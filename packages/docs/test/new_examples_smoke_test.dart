import 'package:docs/pages/docs/components/select/select_example_5.dart';
import 'package:docs/pages/docs/components/select/select_example_6.dart';
import 'package:docs/pages/docs/components/table/table_example_4.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Mirrors how WidgetUsageExample presents an example: centred, so widgets
/// receive loose constraints and can size themselves.
Widget _host(Widget child) => ShadcnApp(
  home: Scaffold(child: Center(child: child)),
);

void main() {
  testWidgets('TableExample4 renders and flips direction', (tester) async {
    await tester.pumpWidget(_host(const TableExample4()));
    await tester.pumpAndSettle();
    expect(find.text('Invoice'), findsOneWidget);

    final ltr = tester.getTopLeft(find.text('INV001')).dx;
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    final rtl = tester.getTopLeft(find.text('INV001')).dx;
    expect(rtl, greaterThan(ltr), reason: 'first column should move right');
  });

  testWidgets('SelectExample5 renders both triggers', (tester) async {
    await tester.pumpWidget(_host(const SelectExample5()));
    await tester.pumpAndSettle();
    expect(find.text('Select a fruit'), findsNWidgets(2));
  });

  testWidgets('SelectExample6 creates from the search box without a dialog', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const SelectExample6()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Select a fruit'));
    await tester.pumpAndSettle();
    expect(find.text('Apple'), findsOneWidget);
    // Nothing to create until the user types something that does not exist.
    expect(find.textContaining('Create "'), findsNothing);

    await tester.enterText(find.byType(TextField), 'Durian');
    await tester.pumpAndSettle();
    expect(find.text('Apple'), findsNothing);
    expect(find.text('Create "Durian"'), findsOneWidget);

    await tester.tap(find.text('Create "Durian"'));
    await tester.pumpAndSettle();
    // The popup closed itself and the new fruit is now the selected value.
    expect(find.text('Create "Durian"'), findsNothing);
    expect(find.text('Select a fruit'), findsNothing);
    expect(find.text('Durian'), findsOneWidget);
  });

  testWidgets('SelectExample6 does not offer to create an existing fruit', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const SelectExample6()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Select a fruit'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Apple');
    await tester.pumpAndSettle();
    // Matched by an existing item, so only that item is offered.
    expect(find.byType(SelectItemButton<String>), findsOneWidget);
    expect(find.textContaining('Create "'), findsNothing);
  });

  testWidgets('example selects keep a fixed trigger width', (tester) async {
    await tester.pumpWidget(_host(const SelectExample6()));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(Select<String>)).width, 260);

    // Selecting a longer value must not resize the trigger.
    await tester.tap(find.text('Select a fruit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Banana'));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(Select<String>)).width, 260);

    await tester.pumpWidget(_host(const SelectExample5()));
    await tester.pumpAndSettle();
    for (final size in tester.widgetList<Select<String>>(
      find.byType(Select<String>),
    )) {
      expect(size.constraints?.maxWidth, 200);
    }
  });
}
