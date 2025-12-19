import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

Widget buildApp({bool overscroll = false}) {
  return ShadcnApp(
    home: Scaffold(
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: ScrollableClient(
            diagonalDragBehavior: DiagonalDragBehavior.free,
            overscroll: overscroll,
            builder: (context, offset, viewportSize, child) {
              return Table(
                horizontalOffset: offset.dx,
                verticalOffset: offset.dy,
                viewportSize: viewportSize,
                columnWidths: const {
                  0: FixedTableSize(100),
                  1: FixedTableSize(100),
                  2: FixedTableSize(100),
                },
                frozenCells: FrozenTableData(
                  frozenRows: [TableRef(0)],
                  frozenColumns: [TableRef(0)],
                ),
                rows: [
                  TableRow(
                    cells: [
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R0 C0'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R0 C1'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R0 C2'))),
                    ],
                  ),
                  TableRow(
                    cells: [
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R1 C0'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R1 C1'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R1 C2'))),
                    ],
                  ),
                  TableRow(
                    cells: [
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R2 C0'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R2 C1'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R2 C2'))),
                    ],
                  ),
                  TableRow(
                    cells: [
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R3 C0'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R3 C1'))),
                      TableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R3 C2'))),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('Table overscroll - Valid Range', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    final scrollableFinder = find.byType(ScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Drag (-50, -50) should be within max scroll (100, 200)
    await tester.drag(scrollableFinder, const Offset(-50, -50));
    await tester.pump();

    var r0c0Pos = tester.getTopLeft(r0c0Finder);
    var scrollablePos = tester.getTopLeft(scrollableFinder);

    // Frozen cell (0,0) should stick to top-left of viewport
    expect(r0c0Pos, equals(scrollablePos));
  });

  testWidgets('Table overscroll - End Overscroll', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    final scrollableFinder = find.byType(ScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Scroll to end first
    await tester.drag(scrollableFinder, const Offset(-500, -500));
    await tester.pump();

    // Overscroll further (pull up-left)
    await tester.drag(scrollableFinder, const Offset(-50, -50));
    await tester.pump();

    var r0c0Pos = tester.getTopLeft(r0c0Finder);
    var scrollablePos = tester.getTopLeft(scrollableFinder);

    // Frozen cell should stick to top-left of viewport, even during overscroll
    expect(r0c0Pos, equals(scrollablePos));
  });

  testWidgets('Table overscroll - Start Overscroll',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    final scrollableFinder = find.byType(ScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Overscroll at start (pull down-right)
    await tester.drag(scrollableFinder, const Offset(50, 50));
    await tester.pump();

    var r0c0Pos = tester.getTopLeft(r0c0Finder);
    var scrollablePos = tester.getTopLeft(scrollableFinder);

    // Frozen cell should stick to top-left of viewport, even during overscroll
    expect(r0c0Pos, equals(scrollablePos));
  });

  testWidgets('Table overscroll disabled - Start Overscroll',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp(overscroll: false));
    final scrollableFinder = find.byType(ScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Drag (50, 50) -> Start Overscroll (pulling down-right)
    await tester.drag(scrollableFinder, const Offset(50, 50));
    await tester.pump();

    final scrollablePos = tester.getTopLeft(scrollableFinder);
    final r0c0Pos = tester.getTopLeft(r0c0Finder);

    // Expect frozen cell to be at (0,0) relative to scrollable
    expect(r0c0Pos, equals(scrollablePos));
  });
}
