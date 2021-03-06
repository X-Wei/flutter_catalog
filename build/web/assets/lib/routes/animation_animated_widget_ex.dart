import 'package:flutter/material.dart';

// The AnimatedWidget base class allows you to separate out the core widget code
// from the animation code.
class _AnimatedLogo extends AnimatedWidget {
  const _AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({Key key}) : super(key: key);
  @override
  _AnimatedWidgetExampleState createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
    with SingleTickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    this._controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    this._sizeAnimation =
        Tween<double>(begin: 50, end: 100).animate(this._controller);
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _AnimatedLogo(
          animation: this._sizeAnimation,
        ),
        ElevatedButton(
          onPressed: () => _controller.forward(),
          child: const Text('Forward animation'),
        ),
        ElevatedButton(
          onPressed: () => _controller.reverse(),
          child: const Text('Reverse animation'),
        ),
      ],
    );
  }
}
