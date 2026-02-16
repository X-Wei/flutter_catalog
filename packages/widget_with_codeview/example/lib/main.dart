import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

void main() {
  runApp(MyApp());
}

/// ! Ensure the files in [filePath] are included in pubspec.yaml
/// In this example the codeViewer will display this file's code
/// by pointing to the main.dart file
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: WidgetWithCodeView(
          child: const SomeWidget(), //! If empty, will only show the code view.
          filePath: 'lib/main.dart',
          // codeContent: '',
          codeLinkPrefix: 'https://google.com?q=',
          iconBackgroundColor: Colors.white,
          iconForegroundColor: Colors.pink,
          labelBackgroundColor: Theme.of(context).canvasColor,
          labelTextStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          showLabelText: true,
        ),
      ),
    );
  }
}

class SomeWidget extends StatelessWidget {
  const SomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Center(
            child: Transform.rotate(
              angle: Random().nextDouble(),
              child: Text(
                'Example',
                textScaleFactor: 2,
              ),
            ),
          ),
          Wrap(
            children: List.generate(
              100,
              (_) => SizedBox(
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.width * .25,
                child: Placeholder(
                  color: Colors.accents[Random().nextInt(
                    Colors.accents.length,
                  )],
                ),
              ),
            ),
          ),
        ],
      );
}
