import 'package:flutter/material.dart';
import '../my_route.dart';

class WrapExample extends MyRoute {
  const WrapExample([String sourceFile = 'lib/routes/layouts_wrap_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Wrap';

  @override
  get description => 'Wrap to the next row/column when run out of room.';

  @override
  get links => {
        "Youtube video": "https://www.youtube.com/watch?v=z5iw2SeFx2M",
        'Doc': 'https://docs.flutter.io/flutter/widgets/Wrap-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Wrap(
      // Gap between adjacent chips.
      spacing: 8.0,
      // Gap between lines.
      runSpacing: 4.0,
      direction: Axis.horizontal,
      children: [
        'Cauchy',
        'Fourrier',
        'Lagrange',
        'Lebesgue',
        'Levy',
        'Poisson',
        'Pointcare',
      ]
          .map((String name) => Chip(
                avatar: CircleAvatar(child: Text(name.substring(0, 1))),
                label: Text(name),
              ))
          .toList(),
    );
  }
}
