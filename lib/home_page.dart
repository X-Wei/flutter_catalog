import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants.dart';
import 'my_app_routes.dart';

import './my_app_settings.dart';
import './my_route.dart';
import 'routes/monetization_inline_banner_ad_ex.dart';
import 'routes/onboarding_intro_screen_ex.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  static const _kBottmonNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.library_books),
      label: 'Basics',
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blueAccent,
      icon: Icon(Icons.insert_chart),
      label: 'Advanced',
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blueAccent,
      icon: Icon(Icons.rocket),
      label: 'In Action',
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.indigo,
      icon: Icon(Icons.star),
      label: 'Bookmarks',
    ),
  ];

  int _currentTabIndex = 0;
  // !Adding scroll controllers to avoid errors like:
  // !"The provided ScrollController is currently attached to more than one ScrollPosition."
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();
  final ScrollController _scrollController4 = ScrollController();

  @override
  void initState() {
    super.initState();
    //! Show intro screen if it's never shown before.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final settings = ref.read(mySettingsProvider);
        if (settings.introIsShown == false) {
          Navigator.of(context)
              .push(IntroductionScreenExample.route())
              .then((_) => settings.introIsShown = true);
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _scrollController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final basicDemos = <Widget>[
      for (final MyRouteGroup group in kMyAppRoutesBasic)
        _myRouteGroupToExpansionTile(group),
      const MyBannerAd(),
    ];
    final advancedDemos = <Widget>[
      for (final MyRouteGroup group in kMyAppRoutesAdvanced)
        _myRouteGroupToExpansionTile(group),
      const MyBannerAd(),
    ];
    final inactionDemos = <Widget>[
      for (final MyRouteGroup group in kMyAppRoutesInAction)
        _myRouteGroupToExpansionTile(group),
      const MyBannerAd(),
    ];
    final bookmarkAndAboutDemos = <Widget>[
      for (final MyRoute route in ref.watch(mySettingsProvider).starredRoutes)
        _myRouteToListTile(route, leading: const Icon(Icons.bookmark)),
      _myRouteToListTile(kAboutRoute, leading: const Icon(Icons.info)),
      const MyBannerAd(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: <Widget>[
          ListView(controller: _scrollController1, children: basicDemos),
          ListView(controller: _scrollController2, children: advancedDemos),
          ListView(controller: _scrollController3, children: inactionDemos),
          ListView(
              controller: _scrollController4, children: bookmarkAndAboutDemos),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _kBottmonNavBarItems,
        currentIndex: _currentTabIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          setState(() => this._currentTabIndex = index);
        },
      ),
    );
  }

  Widget _myRouteToListTile(MyRoute myRoute,
      {Widget? leading, IconData trialing = Icons.keyboard_arrow_right}) {
    final mySettings = ref.watch(mySettingsProvider);
    final routeTitleTextStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontWeight: FontWeight.bold);
    final leadingWidget =
        leading ?? mySettings.starStatusOfRoute(myRoute.routeName);
    final isNew = mySettings.isNewRoute(myRoute);
    return ListTile(
      leading: isNew
          ? badge.Badge(
              position: badge.BadgePosition.topEnd(top: 2, end: 2),
              child: leadingWidget,
            )
          : leadingWidget,
      title: Text(myRoute.title, style: routeTitleTextStyle),
      trailing: Icon(trialing),
      subtitle: myRoute.description.isEmpty ? null : Text(myRoute.description),
      onTap: () {
        if (isNew) {
          mySettings.markRouteKnown(myRoute);
        }
        kAnalytics?.logEvent(
          name: 'evt_openRoute',
          parameters: {'routeName': myRoute.routeName},
        );
        Navigator.of(context).pushNamed(myRoute.routeName);
      },
    );
  }

  Widget _myRouteGroupToExpansionTile(MyRouteGroup myRouteGroup) {
    final nNew = ref.watch(mySettingsProvider).numNewRoutes(myRouteGroup);
    return Card(
      key: ValueKey(myRouteGroup.groupName),
      child: ExpansionTile(
        leading: nNew > 0
            ? badge.Badge(badgeContent: Text('$nNew'), child: myRouteGroup.icon)
            : myRouteGroup.icon,
        title: Text(
          myRouteGroup.groupName,
          style: Theme.of(context).textTheme.headline6,
        ),
        children: myRouteGroup.routes.map(_myRouteToListTile).toList(),
      ),
    );
  }
}
