import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show WidgetRef;

import 'constants.dart' show kAnalytics;
import 'my_app_settings.dart' show mySettingsProvider;
import 'my_route.dart' show MyRoute;

/* The app's home page tabs has a 2-level menu structure, its schema is like:
[ MyRouteGroup{
       groupName: group1_name,
       icon: group1_icon,
       routes: [route1, route2, ...]
  },
  MyRouteGroup{
       groupName: group2_name,
       icon: group2_icon,
       routes: [route1, route2, ...]
  },
  ...
]
*/
class MyRouteGroup {
  const MyRouteGroup({
    required this.groupName,
    required this.icon,
    required this.routes,
  });
  final String groupName;
  final Widget icon;
  final List<MyRoute> routes;

  /// The expansion tile shown in the app home page.
  Widget homepageExpansionTile(WidgetRef ref, BuildContext context) {
    final nNew = ref.watch(mySettingsProvider).numNewRoutes(this);

    return Card(
      key: ValueKey(this.groupName),
      child: ExpansionTile(
        leading: nNew > 0
            ? Badge(label: Text('$nNew'), child: this.icon)
            : this.icon,
        title: Text(
          this.groupName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        children: [
          for (final route in this.routes) route.homepageListTile(ref, context),
        ],
      ),
    );
  }
}

extension MyRouteExtension on MyRoute {
  /// The list tile (to navigate to the route) in app home page.
  Widget homepageListTile(
    WidgetRef ref,
    BuildContext context, {
    Widget? leading,
    IconData trialing = Icons.keyboard_arrow_right,
  }) {
    final mySettings = ref.watch(mySettingsProvider);
    final routeTitleTextStyle = Theme.of(
      context,
    ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold);
    final leadingWidget =
        leading ?? mySettings.starStatusOfRoute(this.routeName);
    final isNew = mySettings.isNewRoute(this);
    return ListTile(
      leading: isNew
          ? Badge(alignment: AlignmentDirectional.topEnd, child: leadingWidget)
          : leadingWidget,
      title: Text(this.title, style: routeTitleTextStyle),
      trailing: Icon(trialing),
      subtitle: this.description.isEmpty ? null : Text(this.description),
      onTap: () {
        if (isNew) {
          mySettings.markRouteKnown(this);
        }
        kAnalytics?.logEvent(
          name: 'evt_openRoute',
          parameters: {'routeName': this.routeName},
        );
        Navigator.of(context).pushNamed(this.routeName);
      },
    );
  }
}
