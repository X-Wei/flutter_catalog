import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import './my_code_view.dart';
import './my_app_meta.dart' as my_app_meta;

abstract class MyRoute extends StatefulWidget {
  // Path of source file (relative to project root). The file's content will be
  // shown in the "Code" tab.
  final String _sourceFile;
  // Preference key's prefix for storing whether you have stared a route or not.
  static const kStaredPreferenceKeyPrefx = 'StaredFor_';

  static of(BuildContext context) {
    final ret =
        context.rootAncestorStateOfType(const TypeMatcher<_MyRouteState>());
    print('MyRouteState.of returned: ${ret.runtimeType.toString()}');
    return ret;
  }

  const MyRoute(this._sourceFile);

  // Subclasses can return routeName accordingly (polymorphism).
  String get routeName => this.runtimeType.toString();
  // String get routeName => '/${this.runtimeType.toString()}';

  // Title shown in the route's appbar and in the app's navigation drawer item.
  // By default just returns routeName.
  String get title => this.routeName;

  // A short description of the route. If not null, will be shown as subtitle in
  // app's navigation drawer.
  String get description => null;

  // Returns a set of links {title:link} that are relative to the route. Can put
  // documention links or reference video/article links here.
  Map<String, String> get links => {};

  // Returns the widget that will be shown in the "Preview" tab.
  Widget buildMyRouteContent(BuildContext context);

  @override
  State<StatefulWidget> createState() => _MyRouteState();
}

