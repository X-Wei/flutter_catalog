import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

class BackdropExample extends StatelessWidget {
  const BackdropExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text('Backdrop demo'),
      iconPosition: BackdropIconPosition.action,
      // Height of front layer when backlayer is shown.
      headerHeight: 120.0,
      frontLayer: Center(
          child: Text(
              '(front layer) \n Click top-right button to show back layer.\n\n'
              "There's no flutter official backdrop widget, this demo uses the "
              "'backdrop' package.")),
      backLayer: Center(child: Text('(back layer)')),
    );
  }
}
