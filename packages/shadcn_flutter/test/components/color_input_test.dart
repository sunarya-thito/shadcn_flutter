import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('ColorInput', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorInput(
            value: ColorDerivative.fromColor(Colors.red),
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(ColorInput), findsOneWidget);
      // Default is small box without label
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('shows label when showLabel is true', (tester) async {
      // An explicit color, so the expected label does not depend on which
      // palette Colors.red happens to come from.
      await tester.pumpWidget(
        SimpleApp(
          child: ColorInput(
            value: ColorDerivative.fromColor(const Color(0xFFF44336)),
            onChanged: (value) {},
            showLabel: true,
          ),
        ),
      );

      expect(find.text('#fff44336'), findsOneWidget);
    });

    testWidgets('respects enabled state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorInput(
            value: ColorDerivative.fromColor(Colors.red),
            onChanged: (value) {},
            enabled: false,
          ),
        ),
      );

      final button = tester.widget<OutlineButton>(
        find.descendant(
          of: find.byType(ColorInput),
          matching: find.byType(OutlineButton),
        ),
      );
      expect(button.enabled, isFalse);
    });

    testWidgets('opens popover on tap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: ColorInput(
              value: ColorDerivative.fromColor(Colors.red),
              onChanged: (value) {},
              promptMode: PromptMode.popover,
              enabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OutlineButton));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(ColorPicker), findsOneWidget);
    });
  });

  group('ControlledColorInput', () {
    testWidgets('works with controller', (tester) async {
      final controller = ColorInputController(
        ColorDerivative.fromColor(Colors.red),
      );
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledColorInput(
            initialValue: ColorDerivative.fromColor(Colors.blue),
            controller: controller,
          ),
        ),
      );

      expect(find.byType(ColorInput), findsOneWidget);
      // Should use controller's value (red)
      final container = tester.widget<Container>(
        find.byKey(const Key('color_input_preview')),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color?.toARGB32(), equals(Colors.red.toARGB32()));

      // Update controller
      controller.setColor(Colors.green);
      await tester.pumpAndSettle();

      final container2 = tester.widget<Container>(
        find.byKey(const Key('color_input_preview')),
      );
      final decoration2 = container2.decoration as BoxDecoration;
      expect(decoration2.color?.toARGB32(), equals(Colors.green.toARGB32()));
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledColorInput(
            initialValue: ColorDerivative.fromColor(Colors.blue),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ColorInput), findsOneWidget);
      final container = tester.widget<Container>(
        find.byKey(const Key('color_input_preview')),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color?.toARGB32(), equals(Colors.blue.toARGB32()));
    });
  });
}
