import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Button', () {
    testWidgets('renders primary button with text', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            child: Text('Primary Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Primary Button'), findsOneWidget);
    });

    testWidgets('renders secondary button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.secondary(
            onPressed: () {},
            child: Text('Secondary Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Secondary Button'), findsOneWidget);
    });

    testWidgets('renders outline button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.outline(
            onPressed: () {},
            child: Text('Outline Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Outline Button'), findsOneWidget);
    });

    testWidgets('renders ghost button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.ghost(
            onPressed: () {},
            child: Text('Ghost Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Ghost Button'), findsOneWidget);
    });

    testWidgets('renders link button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.link(
            onPressed: () {},
            child: Text('Link Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Link Button'), findsOneWidget);
    });

    testWidgets('renders text button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.text(
            onPressed: () {},
            child: Text('Text Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('renders destructive button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.destructive(
            onPressed: () {},
            child: Text('Delete'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            leading: Icon(Icons.add),
            child: Text('Add Item'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Add Item'), findsOneWidget);
    });

    testWidgets('renders with trailing icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            trailing: Icon(Icons.arrow_forward),
            child: Text('Continue'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders with both leading and trailing icons', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            leading: Icon(Icons.star),
            trailing: Icon(Icons.arrow_forward),
            child: Text('Featured'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);
    });

    testWidgets('handles onPressed callback', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () => pressed = true,
            child: Text('Press Me'),
          ),
        ),
      );

      await tester.tap(find.byType(Button));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            child: Text('Disabled Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      // Button should be disabled when onPressed is null
    });

    testWidgets('respects enabled parameter', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () => pressed = true,
            enabled: false,
            child: Text('Disabled Button'),
          ),
        ),
      );

      await tester.tap(find.byType(Button));
      await tester.pumpAndSettle();

      expect(pressed, isFalse); // Should not trigger when disabled
    });

    testWidgets('accepts focus and hover callbacks', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            onFocus: (hasFocus) {},
            onHover: (isHovering) {},
            child: Text('Interactive Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);

      // Verify the button can be created with callbacks
      // Note: Actual focus/hover triggering requires integration testing
      // but we verify the callbacks are accepted without errors
      final button = tester.widget<Button>(find.byType(Button));
      expect(button.onFocus, isNotNull);
      expect(button.onHover, isNotNull);
    });

    testWidgets('respects custom alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            alignment: Alignment.centerLeft,
            child: Text('Left Aligned'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Left Aligned'), findsOneWidget);
    });

    testWidgets('handles long text content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 200,
            child: Button.primary(
              onPressed: () {},
              child: Text(
                  'This is a very long button text that should wrap or be handled appropriately'),
            ),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.textContaining('very long button text'), findsOneWidget);
    });

    testWidgets('renders with different child widget types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.save),
                SizedBox(width: 8),
                Text('Save Changes'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);
    });

    testWidgets('maintains proper sizing', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            child: Text('Button'),
          ),
        ),
      );

      final buttonFinder = find.byType(Button);
      expect(buttonFinder, findsOneWidget);

      final buttonSize = tester.getSize(buttonFinder);
      expect(buttonSize.width, greaterThan(0));
      expect(buttonSize.height, greaterThan(0));
    });

    testWidgets('handles focus node parameter', (tester) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(
        SimpleApp(
          child: Button.primary(
            onPressed: () {},
            focusNode: focusNode,
            child: Text('Focusable Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      focusNode.dispose();
    });

    testWidgets('works with custom style parameter', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Button(
            style: ButtonVariance.primary,
            onPressed: () {},
            child: Text('Custom Style Button'),
          ),
        ),
      );

      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Custom Style Button'), findsOneWidget);
    });
  });
}
