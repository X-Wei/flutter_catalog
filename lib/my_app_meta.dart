// This file declares "metadata" (or "structure") of the app, in a const
// List<Tuple2> object. And it provides functions to get app's routing table or
// app's navigation drawer menu items from the declared metadata.
import 'package:flutter/material.dart';
import 'package:flutter_catalog/my_app_settings.dart';
import 'package:provider/provider.dart';

import './constants.dart';
import './my_route.dart';
import './routes/about.dart';

import './routes/animation_animated_builder_ex.dart';
import './routes/animation_animated_container_ex.dart';
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
      MyRoute2(
        child: IconExample(),
        sourceFilePath: 'lib/routes/widgets_icon_ex.dart',
        title: 'Icon',
      ),
      MyRoute2(
        child: TextExample(),
        sourceFilePath: 'lib/routes/widgets_text_ex.dart',
        title: 'Text',
      ),
      MyRoute2(
        child: TextFieldExample(),
        sourceFilePath: 'lib/routes/widgets_textfield_ex.dart',
        title: 'TextField',
        description: 'Text input.',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/material/TextField-class.html'
        },
      ),
      MyRoute2(
        child: TextFormFieldExample(),
        sourceFilePath: 'lib/routes/widgets_textformfield_ex.dart',
        title: 'TextFormField',
        description: 'Convenience widget wrapping a TextField in a FormField.',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/TextFormField-class.html'
        },
      ),
      MyRoute2(
        child: ImageExample(),
        sourceFilePath: 'lib/routes/widgets_image_ex.dart',
        title: 'Image',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/widgets/Image-class.html'
        },
      ),
      MyRoute2(
        child: CardExample(),
        sourceFilePath: 'lib/routes/widgets_card_ex.dart',
        title: 'Card, Inkwell',
        description:
            'Container with corner and shadow; inkwell (ripple) effects',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/material/Card-class.html',
          'Inkwell': 'https://flutter.io/cookbook/gestures/ripples/',
        },
      ),
      MyRoute2(
        child: ButtonsExample(),
        sourceFilePath: 'lib/routes/widgets_buttons_ex.dart',
        title: 'Buttons',
        description:
            'RaisedButton, FlatButton, OutlineButton, IconButton&Tooltips',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/ButtonBar-class.html',
          'Gallery button demo code':
              'https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/buttons_demo.dart'
        },
      ),
      MyRoute2(
        child: DropdownButtonExample(),
        sourceFilePath: 'lib/routes/widgets_dropdown_button_ex.dart',
        title: 'DropdownButton, MenuButton',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/DropdownButton-class.html'
        },
      ),
      MyRoute2(
        child: StatefulWidgetsExample(),
        sourceFilePath: 'lib/routes/widgets_stateful_widgets_ex.dart',
        title: 'Other stateful widgets',
        description: 'Switch, CheckBox, Slider, etc.',
      ),
    ],
  ),
  MyRouteGroup(
    groupName: 'Layouts',
    icon: Icon(Icons.dashboard),
    routes: <MyRoute>[
      MyRoute2(
        child: ContainerExample(),
        sourceFilePath: 'lib/routes/layouts_container_padding_center_ex.dart',
        title: 'Container',
        description: 'Basic widgets for layout.',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/widgets/Container-class.html',
        },
      ),
      MyRoute2(
        child: RowColExample(),
        sourceFilePath: 'lib/routes/layouts_row_col_ex.dart',
        title: 'Row, Column',
        description: 'Align chidren widgets linearly.',
        links: {
          "Youtube video": "https://www.youtube.com/watch?v=RJEnTRBxaSg&t=75s",
          'Doc': 'https://docs.flutter.io/flutter/widgets/Row-class.html',
        },
      ),
      MyRoute2(
        child: WrapExample(),
        sourceFilePath: 'lib/routes/layouts_wrap_ex.dart',
        title: 'Wrap',
        description: 'Wrap to the next row/column when run out of room.',
        links: {
          "Youtube video": "https://www.youtube.com/watch?v=z5iw2SeFx2M",
          'Doc': 'https://docs.flutter.io/flutter/widgets/Wrap-class.html',
        },
      ),
      MyRoute2(
        child: ExpandedExample(),
        sourceFilePath: 'lib/routes/layouts_expanded_ex.dart',
        title: 'Expanded, SizedBox',
        description: 'Dividing space by "weights" (flex).',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/widgets/Expanded-class.html',
          'Youtube video':
              'https://www.youtube.com/watch?v=RJEnTRBxaSg&t=1072s',
        },
      ),
      MyRoute2(
        child: StackExample(),
        sourceFilePath: 'lib/routes/layouts_stack_ex.dart',
        title: 'Stack',
        description: 'Putting widget on top of another.',
        links: {
          "Youtube video":
              "https://www.youtube.com/watch?v=RJEnTRBxaSg&t=1072s",
          'Doc': 'https://docs.flutter.io/flutter/widgets/Stack-class.html',
        },
      ),
      // TODO TableExample(),
    ],
  ),
  MyRouteGroup(
    groupName: 'Lists',
    icon: Icon(Icons.format_list_numbered),
    routes: <MyRoute>[
      MyRoute2(
        child: ListTileExample(),
        sourceFilePath: 'lib/routes/lists_list_tile_ex.dart',
        title: 'ListTile',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/material/ListTile-class.html',
        },
      ),
      MyRoute2(
        child: ListViewBuilderExample(),
        sourceFilePath: 'lib/routes/lists_listview_builder_ex.dart',
        title: 'ListView.builder',
        description: 'Building list items with a builder.',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/widgets/ListView-class.html',
        },
      ),
      MyRoute2(
        child: GridListExample(),
        sourceFilePath: 'lib/routes/lists_grid_list_ex.dart',
        title: 'GridList',
        links: {
          'Cookbook': 'https://flutter.io/cookbook/lists/grid-lists/',
        },
      ),
      MyRoute2(
        child: ExpansionTileExample(),
        sourceFilePath: 'lib/routes/lists_expansion_tile_ex.dart',
        title: 'ExpansionTile',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/ExpansionTile-class.html',
        },
      ),
      MyRoute2(
        child: ListSwipeToDismissExample(),
        sourceFilePath: 'lib/routes/lists_swipe_to_dismiss_ex.dart',
        title: 'Swipe to dismiss',
        links: {
          'Cookbook': 'https://flutter.io/cookbook/gestures/dismissible',
        },
      ),
      MyRoute2(
        child: ReorderableListExample(),
        sourceFilePath: 'lib/routes/lists_reorderable_ex.dart',
        title: 'Reorderable list',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/ReorderableListView-class.html'
        },
      ),
      MyRoute2(
        child: DataTableExample(),
        sourceFilePath: 'lib/routes/lists_datatable_ex.dart',
        title: 'DataTable',
        description: 'Showing data in a table.',
        links: {
          'Docs':
              'https://docs.flutter.io/flutter/material/PaginatedDataTable-class.html'
        },
      ),
    ],
  ),
  MyRouteGroup(
    groupName: 'Appbar',
    icon: RotatedBox(
      child: Icon(Icons.video_label),
      quarterTurns: 2,
    ),
    routes: <MyRoute>[
      MyRoute2(
        child: BasicAppbarExample(),
        sourceFilePath: 'lib/routes/appbar_basic_appbar_ex.dart',
        title: 'Basic AppBar',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/material/AppBar-class.html',
        },
      ),
      MyRoute2(
        child: BottomAppbarExample(),
        sourceFilePath: 'lib/routes/appbar_bottom_appbar_ex.dart',
        title: 'Bottom AppBar',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html'
        },
      ),
      MyRoute2(
        child: SliverAppBarExample(),
        sourceFilePath: 'lib/routes/appbar_sliver_appbar_ex.dart',
        title: 'Sliver AppBar',
        description: 'Appbar that auto-hides.',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/SliverAppBar-class.html',
          'Medium article':
              'https://flutterdoc.com/animating-app-bars-in-flutter-cf034cd6c68b',
        },
      ),
      MyRoute2(
        child: AppBarSearchExample(),
        sourceFilePath: 'lib/routes/appbar_search_ex.dart',
        title: 'Search',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/SearchDelegate-class.html'
        },
      ),
      MyRoute2(
        child: BackdropExample(),
        sourceFilePath: 'lib/routes/appbar_backdrop_ex.dart',
        title: 'Backdrop',
        description: 'Switching between front and back layer.',
        links: {
          'Medium article':
              'https://medium.com/flutter/decomposing-widgets-backdrop-b5c664fb9cf4'
        },
      ),
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
      AnimatedBuilderExample(),
      AnimatedContainerExample(),
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

final ListView kBackdropListTiles = ListView(
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
        leading:
            Icon(settings.isDarkMode ? Icons.brightness_4 : Icons.brightness_7),
        title: Text('Dark mode'),
        trailing: Switch(
          onChanged: (bool value) => settings.setDarkMode(value),
          value: settings.isDarkMode,
        ),
      );
    }),
  ],
);
