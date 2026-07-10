import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('CircularProgressIndicator', () {
    testWidgets('renders indeterminate state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CircularProgressIndicator(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Indeterminate progress usually has no specific value to check,
      // but we can verify it doesn't crash and renders.
    });

    testWidgets('renders determinate state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CircularProgressIndicator(value: 0.5),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('applies custom size and color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CircularProgressIndicator(
            value: 0.5,
            size: 40,
            color: Colors.red,
            backgroundColor: Colors.blue,
            strokeWidth: 4,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Visual verification would require golden tests or inspecting render object properties
    });

    testWidgets('animates value change', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CircularProgressIndicator(
            value: 0.5,
            animated: true,
          ),
        ),
      );

      await tester.pumpWidget(
        SimpleApp(
          child: CircularProgressIndicator(
            value: 0.8,
            animated: true,
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100)); // Start animation
      await tester.pumpAndSettle(); // Finish animation

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
