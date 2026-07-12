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

  group('Popover positioning (anchor tracking)', () {
    testWidgets(
        'popover attaches to the anchor-alignment point, not the anchor corner',
        (tester) async {
      final anchorKey = GlobalKey();
      final popoverKey = GlobalKey();
      late BuildContext anchorContext;

      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              // Builder wraps the sized box so anchorContext.findRenderObject()
              // resolves to the 100x40 box the overlay anchors against.
              Builder(
                builder: (context) {
                  anchorContext = context;
                  return SizedBox(
                    key: anchorKey,
                    width: 100,
                    height: 40,
                    child: const Center(child: Text('Anchor')),
                  );
                },
              ),
              Button.primary(
                onPressed: () {
                  showOverlay(
                    anchorContext,
                    PopoverConfiguration(
                      // Default ContextAnchor => the per-frame follow ticker
                      // runs, which is where the corner-snapping regression
                      // manifested.
                      alignment: Alignment.topCenter,
                      builder: (context) => SizedBox(
                        key: popoverKey,
                        width: 120,
                        height: 60,
                        child: const Text('Popover Content'),
                      ),
                      handler: const PopoverOverlayHandler(),
                    ),
                  );
                },
                child: const Text('Show Popover'),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Show Popover'));
      await tester.pump();
      // Advance past the show animation and let the follow ticker run several
      // frames — the regression overwrote the (correct) initial position on
      // the first tick. (The ContextAnchor ticker schedules a frame every
      // tick, so pumpAndSettle would never settle here.)
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 16));
      await tester.pump(const Duration(milliseconds: 16));

      final anchorRect = tester.getRect(find.byKey(anchorKey));
      final popoverRect = tester.getRect(find.byKey(popoverKey));

      // alignment topCenter / anchorAlignment bottomCenter: the popover's top
      // edge sits at the anchor's bottom edge and is horizontally centered on
      // the anchor. The bug snapped it to the anchor's top-left corner instead.
      expect(popoverRect.top, moreOrLessEquals(anchorRect.bottom, epsilon: 2.0));
      expect(popoverRect.center.dx,
          moreOrLessEquals(anchorRect.center.dx, epsilon: 2.0));
    });

    testWidgets(
        'LinkedAnchor popover follows the anchor when the page is scrolled',
        (tester) async {
      final anchorKey = GlobalKey();
      final popoverKey = GlobalKey();
      final controller = ScrollController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              // Button lives outside the scroll view so it stays tappable.
              Builder(
                builder: (context) => Button.primary(
                  onPressed: () {
                    showOverlay(
                      context,
                      PopoverConfiguration(
                        anchor: const LinkedAnchor(#scrollAnchor),
                        alignment: Alignment.bottomCenter,
                        anchorAlignment: Alignment.topCenter,
                        builder: (context) => SizedBox(
                          key: popoverKey,
                          width: 120,
                          height: 60,
                          child: const Text('Popover Content'),
                        ),
                        handler: const PopoverOverlayHandler(),
                      ),
                    );
                  },
                  child: const Text('Show Popover'),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      const SizedBox(height: 200),
                      OverlayAnchor(
                        anchor: #scrollAnchor,
                        child: SizedBox(
                          key: anchorKey,
                          width: 100,
                          height: 40,
                          child: const Center(child: Text('Anchor')),
                        ),
                      ),
                      const SizedBox(height: 2000),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Show Popover'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Popover sits above the anchor (alignment bottomCenter / anchorAlignment
      // topCenter): its bottom edge is at the anchor's top edge.
      final anchorBefore = tester.getRect(find.byKey(anchorKey));
      final popoverBefore = tester.getRect(find.byKey(popoverKey));
      expect(popoverBefore.bottom,
          moreOrLessEquals(anchorBefore.top, epsilon: 2.0));

      // Scroll the page; the anchor moves up. The popover must move with it.
      controller.jumpTo(150);
      await tester.pump(); // apply scroll -> compositing probe detects movement
      await tester.pump(); // post-frame notify -> popover repositions

      final anchorAfter = tester.getRect(find.byKey(anchorKey));
      final popoverAfter = tester.getRect(find.byKey(popoverKey));

      // The anchor actually moved up by the scroll delta...
      expect(anchorAfter.top, lessThan(anchorBefore.top - 100));
      // ...and the popover tracked it, staying pinned to the anchor's top edge.
      expect(popoverAfter.bottom,
          moreOrLessEquals(anchorAfter.top, epsilon: 2.0));
    });

    testWidgets(
        'LinkedAnchor popover re-evaluates invert/margin live while scrolling',
        (tester) async {
      final anchorKey = GlobalKey();
      final popoverKey = GlobalKey();
      // Bottom-anchored so scrolling to offset 0 leaves the anchor near the
      // bottom of the viewport; starting fully scrolled puts it near the top.
      final controller = ScrollController(initialScrollOffset: 440);
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              Builder(
                builder: (context) => Button.primary(
                  onPressed: () {
                    showOverlay(
                      context,
                      PopoverConfiguration(
                        anchor: const LinkedAnchor(#invertAnchor),
                        // Opens below the anchor.
                        alignment: Alignment.topCenter,
                        anchorAlignment: Alignment.bottomCenter,
                        builder: (context) => SizedBox(
                          key: popoverKey,
                          width: 120,
                          height: 200,
                          child: const Text('Popover Content'),
                        ),
                        handler: const PopoverOverlayHandler(),
                      ),
                    );
                  },
                  child: const Text('Show Popover'),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      const SizedBox(height: 500),
                      OverlayAnchor(
                        anchor: #invertAnchor,
                        child: SizedBox(
                          key: anchorKey,
                          width: 100,
                          height: 40,
                          child: const Center(child: Text('Anchor')),
                        ),
                      ),
                      const SizedBox(height: 500),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Show Popover'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Anchor near the top: popover sits BELOW it (top edge at anchor bottom).
      final anchorBefore = tester.getRect(find.byKey(anchorKey));
      final popoverBefore = tester.getRect(find.byKey(popoverKey));
      expect(popoverBefore.top,
          moreOrLessEquals(anchorBefore.bottom, epsilon: 3.0),
          reason: 'popover should start below the anchor');

      // Scroll the anchor down toward the bottom edge; below no longer fits.
      controller.jumpTo(0);
      await tester.pump();
      await tester.pump();

      final anchorAfter = tester.getRect(find.byKey(anchorKey));
      final popoverAfter = tester.getRect(find.byKey(popoverKey));

      // The anchor moved down...
      expect(anchorAfter.top, greaterThan(anchorBefore.top + 100));
      // ...and the popover flipped ABOVE it (bottom edge at anchor top) — invert
      // was re-evaluated live during the scroll, not frozen at open time.
      expect(popoverAfter.bottom,
          moreOrLessEquals(anchorAfter.top, epsilon: 3.0),
          reason: 'popover should have inverted to above the anchor');
    });

    testWidgets(
        'popover clamps to the overflowing edge instead of teleporting to the top',
        (tester) async {
      final popoverKey = GlobalKey();
      late BuildContext anchorContext;

      await tester.pumpWidget(
        SimpleApp(
          child: Stack(
            children: [
              // Anchor pinned near the TOP of the screen.
              Positioned(
                top: 40,
                left: 350,
                child: Builder(
                  builder: (context) {
                    anchorContext = context;
                    return const SizedBox(
                        width: 100, height: 30, child: Center(child: Text('A')));
                  },
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Builder(
                  builder: (context) => Button.primary(
                    onPressed: () {
                      showOverlay(
                        anchorContext,
                        PopoverConfiguration(
                          // Opens downward from the anchor.
                          alignment: Alignment.topCenter,
                          anchorAlignment: Alignment.bottomCenter,
                          builder: (context) => SizedBox(
                            key: popoverKey,
                            width: 120,
                            height: 560,
                            child: const Text('P'),
                          ),
                          handler: const PopoverOverlayHandler(),
                        ),
                      );
                    },
                    child: const Text('Show'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 16));

      final popoverRect = tester.getRect(find.byKey(popoverKey));
      final double surfaceHeight =
          tester.view.physicalSize.height / tester.view.devicePixelRatio;

      // The popover overflows the bottom on its (downward) side; inverting to
      // above the anchor would overflow the top far more, so it must stay
      // clamped against the bottom edge — NOT snap up to the top of the screen.
      // Equivalent to: the gap below the popover is smaller than the gap above.
      expect(
        surfaceHeight - popoverRect.bottom,
        lessThan(popoverRect.top),
        reason:
            'popover should hug the overflowing (bottom) edge, not teleport to the top',
      );
    });
  });
}
