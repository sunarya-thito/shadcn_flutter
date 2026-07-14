import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

class _RemoveList extends StatefulWidget {
  const _RemoveList({super.key});
  @override
  State<_RemoveList> createState() => _RemoveListState();
}

class _RemoveListState extends State<_RemoveList> {
  List<SortableData<String>> names = [
    const SortableData('A'),
    const SortableData('B'),
    const SortableData('C'),
    const SortableData('D'),
    const SortableData('E'),
  ];

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      child: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < names.length; i++)
              Sortable<String>(
                key: ValueKey(names[i].data),
                data: names[i],
                onAcceptTop: (v) => setState(() => names.swapItem(v, i)),
                onAcceptBottom: (v) => setState(() => names.swapItem(v, i + 1)),
                onDropFailed: () => setState(() {
                  final removed = names.removeAt(i);
                  SortableLayer.ensureAndDismissDrop(context, removed);
                }),
                child: SizedBox(
                  height: 40,
                  child: Center(child: Text(names[i].data)),
                ),
              ),
          ],
        );
      }),
    );
  }
}

Future<bool> _dragAndCheckRemoved(WidgetTester tester, Offset totalDelta,
    {String item = 'C'}) async {
  // Fresh key each call so a new State (full A-E list) is built.
  await tester.pumpWidget(SimpleApp(child: _RemoveList(key: UniqueKey())));
  await tester.pumpAndSettle();
  final start = tester.getCenter(find.text(item));
  final gesture = await tester.startGesture(start, kind: PointerDeviceKind.touch);
  await tester.pump(const Duration(milliseconds: 50));
  const steps = 12;
  for (int i = 0; i < steps; i++) {
    await gesture.moveBy(totalDelta / steps.toDouble());
    await tester.pump(const Duration(milliseconds: 16));
  }
  await gesture.up();
  await tester.pumpAndSettle();
  return find.text(item).evaluate().isEmpty; // removed if the item is gone
}

void main() {
  // A tap or tiny nudge (pointer never leaves the item) must NOT remove -
  // that was the old inverted behavior.
  testWidgets('tap / tiny nudge does not remove', (tester) async {
    expect(await _dragAndCheckRemoved(tester, const Offset(3, 3)), isFalse);
  });

  // Releasing on empty space after the pointer leaves the item is a failed
  // drop -> removed, regardless of direction.
  testWidgets('drag up-and-out removes', (tester) async {
    expect(await _dragAndCheckRemoved(tester, const Offset(0, -140)), isTrue);
  });

  testWidgets('drag down-and-out removes', (tester) async {
    expect(await _dragAndCheckRemoved(tester, const Offset(0, 170)), isTrue);
  });

  // Targeting follows the pointer, not the item centre: grabbing near the top
  // edge and dragging up so the *pointer* clears the list removes the item even
  // though much of the item body still overlaps the list area.
  testWidgets('removal follows the pointer, not the item area', (tester) async {
    await tester.pumpWidget(SimpleApp(child: _RemoveList(key: UniqueKey())));
    await tester.pumpAndSettle();
    // Grab 'C' near its top edge (like a handle), then drag up ~2.5 items.
    final rect = tester.getRect(find.text('C'));
    final grab = Offset(rect.center.dx, rect.top + 2);
    final gesture = await tester.startGesture(grab, kind: PointerDeviceKind.touch);
    await tester.pump(const Duration(milliseconds: 50));
    for (int i = 0; i < 12; i++) {
      await gesture.moveBy(const Offset(0, -9));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();
    expect(find.text('C').evaluate().isEmpty, isTrue);
  });
}
