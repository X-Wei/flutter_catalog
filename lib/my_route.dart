import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import './my_code_view.dart';
import './my_app_meta.dart' as my_app_meta;

abstract class MyRoute extends StatefulWidget {
  // Path of source file (relative to project root). The file's content will be
  // shown in the "Code" tab.
  final String _sourceFile;

  static of(BuildContext context) =>
      context.rootAncestorStateOfType(const TypeMatcher<_MyRouteState>());

  const MyRoute(this._sourceFile);

  // Subclasses can return routeName accordingly (polymorphism).
  String get routeName => '/${this.runtimeType.toString()}';

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
  final Map<String, _DemoStarsRecord> _demoStars = {};

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
                AlwaysAliveWidget(
                    child: this.widget.buildMyRouteContent(context)),
                // "Code" tab:
                AlwaysAliveWidget(
                    child: MyCodeView(filePath: this.widget._sourceFile)),
              ];
              assert(myTabPages.length == _TABS.length);
              // Body of MyRoute is two-tabs ("Preview" and "Code").
              return TabBarView(
                children: myTabPages,
                controller: this._tabController,
              );
            }),
            // Only home route has drawer:
            drawer: this.widget.routeName == my_app_meta.kHomeRouteName
                ? Drawer(
                    child: my_app_meta.getNavDrawerItems(this, context),
                  )
                : null,
          );
        });
  }

  // Returns a widget showing the star status of one demo route: a star icon
  // with counts.
  Widget starStatusOfRoute(MyRoute route) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        IconButton(
          icon: Icon(
            this._isStared(route.routeName) ? Icons.star : Icons.star_border,
            color:
                this._isStared(route.routeName) ? Colors.yellow : Colors.grey,
          ),
          onPressed: () => this._toggleStaredAndUpdateStarCounts(route),
        ),
        Text(
          '${this._demoStars[route.routeName]?.stars ?? 0}',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  List<Widget> _getAppbarActions() {
    // final state = MyRouteState.of(context);
    final appbarActions = <Widget>[
      starStatusOfRoute(this.widget),
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

  // Returns whether routeName (defaults to this.widget.routeName) is stared.
  bool _isStared([String routeName]) {
    routeName ??= this.widget.routeName;
    return this._preferences.getBool('$kStaredPreferenceKeyPrefx$routeName') ??
        false;
  }

  // Toggles the local stared/not-stared status of routeName (defaults to
  // this.widget.routeName).
  void _toggleStared([String routeName]) {
    routeName ??= this.widget.routeName;
    bool stared = this._isStared(routeName);
    this._preferences.setBool('$kStaredPreferenceKeyPrefx$routeName', !stared);
  }

  // Caches the value of demo stars from snapshot into this._demoStars.
  void _loadDemoStarsFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    for (DocumentSnapshot doc in snapshot.data.documents) {
      final demoStarsRecord = _DemoStarsRecord.fromSnapshot(doc);
      this._demoStars[demoStarsRecord.routeName] = demoStarsRecord;
    }
  }

  // Creates a document corresponding to routeName on cloud firestore.
  Future<Null> _createDemoStarsFirestoreDocument(String routeName) async {
    // In firestore, the documents are keyed by corresponding route names
    // (without the leading "/")
    final documentKey = routeName.replaceAll('/', '');
    await Firestore.instance
        .collection('demo_stars')
        .document(documentKey)
        .setData({'routeName': routeName, 'stars': 0}, merge: true);
  }

  // Toggles the star status of one record, also updats the star counts in
  // cloud firestore.
  // If the corresponding document is not yet created on firestore, create it
  // first, then re-call this function after 1 second.
  Future<Null> _toggleStaredAndUpdateStarCounts(MyRoute route) async {
    _DemoStarsRecord record = this._demoStars[route.routeName];
    if (record == null) {
      print('Creating record for ${route.routeName}');
      await _createDemoStarsFirestoreDocument(route.routeName);
      // After the document is created, wait for the firestore update to be
      // synced back -- 1 second should be more than enough.
      await Future.delayed(Duration(seconds: 1));
      // Next time this function is called, the record will not be null.
      _toggleStaredAndUpdateStarCounts(route);
      return;
    }
    int deltaStars = this._isStared(route.routeName) ? -1 : 1;
    try {
      await Firestore.instance.runTransaction(
        (transaction) async {
          try {
            final freshSnapshot =
                await transaction.get(record.firestoreDocReference);
            final freshRecord = _DemoStarsRecord.fromSnapshot(freshSnapshot);
            await transaction.update(record.firestoreDocReference,
                {'stars': max(0, freshRecord.stars + deltaStars)});
          } catch (e) {
            Fluttertoast.showToast(msg: 'Error doing firebase transaction: $e');
          }
        },
        timeout: Duration(seconds: 3),
      );
      setState(() => this._toggleStared(route.routeName));
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error doing firebase transaction: $e');
    }
  }
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

// This widget is always kept alive, so that when tab is switched back, its
// child's state is still preserved.
class AlwaysAliveWidget extends StatefulWidget {
  final Widget child;

  const AlwaysAliveWidget({Key key, @required this.child}) : super(key: key);
  @override
  _AlwaysAliveWidgetState createState() => _AlwaysAliveWidgetState();
}

class _AlwaysAliveWidgetState extends State<AlwaysAliveWidget>
    with AutomaticKeepAliveClientMixin<AlwaysAliveWidget> {
  @override
  Widget build(BuildContext context) {
    return this.widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
