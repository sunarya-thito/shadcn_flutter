import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

class _TwoLists extends StatefulWidget {
  final bool keyed;
  const _TwoLists({required this.keyed});
  @override
  State<_TwoLists> createState() => _TwoListsState();
}

class _TwoListsState extends State<_TwoLists> {
  List<SortableData<String>> a = [
    const SortableData('A0'),
    const SortableData('A1'),
    const SortableData('A2'),
    const SortableData('A3'),
  ];
  List<SortableData<String>> b = [
    const SortableData('B0'),
    const SortableData('B1'),
  ];

  Widget _list(List<SortableData<String>> list, List<List<SortableData<String>>> all) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < list.length; i++)
          Sortable<String>(
            key: widget.keyed ? ValueKey(list[i].data) : null,
            data: list[i],
            onAcceptTop: (v) =>
                setState(() => swapItemInLists(all, v, list, i)),
            onAcceptBottom: (v) =>
                setState(() => swapItemInLists(all, v, list, i + 1)),
            child: SizedBox(height: 40, child: Center(child: Text(list[i].data))),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _list(a, [a, b])),
          Expanded(child: _list(b, [a, b])),
        ],
      ),
    );
  }
}

// Texts rendered in the left half of the 800px-wide surface (list A region).
List<String> _leftTexts(WidgetTester tester) {
  final out = <String>[];
  for (final label in ['A0', 'A1', 'A2', 'A3', 'B0', 'B1']) {
    for (final e in find.text(label).evaluate()) {
      final rb = e.renderObject as RenderBox;
      final x = rb.localToGlobal(Offset.zero).dx;
      if (x < 400) out.add(label);
    }
  }
  out.sort();
  return out;
}

Future<List<String>> _dragA2ToListB(WidgetTester tester) async {
  await tester.pumpWidget(const SimpleApp(child: _TwoLists(keyed: true)));
  await tester.pumpAndSettle();

  final start = tester.getCenter(find.text('A2'));
  final target = tester.getCenter(find.text('B0'));
  final deltas = target - start;
  final gesture = await tester.startGesture(start, kind: PointerDeviceKind.touch);
  await tester.pump(const Duration(milliseconds: 50));
  for (int i = 0; i < 10; i++) {
    await gesture.moveBy(deltas / 10);
    await tester.pump(const Duration(milliseconds: 16));
  }
  await gesture.up();
  // A couple of frames into the drop animation (the transient where the bug
  // shows a wrong item removed from the source list), before it settles.
  await tester.pump(const Duration(milliseconds: 16));
  await tester.pump(const Duration(milliseconds: 16));
  final left = _leftTexts(tester);
  await tester.pumpAndSettle();
  return left;
}

void main() {
  // Regression guard for identity-keyed cross-list drag. Without identity keys,
  // the per-item Sortable state (and its internal GlobalKey) rebinds to the
  // wrong item when a list changes length, which threw a duplicate-GlobalKey
  // error and removed/duplicated the wrong item on drop.
  testWidgets('keyed cross-list drop removes the dragged item, not another',
      (tester) async {
    final left = await _dragA2ToListB(tester);
    // A2 moved to list B, so list A must still show A0, A1, A3 (and only those).
    expect(left, ['A0', 'A1', 'A3'], reason: 'left list after drop: $left');
  });
}
