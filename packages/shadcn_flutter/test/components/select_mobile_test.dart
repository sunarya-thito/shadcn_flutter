import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  testWidgets('select opens and selects with touch on iOS', (tester) async {
    String? selected;
    await tester.pumpWidget(
      ShadcnApp(
        theme: ThemeData(
          colorScheme: ColorSchemes.lightZinc,
          platform: TargetPlatform.iOS,
        ),
        home: Scaffold(
          child: Select<String>(
            value: selected,
            placeholder: const Text('Choose'),
            onChanged: (value) => selected = value,
            popup: const SelectPopup<String>(
              items: SelectItemList(
                children: [
                  SelectItemButton<String>(
                    value: 'apple',
                    child: Text('Apple'),
                  ),
                ],
              ),
            ),
            itemBuilder: (context, value) => Text(value),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Choose'));
    await tester.pumpAndSettle();
    expect(find.text('Apple'), findsOneWidget);

    await tester.tap(find.text('Apple'));
    await tester.pumpAndSettle();
    expect(selected, 'apple');
    expect(tester.takeException(), isNull);
  });
}
