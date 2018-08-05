import 'package:flutter/material.dart';
import '../my_route.dart';

class CardExample extends MyRoute {
  const CardExample([String sourceFile = 'lib/routes/widgets_card_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Card';

  @override
  get description => 'Container with corner and shadow.';

  @override
  get links =>
      {'Doc': 'https://docs.flutter.io/flutter/material/Card-class.html'};

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          color: Colors.red,
          // The elevation determines shade.
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Card 1'),
                  ),
                ],
              )),
        ),
        Card(
          color: Colors.green,
          margin: EdgeInsets.all(20.0),
          elevation: 0.0,
          child: Container(
            height: 100.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Card 2'),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.elliptical(40.0, 80.0),
            ),
          ),
          child: Container(
            height: 100.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Card 3'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
