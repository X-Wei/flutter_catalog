import 'package:flutter/material.dart';

class BasicAppbarExample extends StatelessWidget {
  const BasicAppbarExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: const Icon(Icons.tag_faces),
        title: const Text("Sample title"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.directions_bike),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.directions_bus),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(child: const Text('Boat')),
                const PopupMenuItem(child: const Text('Train'))
              ];
            },
          )
        ],
      ),
      body: const Center(child: const Text("Hello")),
    );
  }
}
