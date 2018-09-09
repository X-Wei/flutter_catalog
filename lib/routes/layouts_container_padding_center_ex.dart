import 'package:flutter/material.dart';
import '../my_route.dart';

class ContainerBasicsExample extends MyRoute {
  const ContainerBasicsExample(
      [String sourceFile =
          'lib/routes/layouts_container_padding_center_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Container';

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
            // Container.color should not be set when decoration is set.
            decoration: BoxDecoration(
                border: Border.all(width: 5.0, color: Colors.black),
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20.0)),
            // Container.padding is implementd internally with Padding widgets.
            // EdgeInsets.fromLTRB: specify padding for left/right/top/bottom.
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0),
            child: Container(
              color: Colors.red,
              // EdgeInsets.symmetric: specify vertical/horizontal padding.
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              // Rotation.
              transform: new Matrix4.rotationZ(-0.1),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10.0),
                    right: Radius.circular(30.0),
                  ),
                ),
                alignment: Alignment.topLeft,
                child: Text("hello"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
