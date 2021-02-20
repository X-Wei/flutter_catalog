import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({Key key}) : super(key: key);

  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  final _rng = Random();
  double _height = 100;
  double _width = 100;
  double _borderRadius = 8;
  Color _color = Colors.blue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          margin: const EdgeInsets.all(8),
          // Use the properties stored in the State class.
          width: this._width,
          height: this._height,
          decoration: BoxDecoration(
            color: this._color,
            borderRadius: BorderRadius.circular(this._borderRadius),
          ),
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: const FlutterLogo(),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.update),
          label: const Text('Change random property'),
          onPressed: () => setState(
            () {
              // Generate a random width and height.
              _width = _rng.nextInt(100).toDouble() + 50;
              _height = _rng.nextInt(100).toDouble() + 50;
              _borderRadius = _rng.nextInt(50).toDouble();
              // Generate a random color.
              _color = Color.fromRGBO(
                  _rng.nextInt(256), _rng.nextInt(256), _rng.nextInt(256), 1);
            },
          ),
        ),
      ],
    );
  }
}
