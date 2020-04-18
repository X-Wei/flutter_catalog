import 'package:flutter/material.dart';

class CardExample extends StatelessWidget {
  const CardExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
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
            ),
          ),
        ),
        Card(
          color: Colors.green,
          margin: EdgeInsets.all(20.0),
          elevation: 0.0,
          child: Container(
            height: 100.0,
            child: InkWell(
              splashColor: Colors.deepOrange,
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Card 2 (with Inkwell effect on tap)'),
                  ),
                ],
              ),
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
                  child: Text('Card 3 (with custom border radius)'),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        'res/images/material_design_4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Card 4 (complex example)',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text('SHARE'),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text('EXPLORE'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
