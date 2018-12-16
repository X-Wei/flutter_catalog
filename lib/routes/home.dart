import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_route.dart';
import '../my_app_meta.dart'
    show kMyAppRoutesStructure, MyRouteGroup, kAboutRoute;

class MyHomeRoute extends MyRoute {
  const MyHomeRoute([String sourceFile = 'lib/routes/home.dart'])
      : super(sourceFile);

  @override
  get title => 'Flutter Catalog';

  @override
  get routeName =>
      Navigator.defaultRouteName; // Navigator.defaultRouteName is just "/".

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences _preferences;
  // Maps route names to the corresponding _DemoStarsRecord, this map serves as
  // a local cache of the cloud firestore snapshot.
  final Map<String, _DemoStarsRecord> _demoStars = {};

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._preferences = prefs);
      });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('demo_stars').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _loadDemoStarsFromSnapshot(snapshot);
          }
          final listTiles =
              kMyAppRoutesStructure.map(_myRouteGroupToExpansionTile).toList()
                ..add(
                  _myRouteToListTile(kAboutRoute, leading: Icon(Icons.info)),
                );
          return ListView(children: listTiles);
        });
  }

  Widget _myRouteGroupToExpansionTile(MyRouteGroup myRouteGroup) {
    return Card(
      child: ExpansionTile(
        leading: myRouteGroup.icon,
        title: Text(
          myRouteGroup.groupName,
          style: Theme.of(context).textTheme.title,
        ),
        children: myRouteGroup.routes.map(this._myRouteToListTile).toList(),
      ),
    );
  }

  ListTile _myRouteToListTile(MyRoute myRoute,
      {Widget leading, IconData trialing: Icons.keyboard_arrow_right}) {
    final routeTitleTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold);
    return ListTile(
      leading: leading ?? _getDefaultLeadingWidget(myRoute),
      title: GestureDetector(
        child: Text(myRoute.title, style: routeTitleTextStyle),
      ),
      trailing: trialing == null ? null : Icon(trialing),
      subtitle: myRoute.description == null ? null : Text(myRoute.description),
      onTap: () => Navigator.of(context).pushNamed(myRoute.routeName),
    );
  }

  // Returns the default leading widget of a ListTile: star icon with counts.
  Widget _getDefaultLeadingWidget(MyRoute route) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        IconButton(
          icon: route.isStared(this._preferences)
              ? Icon(Icons.star, color: Theme.of(context).primaryColor)
              : Icon(Icons.star_border),
          onPressed: () => _toggleStared(route),
        ),
        Text(
          '${this._demoStars[route.routeName] != null ? this._demoStars[route.routeName].stars : 0}',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
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
  void _toggleStared(MyRoute route) {
    _DemoStarsRecord record = this._demoStars[route.routeName];
    if (record == null) {
      _createDemoStarsFirestoreDocument(route.routeName)
        ..then((_) async {
          // After the document is created, wait for the firestore update to be
          // synced back -- 1 second should be more than enough.
          await Future.delayed(Duration(seconds: 1));
          // Next time this function is called, the record will not be null.
          _toggleStared(route);
        });
      return;
    }
    int deltaStars = route.isStared(this._preferences) ? -1 : 1;
    Firestore.instance.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(record.firestoreDocReference);
      final freshRecord = _DemoStarsRecord.fromSnapshot(freshSnapshot);
      await transaction.update(record.firestoreDocReference,
          {'stars': freshRecord.stars + deltaStars});
    });
    setState(() {
      route.toggleStared(this._preferences);
    });
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
