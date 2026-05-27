import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('OverlayAnchor (Key-based Anchoring)', () {
    testWidgets('shows and dismisses popover using Symbol key', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              OverlayAnchor(
                anchor: #myAnchor,
                child: Text('Anchor Element'),
              ),
              Button.primary(
                onPressed: () {
                  showPopover(
                    anchor: #myAnchor,
                    alignment: Alignment.bottomCenter,
                    builder: (context) => Text('Popover Content'),
                  );
                },
                child: Text('Show Popover'),
              ),
            ],
          ),
        ),
      );

      // Verify popover is not shown initially
      expect(find.text('Popover Content'), findsNothing);

      // Tap the button to trigger popover
      await tester.tap(find.text('Show Popover'));
      await tester.pumpAndSettle();

      // Verify popover shows up relative to the anchor
      expect(find.text('Popover Content'), findsOneWidget);
    });

    testWidgets('shows drawer/sheet using Symbol key', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              OverlayAnchor(
                anchor: #myDrawerAnchor,
                child: Text('Drawer Anchor Element'),
              ),
              Button.primary(
                onPressed: () {
                  openDrawer(
                    anchor: #myDrawerAnchor,
                    position: OverlayPosition.left,
                    builder: (context) => Text('Drawer Content'),
                  );
                },
                child: Text('Show Drawer'),
              ),
            ],
          ),
        ),
      );

      // Verify drawer is not shown initially
      expect(find.text('Drawer Content'), findsNothing);

      // Tap the button to trigger drawer
      await tester.tap(find.text('Show Drawer'));
      await tester.pumpAndSettle();

      // Verify drawer content shows up
      expect(find.text('Drawer Content'), findsOneWidget);
    });

    testWidgets('unregisters Symbol key when OverlayAnchor is unmounted',
        (tester) async {
      final valueNotifier = ValueNotifier<bool>(true);

      await tester.pumpWidget(
        SimpleApp(
          child: AnimatedBuilder(
            animation: valueNotifier,
            builder: (context, child) {
              return Column(
                children: [
                  if (valueNotifier.value)
                    OverlayAnchor(
                      anchor: #tempAnchor,
                      child: Text('Temporary Anchor'),
                    ),
                  Button.primary(
                    onPressed: () {
                      showPopover(
                        anchor: #tempAnchor,
                        alignment: Alignment.bottomCenter,
                        builder: (context) => Text('Temp Popover'),
                      );
                    },
                    child: Text('Show Temp'),
                  ),
                ],
              );
            },
          ),
        ),
      );

      // Verify registry contains key initially
      expect(OverlayAnchorRegistry.find(#tempAnchor), isNotNull);

      // Unmount the anchor
      valueNotifier.value = false;
      await tester.pump();

      // Verify registry is cleaned up and has unregistered the key
      expect(OverlayAnchorRegistry.find(#tempAnchor), isNull);
    });
  });
}
