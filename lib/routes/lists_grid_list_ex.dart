import 'package:flutter/material.dart';
import '../my_route.dart';

class GridListExample extends MyRoute {
  const GridListExample(
      [String sourceFile = 'lib/routes/lists_grid_list_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'GridList';

  @override
  get links => {
        'Cookbook': 'https://flutter.io/cookbook/lists/grid-lists/',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      // Generate 100 Widgets that display their index in the List
      children: List.generate(100, (index) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 3.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        );
      }),
    );
  }
}