// Each MyRoute contains two tabs: "Preview" and "Code".
const _TABS = <Widget>[
  Tab(
    // text: 'Preview',
    // icon: Icon(Icons.phone_android),
    child: ListTile(
      leading: Icon(
        Icons.phone_android,
        color: Colors.white,
      ),
      title: Text(
        'Preview',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
  Tab(
    // text: 'Code',
    // icon: Icon(Icons.code),
    child: ListTile(
      leading: Icon(
        Icons.code,
        color: Colors.white,
      ),
      title: Text(
        'Code',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
];

class _MyRouteState extends State<MyRoute> with SingleTickerProviderStateMixin {
  static const kStaredPreferenceKeyPrefx = 'StaredFor_';
  TabController _tabController;
  SharedPreferences _preferences;
  // Maps route names to the corresponding _DemoStarsRecord, this map serves as
  // a local cache of the cloud firestore snapshot.
  final Map<String, _DemoStarsRecord> demoStars = {};

  // Returns whether routeName (defaults to this.widget.routeName) is stared.
  bool isStared([String routeName]) {
    print('isStared: ${routeName ?? this.widget.routeName}');
    return this._preferences.getBool(
              '$kStaredPreferenceKeyPrefx${routeName ?? this.widget.routeName}',
            ) ??
        false;
  }

  // Toggles the stared/not-stated status of routeName (defaults to
  // this.widget.routeName).
  toggleStared([String routeName]) {
    print('toggleStared: ${routeName ?? this.widget.routeName}');
    bool stared = this.isStared();
    this._preferences.setBool(
        '$kStaredPreferenceKeyPrefx${routeName ?? this.widget.routeName}',
        !stared);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _TABS.length,
      vsync: this,
    );
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._preferences = prefs);
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('demo_stars').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _loadDemoStarsFromSnapshot(snapshot);
          }
          return Scaffold(
            appBar: AppBar(
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(this.widget.title),
              ),
              actions: _getAppbarActions(),
              bottom: TabBar(
                tabs: _TABS,
                controller: this._tabController,
              ),
            ),
            // Use a Builder so that Scaffold.of(context) uses correct context, c.f.
            // https://stackoverflow.com/a/45948913
            body: Builder(builder: (BuildContext context) {
              final myTabPages = <Widget>[
                // "Preview" tab:
                this.widget.buildMyRouteContent(context),
                // "Code" tab:
                MyCodeView(filePath: this.widget._sourceFile),
              ];
              assert(myTabPages.length == _TABS.length);
              // Body of MyRoute is two-tabs ("Preview" and "Code").
              return TabBarView(
                children: myTabPages,
                controller: this._tabController,
              );
            }),
            // Only home route has drawer:
            drawer: this.widget.routeName == Navigator.defaultRouteName
                ? Drawer(
                    child: my_app_meta.getNavDrawerItems(this, context),
                  )
                : null,
          );
        });
  }

  List<Widget> _getAppbarActions() {
    // final state = MyRouteState.of(context);
    final appbarActions = <Widget>[
      IconButton(
        icon: Icon(
          this.isStared() ? Icons.star : Icons.star_border,
        ),
        onPressed: () => setState(() => this.toggleStared()),
      ),
    ];
    if (this.widget.links.isNotEmpty) {
      final popMenu = PopupMenuButton(
        itemBuilder: (context) {
          var menuItems = <PopupMenuItem>[];
          this.widget.links.forEach((title, link) {
            menuItems.add(
              PopupMenuItem(
                child: ListTile(
                  title: Text(title),
                  trailing: IconButton(
                    icon: Icon(Icons.open_in_new),
                    tooltip: '$link',
                    onPressed: () => url_launcher.launch(link),
                  ),
                  onTap: () => url_launcher.launch(link),
                ),
              ),
            );
          });
          return menuItems;
        },
      );
      appbarActions.add(popMenu);
    }
    return appbarActions;
  }

  // Caches the value of demo stars from snapshot into this._demoStars.
  void _loadDemoStarsFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    for (DocumentSnapshot doc in snapshot.data.documents) {
      final demoStarsRecord = _DemoStarsRecord.fromSnapshot(doc);
      this.demoStars[demoStarsRecord.routeName] = demoStarsRecord;
    }
  }

  // Creates a document corresponding to routeName on cloud firestore.
  Future<Null> _createDemoStarsFirestoreDocument(String routeName) async {
    // In firestore, the documents are keyed by corresponding route names.
    await Firestore.instance
        .collection('demo_stars')
        .document(routeName)
        .setData({'routeName': routeName, 'stars': 0}, merge: true);
  }

  // Toggles the star status of one record, also updats the star counts in
  // cloud firestore.
  // If the corresponding document is not yet created on firestore, create it
  // first, then re-call this function after 1 second.
  Future<Null> toggleStaredAsync(MyRoute route) async {
    _DemoStarsRecord record = this.demoStars[route.routeName];
    if (record == null) {
      print('creating record for ${route.routeName}');
      _createDemoStarsFirestoreDocument(route.routeName)
        ..then((_) async {
          // After the document is created, wait for the firestore update to be
          // synced back -- 1 second should be more than enough.
          await Future.delayed(Duration(seconds: 1));
          // Next time this function is called, the record will not be null.
          toggleStaredAsync(route);
        });
      return;
    }
    int deltaStars = this.isStared(route.routeName) ? -1 : 1;
    try {
      await Firestore.instance.runTransaction((transaction) async {
        final freshSnapshot =
            await transaction.get(record.firestoreDocReference);
        final freshRecord = _DemoStarsRecord.fromSnapshot(freshSnapshot);
        await transaction.update(record.firestoreDocReference,
            {'stars': freshRecord.stars + deltaStars});
      });
      setState(() {
        this.toggleStared(route.routeName);
      });
    } catch (e) {
      print('Error doing firebase transaction: $e');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error doing firebase transaction: $e'),
        ),
      );
    }
  }
}

class DemoStarsManager {
  // static DemoStarsManager of(BuildContext contexFt) =>
}

// Custom data class for holding "{routeName,stars}" records.
class _DemoStarsRecord {
  final String routeName;
  final int stars;
  // Reference to this record as a firestore document.
  final DocumentReference firestoreDocReference;

  _DemoStarsRecord.fromMap(Map<String, dynamic> map,
      {@required this.firestoreDocReference})
      : assert(map['routeName'] != null),
        assert(map['stars'] != null),
        routeName = map['routeName'],
        stars = map['stars'];

  _DemoStarsRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, firestoreDocReference: snapshot.reference);

  @override
  String toString() => "Record<$routeName:$stars>";
}
