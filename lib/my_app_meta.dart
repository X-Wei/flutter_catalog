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
      MyRoute2(
        child: TabsExample(),
        sourceFilePath: 'lib/routes/nav_tabs_ex.dart',
        title: 'Tabs',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/material/TabBar-class.html'
        },
      ),
      MyRoute2(
        child: DialogsExample(),
        sourceFilePath: 'lib/routes/nav_dialogs_ex.dart',
        title: 'Dialogs',
      ),
      MyRoute2(
        child: RoutesExample(),
        sourceFilePath: 'lib/routes/nav_routes_ex.dart',
        title: 'Routes',
        description: 'Jumping between pages.',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/widgets/Navigator-class.html',
          'Youtube video':
              'https://youtu.be/b2fgMCeSNpY?list=PLJbE2Yu2zumDqr_-hqpAN0nIr6m14TAsd',
        },
      ),
      MyRoute2(
        child: NavDrawerExample(),
        sourceFilePath: 'lib/routes/nav_nav_drawer_header_ex.dart',
        title: 'Navigation Drawer',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/material/Drawer-class.html',
        },
      ),
      MyRoute2(
        child: BottomTabbarExample(),
        sourceFilePath: 'lib/routes/nav_bottom_tabbar_ex.dart',
        title: 'Bottom tab bar',
      ),
      MyRoute2(
        child: BottomNavigationBarExample(),
        sourceFilePath: 'lib/routes/nav_bottom_navbar_ex.dart',
        title: 'Bottom navigation bar',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html',
        },
      ),
      MyRoute2(
        child: PageSelectorExample(),
        sourceFilePath: 'lib/routes/nav_pageselector_ex.dart',
        title: 'Page selector',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/material/TabPageSelector-class.html'
        },
      ),
    ],
  ),
  MyRouteGroup(
    groupName: 'Animation',
    icon: Icon(Icons.movie_filter),
    routes: <MyRoute>[
      MyRoute2(
        child: OpacityExample(),
        sourceFilePath: 'lib/routes/animation_opacity_ex.dart',
        title: 'Opacity',
        description: 'Making a widget transparent/visible.',
        links: {
          'Doc': 'https://docs.flutter.io/flutter/widgets/Opacity-class.html',
          'Youtube video':
              'https://www.youtube.com/watch?v=9hltevOHQBw&index=5&list=PLOU2XLYxmsIL0pH0zWe_ZOHgGhZ7UasUE',
        },
      ),
      MyRoute2(
        child: HeroExample(),
        sourceFilePath: 'lib/routes/animation_hero_ex.dart',
        title: 'Hero',
        description: 'Hero animation between routes.',
        links: {
          'cookbook':
              'https://flutter.io/docs/development/ui/animations/hero-animations',
          'Youtube video': 'https://www.youtube.com/watch?v=Be9UH1kXFDw',
        },
      ),
      MyRoute2(
        child: BasicAnimationExample(),
        sourceFilePath: 'lib/routes/animation_basic_ex.dart',
        title: 'Basic animation',
        description:
            'Implement animation using low-level Animations, AnimationControllers and Tweens.',
        links: {
          'Tutorial':
              'https://flutter.dev/docs/development/ui/animations/tutorial',
          'Youtube video': 'https://www.youtube.com/watch?v=mdhoIQqS2z0',
        },
      ),
      MyRoute2(
        child: AnimatedWidgetExample(),
        sourceFilePath: 'lib/routes/animation_animated_widget_ex.dart',
        title: 'AnimatedWidget',
        description: 'Easier animtation without addListener() and setState()',
        links: {
          'Tutorial':
              'https://flutter.dev/docs/development/ui/animations/tutorial#simplifying-with-animatedwidget',
          'Youtube video': 'https://www.youtube.com/watch?v=mdhoIQqS2z0',
        },
      ),
      MyRoute2(
        child: AnimatedBuilderExample(),
        sourceFilePath: 'lib/routes/animation_animated_builder_ex.dart',
        title: 'AnimatedBuilder',
        description: 'Similar to AnimatedWidget.',
        links: {
          'Tutorial':
              'https://flutter.dev/docs/development/ui/animations/tutorial#refactoring-with-animatedbuilder',
          'Widget of the Week (YouTube)': 'https://youtu.be/N-RiyZlv8v8',
        },
      ),
      MyRoute2(
        child: AnimatedContainerExample(),
        sourceFilePath: 'lib/routes/animation_animated_container_ex.dart',
        title: 'AnimatedContainer',
        description:
            'Implicit animation when container property changes, without controllers.',
        links: {
          'Cookbook':
              'https://flutter.dev/docs/cookbook/animation/animated-container',
          'Widget of the Week (YouTube)': 'https://youtu.be/yI-8QHpGIP4',
        },
      ),
    ],
  ),
  MyRouteGroup(
    groupName: 'Persistence',
    icon: Icon(Icons.sd_storage),
    routes: <MyRoute>[
      MyRoute2(
        child: SharedPreferenceExample(),
        sourceFilePath: 'lib/routes/persistence_preference_ex.dart',
        title: 'Shared preference',
        description: 'Key-value pairs stored locally using shared_preference.',
        links: {
          'Cookbook': 'https://flutter.io/docs/cookbook/persistence/key-value',
        },
      ),
      MyRoute2(
        child: FileReadWriteExample(),
        sourceFilePath: 'lib/routes/persistence_file_rw_ex.dart',
        title: 'Local file read/write',
        description: 'Read and write local file using path_provider.',
        links: {
          'Cookbook':
              'https://flutter.io/docs/cookbook/persistence/reading-writing-files',
        },
      ),
    ],
  ),
  MyRouteGroup(
    groupName: 'State Management',
    icon: Icon(Icons.developer_mode),
    routes: <MyRoute>[
      MyRoute2(
        child: StreamBuilderExample(),
        sourceFilePath: 'lib/routes/state_streambuilder_ex.dart',
        title: 'StreamBuilder (timer app)',
        description: 'Update UI according to the latest stream value.',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/widgets/StreamBuilder-class.html',
          'Youtube': 'https://www.youtube.com/watch?v=MkKEWHfy99Y',
        },
      ),
      MyRoute2(
        child: StreamControllerExample(),
        sourceFilePath: 'lib/routes/state_streamcontroller_ex.dart',
        title: 'StreamController',
        description:
            'Receive data from sink and output at stream, two StreamControllers can make a "Bloc".',
        links: {
          'Doc':
              'https://api.dartlang.org/stable/2.1.1/dart-async/StreamController-class.html',
        },
      ),
      MyRoute2(
        child: InheritedWidgetExample(),
        sourceFilePath: 'lib/routes/state_inherited_widget_ex.dart',
        title: 'InheritedWidget',
        description: 'Access state of widgets up the tree.',
        links: {
          'Doc':
              'https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html',
          'Youtube': 'https://www.youtube.com/watch?v=4I68ilX0Y24',
        },
      ),
      MyRoute2(
        child: ScopedModelExample(),
        sourceFilePath: 'lib/routes/state_scoped_model_ex.dart',
        title: 'ScopedModel',
        description:
            'Another (simpler) way to access&mutate state of widgets up the tree.',
        links: {
          "I/O'18 talk": 'https://youtu.be/RS36gBEp8OI?t=680',
          'Youtube': 'https://www.youtube.com/watch?v=-MCeWP3rgI0',
        },
      ),
      MyRoute2(
        child: BlocExample(),
        sourceFilePath: 'lib/routes/state_bloc_ex.dart',
        title: 'BLoC pattern',
        description:
            'Combining StreamBuilder, StreamController, and InheritedWidget.',
        links: {
          "I/O'18 talk": 'https://youtu.be/RS36gBEp8OI?t=1090',
          'Video by Reso Coder': 'https://youtu.be/oxeYeMHVLII',
        },
      ),
      MyRoute2(
        child: BlocLibExample(),
        sourceFilePath: 'lib/routes/state_bloc_lib_ex.dart',
        title: 'Easier BLoC pattern',
        description: 'Simpler BLoC implementation with flutter_bloc package.',
        links: {
          'Video by Reso Coder': 'https://youtu.be/LeLrsnHeCZY',
          'flutter_bloc doc': 'https://felangel.github.io/bloc/#/coreconcepts',
        },
      ),
      MyRoute2(
        child: ProviderExample(),
        sourceFilePath: 'lib/routes/state_provider_ex.dart',
        title: 'Provider',
        description: 'Officially recommended state management solution.',
        links: {
          "I/O'19 talk": 'https://www.youtube.com/watch?v=d_m5csmrf7I',
          'pub.dev': 'https://pub.dev/packages/provider',
        },
      ),
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
