import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('ButtonGroup', () {
    testWidgets('renders horizontal button group', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            direction: Axis.horizontal,
            children: [
              Button.outline(child: Text('Button 1')),
              Button.outline(child: Text('Button 2')),
              Button.outline(child: Text('Button 3')),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(3));
      expect(find.text('Button 1'), findsOneWidget);
      expect(find.text('Button 2'), findsOneWidget);
      expect(find.text('Button 3'), findsOneWidget);
    });

    testWidgets('renders vertical button group', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            direction: Axis.vertical,
            children: [
              Button.outline(child: Text('Button 1')),
              Button.outline(child: Text('Button 2')),
              Button.outline(child: Text('Button 3')),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(3));
      expect(find.text('Button 1'), findsOneWidget);
      expect(find.text('Button 2'), findsOneWidget);
      expect(find.text('Button 3'), findsOneWidget);
    });

    testWidgets('renders horizontal convenience constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup.horizontal(
            children: [
              Button.outline(child: Text('Button 1')),
              Button.outline(child: Text('Button 2')),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
    });

    testWidgets('renders vertical convenience constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup.vertical(
            children: [
              Button.outline(child: Text('Button 1')),
              Button.outline(child: Text('Button 2')),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
    });

    testWidgets('renders with single child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            children: [
              Button.outline(child: Text('Single Button')),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Single Button'), findsOneWidget);
    });

    testWidgets('renders with empty children list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            children: [],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNothing);
    });

    testWidgets('handles different button types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            children: [
              Button.primary(child: Text('Primary')),
              Button.secondary(child: Text('Secondary')),
              Button.outline(child: Text('Outline')),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(3));
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Outline'), findsOneWidget);
    });

    testWidgets('respects expands parameter', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 300,
            height: 100,
            child: ButtonGroup(
              expands: true,
              children: [
                Button.outline(child: Text('Button 1')),
                Button.outline(child: Text('Button 2')),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
    });

    testWidgets('handles buttons with icons', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            children: [
              Button.outline(
                leading: Icon(Icons.add),
                child: Text('Add'),
              ),
              Button.outline(
                leading: Icon(Icons.edit),
                child: Text('Edit'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
    });

    testWidgets('maintains proper sizing in horizontal layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            direction: Axis.horizontal,
            children: [
              Button.outline(child: Text('Short')),
              Button.outline(child: Text('Much Longer Button Text')),
            ],
          ),
        ),
      );

      final groupFinder = find.byType(ButtonGroup);
      expect(groupFinder, findsOneWidget);

      final groupSize = tester.getSize(groupFinder);
      expect(groupSize.width, greaterThan(0));
      expect(groupSize.height, greaterThan(0));
    });

    testWidgets('maintains proper sizing in vertical layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            direction: Axis.vertical,
            children: [
              Button.outline(child: Text('Button 1')),
              Button.outline(child: Text('Button 2')),
            ],
          ),
        ),
      );

      final groupFinder = find.byType(ButtonGroup);
      expect(groupFinder, findsOneWidget);

      final groupSize = tester.getSize(groupFinder);
      expect(groupSize.width, greaterThan(0));
      expect(groupSize.height, greaterThan(0));
    });

    testWidgets('handles many buttons', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ButtonGroup(
              children: List.generate(
                5,
                (index) => Button.outline(child: Text('Button ${index + 1}')),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(5));
      for (int i = 1; i <= 5; i++) {
        expect(find.text('Button $i'), findsOneWidget);
      }
    });

    testWidgets('works with different child widget types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            children: [
              Button.outline(child: Text('Text Button')),
              Button.outline(
                child: Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 4),
                    Text('Icon Button'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
      expect(find.text('Text Button'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);
    });

    testWidgets('handles RTL layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ButtonGroup(
              children: [
                Button.outline(child: Text('Button 1')),
                Button.outline(child: Text('Button 2')),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ButtonGroup), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
    });

    testWidgets('positions buttons correctly in horizontal layout',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            direction: Axis.horizontal,
            children: [
              Button.outline(child: Text('Left')),
              Button.outline(child: Text('Right')),
            ],
          ),
        ),
      );

      final leftButton = find.text('Left');
      final rightButton = find.text('Right');

      final leftRect = tester.getRect(leftButton);
      final rightRect = tester.getRect(rightButton);

      // Right button should be positioned to the right of left button
      expect(leftRect.left, lessThan(rightRect.left));
    });

    testWidgets('positions buttons correctly in vertical layout',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ButtonGroup(
            direction: Axis.vertical,
            children: [
              Button.outline(child: Text('Top')),
              Button.outline(child: Text('Bottom')),
            ],
          ),
        ),
      );

      final topButton = find.text('Top');
      final bottomButton = find.text('Bottom');

      final topRect = tester.getRect(topButton);
      final bottomRect = tester.getRect(bottomButton);

      // Bottom button should be positioned below top button
      expect(topRect.top, lessThan(bottomRect.top));
    });
  });
}
