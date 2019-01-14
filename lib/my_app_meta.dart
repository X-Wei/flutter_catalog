// This file declares "metadata" (or "structure") of the app, in a const
// List<Tuple2> object. And it provides fuctions to get app's routing table or
// app's navigation drawer menu items from the declared metadata.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './my_route.dart';
import './routes/about.dart';
import './routes/home.dart';

import './routes/animation_hero_ex.dart';
import './routes/animation_opacity_ex.dart';
import './routes/appbar_basic_appbar_ex.dart';
import './routes/appbar_bottom_appbar_ex.dart';
import './routes/appbar_search_ex.dart';
import './routes/appbar_sliver_appbar_ex.dart';
import './routes/firebase_chatroom_ex.dart';
import './routes/firebase_login_ex.dart';
import './routes/firebase_mlkit_ex.dart';
import './routes/firebase_vote_ex.dart';
import './routes/layouts_container_padding_center_ex.dart';
import './routes/layouts_expanded_ex.dart';
import './routes/layouts_row_col_ex.dart';
import './routes/layouts_stack_ex.dart';
import './routes/layouts_wrap_ex.dart';
import './routes/lists_datatable_ex.dart';
import './routes/lists_expansion_tile_ex.dart';
import './routes/lists_grid_list_ex.dart';
import './routes/lists_list_tile_ex.dart';
import './routes/lists_listview_builder_ex.dart';
import './routes/lists_reorderable_ex.dart';
import './routes/lists_swipe_to_dismiss_ex.dart';
import './routes/nav_bottom_navbar_ex.dart';
import './routes/nav_bottom_tabbar_ex.dart';
import './routes/nav_dialogs_ex.dart';
import './routes/nav_nav_drawer_header_ex.dart';
import './routes/nav_pageselector_ex.dart';
import './routes/nav_routes_ex.dart';
import './routes/nav_tabs_ex.dart';
import './routes/persistence_file_rw_ex.dart';
import './routes/persistence_preference_ex.dart';
import './routes/plugins_image_picker_ex.dart';
import './routes/plugins_local_auth_ex.dart';
import './routes/plugins_markdown_ex.dart';
import './routes/plugins_webview_ex.dart';
import './routes/widgets_buttons_ex.dart';
import './routes/widgets_card_ex.dart';
import './routes/widgets_dropdown_button_ex.dart';
import './routes/widgets_icon_ex.dart';
import './routes/widgets_image_ex.dart';
import './routes/widgets_stateful_widgets_ex.dart';
import './routes/widgets_text_ex.dart';
import './routes/widgets_textfield_ex.dart';
import './routes/widgets_textformfield_ex.dart';

// Metadatas about this app:
// *Note*: when APP_VERSION is changed, remember to also update pubspec.yaml.
const APP_VERSION = 'v1.5.2';
const APP_NAME = 'Flutter Catalog';
final kAppIcon =
    Image.asset('res/images/launcher_icon.png', height: 64.0, width: 64.0);
const APP_DESCRIPTION = 'An app showcasing Flutter components, with '
    'side-by-side source code view.'
    '\n\nDeveloped by X.Wei.';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=io.github.x_wei.flutter_catalog';
const GITHUB_URL = 'https://github.com/X-Wei/flutter_catalog';
const AUTHOR_SITE = 'http://x-wei.github.io';

const kHomeRoute = MyHomeRoute();
const kAboutRoute = MyAboutRoute();

// All routes should use this same preference instance, to avoid unexpected
// states-not-updated issues.
final Future<SharedPreferences> kSharedPreferences =
    SharedPreferences.getInstance();

// A class to manage the bookmark status of routes.
class BookmarkManager {
  static const kBookmarkedRoutesPreferenceKey = 'BOOKMARKED_ROUTES';

  // Returns if a route is stared or not.
  static bool isStared(String routeName, SharedPreferences preferences) {
    return bookmarkedRoutenames(preferences).contains(routeName) ?? false;
  }

  // Toggles the local stared/not-stared status of a route.
  static void toggleStared(String routeName, SharedPreferences preferences) {
    final staredRoutes = bookmarkedRoutenames(preferences);
    if (isStared(routeName, preferences)) {
      staredRoutes.remove(routeName);
    } else {
      staredRoutes.add(routeName);
    }
    final dedupedStaredRoutes = Set<String>.from(staredRoutes).toList();
    preferences?.setStringList(
        kBookmarkedRoutesPreferenceKey, dedupedStaredRoutes);
  }

  static List<String> bookmarkedRoutenames(SharedPreferences preferences) {
    return preferences?.getStringList(kBookmarkedRoutesPreferenceKey) ?? [];
  }

