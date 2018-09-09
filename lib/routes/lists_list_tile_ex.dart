import 'package:flutter/material.dart';
import '../my_route.dart';

class ListTileExample extends MyRoute {
  const ListTileExample(
      [String sourceFile = 'lib/routes/lists_list_tile_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'ListTile';

  @override
  get links => {
        'Doc': 'https://docs.flutter.io/flutter/material/ListTile-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    const listTiles = <Widget>[
      ListTile(
        title: Text('Tile 0: basic'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.face),
        title: Text('Tile 1: with leading/trailing widgets'),
        trailing: Icon(Icons.tag_faces),
      ),
      Divider(),
      ListTile(
        title: Text('Tile 2 title'),
        subtitle: Text('subtitle of tile 2'),
      ),
      Divider(),
      ListTile(
        title: Text('Tile 3: 3 lines'),
        isThreeLine: true,
        subtitle: Text('subtitle of tile 3'),
      ),
      Divider(),
      ListTile(
        title: Text('Tile 4: dense'),
        dense: true,
      ),
    ];
    // Directly returning a list of widgets is not common practice.
    // People usually use ListView.builder, c.f. "ListView.builder" example.
    // Here we mainly demostrate ListTile.
    return ListView(children: listTiles);
  }
}
