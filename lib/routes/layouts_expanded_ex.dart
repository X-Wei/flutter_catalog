import 'package:flutter/material.dart';
import '../my_route.dart';

// Inspired by bizz84's flutter layout demo:
// https://github.com/bizz84/layout-demo-flutter.
class ExpandedExample extends MyRoute {
  const ExpandedExample(
      [String sourceFile = 'lib/routes/layouts_expanded_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Expanded';

  @override
  get description => 'Dividing space by "weights" (flex).';
  // Expanded() objects takes all available space, and each Expanded gets the
  // portion of space according to it's flex.
  // SizedBox() instead has fixed height/width.

  @override
  get links => {
        'Doc': 'https://docs.flutter.io/flutter/widgets/Expanded-class.html',
        'Youtube video': 'https://www.youtube.com/watch?v=RJEnTRBxaSg&t=1072s',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            child: Text('Item1: flex=1'),
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Text('Item2: flex=2'),
            color: Colors.green,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Text('Item3, flex=3'),
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
