import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('SheetStage', () {
    const res = SheetStageResolution(
      size: Size(300, 200),
      position: OverlayPosition.bottom,
      dragHandleExtent: 24,
    );

    test('closed resolves to 0 and expanded to the axis extent', () {
      expect(const SheetStage.closed().resolveDragOffset(res), 0);
      expect(const SheetStage.expanded().resolveDragOffset(res), 200);
    });

    test('fixed, fraction and peekDragHandle resolve along the axis', () {
      expect(const SheetStage.fixed(80).resolveDragOffset(res), 80);
      expect(const SheetStage.fraction(0.5).resolveDragOffset(res), 100);
      expect(const SheetStage.peekDragHandle().resolveDragOffset(res), 24);
    });

    test('arithmetic combines offsets', () {
      final sum = const SheetStage.fixed(100) + const SheetStage.fraction(0.25);
      expect(sum.resolveDragOffset(res), 150); // 100 + 0.25*200

      final short = const SheetStage.expanded() - const SheetStage.fixed(40);
      expect(short.resolveDragOffset(res), 160); // 200 - 40

      final scaled = const SheetStage.expanded() * 0.9;
      expect(scaled.resolveDragOffset(res), closeTo(180, 0.001));
    });

    test('backdropTransform falls back to expansion when null', () {
      // fraction(0.5) has no explicit backdrop transform -> 0.5 expansion.
      expect(const SheetStage.fraction(0.5).resolveBackdropTransform(res), 0.5);
      // explicit value wins.
      expect(
          const SheetStage.expanded(backdropTransform: 0.2)
              .resolveBackdropTransform(res),
          0.2);
    });
  });

  group('PinnedSheet + SheetController', () {
    Widget buildSheet(SheetController controller,
        {List<SheetStage>? stages, SheetStage? initial}) {
      return SimpleApp(
        child: Center(
          child: SizedBox(
            width: 300,
            height: 400,
            child: PinnedSheet(
              controller: controller,
              position: OverlayPosition.bottom,
              stages: stages ??
                  const [
                    SheetStage.closed(),
                    SheetStage.fraction(0.5),
                    SheetStage.expanded(),
                  ],
              initialStage: initial ?? const SheetStage.closed(),
              child: DrawerContainer(
                child: const SizedBox(height: 200, width: 300),
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('starts closed and animates to expanded', (tester) async {
      final controller = SheetController();
      await tester.pumpWidget(buildSheet(controller));
      await tester.pumpAndSettle();

      expect(controller.isAttached, isTrue);
      expect(controller.fraction, closeTo(0.0, 0.01));

      controller.stage = const SheetStage.expanded();
      await tester.pumpAndSettle();
      expect(controller.fraction, closeTo(1.0, 0.01));

      controller.dispose();
    });

    testWidgets('animateTo a fractional stage settles at that fraction',
        (tester) async {
      final controller = SheetController();
      await tester.pumpWidget(buildSheet(controller));
      await tester.pumpAndSettle();

      controller.animateTo(const SheetStage.fraction(0.5),
          duration: const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(controller.fraction, closeTo(0.5, 0.02));
      controller.dispose();
    });

    testWidgets('SizedBox.expand child fills the backdrop when expanded',
        (tester) async {
      final controller = SheetController();
      await tester.pumpWidget(SimpleApp(
        child: Center(
          child: SizedBox(
            width: 300,
            height: 400,
            child: PinnedSheet(
              controller: controller,
              position: OverlayPosition.bottom,
              stages: const [SheetStage.closed(), SheetStage.expanded()],
              initialStage: const SheetStage.expanded(),
              child: const DrawerContainer(
                child: SizedBox.expand(),
              ),
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // The content stretched to the full 400px region height, and the
      // expanded stage covers it fully.
      expect(controller.fraction, closeTo(1.0, 0.01));
      expect(controller.offset, closeTo(400, 1));
      controller.dispose();
    });

    testWidgets('nested pinned sheet opens inner without layout assert',
        (tester) async {
      final outer = SheetController();
      final inner = SheetController();
      Widget content(String t) => DrawerContainer(
            child: SizedBox(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(t)],
                ),
              ),
            ),
          );
      await tester.pumpWidget(SimpleApp(
        child: Center(
          child: SizedBox(
            width: 400,
            height: 460,
            child: PinnedSheet(
              controller: outer,
              position: OverlayPosition.bottom,
              backdropTransform: const ScaleBackdropTransform(),
              backdrop: PinnedSheet(
                controller: inner,
                position: OverlayPosition.bottom,
                backdropTransform: const ScaleBackdropTransform(),
                backdrop: const ColoredBox(color: Color(0xFF888888)),
                child: content('inner'),
              ),
              child: content('outer'),
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      inner.stage = const SheetStage.expanded();
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(inner.fraction, closeTo(1.0, 0.01));

      // Dragging the inner sheet content down must drive the INNER sheet, not
      // be swallowed by the (closed) outer sheet's gesture area.
      await tester.drag(find.text('inner'), const Offset(0, 120));
      await tester.pump();
      expect(inner.fraction, lessThan(0.95));
      expect(outer.fraction, closeTo(0.0, 0.01));
      await tester.pumpAndSettle();

      outer.dispose();
      inner.dispose();
    });

    testWidgets('inner sheet hands off overscroll to the outer at its end',
        (tester) async {
      final outer = SheetController();
      final inner = SheetController();
      Widget content(String t) => DrawerContainer(
            child: SizedBox(
              height: 200,
              child: Center(child: Text(t)),
            ),
          );
      await tester.pumpWidget(SimpleApp(
        child: Center(
          child: SizedBox(
            width: 400,
            height: 460,
            child: PinnedSheet(
              controller: outer,
              position: OverlayPosition.bottom,
              backdropTransform: const ScaleBackdropTransform(),
              backdrop: PinnedSheet(
                controller: inner,
                position: OverlayPosition.bottom,
                stages: const [
                  SheetStage.closed(),
                  SheetStage.fraction(0.5),
                  SheetStage.expanded(),
                ],
                initialStage: const SheetStage.expanded(),
                backdropTransform: const ScaleBackdropTransform(),
                backdrop: const ColoredBox(color: Color(0xFF888888)),
                child: content('inner'),
              ),
              child: content('outer'),
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(inner.fraction, closeTo(1.0, 0.01));
      expect(outer.fraction, closeTo(0.0, 0.01));

      // Single continuous gesture. Drag the (already expanded) inner up: the
      // inner has no room, so the leftover opens the outer.
      final gesture =
          await tester.startGesture(tester.getCenter(find.text('inner')));
      await gesture.moveBy(const Offset(0, -140));
      await tester.pump();
      expect(inner.fraction, closeTo(1.0, 0.01));
      expect(outer.fraction, greaterThan(0.2));
      final outerAtPeak = outer.fraction;

      // Reverse within the SAME gesture: this must pull the (engaged) outer
      // sheet back first, not re-drag the inner.
      await gesture.moveBy(const Offset(0, 90));
      await tester.pump();
      expect(inner.fraction, closeTo(1.0, 0.02));
      expect(outer.fraction, lessThan(outerAtPeak));

      await gesture.up();
      await tester.pumpAndSettle();

      outer.dispose();
      inner.dispose();
    });

    testWidgets('expands child: collapses to zero when closed, fills when open',
        (tester) async {
      final controller = SheetController();
      var taps = 0;
      await tester.pumpWidget(SimpleApp(
        child: Center(
          child: SizedBox(
            width: 300,
            height: 400,
            child: PinnedSheet(
              controller: controller,
              position: OverlayPosition.bottom,
              stages: const [SheetStage.closed(), SheetStage.expanded()],
              initialStage: const SheetStage.closed(),
              backdrop: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 60,
                  child: PrimaryButton(
                    onPressed: () => taps++,
                    child: const Text('bg'),
                  ),
                ),
              ),
              child: const DrawerContainer(
                expands: true,
                child:
                    SizedBox(height: 120, child: Center(child: Text('sheet'))),
              ),
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // Closed: the sheet collapses to zero, so a tap at the bottom reaches the
      // backdrop button behind it (no overflow either).
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('bg'));
      await tester.pump();
      expect(taps, 1);

      // Fully open: the sheet fills the whole 400px region.
      controller.stage = const SheetStage.expanded();
      await tester.pumpAndSettle();
      expect(controller.offset, closeTo(400, 1));
      expect(tester.takeException(), isNull);

      controller.dispose();
    });

    testWidgets('expands: MainAxisSize.max keeps bottom content visible',
        (tester) async {
      final controller = SheetController();
      final regionKey = GlobalKey();
      final ninety = const SheetStage.expanded() * 0.9;
      await tester.pumpWidget(SimpleApp(
        child: Center(
          child: SizedBox(
            key: regionKey,
            width: 300,
            height: 400,
            child: PinnedSheet(
              controller: controller,
              position: OverlayPosition.bottom,
              stages: [
                const SheetStage.closed(),
                ninety,
                const SheetStage.expanded()
              ],
              initialStage: ninety,
              child: DrawerContainer(
                expands: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text('top'),
                    Spacer(),
                    Align(
                        alignment: Alignment.bottomCenter, child: Text('btn')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      final region = tester.getRect(find.byKey(regionKey));
      final btn = tester.getRect(find.text('btn'));
      // The bottom button is NOT clipped below the visible box (the previous
      // bug pushed it past region.bottom) and sits near the bottom edge.
      expect(btn.bottom, lessThanOrEqualTo(region.bottom + 0.5));
      expect(btn.bottom, greaterThan(region.bottom - 20));
      controller.dispose();
    });

    testWidgets('controller.stage compares against derived stages both ways',
        (tester) async {
      final controller = SheetController();
      await tester.pumpWidget(buildSheet(controller));
      await tester.pumpAndSettle();

      controller.stage = const SheetStage.expanded();
      await tester.pumpAndSettle();

      // The content extent includes the drag handle chrome, so full != 200.
      final full = controller.offset;
      final derived = const SheetStage.expanded() -
          SheetStage.fixed(full); // resolves to ~0 offset

      // At expanded, controller.stage matches expanded() (both directions).
      expect(controller.stage == const SheetStage.expanded(), isTrue);
      expect(const SheetStage.expanded() == controller.stage, isTrue);
      // It does not match a stage that resolves to a very different offset.
      expect(controller.stage == derived, isFalse);

      controller.dispose();
    });
  });
}
