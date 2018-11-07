import 'package:flutter/material.dart';
import '../my_route.dart';

class RowColExample extends MyRoute {
  const RowColExample(
      [String sourceFile = 'lib/routes/layouts_row_col_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Row, Column';

  @override
  get description => 'Align chidren widgets linearly.';

  @override
  get links => {
        "Youtube video": "https://www.youtube.com/watch?v=RJEnTRBxaSg&t=75s",
        'Doc': 'https://docs.flutter.io/flutter/widgets/Row-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _RowColumnPage();
  }
}

// Inspired by bizz84's layout demo:
// https://github.com/bizz84/layout-demo-flutter
class _RowColumnPage extends StatefulWidget {
  @override
  _RowColumnPageState createState() => new _RowColumnPageState();
}

class _RowColumnPageState extends State<_RowColumnPage> {
  static const kElements = <Widget>[
    Icon(Icons.stars, size: 50.0),
    Icon(Icons.stars, size: 100.0),
    Icon(Icons.stars, size: 50.0),
  ];

  bool _isRow = true;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    final _appbarButtons = _getBottomBar();
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _appbarButtons,
    );
  }

  Widget _buildBody() => Container(
        color: Colors.yellow,
        child: _isRow
            ? Row(
                mainAxisAlignment: _mainAxisAlignment,
                crossAxisAlignment: _crossAxisAlignment,
                mainAxisSize: _mainAxisSize,
                children: kElements,
              )
            : Column(
                mainAxisAlignment: _mainAxisAlignment,
                crossAxisAlignment: _crossAxisAlignment,
                mainAxisSize: _mainAxisSize,
                children: kElements,
              ),
      );

  Widget _getBottomBar() {
    return Material(
      color: Theme.of(context).primaryColorLight,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio<bool>(
                    value: true,
                    groupValue: this._isRow,
                    onChanged: (bool value) {
                      setState(() => this._isRow = value);
                    }),
                Text('Row'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<bool>(
                    value: false,
                    groupValue: this._isRow,
                    onChanged: (bool value) {
                      setState(() => this._isRow = value);
                    }),
                Text('Column'),
              ],
            ),
          ],
        ),
        ListTile(
          title: Text('mainAxisSize:'),
          trailing: DropdownButton<MainAxisSize>(
            value: _mainAxisSize,
            onChanged: (MainAxisSize newVal) {
              if (newVal != null) {
                setState(() => this._mainAxisSize = newVal);
              }
            },
            items: MainAxisSize.values
                .map((MainAxisSize val) => DropdownMenuItem(
                      value: val,
                      child: Text(
                          val.toString().substring('MainAxisSize.'.length)),
                    ))
                .toList(),
          ),
        ),
        ListTile(
          title: Text('mainAxisAlignment:'),
          trailing: DropdownButton<MainAxisAlignment>(
            value: _mainAxisAlignment,
            onChanged: (MainAxisAlignment newVal) {
              if (newVal != null) {
                setState(() => this._mainAxisAlignment = newVal);
              }
            },
            items: MainAxisAlignment.values
                .map((MainAxisAlignment val) => DropdownMenuItem(
                      value: val,
                      child: Text(val
                          .toString()
                          .substring('MainAxisAlignment.'.length)),
                    ))
                .toList(),
          ),
        ),
        ListTile(
          title: Text('crossAxisAlignment:'),
          trailing: DropdownButton<CrossAxisAlignment>(
            value: _crossAxisAlignment,
            onChanged: (CrossAxisAlignment newVal) {
              if (newVal != null) {
                setState(() => this._crossAxisAlignment = newVal);
              }
            },
            items: CrossAxisAlignment.values
                .map((CrossAxisAlignment val) => DropdownMenuItem(
                      value: val,
                      child: Text(val
                          .toString()
                          .substring('CrossAxisAlignment.'.length)),
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }
}
