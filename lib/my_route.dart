import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:widget_with_codeview/widget_with_codeview.dart';

import './constants.dart' show APP_NAME, APP_VERSION, GITHUB_URL, kAppIcon;
import './my_app_settings.dart';
import './my_route_search_delegate.dart';
import './routes/about.dart';

class MyRoute extends StatelessWidget {
  static const _kFrontLayerMinHeight = 128.0;
  // Path of source file (relative to project root). The file's content will be
  // shown in the "Code" tab.
  final String sourceFilePath;
  // Actual content of the example.
  final Widget child;
  // Title shown in the route's appbar. By default just returns routeName.
  final String _title;
  // A short description of the route. If not null, will be shown as subtitle in
  // the home page list tile.
  final String description;
  // Returns a set of links {title:link} that are relative to the route. Can put
  // documention links or reference video/article links here.
  final Map<String, String> links;
  // Route name of a page.
  final String _routeName;

  const MyRoute({
    Key key,
    @required this.sourceFilePath,
    @required this.child,
    String title,
    this.description,
    this.links,
    String routeName,
  })  : _title = title,
        _routeName = routeName,
        super(key: key);

  String get routeName =>
      this._routeName ?? '/${this.child.runtimeType.toString()}';

  String get title => _title ?? this.routeName;

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(this.title),
      ),
      actions: _getAppbarActions(context),
      iconPosition: BackdropIconPosition.action,
      headerHeight: _kFrontLayerMinHeight,
      frontLayer: Builder(
        builder: (BuildContext context) =>
            routeName == Navigator.defaultRouteName
                ? this.child
                : WidgetWithCodeView(
                    child: this.child,
                    sourceFilePath: this.sourceFilePath,
                    codeLinkPrefix: '$GITHUB_URL/blob/master',
                  ),
      ),
      backLayer: _getBackdropListTiles(),
    );
  }

  List<Widget> _getAppbarActions(BuildContext context) {
    final settings = Provider.of<MyAppSettings>(context);
    return <Widget>[
      if (this.routeName == Navigator.defaultRouteName)
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            final String selected = await showSearch<String>(
              context: context,
              delegate: MyRouteSearchDelegate(),
            );
            if (selected != null) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('You have selected the word: $selected'),
                ),
              );
            }
          },
        ),
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
      padding: EdgeInsets.only(bottom: _kFrontLayerMinHeight),
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
