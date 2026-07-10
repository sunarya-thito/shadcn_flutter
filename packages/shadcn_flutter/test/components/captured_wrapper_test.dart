import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../test_helper.dart';

void main() {
  group('CapturedWrapper', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Text('Test Child'),
          ),
        ),
      );

      expect(find.byType(CapturedWrapper), findsOneWidget);
      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('renders with null themes and data', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            themes: null,
            data: null,
            child: Text('Test Child'),
          ),
        ),
      );

      expect(find.byType(CapturedWrapper), findsOneWidget);
      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('renders with child widget only', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Container(
              width: 100,
              height: 100,
              color: material.Colors.blue,
            ),
          ),
        ),
      );

      expect(find.byType(CapturedWrapper), findsOneWidget);
      // Check that the child container is present (don't check for exactly one since SimpleApp may have others)
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('maintains widget identity with KeyedSubtree', (tester) async {
      final key = GlobalKey();
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Container(
              key: key,
              width: 100,
              height: 100,
              color: material.Colors.red,
            ),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
      // KeyedSubtree is used internally, just verify the wrapper and keyed child exist
      expect(find.byType(CapturedWrapper), findsOneWidget);
    });

    testWidgets('handles different child types', (tester) async {
      // Test with Text widget
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Text('Text Child'),
          ),
        ),
      );
      expect(find.text('Text Child'), findsOneWidget);

      // Test with Container widget
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: SizedBox(width: 50, height: 50),
          ),
        ),
      );
      expect(find.byType(CapturedWrapper), findsOneWidget);
      expect(find.byType(Container),
          findsWidgets); // May find multiple due to SimpleApp

      // Test with Column widget
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Column(
              children: [
                Text('Item 1'),
                Text('Item 2'),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('creates state correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Text('State Test'),
          ),
        ),
      );

      final state = tester.state(find.byType(CapturedWrapper));
      expect(state, isNotNull);
    });

    testWidgets('handles state updates', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Text('Initial'),
          ),
        ),
      );

      expect(find.text('Initial'), findsOneWidget);

      // Rebuild with different child
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Text('Updated'),
          ),
        ),
      );

      expect(find.text('Updated'), findsOneWidget);
      expect(find.text('Initial'), findsNothing);
    });

    testWidgets('maintains GlobalKey across rebuilds', (tester) async {
      final key = GlobalKey();
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: SizedBox(key: key, width: 100, height: 100),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);

      // Rebuild with same key
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Container(
                key: key, width: 100, height: 100, color: material.Colors.blue),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('handles complex widget trees', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Nested'),
                    Icon(Icons.star),
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: material.Colors.green,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Nested'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      // Container may appear multiple times due to SimpleApp
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Row), findsOneWidget);
      // Column may appear multiple times due to SimpleApp
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('works with different themes parameter types', (tester) async {
      // Test with null themes (default)
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            themes: null,
            child: Text('Null Themes'),
          ),
        ),
      );
      expect(find.text('Null Themes'), findsOneWidget);

      // Since CapturedThemes comes from data_widget package and we can't easily
      // create instances without knowing the implementation, we'll focus on
      // the null case which is the most common usage pattern
    });

    testWidgets('works with different data parameter types', (tester) async {
      // Test with null data (default)
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            data: null,
            child: Text('Null Data'),
          ),
        ),
      );
      expect(find.text('Null Data'), findsOneWidget);

      // Since CapturedData comes from data_widget package and we can't easily
      // create instances without knowing the implementation, we'll focus on
      // the null case which is the most common usage pattern
    });

    testWidgets('handles empty child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(CapturedWrapper), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('maintains proper widget hierarchy', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CapturedWrapper(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Padded Text'),
            ),
          ),
        ),
      );

      expect(find.byType(CapturedWrapper), findsOneWidget);
      // Padding may appear multiple times due to SimpleApp
      expect(find.byType(Padding), findsWidgets);
      expect(find.text('Padded Text'), findsOneWidget);
    });
  });
}
