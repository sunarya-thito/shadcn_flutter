import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('AccordionItem', () {
    testWidgets('renders with trigger and content', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Trigger'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('starts collapsed by default', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      final transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0); // Initially collapsed
    });

    testWidgets('starts expanded when expanded is true', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
                expanded: true,
              ),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();

      final transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0)); // Should be expanded
    });

    testWidgets('expands when trigger is tapped', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      final transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0)); // Should be expanded
    });

    testWidgets('collapses when expanded trigger is tapped', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
                expanded: true,
              ),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      final transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0); // Should be collapsed
    });

    testWidgets('only one item can be expanded at a time', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger 1')),
                content: const Text('Content 1'),
              ),
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger 2')),
                content: const Text('Content 2'),
              ),
            ],
          ),
        ),
      );

      // Expand first item
      await tester.tap(find.text('Trigger 1'));
      await tester.pumpAndSettle();

      var transitionElements =
          find.byKey(const ValueKey('accordion_size_transition'));
      expect(transitionElements, findsNWidgets(2));
      var firstSize = tester.getSize(transitionElements.first);
      var secondSize = tester.getSize(transitionElements.last);
      expect(firstSize.height, greaterThan(0)); // First expanded
      expect(secondSize.height, 0); // Second collapsed

      // Expand second item
      await tester.tap(find.text('Trigger 2'));
      await tester.pumpAndSettle();

      firstSize = tester.getSize(transitionElements.first);
      secondSize = tester.getSize(transitionElements.last);
      expect(firstSize.height, 0); // First collapsed
      expect(secondSize.height, greaterThan(0)); // Second expanded
    });

    testWidgets('respects expanded parameter', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
                expanded: true,
              ),
            ],
          ),
        ),
      );

      final item = tester.widget<AccordionItem>(find.byType(AccordionItem));
      expect(item.expanded, true);
    });

    testWidgets('handles custom trigger widget', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Custom Trigger'),
                ),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Custom Trigger'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('handles complex content', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: Column(
                  children: const [
                    Text('Line 1'),
                    Text('Line 2'),
                    Text('Line 3'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.text('Line 3'), findsOneWidget);
    });

    testWidgets('maintains state when rebuilt', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      // Expand the item
      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      var transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0));

      // Rebuild with same widget
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0)); // Should remain expanded
    });

    testWidgets('handles empty content gracefully', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const SizedBox(),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      expect(find.byType(AccordionItem), findsOneWidget);
    });

    testWidgets('animation completes properly', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger')),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Trigger'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 150)); // Mid animation

      final transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0)); // Partially expanded

      await tester.pumpAndSettle(); // Complete animation

      final finalSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(finalSize.height,
          greaterThan(transitionSize.height)); // Fully expanded
    });
  });
}
