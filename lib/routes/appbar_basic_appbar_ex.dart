import 'package:flutter/material.dart';
import '../my_route.dart';

class BasicAppbarExample extends MyRoute {
  const BasicAppbarExample(
      [String sourceFile = 'lib/routes/appbar_basic_appbar_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Basic AppBar';

  @override
  get links => {
        'Doc': 'https://docs.flutter.io/flutter/material/AppBar-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: Icon(Icons.tag_faces),
        title: Text("Sample title"),
        // TODO: add actions when items are clicked.
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.directions_bike),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.directions_bus),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('Boat')),
                PopupMenuItem(child: Text('Train'))
              ];
            },
          )
        ],
      ),
      body: Center(child: Text("Hello")),
    );
  }
}
