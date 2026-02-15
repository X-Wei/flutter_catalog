import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'my_app_routes.dart';
import 'my_app_settings.dart';
import 'my_route.dart';
import 'my_route_group.dart';
import 'routes/monetization_inline_banner_ad_ex.dart';
import 'routes/onboarding_intro_screen_ex.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  List<BottomNavigationBarItem> get _bottmonNavBarItems {
    final newBasic = nNewRoutes(kMyAppRoutesBasic);
    final newAdvanced = nNewRoutes(kMyAppRoutesAdvanced);
    final newInaction = nNewRoutes(kMyAppRoutesInAction);
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Badge(
          label: Text(newBasic.toString()),
          isLabelVisible: newBasic > 0,
          child: Icon(Icons.library_books),
        ),
        label: 'Basics',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.blueAccent,
        icon: Badge(
          label: Text(newAdvanced.toString()),
          isLabelVisible: newAdvanced > 0,
          child: Icon(Icons.insert_chart),
        ),
        label: 'Advanced',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.blueAccent,
        icon: Badge(
          label: Text(newInaction.toString()),
          isLabelVisible: newInaction > 0,
          child: Icon(Icons.rocket),
        ),
        label: 'In Action',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.indigo,
        icon: Icon(Icons.star),
        label: 'Bookmarks',
      ),
    ];
  }

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = ref.read(mySettingsProvider);
      if (settings.introIsShown == false) {
        Navigator.of(context)
            .push(IntroductionScreenExample.route())
            .then((_) => settings.introIsShown = true);
      }
    });
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
        group.homepageExpansionTile(ref, context),
      const MyBannerAd(),
    ];
    final advancedDemos = <Widget>[
      for (final MyRouteGroup group in kMyAppRoutesAdvanced)
        group.homepageExpansionTile(ref, context),
      const MyBannerAd(),
    ];
    final inactionDemos = <Widget>[
      for (final MyRouteGroup group in kMyAppRoutesInAction)
        group.homepageExpansionTile(ref, context),
      const MyBannerAd(),
    ];
    final bookmarkAndAboutDemos = <Widget>[
      for (final MyRoute route in ref.watch(mySettingsProvider).starredRoutes)
        route.homepageListTile(
          ref,
          context,
          leading: const Icon(Icons.bookmark),
        ),
      kAboutRoute.homepageListTile(
        ref,
        context,
        leading: const Icon(Icons.info),
      ),
      const MyBannerAd(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(mySettingsProvider).currentTabIdx,
        children: <Widget>[
          ListView(controller: _scrollController1, children: basicDemos),
          ListView(controller: _scrollController2, children: advancedDemos),
          ListView(controller: _scrollController3, children: inactionDemos),
          ListView(
            controller: _scrollController4,
            children: bookmarkAndAboutDemos,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottmonNavBarItems,
        currentIndex: ref.watch(mySettingsProvider).currentTabIdx,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          ref.read(mySettingsProvider).currentTabIdx = index;
        },
      ),
    );
  }

  /// Number of newly added routes (for the routeGroups in a tab)
  int nNewRoutes(List<MyRouteGroup> routeGroups) {
    int res = 0;
    for (final group in routeGroups) {
      res += ref.watch(mySettingsProvider).numNewRoutes(group);
    }
    return res;
  }
}
