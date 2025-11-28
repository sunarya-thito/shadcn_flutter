import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Calendar', () {
    testWidgets('renders calendar with current month', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView.now(),
            selectionMode: CalendarSelectionMode.single,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
      expect(find.byType(CalendarGrid), findsOneWidget);
    });

    testWidgets('renders calendar with specific month and year',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3), // March 2024
            selectionMode: CalendarSelectionMode.single,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
      expect(find.byType(CalendarGrid), findsOneWidget);
    });

    testWidgets('renders calendar with single selection mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('renders calendar with multiple selection mode',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.multi,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('renders calendar with range selection mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.range,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('renders calendar with initial single value', (tester) async {
      final selectedDate = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            value: CalendarValue.single(selectedDate),
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('renders calendar with initial multiple values',
        (tester) async {
      final dates = [
        DateTime(2024, 3, 10),
        DateTime(2024, 3, 15),
        DateTime(2024, 3, 20),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.multi,
            value: CalendarValue.multi(dates),
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('renders calendar with initial range value', (tester) async {
      final startDate = DateTime(2024, 3, 10);
      final endDate = DateTime(2024, 3, 20);

      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.range,
            value: CalendarValue.range(startDate, endDate),
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('calls onChanged when date is selected in single mode',
        (tester) async {
      CalendarValue? changedValue;
      final testDate = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            onChanged: (value) => changedValue = value,
          ),
        ),
      );

      // Find and tap the calendar item for the 15th
      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(changedValue, isNotNull);
      expect(changedValue, isA<SingleCalendarValue>());
      final singleValue = changedValue as SingleCalendarValue;
      expect(singleValue.date, equals(testDate));
    });

    testWidgets(
        'calls onChanged with null when same date is selected in single mode',
        (tester) async {
      CalendarValue? changedValue;
      final testDate = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            value: CalendarValue.single(testDate),
            onChanged: (value) => changedValue = value,
          ),
        ),
      );

      // Tap the same date again to deselect
      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(changedValue, isNull);
    });

    testWidgets('calls onChanged when date is selected in multi mode',
        (tester) async {
      CalendarValue? currentValue;

      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) => Calendar(
              view: CalendarView(2024, 3),
              selectionMode: CalendarSelectionMode.multi,
              value: currentValue,
              onChanged: (value) => setState(() => currentValue = value),
            ),
          ),
        ),
      );

      // Select first date
      await tester.tap(find.text('10'));
      await tester.pumpAndSettle();

      expect(currentValue, isNotNull);
      expect(currentValue, isA<SingleCalendarValue>());
      expect((currentValue as SingleCalendarValue).date,
          equals(DateTime(2024, 3, 10)));

      // Select second date
      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(currentValue, isA<MultiCalendarValue>());
      final multiValue = currentValue as MultiCalendarValue;
      expect(multiValue.dates.length, equals(2));
      expect(multiValue.dates.contains(DateTime(2024, 3, 10)), isTrue);
      expect(multiValue.dates.contains(DateTime(2024, 3, 15)), isTrue);
    });

    testWidgets('handles isDateEnabled function', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            isDateEnabled: (date) => date.day != 15, // Disable 15th
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('handles stateBuilder function', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            stateBuilder: (date) {
              if (date.weekday == DateTime.sunday) {
                return DateState.disabled;
              }
              return DateState.enabled;
            },
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('handles custom now parameter', (tester) async {
      final customNow = DateTime(2024, 3, 10);

      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            now: customNow,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('updates view when widget changes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);

      // Update to different month
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 4), // April 2024
            selectionMode: CalendarSelectionMode.single,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('handles null value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            value: null,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('handles null onChanged', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Calendar(
            view: CalendarView(2024, 3),
            selectionMode: CalendarSelectionMode.single,
            onChanged: null,
          ),
        ),
      );

      expect(find.byType(Calendar), findsOneWidget);
    });

    testWidgets('CalendarValue.single creates correct value', (tester) async {
      final date = DateTime(2024, 3, 15);
      final value = CalendarValue.single(date);

      expect(value.toSingle().date, equals(date));
      expect(value.toMulti().dates, contains(date));
    });

    testWidgets('CalendarValue.multi creates correct value', (tester) async {
      final dates = [DateTime(2024, 3, 10), DateTime(2024, 3, 15)];
      final value = CalendarValue.multi(dates);

      expect(value.toMulti().dates, equals(dates));
    });

    testWidgets('CalendarValue.range creates correct value', (tester) async {
      final start = DateTime(2024, 3, 10);
      final end = DateTime(2024, 3, 20);
      final value = CalendarValue.range(start, end);

      expect(value.toRange().start, equals(start));
      expect(value.toRange().end, equals(end));
    });

    testWidgets('CalendarView.now creates current date view', (tester) async {
      final view = CalendarView.now();
      final now = DateTime.now();

      expect(view.year, equals(now.year));
      expect(view.month, equals(now.month));
    });

    testWidgets('CalendarView constructor creates specific view',
        (tester) async {
      final view = CalendarView(2024, 3);

      expect(view.year, equals(2024));
      expect(view.month, equals(3));
    });
  });
}
