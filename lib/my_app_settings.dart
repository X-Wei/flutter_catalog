import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './my_route.dart';
import './my_app_routes.dart' show kAllRoutes;

class MyAppSettings extends ChangeNotifier {
  static const _kDarkModePreferenceKey = 'DARK_MODE';
  static const _kSearchHistoryPreferenceKey = 'SEARCH_HISTORY';
  static const _kBookmarkedRoutesPreferenceKey = 'BOOKMARKED_ROUTES';
  static final _kRoutenameToRouteMap = {
    for (MyRoute route in kAllRoutes) route.routeName: route
  };

  final SharedPreferences _pref;

  MyAppSettings(this._pref);

  bool get isDarkMode => _pref?.getBool(_kDarkModePreferenceKey) ?? false;

  void setDarkMode(bool val) {
    _pref?.setBool(_kDarkModePreferenceKey, val);
    notifyListeners();
  }

  /// The list of route names in search history.
  List<String> get searchHistory =>
      _pref?.getStringList(_kSearchHistoryPreferenceKey) ?? [];

  void addSearchHistory(String routeName) {
    List<String> history = this.searchHistory;
    history.remove(routeName);
    history.insert(0, routeName);
    if (history.length >= 10) {
      history = history.take(10).toList();
    }
    _pref?.setStringList(_kSearchHistoryPreferenceKey, history);
  }

  List<String> get starredRoutenames =>
      _pref?.getStringList(_kBookmarkedRoutesPreferenceKey) ?? [];

  List<MyRoute> get starredRoutes => [
        for (String routename in this.starredRoutenames)
          if (_kRoutenameToRouteMap[routename] != null)
            _kRoutenameToRouteMap[routename]
      ];

  // Returns a widget showing the star status of one demo route.
  Widget starStatusOfRoute(String routeName) {
    return IconButton(
      tooltip: 'Bookmark',
      icon: Icon(
        this.isStarred(routeName) ? Icons.star : Icons.star_border,
        color: this.isStarred(routeName) ? Colors.yellow : Colors.grey,
      ),
      onPressed: () => this.toggleStarred(routeName),
    );
  }

  bool isStarred(String routeName) =>
      starredRoutenames.contains(routeName) ?? false;

  void toggleStarred(String routeName) {
    final staredRoutes = this.starredRoutenames;
    if (isStarred(routeName)) {
      staredRoutes.remove(routeName);
    } else {
      staredRoutes.add(routeName);
    }
    final dedupedStaredRoutes = Set<String>.from(staredRoutes).toList();
    _pref?.setStringList(_kBookmarkedRoutesPreferenceKey, dedupedStaredRoutes);
    notifyListeners();
  }
}