  static Future<List<String>> bookmarkedRoutenamesAsync() async {
    final preferences = await kSharedPreferences;
    return bookmarkedRoutenames(preferences);
  }
}

// The structure of app's navigation drawer items is a 2-level menu, its schema
// is the following:
// [ MyRouteGroup{
//        groupName: group1_name,
//        icon: group1_icon,
//        routes: [route1, route2, ...]
//   },
//   MyRouteGroup{
//        groupName: group2_name,
//        icon: group2_icon,
//        routes: [route1, route2, ...]
//   },
//   ...
// ]
class MyRouteGroup {
  const MyRouteGroup(
      {@required this.groupName, @required this.icon, @required this.routes});
  final String groupName;
  final Widget icon;
  final List<MyRoute> routes;
}

const kMyAppRoutesStructure = <MyRouteGroup>[
  MyRouteGroup(
    groupName: 'Widgets',
    icon: Icon(Icons.widgets),
    routes: <MyRoute>[
      IconExample(),
      TextExample(),
      TextFieldExample(),
      TextFormFieldExample(),
      ImageExample(),
      CardExample(),
      ButtonsExample(),
      DropdownButtonExample(),
      StatefulWidgetsExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Layouts',
    icon: Icon(Icons.dashboard),
    routes: <MyRoute>[
      ContainerBasicsExample(),
      RowColExample(),
      WrapExample(),
      ExpandedExample(),
      StackExample(),
      // TODO TableExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Lists',
    icon: Icon(Icons.format_list_numbered),
    routes: <MyRoute>[
      ListTileExample(),
      ListViewBuilderExample(),
      GridListExample(),
      ExpansionTileExample(),
      ListSwipeToDismissExample(),
      ReorderableListExample(),
      DataTableExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Appbar',
    icon: RotatedBox(
      child: Icon(Icons.video_label),
      quarterTurns: 2,
    ),
    routes: <MyRoute>[
      BasicAppbarExample(),
      BottomAppbarExample(),
      SliverAppBarExample(),
      AppbarSearchExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Navigation',
    icon: Icon(Icons.view_carousel),
    routes: <MyRoute>[
      TabsExample(),
      DialogsExample(),
      RoutesExample(),
      NavDrawerExample(),
      BottomTabbarExample(),
      BottomNavigationBarExample(),
      PageSelectorExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Animation',
    icon: Icon(Icons.movie_filter),
    routes: <MyRoute>[
      OpacityExample(),
      HeroExample(),
      // TODO BackDropExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Persistence',
    icon: Icon(Icons.sd_storage),
    routes: <MyRoute>[
      SharedPreferenceExample(),
      FileReadWriteExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Plugins',
    icon: Icon(Icons.power),
    routes: <MyRoute>[
      ImagePickerExample(),
      WebViewExample(),
      MarkdownExample(),
      LocalAuthExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Firebase',
    icon: Icon(Icons.cloud),
    routes: <MyRoute>[
      FirebaseLoginExample(),
      FirebaseVoteExample(),
      FirebaseChatroomExample(),
      FirebaseMLKitExample(),
    ],
  ),
];

final _allRoutes = kMyAppRoutesStructure.expand((group) => group.routes);

// Mapping route names to routes.
final kRoutenameToRouteMap = Map<String, MyRoute>.fromIterable(
  _allRoutes,
  key: (route) => route.routeName,
  value: (route) => route,
)..addAll(
    {
      // By default go to home screen. (Navigator.defaultRouteName is just '/')
      Navigator.defaultRouteName: kHomeRoute,
      kAboutRoute.routeName: kAboutRoute,
    },
  );

// The app's root-level routing table.
Map<String, WidgetBuilder> kRoutingTable = kRoutenameToRouteMap.map(
  (routeName, route) {
    final widgetBuilder = (BuildContext context) => route;
    return MapEntry<String, WidgetBuilder>(routeName, widgetBuilder);
  },
);

// Returns the app's navigation drawer menu items.
ListView getNavDrawerItems(State state, BuildContext context) {
  final drawerHeader = DrawerHeader(
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        kAppIcon,
        Text(APP_NAME, style: Theme.of(context).textTheme.title),
        Text('$APP_VERSION', style: Theme.of(context).textTheme.caption),
      ],
    ),
  );

  List<Widget> drawerNavItems = []
    ..add(drawerHeader)
    ..addAll(kAboutRoute.aboutListTiles(context));
  return ListView(
    children: drawerNavItems,
  );
}
