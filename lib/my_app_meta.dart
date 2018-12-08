// This file declares "metadata" (or "structure") of the app, in a const
// List<Tuple2> object. And it provides fuctions to get app's routing table or
// app's navigation drawer menu items from the declared metadata.
import 'package:flutter/material.dart';

import './my_route.dart';
import './routes/about.dart';
import './routes/home.dart';

import './routes/appbar_basic_appbar_ex.dart';
import './routes/appbar_bottom_appbar_ex.dart';
import './routes/appbar_search_ex.dart';
import './routes/appbar_sliver_appbar_ex.dart';
import './routes/firebase_chatroom_ex.dart';
import './routes/firebase_login_ex.dart';
import './routes/layouts_container_padding_center_ex.dart';
import './routes/layouts_expanded_ex.dart';
import './routes/layouts_opacity_ex.dart';
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
const APP_VERSION = 'v1.1.1';
const APP_NAME = 'Flutter Catalog';
const APP_LOGO = FlutterLogo(size: 32.0);
const APP_DESCRIPTION = 'An app showcasing Flutter components, with '
    'side-by-side source code view.'
    '\n\nDevelopped by X.Wei.';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=io.github.x_wei.flutter_catalog';
const GITHUB_URL = 'https://github.com/X-Wei/flutter_catalog';
const AUTHOR_SITE = 'http://x-wei.github.io';

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
      OpacityExample(),
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
    groupName: 'Firebase',
    icon: Icon(Icons.cloud),
    routes: <MyRoute>[
      FirebaseLoginExample(),
      FirebaseChatroomExample(),
    ],
  ),
  // TODO MyRouteGroup('Animation', [BackDropExample(),])
];

const kAboutRoute = MyAboutRoute();

// Returns the app's root-level routing table.
Map<String, WidgetBuilder> getRoutingTable() {
  final routingTable = <String, WidgetBuilder>{
    // By default go to home screen. (Navigator.defaultRouteName is just '/')
    Navigator.defaultRouteName: (context) => MyHomeRoute(),
    kAboutRoute.routeName: (context) => kAboutRoute,
  };
  kMyAppRoutesStructure.forEach((myRouteGroup) {
    List<MyRoute> routes = myRouteGroup.routes;
    routes.forEach((MyRoute route) {
      final widgetBuilder = (BuildContext context) => route;
      routingTable[route.routeName] = widgetBuilder;
    });
  });
  return routingTable;
}

// Returns the app's navigation drawer menu items.
ListView getNavDrawerItems(State state, BuildContext context) {
  final drawerHeader = DrawerHeader(
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          child: APP_LOGO,
        ),
        Text(
          APP_NAME,
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          '$APP_VERSION',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    ),
  );

  List<Widget> drawerNavItems = [
    drawerHeader,
  ]..addAll(kAboutRoute.aboutListTiles(context));
  return ListView(
    children: drawerNavItems,
  );
  // return kAboutRoute.buildMyRouteContent(context);
}
