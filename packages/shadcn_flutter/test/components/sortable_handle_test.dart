import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

class _List extends StatefulWidget {
  final bool useHandle;
  const _List({required this.useHandle});
  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  List<SortableData<String>> names = [
    const SortableData('A'),
    const SortableData('B'),
    const SortableData('C'),
    const SortableData('D'),
  ];

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < names.length; i++)
            Sortable<String>(
              key: ValueKey(names[i].data),
              data: names[i],
              enabled: !widget.useHandle,
              onAcceptTop: (v) => setState(() => names.swapItem(v, i)),
              onAcceptBottom: (v) => setState(() => names.swapItem(v, i + 1)),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    if (widget.useHandle)
                      SortableDragHandle(
                        child: Icon(Icons.drag_handle,
                            key: ValueKey('h${names[i].data}')),
                      ),
                    Expanded(child: Center(child: Text(names[i].data))),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

List<String> _order(WidgetTester tester) {
  final entries = <(double, String)>[];
  for (final label in ['A', 'B', 'C', 'D']) {
    for (final e in find.text(label).evaluate()) {
      final rb = e.renderObject as RenderBox;
      if (!rb.hasSize || rb.size.isEmpty) continue;
      entries.add((rb.localToGlobal(Offset.zero).dy, label));
    }
  }
  entries.sort((a, b) => a.$1.compareTo(b.$1));
  return entries.map((e) => e.$2).toList();
}

Future<List<String>> _drag(WidgetTester tester,
    {required bool useHandle}) async {
  await tester.pumpWidget(SimpleApp(child: _List(useHandle: useHandle)));
  await tester.pumpAndSettle();

  final grab = useHandle
      ? tester.getCenter(find.byKey(const ValueKey('hA')))
      : tester.getCenter(find.text('A'));
  final gesture = await tester.startGesture(grab, kind: PointerDeviceKind.touch);
  await tester.pump(const Duration(milliseconds: 50));
  for (int i = 0; i < 6; i++) {
    await gesture.moveBy(const Offset(0, 12));
    await tester.pump(const Duration(milliseconds: 16));
  }
  await gesture.up();
  await tester.pumpAndSettle();
  return _order(tester);
}

void main() {
  // Dragging 'A' down ~60px past 'B' and 'C' lands it between them.
  testWidgets('direct drag reorders', (tester) async {
    expect(await _drag(tester, useHandle: false), ['B', 'C', 'A', 'D']);
  });

  // A SortableDragHandle re-parents the child into the ghost overlay on drag
  // start; the handle must keep its owning Sortable (via Data) so its pan
  // callbacks survive and the drag actually tracks/reorders.
  testWidgets('drag handle reorders (and leaves no stuck ghost)',
      (tester) async {
    expect(await _drag(tester, useHandle: true), ['B', 'C', 'A', 'D']);
  });
}
