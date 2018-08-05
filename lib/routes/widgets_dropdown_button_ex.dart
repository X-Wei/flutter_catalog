import 'package:flutter/material.dart';
import '../my_route.dart';

class DropdownButtonExample extends MyRoute {
  const DropdownButtonExample(
      [String sourceFile = 'lib/routes/widgets_dropdown_button_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'DropdownButton';

  @override
  get links => {
        'Doc':
            'https://docs.flutter.io/flutter/material/DropdownButton-class.html'
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _DropdowButtonDemo();
  }
}

// Inspired by dropdown buttons demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/buttons_demo.dart
class _DropdowButtonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DropdowButtonDemoState();
}

class _DropdowButtonDemoState extends State<_DropdowButtonDemo> {
  final List<DropdownMenuItem<String>> _dropDownMenuItems = <String>[
    'One',
    'Two',
    'Three',
    'Four',
  ].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
  String _btn1SelectedVal = 'One';
  String _btn2SelectedVal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('DropDownButton with default:'),
          trailing: DropdownButton<String>(
            // Must be one of items.value.
            value: _btn1SelectedVal,
            onChanged: (String newValue) {
              setState(() {
                _btn1SelectedVal = newValue;
              });
            },
            items: this._dropDownMenuItems,
          ),
        ),
        ListTile(
          title: Text('DropDownButton with hint:'),
          trailing: DropdownButton(
            value: _btn2SelectedVal,
            hint: Text('Choose'),
            onChanged: ((String newValue) {
              setState(() {
                _btn2SelectedVal = newValue;
              });
            }),
            items: _dropDownMenuItems,
          ),
        ),
      ],
    );
  }
}
