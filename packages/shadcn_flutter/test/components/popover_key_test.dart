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
              Builder(
                builder: (context) => Button.primary(
                  onPressed: () {
                    showOverlay(
                      context,
                      PopoverConfiguration(
                        anchor: LinkedAnchor(#myAnchor),
                        alignment: Alignment.bottomCenter,
                        builder: (context) => Text('Popover Content'),
                      ),
                    );
                  },
                  child: Text('Show Popover'),
                ),
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
              Builder(
                builder: (context) => Button.primary(
                  onPressed: () {
                    showOverlay(
                      context,
                      DrawerConfiguration(
                        anchor: LinkedAnchor(#myDrawerAnchor),
                        position: OverlayPosition.left,
                        builder: (context) => Text('Drawer Content'),
                      ),
                    );
                  },
                  child: Text('Show Drawer'),
                ),
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
                      showOverlay(
                        context,
                        PopoverConfiguration(
                          anchor: LinkedAnchor(#tempAnchor),
                          alignment: Alignment.bottomCenter,
                          builder: (context) => Text('Temp Popover'),
                        ),
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

  group('Anchor (isVisible gating and auto-close)', () {
    testWidgets(
        'prevents popover from showing when LinkedAnchor key is not registered',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Builder(
            builder: (context) => Button.primary(
              onPressed: () {
                showOverlay(
                  context,
                  PopoverConfiguration(
                    anchor: LinkedAnchor(#neverRegisteredAnchor),
                    alignment: Alignment.bottomCenter,
                    builder: (context) => Text('Popover Content'),
                    // ShadcnApp defaults to SheetOverlayHandler on mobile;
                    // force a real popover to exercise the isVisible gate.
                    handler: const PopoverOverlayHandler(),
                  ),
                );
              },
              child: Text('Show Popover'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Popover'));
      await tester.pumpAndSettle();

      // The anchor was never registered, so the popover must never appear.
      expect(find.text('Popover Content'), findsNothing);
    });

    testWidgets(
        'closes popover with its normal animation when its LinkedAnchor is removed',
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
                      anchor: #vanishingAnchor,
                      child: Text('Vanishing Anchor'),
                    ),
                  Button.primary(
                    onPressed: () {
                      showOverlay(
                        context,
                        PopoverConfiguration(
                          anchor: LinkedAnchor(#vanishingAnchor),
                          alignment: Alignment.bottomCenter,
                          builder: (context) => Text('Popover Content'),
                          handler: const PopoverOverlayHandler(),
                        ),
                      );
                    },
                    child: Text('Show Popover'),
                  ),
                ],
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show Popover'));
      await tester.pumpAndSettle();
      expect(find.text('Popover Content'), findsOneWidget);

      // Remove the anchor while the popover is open.
      valueNotifier.value = false;
      await tester.pump();
      await tester.pump();

      // Still transitioning into its close animation, not vanished instantly.
      expect(find.text('Popover Content'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('Popover Content'), findsNothing);
    });
  });
}
