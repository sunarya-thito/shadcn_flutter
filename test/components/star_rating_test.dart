import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('StarRating', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: StarRating(
            value: 3.5,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(StarRating), findsOneWidget);
    });

    testWidgets('updates value on tap', (tester) async {
      double currentValue = 0.0;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return StarRating(
                value: currentValue,
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
              );
            },
          ),
        ),
      );

      // Tap on the star rating.
      // Since we don't know exact coordinates, we tap center which should be around 2.5 or 3 stars
      await tester.tap(find.byType(StarRating));
      await tester.pump();

      expect(currentValue, greaterThan(0.0));
    });

    testWidgets('respects enabled state', (tester) async {
      double currentValue = 0.0;
      await tester.pumpWidget(
        SimpleApp(
          child: StarRating(
            value: 0.0,
            onChanged: (value) {
              currentValue = value;
            },
            enabled: false,
          ),
        ),
      );

      await tester.tap(find.byType(StarRating));
      await tester.pump();

      expect(currentValue, equals(0.0));
    });
  });

  group('ControlledStarRating', () {
    testWidgets('works with controller', (tester) async {
      final controller = StarRatingController(0.0);
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledStarRating(
            controller: controller,
          ),
        ),
      );

      expect(find.byType(StarRating), findsOneWidget);

      controller.value = 4.0;
      await tester.pump();

      // Verify visual state implicitly
      expect(find.byType(StarRating), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledStarRating(
            initialValue: 3.0,
          ),
        ),
      );

      expect(find.byType(StarRating), findsOneWidget);
    });
  });
}
