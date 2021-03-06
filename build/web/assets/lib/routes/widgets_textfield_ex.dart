import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  bool _numberInputIsValid = true;

  Widget _buildNumberTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        icon: const Icon(Icons.attach_money),
        labelText: 'Enter an integer:',
        errorText: _numberInputIsValid ? null : 'Please enter an integer!',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onSubmitted: (val) =>
          Fluttertoast.showToast(msg: 'You entered: ${int.parse(val)}'),
      onChanged: (String val) {
        final v = int.tryParse(val);
        debugPrint('parsed value = $v');
        if (v == null) {
          setState(() => _numberInputIsValid = false);
        } else {
          setState(() => _numberInputIsValid = true);
        }
      },
    );
  }

  final _controller = TextEditingController();

  Widget _buildMultilineTextField() {
    return TextField(
      controller: this._controller,
      maxLines: 10,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        counterText: '${this._controller.text.split(' ').length} words',
        labelText: 'Enter multiline text:',
        hintText: 'type something...',
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) => setState(() {}),
    );
  }

  bool _showPassword = false;

  Widget _buildPasswordTextField() {
    return TextField(
      obscureText: !this._showPassword,
      decoration: InputDecoration(
        labelText: 'password',
        prefixIcon: const Icon(Icons.security),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: this._showPassword ? Colors.blue : Colors.grey,
          ),
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),
      ),
    );
  }

  Widget _buildBorderlessTextField() {
    return const TextField(
      maxLines: 3,
      decoration: InputDecoration.collapsed(hintText: 'borderless input'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        const ListTile(title: Text('1. Number input field')),
        _buildNumberTextField(),
        const ListTile(title: Text('2. Multiline input field')),
        _buildMultilineTextField(),
        const ListTile(title: Text('3. Password input field')),
        _buildPasswordTextField(),
        const ListTile(title: Text('4. Borderless input')),
        _buildBorderlessTextField(),
      ],
    );
  }
}
