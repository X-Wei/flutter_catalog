import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'my_app_routes.dart'
    show kAllRoutes, kRouteNameToRoute, kRouteNameToRouteGroup;
import 'my_app_settings.dart';
import 'my_route.dart';

/// Delegate class to search pages in the list of
class MyRouteSearchDelegate extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (this.query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () => this.query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () => this.close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Since we never call showResults() we don't need to impl this function.
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final settings = ref.watch(mySettingsProvider);

        // List<String> suggestions = _history;
        Iterable<MyRoute> suggestions = [
          for (final routeName in settings.searchHistory)
            if (kRouteNameToRoute.containsKey(routeName))
              kRouteNameToRoute[routeName]!,
        ];
        if (this.query.isNotEmpty) {
          suggestions = kAllRoutes
              .where(
                (route) =>
                    route.title.toLowerCase().contains(query.toLowerCase()) ||
                    route.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
        }
        return _buildSuggestionsList(suggestions, ref);
      },
    );
  }

  Widget _buildSuggestionsList(Iterable<MyRoute> suggestions, WidgetRef ref) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final route = suggestions.elementAt(i);
        final routeGroup = kRouteNameToRouteGroup[route.routeName]!;
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : routeGroup.icon,
          title: SubstringHighlight(
            text: '${routeGroup.groupName}/${route.title}',
            term: query,
            textStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: route.description.isEmpty
              ? null
              : SubstringHighlight(
                  text: route.description,
                  term: query,
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                ),
          onTap: () {
            ref.read(mySettingsProvider).addSearchHistory(route.routeName);
            Navigator.of(context).popAndPushNamed(route.routeName);
          },
          trailing: const Icon(Icons.keyboard_arrow_right),
        );
      },
    );
  }
}
