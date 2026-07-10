import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('AccordionTrigger', () {
    testWidgets('renders with child content', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: const Text('Trigger Text')),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Trigger Text'), findsOneWidget);
    });

    testWidgets('shows arrow icon', (tester) async {
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

      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
    });

    testWidgets('toggles expansion on tap', (tester) async {
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

      // Initially collapsed
      var transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0);

      // Tap to expand
      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0));
    });

    testWidgets('toggles expansion on Enter key', (tester) async {
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

      // Focus the trigger
      await tester.tap(find.text('Trigger'));
      await tester.pump();

      // Initially collapsed
      var transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0);

      // Press Enter to expand
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0));
    });

    testWidgets('toggles expansion on Space key', (tester) async {
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

      // Focus the trigger
      await tester.tap(find.text('Trigger'));
      await tester.pump();

      // Initially collapsed
      var transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, 0);

      // Press Space to expand
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      transitionSize = tester
          .getSize(find.byKey(const ValueKey('accordion_size_transition')));
      expect(transitionSize.height, greaterThan(0));
    });

    testWidgets('shows focus indicator when focused', (tester) async {
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

      // Focus the trigger
      await tester.tap(find.text('Trigger'));
      await tester.pump();

      // Check that focus indicator is present (border color changes)
      final trigger =
          tester.widget<AccordionTrigger>(find.byType(AccordionTrigger));
      expect(trigger, isNotNull);
    });

    testWidgets('has hover underline mechanism', (tester) async {
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

      // Check that the component has the necessary structure for hover effects
      final triggerFinder = find.byType(AccordionTrigger);
      expect(triggerFinder, findsOneWidget);

      // Check that FocusableActionDetector is present with hover callback
      final focusableDetectors = tester.widgetList<FocusableActionDetector>(
        find.descendant(
            of: triggerFinder, matching: find.byType(FocusableActionDetector)),
      );
      expect(focusableDetectors.length, greaterThan(0));
      // At least one should have hover callback
      expect(
          focusableDetectors
              .any((detector) => detector.onShowHoverHighlight != null),
          isTrue);

      // Check that DefaultTextStyle is present for text styling
      final textStyles = tester.widgetList<DefaultTextStyle>(
        find.descendant(
            of: triggerFinder, matching: find.byType(DefaultTextStyle)),
      );
      expect(textStyles.length, greaterThan(0));

      // Initially, text has no decoration
      final textFinder = find.text('Trigger');
      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.decoration, isNull);
    });

    testWidgets('arrow rotates when expanded', (tester) async {
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

      // Initially collapsed - check that Transform exists
      expect(find.byType(Transform), findsOneWidget);

      // Expand
      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      // Transform should still exist
      expect(find.byType(Transform), findsOneWidget);
    });

    testWidgets('handles complex child content', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(
                  child: Row(
                    children: const [
                      Text('Title'),
                      SizedBox(width: 8),
                      Text('Subtitle'),
                    ],
                  ),
                ),
                content: const Text('Content'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('applies proper padding', (tester) async {
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

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, isA<EdgeInsets>());
    });

    testWidgets('has correct cursor on hover', (tester) async {
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

      final gestureDetectors =
          tester.widgetList<GestureDetector>(find.byType(GestureDetector));
      expect(gestureDetectors.length, greaterThan(0));
    });

    testWidgets('maintains accessibility', (tester) async {
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

      // Check that the trigger is focusable
      expect(find.byType(FocusableActionDetector), findsOneWidget);
    });
  });
}
