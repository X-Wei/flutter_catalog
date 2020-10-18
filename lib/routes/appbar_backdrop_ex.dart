import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

class BackdropExample extends StatelessWidget {
  const BackdropExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: const Text('Backdrop demo'),
      ),
      // Height of front layer when backlayer is shown.
      headerHeight: 120.0,
      frontLayer: const Center(
          child: Text(
              '(front layer) \n Click top-right button to show back layer.\n\n'
              "There's no flutter official backdrop widget, this demo uses the "
              "'backdrop' package.")),
      backLayer: const Center(child: Text('(back layer)')),
    );
  }
}
