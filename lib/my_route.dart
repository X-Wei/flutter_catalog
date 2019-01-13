import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import './my_code_view.dart';
import './my_app_meta.dart' as my_app_meta;

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
  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _TABS.length, vsync: this);
    my_app_meta.kSharedPreferences
      ..then((prefs) => setState(() => this._preferences = prefs));
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
              child: my_app_meta.getNavDrawerItems(this, context),
            )
          : null,
    );
  }

  // Returns a widget showing the star status of one demo route: a star icon
  // with counts.
  Widget starStatusOfRoute(MyRoute route) {
    return IconButton(
      tooltip: 'Bookmark',
      icon: Icon(
        this._isStared(route.routeName) ? Icons.star : Icons.star_border,
        color: this._isStared(route.routeName) ? Colors.yellow : Colors.grey,
      ),
      onPressed: () => setState(() => this._toggleStared(route.routeName)),
    );
  }

  List<Widget> _getAppbarActions() {
    // final state = MyRouteState.of(context);
    final appbarActions = <Widget>[];
    if (this.widget.routeName != Navigator.defaultRouteName) {
      appbarActions.add(starStatusOfRoute(this.widget));
    }
    if (this.widget.links.isNotEmpty) {
      final popMenu = PopupMenuButton(
        itemBuilder: (context) {
          var menuItems = <PopupMenuItem>[];
          this.widget.links.forEach((title, link) {
            menuItems.add(
              PopupMenuItem(
                child: ListTile(
                  title: Text(title),
                  trailing: IconButton(
                    icon: Icon(Icons.open_in_new),
                    tooltip: '$link',
                    onPressed: () => url_launcher.launch(link),
                  ),
                  onTap: () => url_launcher.launch(link),
                ),
              ),
            );
          });
          return menuItems;
        },
      );
      appbarActions.add(popMenu);
    }
    return appbarActions;
  }

  // Returns whether routeName (defaults to this.widget.routeName) is stared.
  bool _isStared([String routeName]) {
    routeName ??= this.widget.routeName;
    return my_app_meta.BookmarkManager.isStared(routeName, this._preferences);
  }

  // Toggles the local stared/not-stared status of routeName (defaults to
  // this.widget.routeName).
  void _toggleStared([String routeName]) {
    routeName ??= this.widget.routeName;
    my_app_meta.BookmarkManager.toggleStared(routeName, this._preferences);
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
    return this.widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
