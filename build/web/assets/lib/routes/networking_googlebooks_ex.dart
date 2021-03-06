import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiGoogleBooksExample extends StatefulWidget {
  const RestApiGoogleBooksExample({Key key}) : super(key: key);

  @override
  _RestApiGoogleBooksExampleState createState() =>
      _RestApiGoogleBooksExampleState();
}

class _RestApiGoogleBooksExampleState extends State<RestApiGoogleBooksExample> {
  TextEditingController _queryController;
  List<_MyBook> _books = [];
  bool _pending = false;

  @override
  void initState() {
    super.initState();
    this._queryController = TextEditingController()..text = "three body";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        TextField(
          controller: this._queryController,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 4),
        ButtonBar(
          children: <Widget>[
            ElevatedButton(
              onPressed:
                  _pending ? null : () => this._search(_queryController.text),
              child: const Text('Search'),
            ),
          ],
        ),
        if (this._books.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: this._books.length,
              itemBuilder: (ctx, i) => _bookToListTile(_books[i]),
            ),
          ),
      ],
    );
  }

  ListTile _bookToListTile(_MyBook book) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.authors),
      trailing: Hero(tag: book.id, child: book.thumbnail),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => _MyBookDetailsPage(book)),
      ),
    );
  }

  Future<List<_MyBook>> _getBooksList(String query) async {
    // Uri is a less error-prone way to repsent the URL
    final uri = Uri(
      scheme: 'https',
      host: 'www.googleapis.com',
      path: 'books/v1/volumes',
      queryParameters: {'q': query},
    );
    print('uri=$uri'); // https://www.googleapis.com/books/v1/volumes?q=$query
    final http.Response response = await http.get(uri.toString());
    if (response.statusCode == 200) {
      return _MyBook.parseFromJsonStr(response.body);
    } else {
      throw response;
    }
  }

  Future<void> _search(String query) async {
    setState(() => this._pending = true);
    try {
      this._books = await _getBooksList(query);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully found ${_books.length} books.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
    setState(() => this._pending = false);
  }
}

// Data class to convert from the json response.
class _MyBook {
  final String id;
  final String title;
  final String authors;
  final String description;
  final String thumbnailUrl;

  _MyBook(
      this.id, this.title, this.authors, this.description, this.thumbnailUrl);

  Widget get thumbnail => this.thumbnailUrl != null
      ? Image.network(this.thumbnailUrl)
      : CircleAvatar(child: Text(this.title[0]));

  _MyBook.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] as String,
        title = jsonMap['volumeInfo']['title'] as String,
        authors = (jsonMap['volumeInfo']['authors'] as List).join(', '),
        description = jsonMap['volumeInfo']['description'] as String ??
            '<missing description>',
        thumbnailUrl =
            jsonMap['volumeInfo']['imageLinks']['smallThumbnail'] as String;

  static List<_MyBook> parseFromJsonStr(String jsonStr) {
    final json = jsonDecode(jsonStr);
    final jsonList = json['items'] as List<dynamic>;
    print('${jsonList.length} items in json');
    return [
      for (final jsonMap in jsonList)
        _MyBook.fromJson(jsonMap as Map<String, dynamic>)
    ];
  }
}

class _MyBookDetailsPage extends StatelessWidget {
  final _MyBook _book;

  const _MyBookDetailsPage(this._book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Hero(
              tag: _book.id,
              child: _book.thumbnail,
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_book.description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
