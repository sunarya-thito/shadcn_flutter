import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

enum _KeyMode { none, indexed, identity }

class _ReorderList extends StatefulWidget {
  final _KeyMode mode;
  const _ReorderList(this.mode);
  @override
  State<_ReorderList> createState() => _ReorderListState();
}

class _ReorderListState extends State<_ReorderList> {
  List<SortableData<String>> names = [
    const SortableData('A'),
    const SortableData('B'),
    const SortableData('C'),
    const SortableData('D'),
    const SortableData('E'),
  ];

  Key? _key(int i) {
    switch (widget.mode) {
      case _KeyMode.none:
        return null;
      case _KeyMode.indexed:
        return ValueKey(i);
      case _KeyMode.identity:
        return ValueKey(names[i].data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < names.length; i++)
            Sortable<String>(
              key: _key(i),
              data: names[i],
              onAcceptTop: (v) => setState(() => names.swapItem(v, i)),
              onAcceptBottom: (v) => setState(() => names.swapItem(v, i + 1)),
              child: SizedBox(height: 40, child: Center(child: Text(names[i].data))),
            ),
        ],
      ),
    );
  }
}

// The item the flying drop-animation ghost is showing.
List<String> _ghostTexts(WidgetTester tester) {
  final out = <String>[];
  for (final label in ['A', 'B', 'C', 'D', 'E']) {
    final f = find.descendant(
      of: find.byType(Transform),
      matching: find.text(label),
    );
    if (f.evaluate().isNotEmpty) out.add(label);
  }
  return out;
}

Future<List<String>> _dragBottomToTop(WidgetTester tester, _KeyMode mode) async {
  await tester.pumpWidget(SimpleApp(child: _ReorderList(mode)));
  await tester.pumpAndSettle();

  final start = tester.getCenter(find.text('E'));
  final top = tester.getCenter(find.text('A'));
  final gesture = await tester.startGesture(start, kind: PointerDeviceKind.touch);
  await tester.pump(const Duration(milliseconds: 50));
  final delta = top - start;
  for (int i = 0; i < 10; i++) {
    await gesture.moveBy(delta / 10);
    await tester.pump(const Duration(milliseconds: 16));
  }
  await gesture.up();
  // Sample the flying drop ghost mid-animation.
  await tester.pump(const Duration(milliseconds: 16));
  final ghost = _ghostTexts(tester);
  await tester.pumpAndSettle();
  return ghost;
}

void main() {
  // Reordering a single list with non-identity keys (index keys or none) makes
  // each position rebind to a different item, so the dragged item's internal
  // GlobalKey is claimed twice ("Multiple widgets used the same GlobalKey") and
  // the flying drop ghost shows the wrong item. Identity keys keep each item's
  // state with its data.
  testWidgets('identity keys: drop ghost stays the dragged item', (tester) async {
    final ghost = await _dragBottomToTop(tester, _KeyMode.identity);
    expect(ghost, ['E'], reason: 'flying ghost should be E, was $ghost');
  });
}
