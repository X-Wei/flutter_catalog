import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import './my_app_meta.dart' as my_app_meta;
import './my_app_settings.dart';
import './my_code_view.dart';

abstract class MyRoute extends StatefulWidget {
  // Path of source file (relative to project root). The file's content will be
  // shown in the "Code" tab.
  final String _sourceFile;

  static of(BuildContext context) =>
      context.rootAncestorStateOfType(const TypeMatcher<_MyRouteState>());

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
  Map<String, String> get links => {};

  // Returns the widget that will be shown in the "Preview" tab.
  Widget buildMyRouteContent(BuildContext context);

  @override
  State<StatefulWidget> createState() => _MyRouteState();
}

// Each MyRoute contains two tabs: "Preview" and "Code".
const _TABS = <Widget>[
  Tab(
    // text: 'Preview',
    // icon: Icon(Icons.phone_android),
    child: ListTile(
      leading: Icon(
        Icons.phone_android,
        color: Colors.white,
      ),
      title: Text(
        'Preview',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
  Tab(
    // text: 'Code',
    // icon: Icon(Icons.code),
    child: ListTile(
      leading: Icon(
        Icons.code,
        color: Colors.white,
      ),
      title: Text(
        'Code',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
];

class _MyRouteState extends State<MyRoute> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _TABS.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(this.widget.title),
        ),
        actions: _getAppbarActions(),
        bottom: TabBar(
          tabs: _TABS,
          controller: this._tabController,
        ),
      ),
      // Use a Builder so that Scaffold.of(context) uses correct context, c.f.
      // https://stackoverflow.com/a/45948913
      body: Builder(builder: (BuildContext context) {
        final myTabPages = <Widget>[
          // "Preview" tab:
          AlwaysAliveWidget(child: this.widget.buildMyRouteContent(context)),
          // "Code" tab:
          AlwaysAliveWidget(
              child: MyCodeView(filePath: this.widget._sourceFile)),
        ];
        assert(myTabPages.length == _TABS.length);
        // Body of MyRoute is two-tabs ("Preview" and "Code").
        return TabBarView(
          children: myTabPages,
          controller: this._tabController,
        );
      }),
      // Only home route has drawer:
      drawer: this.widget.routeName == Navigator.defaultRouteName
          ? Drawer(
              child: my_app_meta.getNavDrawerItems(context),
            )
          : null,
    );
  }

  // Returns a widget showing the star status of one demo route.
  Widget starStatusOfRoute(MyRoute route) {
    final settings = Provider.of<MyAppSettings>(context);
    return IconButton(
      tooltip: 'Bookmark',
      icon: Icon(
        settings.isStarred(route.routeName) ? Icons.star : Icons.star_border,
        color:
            settings.isStarred(route.routeName) ? Colors.yellow : Colors.grey,
      ),
      onPressed: () => setState(() => settings.toggleStarred(route.routeName)),
    );
  }

  List<Widget> _getAppbarActions() {
    return <Widget>[
      if (this.widget.routeName != Navigator.defaultRouteName)
        starStatusOfRoute(this.widget),
      if (this.widget.links.isNotEmpty)
        PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuItem>[
              for (MapEntry<String, String> titleAndLink
                  in this.widget.links.entries)
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
}

// This widget is always kept alive, so that when tab is switched back, its
// child's state is still preserved.
class AlwaysAliveWidget extends StatefulWidget {
  final Widget child;

  const AlwaysAliveWidget({Key key, @required this.child}) : super(key: key);
  @override
  _AlwaysAliveWidgetState createState() => _AlwaysAliveWidgetState();
}

class _AlwaysAliveWidgetState extends State<AlwaysAliveWidget>
    with AutomaticKeepAliveClientMixin<AlwaysAliveWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context); // This build method is annotated "@mustCallSuper".
    return this.widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
