import 'package:flutter/material.dart';

class OpacityExample extends StatefulWidget {
  const OpacityExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OpacityExampleState();
}

class _OpacityExampleState extends State<OpacityExample> {
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
                'Click on colored squares below to make them invisible, click '
                'once again to make them reappear.'),
            GestureDetector(
              onTap: () {
                setState(() => this._opacity1 = 1.0 - this._opacity1);
              },
              child: Opacity(
                opacity: _opacity1,
                child: _coloredSquare(Colors.red),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() => this._opacity2 = 1.0 - this._opacity2);
              },
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _opacity2,
                child: _coloredSquare(Colors.green),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() => this._opacity3 = 1.0 - this._opacity3);
              },
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _opacity3,
                child: _coloredSquare(Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
