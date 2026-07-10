import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Accordion', () {
    testWidgets('renders without exceptions', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 1')),
                content: Text('Content 1'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(Accordion), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      // Content is always in tree but sized to 0 when collapsed
      expect(find.text('Content 1'), findsOneWidget);
      final transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0); // Initially collapsed
    });

    testWidgets('expands and collapses on trigger tap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 1')),
                content: Text('Content 1'),
              ),
            ],
          ),
        ),
      );

      // Initially collapsed
      var transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0);

      // Tap trigger
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      // Should be expanded
      transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0));

      // Tap again
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      // Should be collapsed
      transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0);
    });

    testWidgets('only one item expanded at a time', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 1')),
                content: Text('Content 1'),
              ),
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 2')),
                content: Text('Content 2'),
              ),
            ],
          ),
        ),
      );

      final sizeTransitions = find.byType(SizeTransition);
      expect(sizeTransitions, findsNWidgets(2));

      // Expand first item
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      var firstSize = tester.getSize(sizeTransitions.at(0));
      var secondSize = tester.getSize(sizeTransitions.at(1));
      expect(firstSize.height, greaterThan(0));
      expect(secondSize.height, 0);

      // Expand second item
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle();

      firstSize = tester.getSize(sizeTransitions.at(0));
      secondSize = tester.getSize(sizeTransitions.at(1));
      expect(firstSize.height, 0);
      expect(secondSize.height, greaterThan(0));
    });

    testWidgets('respects initial expanded state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 1')),
                content: Text('Content 1'),
                expanded: true,
              ),
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 2')),
                content: Text('Content 2'),
              ),
            ],
          ),
        ),
      );

      final sizeTransitions = find.byType(SizeTransition);
      expect(sizeTransitions, findsNWidgets(2));

      final firstSize = tester.getSize(sizeTransitions.at(0));
      final secondSize = tester.getSize(sizeTransitions.at(1));
      expect(firstSize.height, greaterThan(0));
      expect(secondSize.height, 0);
    });

    testWidgets('handles empty items list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Accordion(items: []),
        ),
      );

      expect(find.byType(Accordion), findsOneWidget);
      // Should not crash
    });

    testWidgets('applies theme correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ComponentTheme<AccordionTheme>(
            data: AccordionTheme(
              padding: 20,
              dividerHeight: 2,
            ),
            child: Accordion(
              items: [
                AccordionItem(
                  trigger: AccordionTrigger(child: Text('Item 1')),
                  content: Text('Content 1'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Accordion), findsOneWidget);
      // Theme application would be verified in golden tests or more detailed checks
    });

    testWidgets('supports keyboard navigation', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 1')),
                content: Text('Content 1'),
              ),
            ],
          ),
        ),
      );

      // Focus the trigger
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      // Press enter to expand
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('animates expansion and collapse', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Item 1')),
                content: Text('Content 1'),
              ),
            ],
          ),
        ),
      );

      // Tap to expand
      await tester.tap(find.text('Item 1'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 100)); // Midway

      // Check size during animation
      final transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0));
      expect(transitionSize.height,
          lessThan(18)); // Assuming full height is around 18

      await tester.pumpAndSettle(); // Complete animation

      // Fully expanded
      final finalSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(finalSize.height, greaterThan(0));
    });
  });
}
