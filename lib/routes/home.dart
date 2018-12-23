import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final listTiles =
        kMyAppRoutesStructure.map(_myRouteGroupToExpansionTile).toList()
          ..add(
            _myRouteToListTile(kAboutRoute, leading: Icon(Icons.info)),
          );
    return ListView(children: listTiles);
    // return StreamBuilder<QuerySnapshot>(
    //     stream: Firestore.instance.collection('demo_stars').snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         _loadDemoStarsFromSnapshot(snapshot);
    //       }
    //       final listTiles =
    //           kMyAppRoutesStructure.map(_myRouteGroupToExpansionTile).toList()
    //             ..add(
    //               _myRouteToListTile(kAboutRoute, leading: Icon(Icons.info)),
    //             );
    //       return ListView(children: listTiles);
    //     });
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
    // return null;
    final state = MyRoute.of(context);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        IconButton(
          icon: state.isStared(route.routeName)
              ? Icon(Icons.star, color: Theme.of(context).primaryColor)
              : Icon(Icons.star_border),
          onPressed: () async => await state.toggleStaredAsync(route),
        ),
        Text(
          '${state.demoStars[route.routeName] != null ? state.demoStars[route.routeName].stars : 0}',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
