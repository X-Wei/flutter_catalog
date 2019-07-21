import 'dart:math';

import 'package:flutter/material.dart';
import '../my_route.dart';

class AnimatedBuilderExample extends MyRoute {
  const AnimatedBuilderExample(
      [String sourceFile = 'lib/routes/animation_animated_builder_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'AnimatedBuilder';

  @override
  get description => 'Similar to AnimatedWidget.';

  @override
  get links => {
        'Tutorial':
            'https://flutter.dev/docs/development/ui/animations/tutorial#refactoring-with-animatedbuilder',
        'Widget of the Week (YouTube)': 'https://youtu.be/N-RiyZlv8v8',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return new _AnimatedBuilderDemo();
  }
}

class _AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<_AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    this._controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rotateAnimation =
        Tween<double>(begin: 0, end: pi).animate(this._controller);
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: rotateAnimation,
          child: FlutterLogo(size: 72.0),
          builder: (context, child) {
            return Transform.rotate(
              angle: rotateAnimation.value,
              child: child,
            );
          },
        ),
        RaisedButton(
          child: Text('Forward animation'),
          onPressed: () => _controller.forward(),
        ),
        RaisedButton(
          child: Text('Reverse animation'),
          onPressed: () => _controller.reverse(),
        ),
      ],
    );
  }
}
