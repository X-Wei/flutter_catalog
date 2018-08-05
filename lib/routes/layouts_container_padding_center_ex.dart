import 'package:flutter/material.dart';
import '../my_route.dart';

class ContainerBasicsExample extends MyRoute {
  const ContainerBasicsExample(
      [String sourceFile =
          'lib/routes/layouts_container_padding_center_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Container, Padding, Center';

  @override
  get description => 'Basic widgets for layout.';

  @override
  get links => {
        'Doc': 'https://docs.flutter.io/flutter/widgets/Container-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    // Tip: VSCode have suggestions for widget (e.g. "Center widget", "Add
    // padding", "Remove widget"), which is handy.
    return Center(
      // Container is a rectangle area on the screen.
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.blue,
        child: Padding(
          // EdgeInsets.all: same padding value for all 4 directions.
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.yellow,
            // Container.padding is implementd internally with Padding widgets.
            // EdgeInsets.fromLTRB: specify padding for left/right/top/bottom.
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0),
            child: Container(
              color: Colors.red,
              // EdgeInsets.symmetric: specify vertical/horizontal padding.
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
