import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('DateInput', () {
    testWidgets('renders with initial value', (tester) async {
      final date = DateTime(2023, 1, 1);
      await tester.pumpWidget(
        SimpleApp(
          child: DateInput(
            initialValue: date,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(DateInput), findsOneWidget);

      // DateInput renders text fields for parts.
      // With unpadded implementation: 2023, 1, 1 -> 1 1 2023
      expect(find.text('1'), findsAtLeastNWidgets(2)); // Month and Day
      expect(find.text('2023'), findsOneWidget);
    });

    testWidgets('updates value on input', (tester) async {
      DateTime? currentDate;
      await tester.pumpWidget(
        SimpleApp(
          child: DateInput(
            initialValue: null,
            onChanged: (value) {
              currentDate = value;
            },
          ),
        ),
      );

      expect(find.byType(DateInput), findsOneWidget);

      // Enter year
      await tester.enterText(find.byType(TextField).last, '2023');
      await tester.pump();

      // Enter month
      await tester.enterText(find.byType(TextField).first, '1');
      await tester.pump();

      // Enter day
      await tester.enterText(find.byType(TextField).at(1), '1');
      await tester.pump();

      expect(currentDate, isNotNull);
      expect(currentDate?.year, equals(2023));
      expect(currentDate?.month, equals(1));
      expect(currentDate?.day, equals(1));
    });
  });
}
