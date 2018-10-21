import 'package:flutter/material.dart';
import '../my_route.dart';

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
    // TODO: populate listview from kMyAppRoutesStructure.
    return ListView(
      children: <Widget>[
        Card(
          child: ExpansionTile(
            leading: Icon(Icons.widgets),
            title: Text(
              'Widgets',
              style: Theme.of(context).textTheme.title,
            ),
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('IconExample'),
                onTap: () => Navigator.of(context).pushNamed('/IconExample'),
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('TextExample'),
                onTap: () => Navigator.of(context).pushNamed('/TextExample'),
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: Icon(Icons.layers),
            title: Text(
              'Layout',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: Icon(Icons.list),
            title: Text(
              'Lists',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: Icon(Icons.menu),
            title: Text(
              'AppBar',
              style: Theme.of(context).textTheme.title,
            ),
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('SliverAppBarExample'),
                onTap: () =>
                    Navigator.of(context).pushNamed('/SliverAppBarExample'),
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: Icon(Icons.view_carousel),
            title: Text(
              'Navigation',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ],
    );
  }
}
