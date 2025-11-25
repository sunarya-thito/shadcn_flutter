import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../test_helper.dart';

void main() {
  group('CardButton', () {
    testWidgets('renders with basic content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () {},
            child: const Text('Test Button'),
          ),
        ),
      );

      expect(find.byType(CardButton), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('renders with leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () {},
            leading: const Icon(RadixIcons.star),
            trailing: const Icon(RadixIcons.arrowRight),
            child: const Text('Test Button'),
          ),
        ),
      );

      expect(find.byType(CardButton), findsOneWidget);
      expect(find.byIcon(RadixIcons.star), findsOneWidget);
      expect(find.byIcon(RadixIcons.arrowRight), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('handles onPressed callback', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () => pressed = true,
            child: const Text('Test Button'),
          ),
        ),
      );

      await tester.tap(find.byType(CardButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            child: const Text('Test Button'),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.onPressed, isNull);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () {},
            enabled: false,
            child: const Text('Test Button'),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.enabled, isFalse);
    });

    testWidgets('applies different sizes correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Row(
            children: [
              CardButton(
                onPressed: () {},
                size: ButtonSize.small,
                child: const Text('Small'),
              ),
              CardButton(
                onPressed: () {},
                size: ButtonSize.large,
                child: const Text('Large'),
              ),
            ],
          ),
        ),
      );

      final buttons = tester.widgetList<Button>(find.byType(Button));
      expect(buttons.length, equals(2));

      // Both should use ButtonStyle with card variance
      for (final button in buttons) {
        expect(button.style, isA<ButtonStyle>());
        final buttonStyle = button.style as ButtonStyle;
        expect(buttonStyle.variance, equals(ButtonVariance.card));
      }
    });

    testWidgets('applies different densities correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Row(
            children: [
              CardButton(
                onPressed: () {},
                density: ButtonDensity.compact,
                child: const Text('Compact'),
              ),
              CardButton(
                onPressed: () {},
                density: ButtonDensity.comfortable,
                child: const Text('Comfortable'),
              ),
            ],
          ),
        ),
      );

      final buttons = tester.widgetList<Button>(find.byType(Button));
      expect(buttons.length, equals(2));

      // Both should use ButtonStyle with card variance
      for (final button in buttons) {
        expect(button.style, isA<ButtonStyle>());
        final buttonStyle = button.style as ButtonStyle;
        expect(buttonStyle.variance, equals(ButtonVariance.card));
      }
    });

    testWidgets('applies different shapes correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Row(
            children: [
              CardButton(
                onPressed: () {},
                shape: ButtonShape.rectangle,
                child: const Text('Rectangle'),
              ),
              CardButton(
                onPressed: () {},
                shape: ButtonShape.circle,
                child: const Text('Circle'),
              ),
            ],
          ),
        ),
      );

      final buttons = tester.widgetList<Button>(find.byType(Button));
      expect(buttons.length, equals(2));

      // Both should use ButtonStyle with card variance
      for (final button in buttons) {
        expect(button.style, isA<ButtonStyle>());
        final buttonStyle = button.style as ButtonStyle;
        expect(buttonStyle.variance, equals(ButtonVariance.card));
      }
    });

    testWidgets('handles alignment correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () {},
            alignment: Alignment.centerLeft,
            child: const Text('Aligned Left'),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.alignment, equals(Alignment.centerLeft));
    });

    testWidgets('handles focus node', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () {},
            focusNode: focusNode,
            child: const Text('Focusable'),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.focusNode, equals(focusNode));
      focusNode.dispose();
    });

    testWidgets('handles disableTransition flag', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () {},
            disableTransition: true,
            child: const Text('No Transition'),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.disableTransition, isTrue);
    });

    testWidgets('handles enableFeedback flag', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardButton(
            onPressed: () {},
            enableFeedback: false,
            child: const Text('No Feedback'),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.enableFeedback, isFalse);
    });
  });
}
