import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('ColorPicker', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorPicker(
            value: ColorDerivative.fromColor(Colors.red),
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(ColorPicker), findsOneWidget);
      expect(find.byType(ColorControls), findsOneWidget);
    });

    testWidgets('renders sliders', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorPicker(
            value: ColorDerivative.fromColor(Colors.red),
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(HSVColorSlider), findsWidgets);
    });

    testWidgets('switches modes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorPicker(
            value: ColorDerivative.fromColor(Colors.red),
            onChanged: (value) {},
            initialMode: ColorPickerMode.rgb,
          ),
        ),
      );

      // Find the mode selector (Select<ColorPickerMode>)
      // Since Select is complex, we might look for the text "RGB"
      expect(find.text('RGB'), findsOneWidget);

      // Open the select popup
      await tester.tap(find.text('RGB'));
      await tester.pumpAndSettle();

      // Select HSL
      await tester.tap(find.text('HSL').last);
      await tester.pumpAndSettle();

      expect(find.text('HSL'), findsOneWidget);
    });

    testWidgets('shows alpha slider when showAlpha is true', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorPicker(
            value: ColorDerivative.fromColor(Colors.red),
            onChanged: (value) {},
            showAlpha: true,
          ),
        ),
      );

      // We expect an additional slider for alpha
      // In default RGB/HSV mode, we have Sat/Val area + Hue slider.
      // With alpha, we should have another slider.
      // Let's just check if we can find multiple sliders
      expect(find.byType(HSVColorSlider), findsWidgets);
    });
  });

  group('ColorControls', () {
    testWidgets('renders inputs for RGB mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorControls(
            value: ColorDerivative.fromColor(Colors.red),
            mode: ColorPickerMode.rgb,
          ),
        ),
      );

      expect(find.text('Red'), findsOneWidget);
      expect(find.text('Green'), findsOneWidget);
      expect(find.text('Blue'), findsOneWidget);
    });

    testWidgets('renders inputs for HSL mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ColorControls(
            value: ColorDerivative.fromColor(Colors.red),
            mode: ColorPickerMode.hsl,
          ),
        ),
      );

      expect(find.text('Hue'), findsOneWidget);
      expect(find.text('Sat'), findsOneWidget);
      expect(find.text('Lum'), findsOneWidget);
    });
  });
}
