import 'package:flutter/material.dart';

class TextExample extends StatelessWidget {
  const TextExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Simple text demo.',
      // Optional params to try:
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.blue,
          fontSize: 32.0,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline),
      // Or:
      // style: Theme.of(context).textTheme.xxx
    );
  }
}
