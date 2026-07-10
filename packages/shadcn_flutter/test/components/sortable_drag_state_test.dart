import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

class _Toggle extends StatefulWidget {
  const _Toggle();

  @override
  State<_Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<_Toggle> {
  bool _blue = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _blue = !_blue),
      child: Container(
        width: 100,
        height: 40,
        color: _blue ? Colors.blue : Colors.red,
        child: Text(_blue ? 'BLUE' : 'RED'),
      ),
    );
  }
}

void main() {
  testWidgets('Sortable ghost preserves child state while dragging',
      (tester) async {
    bool dragStarted = false;
    await tester.pumpWidget(
      SimpleApp(
        child: SortableLayer(
          child: Column(
            children: [
              Sortable<int>(
                data: const SortableData(0),
                onAcceptTop: (_) {},
                onAcceptBottom: (_) {},
                onDragStart: () => dragStarted = true,
                child: const _Toggle(),
              ),
              const SizedBox(height: 200, child: ColoredBox(color: Colors.gray)),
            ],
          ),
        ),
      ),
    );

    expect(find.text('RED'), findsOneWidget);

    await tester.tap(find.byType(_Toggle));
    await tester.pumpAndSettle();
    expect(find.text('BLUE'), findsOneWidget);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(_Toggle)),
      kind: PointerDeviceKind.touch,
    );
    await tester.pump(const Duration(milliseconds: 50));
    await gesture.moveBy(const Offset(0, 20));
    await tester.pump(const Duration(milliseconds: 16));
    await gesture.moveBy(const Offset(0, 20));
    await tester.pump(const Duration(milliseconds: 16));
    await gesture.moveBy(const Offset(0, 20));
    await tester.pump(const Duration(milliseconds: 50));

    expect(dragStarted, isTrue);

    // The original slot renders an *invisible* (paint-skipped, not Offstage)
    // placeholder while dragging, so find.text still sees it regardless of
    // its state - that copy is disposable by design. What matters is the
    // ghost that actually follows the cursor: it must carry the live,
    // toggled ("BLUE") state, not a freshly reset ("RED") element. The ghost
    // is the copy positioned via a Transform inside the SortableLayer.
    final ghostBlue = find.descendant(
      of: find.byType(Transform),
      matching: find.text('BLUE'),
    );
    expect(ghostBlue, findsOneWidget);
    final ghostRed = find.descendant(
      of: find.byType(Transform),
      matching: find.text('RED'),
    );
    expect(ghostRed, findsNothing);

    await gesture.up();
    await tester.pumpAndSettle();
  });
}
