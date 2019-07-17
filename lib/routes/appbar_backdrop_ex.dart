import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import '../my_route.dart';

class BackdropExample extends MyRoute {
  const BackdropExample(
      [String sourceFile = 'lib/routes/appbar_backdrop_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Backdrop';

  @override
  get description => 'Switching between front and back layer.';

  @override
  get links => {
        'Medium article':
            'https://medium.com/flutter/decomposing-widgets-backdrop-b5c664fb9cf4'
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
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
