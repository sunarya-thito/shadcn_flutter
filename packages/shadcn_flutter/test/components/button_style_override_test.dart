import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('ButtonStyleOverride', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('applies decoration override', (tester) async {
      const testDecoration = BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      );

      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            decoration: (context, state, value) => testDecoration,
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('applies mouse cursor override', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            mouseCursor: (context, state, value) =>
                SystemMouseCursors.forbidden,
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('applies padding override', (tester) async {
      const testPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            padding: (context, state, value) => testPadding,
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('applies text style override', (tester) async {
      const testTextStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      );

      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            textStyle: (context, state, value) => testTextStyle,
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('applies icon theme override', (tester) async {
      const testIconTheme = IconThemeData(
        color: Colors.green,
        size: 24,
      );

      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            iconTheme: (context, state, value) => testIconTheme,
            child: Button.outline(
              leading: Icon(Icons.add),
              child: Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('applies margin override', (tester) async {
      const testMargin = EdgeInsets.all(16);

      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            margin: (context, state, value) => testMargin,
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('replace mode ignores parent overrides', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            padding: (context, states, value) => const EdgeInsets.all(10),
            child: ButtonStyleOverride(
              textStyle: (context, states, value) =>
                  const TextStyle(fontSize: 18),
              child: Button.outline(child: Text('Test Button')),
            ),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsNWidgets(2));
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('works with different button types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            textStyle: (context, state, value) =>
                const TextStyle(color: Colors.white),
            child: Column(
              children: [
                Button.primary(child: Text('Primary')),
                Button.secondary(child: Text('Secondary')),
                Button.outline(child: Text('Outline')),
                Button.ghost(child: Text('Ghost')),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(4));
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Outline'), findsOneWidget);
      expect(find.text('Ghost'), findsOneWidget);
    });

    testWidgets('overrides work with button states', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            decoration: (context, states, value) {
              if (states.contains(WidgetState.hovered)) {
                return const BoxDecoration(color: Colors.yellow);
              }
              return const BoxDecoration(color: Colors.blue);
            },
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('handles null override delegates', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            // All delegates are null
            child: Button.outline(child: Text('Test Button')),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('works with complex button content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonStyleOverride(
            padding: (context, state, value) => const EdgeInsets.all(16),
            child: Button.outline(
              leading: Icon(Icons.star),
              trailing: Icon(Icons.arrow_forward),
              child: Column(
                children: [
                  Text('Title'),
                  Text('Subtitle'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ButtonStyleOverride), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('ButtonStyleOverrideData equality works', (tester) async {
      const data1 = ButtonStyleOverrideData(
        padding: null,
        decoration: null,
      );

      const data2 = ButtonStyleOverrideData(
        padding: null,
        decoration: null,
      );

      final data3 = ButtonStyleOverrideData(
        padding: (context, states, value) => const EdgeInsets.all(10),
        decoration: null,
      );

      expect(data1 == data2, isTrue);
      expect(data1 == data3, isFalse);
      expect(data1.hashCode == data2.hashCode, isTrue);
      expect(data1.hashCode == data3.hashCode, isFalse);
    });

    testWidgets('ButtonStyleOverrideData toString works', (tester) async {
      final data = ButtonStyleOverrideData(
        padding: (context, states, value) => const EdgeInsets.all(10),
        decoration: (context, states, value) =>
            const BoxDecoration(color: Colors.red),
      );

      final string = data.toString();
      expect(string, contains('ButtonStyleOverrideData'));
      expect(string, contains('padding'));
      expect(string, contains('decoration'));
    });
  });
}
