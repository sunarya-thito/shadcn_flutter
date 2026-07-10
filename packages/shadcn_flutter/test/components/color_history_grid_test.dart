import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('ColorHistoryGrid', () {
    testWidgets('renders with empty history', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: RecentColorsScope(
            child: Builder(builder: (context) {
              return ColorHistoryGrid(
                storage: ColorHistoryStorage.of(context),
              );
            }),
          ),
        ),
      );

      expect(find.byType(ColorHistoryGrid), findsOneWidget);
    });

    testWidgets('renders recent colors', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: RecentColorsScope(
            initialRecentColors: [Colors.red, Colors.blue],
            child: Builder(builder: (context) {
              return ColorHistoryGrid(
                storage: ColorHistoryStorage.of(context),
              );
            }),
          ),
        ),
      );

      // We expect to find buttons representing the colors
      // The grid tiles are Buttons containing Containers with the color
      expect(find.byType(Button), findsWidgets);
    });

    testWidgets('triggers onColorPicked', (tester) async {
      Color? pickedColor;
      await tester.pumpWidget(
        SimpleApp(
          child: RecentColorsScope(
            initialRecentColors: [Colors.red],
            child: Builder(builder: (context) {
              return ColorHistoryGrid(
                storage: ColorHistoryStorage.of(context),
                onColorPicked: (color) => pickedColor = color,
              );
            }),
          ),
        ),
      );

      // Find the button for the red color
      // Since it's the first one, we can try tapping the first button found
      await tester.tap(find.byType(Button).first);
      await tester.pump();

      expect(pickedColor, equals(Colors.red));
    });

    testWidgets('respects maxTotalColors', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: RecentColorsScope(
            initialRecentColors: [Colors.red, Colors.blue, Colors.green],
            child: Builder(builder: (context) {
              return ColorHistoryGrid(
                storage: ColorHistoryStorage.of(context),
                maxTotalColors: 2,
              );
            }),
          ),
        ),
      );

      // Should only show 2 color buttons (plus potentially empty slots if grid logic dictates,
      // but let's check if we can find at least 2 buttons that are NOT empty slots if implemented that way)
      // The implementation uses Expanded(SizedBox()) for empty slots.
      // The actual color tiles are Buttons.
      // So we should find exactly 2 Buttons if the grid only renders buttons for valid colors.
      // Looking at source: _buildGridTile returns a Button even for null color (empty slot).
      // Wait, source says:
      // if (color == null) { return AspectRatio(..., child: Button(... child: SizedBox.shrink())); }
      // So empty slots are also Buttons.

      // However, the loop condition is:
      // i < storage.capacity && (maxTotalColors == null || i < maxTotalColors!)
      // So it stops creating tiles after maxTotalColors.
      // So we should expect exactly 2 buttons if maxTotalColors is 2.

      expect(find.byType(Button), findsNWidgets(2));
    });
  });
}
