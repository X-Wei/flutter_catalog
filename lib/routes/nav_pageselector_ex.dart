import 'package:flutter/material.dart';
import '../my_route.dart';

class PageSelectorExample extends MyRoute {
  const PageSelectorExample(
      [String sourceFile = 'lib/routes/nav_pageselector_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Page selector';

  @override
  get links => {
        'Doc':
            'https://docs.flutter.io/flutter/material/TabPageSelector-class.html'
      };

  static const kIcons = <Icon>[
    Icon(Icons.event),
    Icon(Icons.home),
    Icon(Icons.android),
    Icon(Icons.alarm),
    Icon(Icons.face),
    Icon(Icons.language),
  ];

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return DefaultTabController(
      length: kIcons.length,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TabPageSelector(),
                  Expanded(
                    child: IconTheme(
                      data: IconThemeData(
                        size: 128.0,
                        color: Theme.of(context).accentColor,
                      ),
                      child: TabBarView(children: kIcons),
                    ),
                  ),
                  RaisedButton(
                    child: Text('SKIP'),
                    onPressed: () {
                      final TabController controller =
                          DefaultTabController.of(context);
                      if (!controller.indexIsChanging) {
                        controller.animateTo(kIcons.length - 1);
                      }
                    },
                  )
                ],
              ),
            ),
      ),
    );
  }
}
