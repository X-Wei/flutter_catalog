import 'package:flutter/material.dart';
import '../my_route.dart';

class AnimatedWidgetExample extends MyRoute {
  const AnimatedWidgetExample(
      [String sourceFile = 'lib/routes/animation_animated_widget_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'AnimatedWidget';

  @override
  get description => 'Easier animtation without addListener() and setState()';

  @override
  get links => {
        'Tutorial':
            'https://flutter.dev/docs/development/ui/animations/tutorial#simplifying-with-animatedwidget',
        'Youtube video': 'https://www.youtube.com/watch?v=mdhoIQqS2z0',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return new _AnimatedWidgetDemo();
  }
}

// The AnimatedWidget base class allows you to separate out the core widget code
// from the animation code.
class _AnimatedLogo extends AnimatedWidget {
  _AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: FlutterLogo(),
        height: animation.value,
        width: animation.value,
      ),
    );
  }
}

class _AnimatedWidgetDemo extends StatefulWidget {
  @override
  _AnimatedWidgetDemoState createState() => _AnimatedWidgetDemoState();
}

class _AnimatedWidgetDemoState extends State<_AnimatedWidgetDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    this._controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
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
