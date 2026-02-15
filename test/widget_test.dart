// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/constants.dart';
import 'package:flutter_catalog/home_page.dart';
import 'package:flutter_catalog/my_app_routes.dart';
import 'package:flutter_catalog/my_app_settings.dart';
import 'package:flutter_catalog/my_route_group.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Initialize PackageInfo once for all tests
    kPackageInfo = PackageInfo(
      appName: 'Flutter Catalog',
      packageName: 'io.github.x_wei.flutter_catalog',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    // Mock path_provider
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async {
            if (methodCall.method == 'getApplicationDocumentsDirectory') {
              return '.';
            }
            return null;
          },
        );
    // SharedPreference
    SharedPreferences.setMockInitialValues({'INTRO_IS_SHOWN': true});
  });

  group('HomePage Tests', () {
    late MyAppSettings settings;
    setUp(() async {
      settings = await MyAppSettings.create();
      settings.isTestMode = true; // Enable test mode to avoid Firebase calls
    });
    testWidgets('HomePage has 4 bottom tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [mySettingsProvider.overrideWith((ref) => settings)],
          child: const MaterialApp(home: MyHomePage()),
        ),
      );
      // Verify 4 items in BottomNavigationBar
      final bottomNavBarFinder = find.byType(BottomNavigationBar);
      expect(bottomNavBarFinder, findsOneWidget);
      final BottomNavigationBar bar = tester.widget(bottomNavBarFinder);
      expect(bar.items.length, 4);
      // Verify the tabs exist.
      expect(find.text('Basics'), findsWidgets);
      expect(find.text('Advanced'), findsWidgets);
      expect(find.text('In Action'), findsWidgets);
      expect(find.text('Bookmarks'), findsWidgets);
    });

    //
    Future<void> _testHomeTab(
      WidgetTester tester,
      String tabName,
      List<MyRouteGroup> routeGroupsInTab,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [mySettingsProvider.overrideWith((ref) => settings)],
          child: const MaterialApp(home: MyHomePage()),
        ),
      );
      // Tap on the tab name.
      await tester.tap(find.text(tabName));
      await tester.pumpAndSettle();
      // expect(settings.currentTabIdx, 0);

      // Check expansion tiles for route groups on this tab
      for (final group in routeGroupsInTab) {
        await tester.scrollUntilVisible(find.text(group.groupName), 500);

        // Find expansion tile with the group name
        final expansionTileFinder = find.text(group.groupName);
        expect(
          expansionTileFinder,
          findsOneWidget,
          reason: 'Should find expansion tile for ${group.groupName}',
        );

        // Tap to expand the tile
        await tester.tap(expansionTileFinder);
        await tester.pumpAndSettle();

        // Check that all routes in this group are displayed as list items
        for (final route in group.routes) {
          await tester.scrollUntilVisible(find.text(route.title), 500);

          final routeTileFinder = find.text(route.title);
          expect(
            routeTileFinder,
            findsOneWidget,
            reason: 'Should find list item for route ${route.title}',
          );
        }

        // Scroll back to the group title and collapse it
        await tester.scrollUntilVisible(find.text(group.groupName), -500);
        await tester.tap(expansionTileFinder);
        await tester.pumpAndSettle();
      }
    }

    testWidgets('Basics Tab', (WidgetTester tester) async {
      _testHomeTab(tester, 'Basics', kMyAppRoutesBasic);
    });
    testWidgets('Advanced Tab', (WidgetTester tester) async {
      _testHomeTab(tester, 'Advanced', kMyAppRoutesAdvanced);
    });
    testWidgets('In Action Tab', (WidgetTester tester) async {
      _testHomeTab(tester, 'In Action', kMyAppRoutesInAction);
    });
  });
}
