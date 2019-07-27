import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:widget_with_codeview/widget_with_codeview.dart';

import './constants.dart' show APP_NAME, APP_VERSION, GITHUB_URL, kAppIcon;
import './my_app_settings.dart';
import './routes/about.dart';

abstract class MyRoute extends StatelessWidget {
  // Path of source file (relative to project root). The file's content will be
  // shown in the "Code" tab.
  final String _sourceFile;

  static of(BuildContext context) =>
      context.rootAncestorStateOfType(const TypeMatcher<MyRoute>());

  const MyRoute(this._sourceFile);

  // Subclasses can return routeName accordingly (polymorphism).
  String get routeName => '/${this.runtimeType.toString()}';

  // Title shown in the route's appbar and in the app's navigation drawer item.
  // By default just returns routeName.
  String get title => this.routeName;

  // A short description of the route. If not null, will be shown as subtitle in
  // app's navigation drawer.
  String get description => null;

  // Returns a set of links {title:link} that are relative to the route. Can put
  // documention links or reference video/article links here.
  Map<String, String> get links => null;

  // Returns the widget that will be shown in the "Preview" tab.
  Widget buildMyRouteContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final double headerHeight = 128.0;
    final double appbarHeight = kToolbarHeight;
    final double backLayerHeight =
        MediaQuery.of(context).size.height - headerHeight - appbarHeight;
    return BackdropScaffold(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(this.title),
      ),
      actions: _getAppbarActions(context),
      iconPosition: BackdropIconPosition.action,
      headerHeight: headerHeight,
      frontLayer: Builder(
        builder: (BuildContext context) => WidgetWithCodeView(
          child: this.buildMyRouteContent(context),
          sourceFilePath: this._sourceFile,
          codeLinkPrefix: '$GITHUB_URL/blob/master',
        ),
      ),
      // To make the listview in backlayer scrollable, had to calculate the
      // height of backlayer, and wrap inside a Column. This is due to the
      // implementation of BackdropScaffold ('backdrop' package, v0.1.8).
      backLayer: Column(
        children: <Widget>[
          SizedBox(height: backLayerHeight, child: _getBackdropListTiles())
        ],
      ),
    );
  }

  List<Widget> _getAppbarActions(BuildContext context) {
    final settings = Provider.of<MyAppSettings>(context);
    return <Widget>[
      if (this.routeName != Navigator.defaultRouteName)
        settings.starStatusOfRoute(this.routeName),
      if (this.links?.isNotEmpty ?? false)
        PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuItem>[
              for (MapEntry<String, String> titleAndLink in this.links.entries)
                PopupMenuItem(
                  child: ListTile(
                    title: Text(titleAndLink.key),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      tooltip: '${titleAndLink.value}',
                      onPressed: () => url_launcher.launch(titleAndLink.value),
                    ),
                    onTap: () => url_launcher.launch(titleAndLink.value),
                  ),
                )
            ];
          },
        ),
    ];
  }

  ListView _getBackdropListTiles() {
    return ListView(
      padding: EdgeInsets.only(bottom: 32.0),
      children: <Widget>[
        ListTile(
          leading: kAppIcon,
          title: Text(APP_NAME),
          subtitle: Text(APP_VERSION),
        ),
        ...MyAboutRoute.kAboutListTiles,
        Consumer<MyAppSettings>(builder: (context, MyAppSettings settings, _) {
          return ListTile(
            onTap: () {},
            leading: Icon(
                settings.isDarkMode ? Icons.brightness_4 : Icons.brightness_7),
            title: Text('Dark mode'),
            trailing: Switch(
              onChanged: (bool value) => settings.setDarkMode(value),
              value: settings.isDarkMode,
            ),
          );
        }),
      ],
    );
  }
}

class MyRoute2 extends MyRoute {
  final String sourceFilePath;
  final Widget child;
  final String _title;
  final String description;
  final Map<String, String> links;

  const MyRoute2(
      {@required this.sourceFilePath,
      @required this.child,
      String title,
      this.description,
      this.links})
      : _title = title,
        super(sourceFilePath);

  @override
  String get routeName => '/${this.child.runtimeType.toString()}';

  @override
  String get title => _title ?? this.routeName;

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: this.child,
    );
  }
}
