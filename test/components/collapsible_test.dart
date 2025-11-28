import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Collapsible', () {
    testWidgets('renders trigger', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Collapsible(
            children: [
              CollapsibleTrigger(child: Text('Trigger')),
              Text('Content'),
            ],
          ),
        ),
      );

      expect(find.text('Trigger'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('content is hidden by default', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Collapsible(
            children: [
              CollapsibleTrigger(child: Text('Trigger')),
              CollapsibleContent(child: Text('Content')),
            ],
          ),
        ),
      );

      expect(find.text('Trigger'), findsOneWidget);
      // Should be offstage by default
      expect(find.text('Content'), findsNothing);
      expect(find.text('Content', skipOffstage: false), findsOneWidget);
    });

    testWidgets('toggles content on tap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Collapsible(
            children: [
              CollapsibleTrigger(child: Text('Trigger')),
              CollapsibleContent(child: Text('Content')),
            ],
          ),
        ),
      );

      // Initially hidden
      expect(find.text('Content'), findsNothing);

      // Tap trigger button
      await tester.tap(find.byType(GhostButton));
      await tester.pumpAndSettle();

      // Should be visible
      expect(find.text('Content'), findsOneWidget);

      // Tap again
      await tester.tap(find.byType(GhostButton));
      await tester.pumpAndSettle();

      // Should be hidden again
      expect(find.text('Content'), findsNothing);
    });

    testWidgets('works in controlled mode', (tester) async {
      bool expanded = false;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Collapsible(
                isExpanded: expanded,
                onExpansionChanged: (value) {
                  setState(() {
                    // Collapsible passes the CURRENT state, so we negate it to toggle
                    expanded = !value;
                  });
                },
                children: [
                  CollapsibleTrigger(child: Text('Trigger')),
                  CollapsibleContent(child: Text('Content')),
                ],
              );
            },
          ),
        ),
      );

      // Initially collapsed
      expect(expanded, isFalse);
      expect(find.text('Content'), findsNothing);

      // Tap trigger button
      await tester.tap(find.byType(GhostButton));
      await tester.pumpAndSettle();

      // Should update state
      expect(expanded, isTrue);

      // Verify UI updated
      expect(find.text('Content'), findsOneWidget);
    });
  });
}
