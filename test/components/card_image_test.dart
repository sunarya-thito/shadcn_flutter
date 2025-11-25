import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../test_helper.dart';

void main() {
  group('CardImage', () {
    testWidgets('renders with required image', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(CardImage), findsOneWidget);
      expect(find.byType(OutlinedContainer), findsOneWidget);
      expect(find.byType(AnimatedScale), findsOneWidget);
    });

    testWidgets('displays title and subtitle correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            title: const Text('Test Title'),
            subtitle: const Text('Test Subtitle'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
      expect(find.byType(Basic), findsOneWidget);
    });

    testWidgets('displays leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            leading: const Icon(RadixIcons.star),
            trailing: const Icon(RadixIcons.arrowRight),
            title: const Text('Test Title'),
          ),
        ),
      );

      expect(find.byIcon(RadixIcons.star), findsOneWidget);
      expect(find.byIcon(RadixIcons.arrowRight), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('handles onPressed callback', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(CardImage));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.onPressed, isNull);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            onPressed: () {},
            enabled: false,
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.enabled, isFalse);
    });

    testWidgets('applies custom button style', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            style: ButtonStyle.primary(),
          ),
        ),
      );

      final button = tester.widget<Button>(find.byType(Button));
      expect(button.style, isNotNull); // Custom style is applied
    });

    testWidgets('handles vertical direction layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            title: const Text('Title'),
            direction: Axis.vertical,
          ),
        ),
      );

      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.direction, equals(Axis.vertical));
    });

    testWidgets('handles horizontal direction layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            title: const Text('Title'),
            direction: Axis.horizontal,
          ),
        ),
      );

      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.direction, equals(Axis.horizontal));
    });

    testWidgets('applies normal scale', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            normalScale: 0.9,
          ),
        ),
      );

      final animatedScale =
          tester.widget<AnimatedScale>(find.byType(AnimatedScale));
      expect(animatedScale.scale, equals(0.9));
    });

    testWidgets('applies background color to OutlinedContainer',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            backgroundColor: Colors.red,
          ),
        ),
      );

      final outlinedContainer =
          tester.widget<OutlinedContainer>(find.byType(OutlinedContainer));
      expect(outlinedContainer.backgroundColor, equals(Colors.red));
    });

    testWidgets('applies border color to OutlinedContainer', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            borderColor: Colors.green,
          ),
        ),
      );

      final outlinedContainer =
          tester.widget<OutlinedContainer>(find.byType(OutlinedContainer));
      expect(outlinedContainer.borderColor, equals(Colors.green));
    });

    testWidgets('applies custom gap to layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            title: const Text('Title'),
            gap: 20.0,
          ),
        ),
      );

      final gap = tester.widget<Gap>(find.byType(Gap));
      expect(gap.mainAxisExtent, equals(20.0));
    });

    testWidgets('renders complex layout with all components', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 150, height: 150, color: Colors.purple),
            title: const Text('Beautiful Image'),
            subtitle: const Text('A stunning visual'),
            leading: const Icon(RadixIcons.star),
            trailing: const Icon(RadixIcons.arrowRight),
            direction: Axis.horizontal,
            backgroundColor: Colors.gray.shade200,
            borderColor: Colors.gray,
            hoverScale: 1.1,
            normalScale: 1.0,
            gap: 16.0,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Beautiful Image'), findsOneWidget);
      expect(find.text('A stunning visual'), findsOneWidget);
      expect(find.byIcon(RadixIcons.star), findsOneWidget);
      expect(find.byIcon(RadixIcons.arrowRight), findsOneWidget);

      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.direction, equals(Axis.horizontal));

      final gap = tester.widget<Gap>(find.byType(Gap));
      expect(gap.mainAxisExtent, equals(16.0));

      final outlinedContainer =
          tester.widget<OutlinedContainer>(find.byType(OutlinedContainer));
      expect(outlinedContainer.backgroundColor, equals(Colors.gray.shade200));
      expect(outlinedContainer.borderColor, equals(Colors.gray));

      final animatedScale =
          tester.widget<AnimatedScale>(find.byType(AnimatedScale));
      expect(animatedScale.scale, equals(1.0)); // normalScale value
    });

    testWidgets('handles empty optional widgets gracefully', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CardImage(
            image: Container(width: 100, height: 100, color: Colors.blue),
            // No title, subtitle, leading, or trailing
          ),
        ),
      );

      expect(find.byType(CardImage), findsOneWidget);
      expect(find.byType(Basic), findsOneWidget);
      // Should not crash and should still render the image
    });
  });
}
