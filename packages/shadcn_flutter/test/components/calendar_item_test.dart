import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('CalendarItem', () {
    testWidgets('renders none type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.none,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(GhostButton), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders today type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.today,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(SecondaryButton), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders selected type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.selected,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders inRange type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.inRange,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders startRange type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.startRange,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders endRange type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.endRange,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders startRangeSelected type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.startRangeSelected,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders endRangeSelected type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.endRangeSelected,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders startRangeSelectedShort type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.startRangeSelectedShort,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders endRangeSelectedShort type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.endRangeSelectedShort,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('renders inRangeSelectedShort type', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.inRangeSelectedShort,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('handles onTap callback', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.none,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            onTap: () => tapped = true,
            child: Text('15'),
          ),
        ),
      );

      await tester.tap(find.byType(GhostButton));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('respects disabled state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.none,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.disabled,
            child: Text('15'),
          ),
        ),
      );

      final button = find.byType(GhostButton);
      expect(button, findsOneWidget);

      // The button should be disabled
      final ghostButton = tester.widget<GhostButton>(button);
      expect(ghostButton.enabled, isFalse);
    });

    testWidgets('uses custom width and height', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.none,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            width: 50,
            height: 50,
            child: Text('15'),
          ),
        ),
      );

      final sizedBox = find.byType(SizedBox);
      expect(sizedBox, findsOneWidget);

      final sizedBoxWidget = tester.widget<SizedBox>(sizedBox);
      expect(sizedBoxWidget.width, equals(50));
      expect(sizedBoxWidget.height, equals(50));
    });

    testWidgets('uses default size when width/height not specified',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.none,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      final sizedBox = find.byType(SizedBox);
      expect(sizedBox, findsOneWidget);

      final sizedBoxWidget = tester.widget<SizedBox>(sizedBox);
      // Default size is theme.scaling * 32, but we can't easily test the exact value
      expect(sizedBoxWidget.width, isNotNull);
      expect(sizedBoxWidget.height, isNotNull);
    });

    testWidgets('handles edge positions for range types', (tester) async {
      // Test startRangeSelected at index 0 (should become selected)
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.startRangeSelected,
            indexAtRow: 0,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(PrimaryButton),
          findsOneWidget); // Should be selected, not stack
    });

    testWidgets('handles edge positions for endRangeSelected', (tester) async {
      // Test endRangeSelected at last position (should become selected)
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.endRangeSelected,
            indexAtRow: 6,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(PrimaryButton),
          findsOneWidget); // Should be selected, not stack
    });

    testWidgets('handles edge positions for short range types', (tester) async {
      // Test startRangeSelectedShort at index 0 (should become selected)
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.startRangeSelectedShort,
            indexAtRow: 0,
            rowCount: 7,
            state: DateState.enabled,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget); // Should be selected
    });

    testWidgets('renders different child widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.selected,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            child: Icon(Icons.star),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('handles null onTap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CalendarItem(
            type: CalendarItemType.none,
            indexAtRow: 1,
            rowCount: 7,
            state: DateState.enabled,
            onTap: null,
            child: Text('15'),
          ),
        ),
      );

      expect(find.byType(CalendarItem), findsOneWidget);
      expect(find.byType(GhostButton), findsOneWidget);
    });

    testWidgets('all CalendarItemType values work', (tester) async {
      final types = CalendarItemType.values;

      for (final type in types) {
        await tester.pumpWidget(
          SimpleApp(
            child: CalendarItem(
              type: type,
              indexAtRow: 1,
              rowCount: 7,
              state: DateState.enabled,
              child: Text('15'),
            ),
          ),
        );

        expect(find.byType(CalendarItem), findsOneWidget);
        expect(find.text('15'), findsOneWidget);

        await tester.pumpWidget(Container()); // Reset
      }
    });
  });
}
