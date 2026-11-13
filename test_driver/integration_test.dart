// @dart=2.12
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() => integrationDriver(
      onScreenshot: (String name, List<int> bytes,
          [Map<String, Object?>? args]) async {
        var file = await File('screenshots/$name.png').create(recursive: true);
        await file.writeAsBytes(bytes);
        return true;
      },
    );
