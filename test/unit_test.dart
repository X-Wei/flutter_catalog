import 'dart:io';

import 'package:flutter_catalog/my_app_routes.dart';
import 'package:flutter_catalog/my_route.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('All routes have valid source file path', () {
    for (final MyRoute route in kAllRoutes) {
      final file = File(route.sourceFilePath);
      expect(
        file.existsSync(),
        isTrue,
        reason:
            'Source file for route "${route.routeName}" should exist at: ${route.sourceFilePath}',
      );
    }
  });
}
