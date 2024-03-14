import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/view/single_choice_segment.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('integration_test', () {
    testWidgets('tap on the floating action button',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp()); // Create main app

      expect(find.byIcon(Icons.add), findsOneWidget);
      // Finds the floating action button to tap on.
      final fab = find.byIcon(Icons.add);

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 4));

      final Finder finderCloseButton = find.byIcon(Icons.close);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
      expect(find.text('Importance'), findsOneWidget);
      // 使用 find.byWidgetPredicate 找到帶有特定 hintText 的 TextField
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.decoration != null &&
              widget.decoration?.hintText == 'Content'),
          findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) => widget is SingleChildScrollView),
          findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
      await tester.tap(finderCloseButton); //點擊按鈕

      await tester.pump(const Duration(seconds: 4));
      final fab2 = find.byIcon(Icons.add);
      await tester.tap(fab2);

      // Trigger a frame.
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 4));

      // final Finder finderSaveButton = find.byIcon(Icons.save);
      final Finder textField = find.byWidgetPredicate((widget) =>
          widget is TextField &&
          widget.decoration != null &&
          widget.decoration?.hintText == 'Content');
      // 模擬用戶輸入
      await tester.enterText(textField, 'Hello, World!');
      await tester.pump(const Duration(seconds: 4));

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump(const Duration(seconds: 3));
      final Finder finderSaveButton = find.byIcon(Icons.save);
      await tester.tap(finderSaveButton);
      await tester.pump(const Duration(seconds: 3));

      // Find the ListView by its type
      final listViewFinder = find.byType(ListView);
      // Get the number of children of the ListView
      final listView = tester.widget<ListView>(listViewFinder);
      final itemCount = listView.childrenDelegate.estimatedChildCount;
      // Verify that the ListView has at least one item
      expect(itemCount, greaterThan(0));
      await tester.pump(const Duration(seconds: 3));
    });
  });
}
