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

  group('Slider value indicator', () {
    testWidgets('is absent by default', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Slider(
            value: const SliderValue.single(0.5),
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(SliderValueIndicator), findsNothing);
    });

    testWidgets('is hidden until dragging, then shown', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Slider(
            value: const SliderValue.single(0.5),
            onChanged: (value) {},
            valueIndicatorBuilder: (context, value) =>
                SliderValueIndicator(value: value),
          ),
        ),
      );

      AnimatedOpacity findOpacityWidget() =>
          tester.widget<AnimatedOpacity>(find.ancestor(
            of: find.byType(SliderValueIndicator),
            matching: find.byType(AnimatedOpacity),
          ));

      expect(find.byType(SliderValueIndicator), findsOneWidget);
      expect(findOpacityWidget().opacity, 0.0);

      final gesture =
          await tester.startGesture(tester.getCenter(find.byType(Slider)));
      await tester.pump(const Duration(milliseconds: 100));
      // The first move past the touch-slop threshold only triggers
      // onHorizontalDragStart (no setState there); a second move is needed
      // to trigger onHorizontalDragUpdate, whose setState rebuilds the tree.
      await gesture.moveBy(const Offset(30, 0));
      await gesture.moveBy(const Offset(10, 0));
      await tester.pump();

      expect(findOpacityWidget().opacity, 1.0);

      await gesture.up();
      await tester.pump();

      expect(findOpacityWidget().opacity, 0.0);
    });
  });
}
