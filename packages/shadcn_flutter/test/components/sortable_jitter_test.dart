import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

/// Slowly drags the first item across its neighbours while a downstream item is
/// watched. With a stable drop zone the watched item drifts smoothly, so the
/// per-frame movement stays small. The bug resolves the drop zone against the
/// placeholder-inflated target box, whose growing size sweeps the zone midpoint
/// under the pointer; the zone then flips and a full-item-sized placeholder
/// snaps in/out, producing large single-frame jumps of the watched item.
Future<double> _maxJump(
  WidgetTester tester, {
  required Axis axis,
  required Finder watched,
}) async {
  final gesture = await tester.startGesture(
    tester.getCenter(find.text('A')),
    kind: PointerDeviceKind.touch,
  );
  await tester.pump(const Duration(milliseconds: 50));

  final step = axis == Axis.horizontal ? const Offset(4, 0) : const Offset(0, 4);
  double? last;
  double maxJump = 0;
  for (int i = 0; i < 40; i++) {
    await gesture.moveBy(step);
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(milliseconds: 16));
    final rect = tester.getRect(watched.first);
    final v = axis == Axis.horizontal ? rect.left : rect.top;
    if (last != null) {
      final jump = (v - last).abs();
      if (jump > maxJump) maxJump = jump;
    }
    last = v;
  }
  await gesture.up();
  await tester.pumpAndSettle();
  return maxJump;
}

List<SortableData<String>> _names() => [
      const SortableData('A'),
      const SortableData('B'),
      const SortableData('C'),
      const SortableData('D'),
      const SortableData('E'),
    ];

Widget _horizontal(List<SortableData<String>> names) => SimpleApp(
      child: StatefulBuilder(
        builder: (context, setState) => SortableLayer(
          lock: true,
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < names.length; i++)
                  Sortable<String>(
                    key: ValueKey(names[i].data),
                    data: names[i],
                    onAcceptLeft: (v) => setState(() => names.swapItem(v, i)),
                    onAcceptRight: (v) =>
                        setState(() => names.swapItem(v, i + 1)),
                    child: SizedBox(
                      width: 100,
                      child: Center(child: Text(names[i].data)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

Widget _vertical(List<SortableData<String>> names) => SimpleApp(
      child: StatefulBuilder(
        builder: (context, setState) => SortableLayer(
          lock: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < names.length; i++)
                Sortable<String>(
                  key: ValueKey(names[i].data),
                  data: names[i],
                  onAcceptTop: (v) => setState(() => names.swapItem(v, i)),
                  onAcceptBottom: (v) =>
                      setState(() => names.swapItem(v, i + 1)),
                  child: SizedBox(
                    height: 50,
                    child: Center(child: Text(names[i].data)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

void main() {
  testWidgets('horizontal drag does not snap the drop zone back and forth',
      (tester) async {
    await tester.pumpWidget(_horizontal(_names()));
    await tester.pumpAndSettle();
    final jump =
        await _maxJump(tester, axis: Axis.horizontal, watched: find.text('C'));
    // A full-item placeholder is 100px; a spurious flip snaps the watched item
    // by roughly half that. Smooth drift stays well under 20px/frame.
    expect(jump, lessThan(20));
  });

  testWidgets('vertical drag does not snap the drop zone back and forth',
      (tester) async {
    await tester.pumpWidget(_vertical(_names()));
    await tester.pumpAndSettle();
    final jump =
        await _maxJump(tester, axis: Axis.vertical, watched: find.text('C'));
    expect(jump, lessThan(15));
  });
}
