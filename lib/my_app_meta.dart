// This file declares "metadata" (or "structure") of the app, in a const
// List<Tuple2> object. And it provides functions to get app's routing table or
// app's navigation drawer menu items from the declared metadata.
import 'package:flutter/material.dart';
import 'package:flutter_catalog/my_app_settings.dart';
import 'package:provider/provider.dart';

import './my_route.dart';
import './routes/about.dart';

import './routes/animation_animated_widget_ex.dart';
import './routes/animation_basic_ex.dart';
import './routes/animation_hero_ex.dart';
import './routes/animation_opacity_ex.dart';
import './routes/appbar_backdrop_ex.dart';
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
import './routes/state_bloc_ex.dart';
import './routes/state_bloc_lib_ex.dart';
import './routes/state_inherited_widget_ex.dart';
import './routes/state_provider_ex.dart';
import './routes/state_scoped_model_ex.dart';
import './routes/state_streambuilder_ex.dart';
import './routes/state_streamcontroller_ex.dart';
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
const APP_VERSION = 'v2.1.0';
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
    icon: Icon(Icons.extension),
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
      BackdropExample(),
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
      BasicAnimationExample(),
      AnimatedWidgetExample(),
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
    groupName: 'State Management',
    icon: Icon(Icons.developer_mode),
    routes: <MyRoute>[
      StreamBuilderExample(),
      StreamControllerExample(),
      InheritedWidgetExample(),
      ScopedModelExample(),
      BlocExample(),
      BlocLibExample(),
      ProviderExample(),
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

final kAllRoutes = kMyAppRoutesStructure.expand((group) => group.routes);

// Returns the app's navigation drawer menu items.
ListView getNavDrawerItems(BuildContext context) {
  final drawerHeader = DrawerHeader(
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        kAppIcon,
        Text(APP_NAME, style: Theme.of(context).textTheme.title),
        Text(APP_VERSION, style: Theme.of(context).textTheme.caption),
      ],
    ),
  );

  final toggleDarkModeBtn = Consumer<MyAppSettings>(
    builder: (context, MyAppSettings settings, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Dark mode',
            style: Theme.of(context).textTheme.button,
          ),
          Switch(
            onChanged: (bool value) => settings.setDartMode(value),
            value: settings.isDarkMode,
          ),
        ],
      );
    },
  );

  return ListView(
    children: <Widget>[
      drawerHeader,
      ...MyAboutRoute.kAboutListTiles,
      toggleDarkModeBtn
    ],
  );
}
