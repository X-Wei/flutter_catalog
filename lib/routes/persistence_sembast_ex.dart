import 'package:english_words/english_words.dart' as english_words;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

// Data class for the mini todo application.
class TodoItem {
  final int id;
  final String content;
  bool isDone;
  final DateTime createdAt;

  TodoItem({this.id, this.content, this.isDone = false, this.createdAt});

  TodoItem.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        content = map['content'] as String,
        isDone = map['isDone'] as bool,
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int);

  Map<String, dynamic> toJsonMap() => {
        'id': id,
        'content': content,
        'isDone': isDone,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };
}

class SembastExample extends StatefulWidget {
  const SembastExample({Key key}) : super(key: key);

  @override
  _SembastExampleState createState() => _SembastExampleState();
}

class _SembastExampleState extends State<SembastExample> {
  static const kDbFileName = 'sembast_ex.db';
  static const kDbStoreName = 'example_store';

  Future<bool> _initDbFuture;
  Database _db;
  StoreRef<int, Map<String, dynamic>> _store;
  List<TodoItem> _todos = [];

  @override
  void initState() {
    super.initState();
    this._initDbFuture = _initDb();
  }

  // Opens a db local file. Creates the db table if it's not yet created.
  Future<bool> _initDb() async {
    final dbFolder = await path_provider.getApplicationDocumentsDirectory();
    final dbPath = join(dbFolder.path, kDbFileName);
    this._db = await databaseFactoryIo.openDatabase(dbPath);
    print('Db created at $dbPath');
    this._store = intMapStoreFactory.store(kDbStoreName);
    _getTodoItems();
    return true;
  }

  // Retrieves records from the db store.
  Future<void> _getTodoItems() async {
    final finder = Finder();
    final recordSnapshots = await this._store.find(this._db, finder: finder);
    this._todos = recordSnapshots
        .map((snapshot) => TodoItem.fromJsonMap({
              ...snapshot.value,
              'id': snapshot.key,
            }))
        .toList();
  }

  // Inserts records to the db store.
  // Note we don't need to explicitly set the primary key (id), it'll auto
  // increment.
  Future<void> _addTodoItem(TodoItem todo) async {
    final int id = await this._store.add(this._db, todo.toJsonMap());
    print('Inserted todo item with id=$id.');
  }

  // Updates records in the db table.
  Future<void> _toggleTodoItem(TodoItem todo) async {
    todo.isDone = !todo.isDone;
    final int count = await this._store.update(
          this._db,
          todo.toJsonMap(),
          finder: Finder(filter: Filter.byKey(todo.id)),
        );
    print('Updated $count records in db.');
  }

  // Deletes records in the db table.
  Future<void> _deleteTodoItem(TodoItem todo) async {
    final int count = await this._store.delete(
          this._db,
          finder: Finder(filter: Filter.byKey(todo.id)),
        );
    print('Updated $count records in db.');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: this._initDbFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: ListView(
            children: this._todos.map(_itemToListTile).toList(),
          ),
          floatingActionButton: _buildFloatingActionButton(),
        );
      },
    );
  }

  Future<void> _updateUI() async {
    await _getTodoItems();
    setState(() {});
  }

  ListTile _itemToListTile(TodoItem todo) => ListTile(
        title: Text(
          todo.content,
          style: TextStyle(
              fontStyle: todo.isDone ? FontStyle.italic : null,
              color: todo.isDone ? Colors.grey : null,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text('id=${todo.id}\ncreated at ${todo.createdAt}'),
        isThreeLine: true,
        leading: IconButton(
          icon: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
          onPressed: () async {
            await _toggleTodoItem(todo);
            _updateUI();
          },
        ),
        trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteTodoItem(todo);
              _updateUI();
            }),
      );

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        await _addTodoItem(
          TodoItem(
            content: english_words.generateWordPairs().first.asPascalCase,
            createdAt: DateTime.now(),
          ),
        );
        _updateUI();
      },
      child: const Icon(Icons.add),
    );
  }
}
