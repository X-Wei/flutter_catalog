import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../my_route.dart';

class TextFieldExample extends MyRoute {
  const TextFieldExample(
      [String sourceFile = 'lib/routes/widgets_textfield_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'TextField';

  @override
  get description => 'Text input.';

  @override
  get links =>
      {'Doc': 'https://docs.flutter.io/flutter/material/TextField-class.html'};

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _TextFieldDemo();
  }
}

class _TextFieldDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<_TextFieldDemo> {
  bool _inputIsValid = true;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextField(
      keyboardType: TextInputType.number, // Number only.
      style: Theme.of(context).textTheme.display1,
      decoration: InputDecoration(
        labelText: 'Enter an integer:',
        errorText: _inputIsValid ? null : 'Please enter an integer!',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onSubmitted: (String val) {
        Fluttertoast.showToast(
          msg: 'You entered: ${int.parse(val)}',
        );
      },
      onChanged: (String val) {
        int.parse(val, onError: (val) {
          setState(() => _inputIsValid = false);
        });
      },
    ));
  }
}
