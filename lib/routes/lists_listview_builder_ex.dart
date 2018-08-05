import 'package:flutter/material.dart';
import '../my_route.dart';

class ListViewBuilderExample extends MyRoute {
  const ListViewBuilderExample(
      [String sourceFile = 'lib/routes/lists_listview_builder_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'ListView.builder';

  @override
  get description => 'Building list items with a builder.';

  @override
  get links => {
        'Doc': 'https://docs.flutter.io/flutter/widgets/ListView-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    final numItems = 20;
    final _biggerFont = const TextStyle(fontSize: 18.0);

    Widget _buildRow(int idx) {
      return ListTile(
        leading: CircleAvatar(
          child: Text('$idx'),
        ),
        title: Text(
          'Item $idx',
          style: _biggerFont,
        ),
        trailing: Icon(Icons.dashboard),
      );
    }

    return ListView.builder(
      itemCount: numItems * 2,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2 + 1;
        return _buildRow(index);
      },
    );
  }
}
