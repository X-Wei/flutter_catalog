import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
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
