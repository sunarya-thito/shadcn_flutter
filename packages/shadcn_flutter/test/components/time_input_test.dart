import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('TimeInput', () {
    testWidgets('renders with initial value', (tester) async {
      final time = TimeOfDay(hour: 10, minute: 30);
      await tester.pumpWidget(
        SimpleApp(
          child: TimeInput(
            initialValue: time,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(TimeInput), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
    });

    testWidgets('updates value on input', (tester) async {
      TimeOfDay? currentTime;
      await tester.pumpWidget(
        SimpleApp(
          child: TimeInput(
            initialValue: null,
            onChanged: (value) {
              currentTime = value;
            },
          ),
        ),
      );

      expect(find.byType(TimeInput), findsOneWidget);

      // Enter hour
      await tester.enterText(find.byType(TextField).first, '10');
      await tester.pump();

      // Enter minute
      await tester.enterText(find.byType(TextField).last, '30');
      await tester.pump();

      expect(currentTime, isNotNull);
      expect(currentTime?.hour, equals(10));
      expect(currentTime?.minute, equals(30));
    });
  });
}
