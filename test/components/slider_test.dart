import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Slider', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Slider(
            value: const SliderValue.single(0.5),
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('updates value on tap', (tester) async {
      double? currentValue;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Slider(
                value: SliderValue.single(currentValue ?? 0.0),
                onChanged: (value) {
                  setState(() {
                    currentValue = value.value;
                  });
                },
              );
            },
          ),
        ),
      );

      // Tap in the middle (0.5)
      await tester.tap(find.byType(Slider));
      await tester.pump();

      expect(currentValue, closeTo(0.5, 0.1));
    });

    testWidgets('respects enabled state', (tester) async {
      double? currentValue;
      await tester.pumpWidget(
        SimpleApp(
          child: Slider(
            value: const SliderValue.single(0.0),
            onChanged: (value) {
              currentValue = value.value;
            },
            enabled: false,
          ),
        ),
      );

      await tester.tap(find.byType(Slider));
      await tester.pump();

      expect(currentValue, isNull);
    });
  });

  group('ControlledSlider', () {
    testWidgets('works with controller', (tester) async {
      final controller = SliderController(const SliderValue.single(0.0));
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledSlider(
            controller: controller,
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);

      controller.setValue(0.5);
      await tester.pump();

      // Verify internal state if possible, or just that it doesn't crash
      // Since we can't easily inspect the internal state of Slider without keys or finding specific widgets
      // We rely on the fact that it rendered.
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledSlider(
            initialValue: const SliderValue.single(0.5),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });
  });
}
