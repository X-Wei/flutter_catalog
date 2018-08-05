import 'package:flutter/material.dart';
import '../my_route.dart';

class TextExample extends MyRoute {
  const TextExample([String sourceFile = 'lib/routes/widgets_text_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Text';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Text(
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
