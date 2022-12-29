import 'package:backdrop/backdrop.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:widget_with_codeview/widget_with_codeview.dart';

import './constants.dart'
    show
        APP_NAME,
        GITHUB_URL,
        PlatformType,
        kAnalytics,
        kAppIcon,
        kPackageInfo,
        kPlatformType;
import './my_app_settings.dart';
import './my_route_search_delegate.dart';
import './routes/about.dart';
import 'routes/monetization_inline_banner_ad_ex.dart';

class MyRoute extends StatelessWidget {
  static const _kFrontLayerMinHeight = 128.0;
  // Path of source file (relative to project root). The file's content will be
  // shown in the "Code" tab.
  final String sourceFilePath;
  // Actual content of the example.
  final Widget child;
  // Title shown in the route's appbar. By default just returns routeName.
  final String? _title;
  // A short description of the route. If not null, will be shown as subtitle in
  // the home page list tile.
  final String description;
  // Returns a set of links {title:link} that are relative to the route. Can put
  // documention links or reference video/article links here.
  final Map<String, String> links;
  // Route name of a page, if missing, use sourceFilePath.
  final String? _routeName;
  final Iterable<PlatformType> supportedPlatforms;

  const MyRoute({
    super.key,
    required this.sourceFilePath,
    required this.child,
    String? title,
    this.description = '',
    this.links = const <String, String>{},
    String? routeName,
    this.supportedPlatforms = PlatformType.values,
  })  : _title = title,
        _routeName = routeName;

  String get routeName =>
      this._routeName ?? '/${basenameWithoutExtension(sourceFilePath)}';
  // ! Previously we use runtimeType, but it's not stable.
  // this._routeName ?? '/${this.child.runtimeType.toString()}';

  String get title => _title ?? this.routeName;

  @override
  Widget build(BuildContext context) {
    final appbarLeading = (kPlatformType == PlatformType.Android ||
            this.routeName == Navigator.defaultRouteName)
        ? null
        : IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          );
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(this.title),
        ),
        actions: _getAppbarActions(context),
        automaticallyImplyLeading: false,
        leading: appbarLeading,
      ),
      headerHeight: _kFrontLayerMinHeight,
      frontLayerBorderRadius: BorderRadius.zero,
      frontLayer: Builder(
        builder: (BuildContext context) =>
            routeName == Navigator.defaultRouteName
                ? this.child
                : WidgetWithCodeView(
                    filePath: this.sourceFilePath,
                    codeLinkPrefix: '$GITHUB_URL/blob/master',
                    tabChangeListener: (TabController tabc) {
                      if (!tabc.indexIsChanging) return;
                      if (tabc.index == 1) {
                        debugPrint('Changing to code view!');
                      }
                    },
                    headerWidget: const MyBannerAd(),
                    footerWidget: const MyBannerAd(),
                    child: this.child,
                  ),
      ),
      backLayer: _getBackdropListTiles(),
    );
  }

  List<Widget> _getAppbarActions(BuildContext context) {
    final settings = Provider.of<MyAppSettings>(context);
    return <Widget>[
      const BackdropToggleButton(),
      if (this.routeName == Navigator.defaultRouteName)
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            kAnalytics?.logEvent(name: 'evt_Search');
            await showSearch<String>(
              context: context,
              delegate: MyRouteSearchDelegate(),
            );
          },
        ),
      if (this.routeName != Navigator.defaultRouteName)
        settings.starStatusOfRoute(this.routeName),
      if (this.links.isNotEmpty)
        PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuItem>[
              for (MapEntry<String, String> titleAndLink in this.links.entries)
                PopupMenuItem(
                  child: ListTile(
                    title: Text(titleAndLink.key),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_new),
                      tooltip: titleAndLink.value,
                      onPressed: () =>
                          url_launcher.launchUrl(Uri.parse(titleAndLink.value)),
                    ),
                    onTap: () =>
                        url_launcher.launchUrl(Uri.parse(titleAndLink.value)),
                  ),
                )
            ];
          },
        ),
    ];
  }

  ListView _getBackdropListTiles() {
    return ListView(
      padding: const EdgeInsets.only(bottom: _kFrontLayerMinHeight),
      children: <Widget>[
        ListTile(
          leading: kAppIcon,
          title: const Text(APP_NAME),
          subtitle: Text(kPackageInfo.version),
        ),
        ...MyAboutRoute.kAboutListTiles,
        Consumer<MyAppSettings>(
          builder: (context, MyAppSettings settings, _) {
            return ListTile(
              onTap: () {},
              leading: DayNightSwitcherIcon(
                isDarkModeEnabled: settings.isDarkMode,
                onStateChanged: (_) {},
              ),
              title: Text('Dark mode: ${settings.isDarkMode ? 'on' : 'off'}'),
              trailing: DayNightSwitcher(
                isDarkModeEnabled: settings.isDarkMode,
                onStateChanged: (bool value) => settings.setDarkMode(value),
              ),
            );
          },
        ),
      ],
    );
  }
}
