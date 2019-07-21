import 'dart:math';

import 'package:flutter/material.dart';
import '../my_route.dart';

class AnimatedContainerExample extends MyRoute {
  const AnimatedContainerExample(
      [String sourceFile = 'lib/routes/animation_animated_container_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'AnimatedContainer';

  @override
  get description =>
      'Implicit animation when container property changes, without controllers.';

  @override
  get links => {
        'Cookbook':
            'https://flutter.dev/docs/cookbook/animation/animated-container',
        'Widget of the Week (YouTube)': 'https://youtu.be/yI-8QHpGIP4',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return new _AnimatedContainerDemo();
  }
}

class _AnimatedContainerDemo extends StatefulWidget {
  @override
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<_AnimatedContainerDemo> {
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
          margin: EdgeInsets.all(8),
          child: FlutterLogo(),
          // Use the properties stored in the State class.
          width: this._width,
          height: this._height,
          decoration: BoxDecoration(
            color: this._color,
            borderRadius: BorderRadius.circular(this._borderRadius),
          ),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        ),
        RaisedButton.icon(
          icon: Icon(Icons.update),
          label: Text('Change random property'),
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
