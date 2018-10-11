// This file declares "metadata" (or "structure") of the app, in a const
// List<Tuple2> object. And it provides fuctions to get app's routing table or
// app's navigation drawer menu items from the declared metadata.
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import './my_route.dart';
import './routes/about.dart';
import './routes/home.dart';

import './routes/appbar_basic_appbar_ex.dart';
import './routes/appbar_bottom_appbar_ex.dart';
import './routes/appbar_search_ex.dart';
import './routes/appbar_sliver_appbar_ex.dart';
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
// *Note*: when APP_VERSION is changed, remember to also update 
// android/app/build.gradle.
const APP_VERSION = '1.0.1';
const APP_NAME = 'Flutter Catalog';
const APP_LOGO = FlutterLogo();
const APP_DESCRIPTION = 'An app showcasing Flutter components, with '
    'side-by-side source code view.'
    '\n\nDevelopped by X.Wei.';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=io.github.x_wei.flutter_catalog';
const GITHUB_URL = 'https://github.com/X-Wei/flutter_catalog';
const AUTHOR_SITE = 'http://x-wei.github.io';

// The structure of app's navigation drawer items is a 2-level menu, its schema
// is the following:
// [ Tuple{group1_name,
//        [route1, route2, ...]
//   },
//   Tuple{group2_name,
//        [route1, route2, ...]
//   },
//   ...
// ]

// *Note*: To make the declaration more readable, we want to use type alias. But
// dart doesn't yet support type alias
// (https://github.com/dart-lang/sdk/issues/2626). As a workaround, we create
// _ItemGroup class that extends the Tupel2<xxx> class.
class _ItemGroup extends Tuple2<String, List<MyRoute>> {
  const _ItemGroup(String item1, List<MyRoute> item2) : super(item1, item2);
}

const kMyAppRoutesStructure = <_ItemGroup>[
  _ItemGroup(
    'Widgets',
    <MyRoute>[
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
  _ItemGroup(
    'Layouts',
    <MyRoute>[
      ContainerBasicsExample(),
      RowColExample(),
      WrapExample(),
      ExpandedExample(),
      StackExample(),
      OpacityExample(),
    ],
  ),
  _ItemGroup(
    'Lists',
    <MyRoute>[
      ListTileExample(),
      ListViewBuilderExample(),
      GridListExample(),
      ExpansionTileExample(),
      ListSwipeToDismissExample(),
      ReorderableListExample(),
      DataTableExample(),
    ],
  ),
  _ItemGroup(
    'Appbar',
    <MyRoute>[
      BasicAppbarExample(),
      BottomAppbarExample(),
      SliverAppBarExample(),
      AppbarSearchExample(),
    ],
  ),
  _ItemGroup(
    'Navigation',
    <MyRoute>[
      TabsExample(),
      DialogsExample(),
      RoutesExample(),
      NavDrawerExample(),
      BottomTabbarExample(),
      BottomNavigationBarExample(),
      PageSelectorExample(),
    ],
  )
  // TODO _ItemGroup('Animation', [BackDropExample(),])
];

// Returns the app's root-level routing table.
Map<String, WidgetBuilder> getRoutingTable() {
  final routingTable = <String, WidgetBuilder>{
    // By default go to home screen. (Navigator.defaultRouteName is just '/')
    Navigator.defaultRouteName: (context) => MyHomeRoute(),
    '/AboutRoute': (context) => MyAboutRoute(),
  };
  kMyAppRoutesStructure.forEach((itemGroup) {
    List<MyRoute> routes = itemGroup.item2;
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
    child: Center(
      child: Text(
        'Fultter Catalog',
        style: Theme.of(context).textTheme.title,
      ),
    ),
  );

  ListTile _getNavItem(String navItemTitle, String routeName,
      {IconData icon, String description}) {
    return ListTile(
      leading: icon == null ? null : Icon(icon),
      title: Text(navItemTitle),
      subtitle: description == null ? null : Text(description),
      onTap: () {
        state.setState(() {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(routeName);
        });
      },
    );
  }

  ExpansionTile _getNavGroup(String groupName, List<MyRoute> routes) {
    return ExpansionTile(
      key: PageStorageKey<String>(groupName),
      title: Text(groupName),
      children: routes
          .map((route) => _getNavItem(route.title, route.routeName,
              description: route.description))
          .toList(),
    );
  }

  List<Widget> drawerNavItems = [
    drawerHeader,
    _getNavItem('Home', Navigator.defaultRouteName, icon: Icons.home),
  ];
  kMyAppRoutesStructure.forEach((nameAndRoutes) {
    drawerNavItems.add(_getNavGroup(nameAndRoutes.item1, nameAndRoutes.item2));
  });
  drawerNavItems.add(
    _getNavItem('About', '/AboutRoute', icon: Icons.info),
  );

  return ListView(
    children: drawerNavItems,
  );
}
