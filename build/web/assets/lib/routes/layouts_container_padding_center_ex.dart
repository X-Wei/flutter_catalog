import 'package:flutter/material.dart';

class ContainerExample extends StatelessWidget {
  const ContainerExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tip: VSCode have suggestions for widget (e.g. "Center widget", "Add
    // padding", "Remove widget"), which is handy.
    return Center(
      // Container is a rectangle area on the screen.
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.blue,
        child: Padding(
          // const EdgeInsets.all: same padding value for all 4 directions.
          padding: const EdgeInsets.all(16.0),
          child: Container(
            // Container.color should not be set when decoration is set.
            decoration: BoxDecoration(
                border: Border.all(width: 5.0),
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20.0)),
            // Container.padding is implementd internally with Padding widgets.
            // const EdgeInsets.fromLTRB: specify padding for left/right/top/bottom.
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0),
            child: Container(
              color: Colors.red,
              // const EdgeInsets.symmetric: specify vertical/horizontal padding.
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              // Rotation.
              transform: Matrix4.rotationZ(-0.1),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10.0),
                    right: Radius.circular(30.0),
                  ),
                ),
                alignment: Alignment.topLeft,
                child: const Text("hello"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
