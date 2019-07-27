import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBuilderExample extends StatefulWidget {
  const AnimatedBuilderExample({Key key}) : super(key: key);

  @override
  _AnimatedBuilderExampleState createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample>
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
