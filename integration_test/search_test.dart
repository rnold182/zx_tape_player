import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:zx_tape_player/main.dart' as app;

Future<void> _wait(WidgetTester tester, int seconds) async {
  for (var i = 0; i < seconds * 4; i++)
    await tester.pump(Duration(milliseconds: 250));
}

void _report(String step) {
  var texts = find
      .byType(Text)
      .evaluate()
      .map((e) => (e.widget as Text).data)
      .where((t) => t != null && t.isNotEmpty)
      .toList();
  print('[$step] TextFields: ${find.byType(TextField).evaluate().length}, '
      'texts: $texts');
}

void main() {
  var binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('typing a letter shows the search screen', (tester) async {
    app.main();
    await _wait(tester, 6); // splash screen waits 3 seconds
    _report('home');
    await binding.takeScreenshot('1_home');

    await tester.enterText(find.byType(TextField).first, 'm');
    await _wait(tester, 2);
    _report('after typing m');
    await binding.takeScreenshot('2_after_typing');

    await _wait(tester, 8);
    _report('after waiting');
    await binding.takeScreenshot('3_after_waiting');

    await tester.testTextInput.receiveAction(TextInputAction.search);
    await _wait(tester, 10);
    _report('after submit');
    await binding.takeScreenshot('4_after_submit');
  });
}
