import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

Widget _buildApp(Widget child, {double height = 300, double width = 300}) {
  return ShadcnApp(
    home: Scaffold(
      child: Center(
        child: SizedBox(width: width, height: height, child: child),
      ),
    ),
  );
}

void main() {
  group('Table.builder', () {
    testWidgets('only builds rows within the visible window', (tester) async {
      int builtCount = 0;
      await tester.pumpWidget(_buildApp(
        Table.builder(
          rowCount: 5000,
          rowHeight: const FixedTableSize(40),
          rowBuilder: (context, index) {
            builtCount++;
            return TableRow(cells: [
              TableCell(child: Text('Row $index')),
            ]);
          },
        ),
      ));

      // Viewport is 300px tall with 40px rows (~8 visible) plus a small
      // lookahead on each side — nowhere near the full 5000 rows.
      expect(builtCount, lessThan(100));
    });

    testWidgets('header row is always built and stays pinned while scrolling',
        (tester) async {
      final controller = ScrollController();
      await tester.pumpWidget(_buildApp(
        Table.builder(
          rowCount: 2000,
          rowHeight: const FixedTableSize(40),
          headerRowCount: 1,
          verticalController: controller,
          rowBuilder: (context, index) {
            if (index == 0) {
              return TableHeader(cells: [TableCell(child: Text('Header'))]);
            }
            return TableRow(cells: [TableCell(child: Text('Row $index'))]);
          },
        ),
      ));

      expect(find.text('Header'), findsOneWidget);
      final headerPos = tester.getTopLeft(find.text('Header'));

      controller.jumpTo(1000);
      await tester.pump();

      expect(find.text('Header'), findsOneWidget);
      expect(tester.getTopLeft(find.text('Header')), headerPos);
    });

    testWidgets('scrolling builds rows further down and drops rows near top',
        (tester) async {
      final controller = ScrollController();
      await tester.pumpWidget(_buildApp(
        Table.builder(
          rowCount: 5000,
          rowHeight: const FixedTableSize(40),
          verticalController: controller,
          rowBuilder: (context, index) {
            return TableRow(cells: [TableCell(child: Text('Row $index'))]);
          },
        ),
      ));

      expect(find.text('Row 0'), findsOneWidget);
      expect(find.text('Row 3000'), findsNothing);

      controller.jumpTo(3000 * 40.0);
      await tester.pump();

      expect(find.text('Row 3000'), findsOneWidget);
      expect(find.text('Row 0'), findsNothing);
    });

    testWidgets('throws when rowHeight is not FixedTableSize', (tester) async {
      await tester.pumpWidget(_buildApp(
        Table.builder(
          rowCount: 10,
          rowHeight: const IntrinsicTableSize(),
          rowBuilder: (context, index) =>
              TableRow(cells: [TableCell(child: Text('Row $index'))]),
        ),
      ));

      expect(tester.takeException(), isA<FlutterError>());
    });

    testWidgets('throws when a column width is IntrinsicTableSize',
        (tester) async {
      await tester.pumpWidget(_buildApp(
        Table.builder(
          rowCount: 10,
          rowHeight: const FixedTableSize(40),
          defaultColumnWidth: const IntrinsicTableSize(),
          rowBuilder: (context, index) =>
              TableRow(cells: [TableCell(child: Text('Row $index'))]),
        ),
      ));

      expect(tester.takeException(), isA<FlutterError>());
    });
  });

  group('ResizableTable.builder', () {
    testWidgets('only builds rows within the visible window', (tester) async {
      int builtCount = 0;
      final controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
      );
      await tester.pumpWidget(_buildApp(
        ResizableTable.builder(
          controller: controller,
          rowCount: 5000,
          rowHeight: const FixedTableSize(40),
          rowBuilder: (context, index) {
            builtCount++;
            return TableRow(cells: [
              TableCell(child: Text('Row $index')),
            ]);
          },
        ),
      ));

      expect(builtCount, lessThan(100));
    });

    testWidgets('column resizing still works', (tester) async {
      final controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
      );
      await tester.pumpWidget(_buildApp(
        ResizableTable.builder(
          controller: controller,
          rowCount: 20,
          rowHeight: const FixedTableSize(40),
          rowBuilder: (context, index) => TableRow(cells: [
            TableCell(child: Text('R$index C0')),
            TableCell(child: Text('R$index C1')),
          ]),
        ),
      ));

      expect(controller.getColumnWidth(0), 100);
      controller.resizeColumn(0, 150);
      await tester.pump();
      expect(controller.getColumnWidth(0), 150);
    });
  });
}
