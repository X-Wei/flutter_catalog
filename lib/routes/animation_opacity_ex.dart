import 'package:flutter/material.dart';
import '../my_route.dart';

class OpacityExample extends MyRoute {
  const OpacityExample(
      [String sourceFile = 'lib/routes/animation_opacity_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Opacity';

  @override
  get description => 'Making a widget transparent/visible.';

  @override
  get links => {
        'Doc': 'https://docs.flutter.io/flutter/widgets/Opacity-class.html',
        'Youtube video':
            'https://www.youtube.com/watch?v=9hltevOHQBw&index=5&list=PLOU2XLYxmsIL0pH0zWe_ZOHgGhZ7UasUE',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _OpacityExPage();
  }
}

class _OpacityExPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OpacityExPageState();
}

class _OpacityExPageState extends State<_OpacityExPage> {
  double _opacity1 = 1.0, _opacity2 = 1.0, _opacity3 = 1.0;

  Widget _coloredSquare(Color color) {
    return Container(
      height: 100.0,
      width: 100.0,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Click on colored squares below to make them invisible, click '
                'once again to make them reappear.'),
            GestureDetector(
              child: Opacity(
                opacity: _opacity1,
                child: _coloredSquare(Colors.red),
              ),
              onTap: () {
                setState(() => this._opacity1 = 1.0 - this._opacity1);
              },
            ),
            GestureDetector(
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: _opacity2,
                child: _coloredSquare(Colors.green),
              ),
              onTap: () {
                setState(() => this._opacity2 = 1.0 - this._opacity2);
              },
            ),
            GestureDetector(
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: _opacity3,
                child: _coloredSquare(Colors.blue),
              ),
              onTap: () {
                setState(() => this._opacity3 = 1.0 - this._opacity3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
