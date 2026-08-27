import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builds a fixed-width three column table laid out in [textDirection].
Widget _table(
  TextDirection textDirection, {
  FrozenTableData? frozenCells,
  double width = 300,
}) {
  return ShadcnApp(
    home: Scaffold(
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: width,
          child: Table(
            textDirection: textDirection,
            defaultRowHeight: const FixedTableSize(40),
            frozenCells: frozenCells,
            columnWidths: const {
              0: FixedTableSize(100),
              1: FixedTableSize(100),
              2: FixedTableSize(100),
            },
            rows: const [
              TableRow(
                cells: [
                  TableCell(child: Text('first')),
                  TableCell(child: Text('second')),
                  TableCell(child: Text('third')),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('Table directionality', () {
    testWidgets('lays the first column out on the left under LTR', (
      tester,
    ) async {
      await tester.pumpWidget(_table(TextDirection.ltr));
      await tester.pumpAndSettle();

      expect(
        tester.getTopLeft(find.text('first')).dx,
        lessThan(tester.getTopLeft(find.text('second')).dx),
      );
      expect(
        tester.getTopLeft(find.text('second')).dx,
        lessThan(tester.getTopLeft(find.text('third')).dx),
      );
    });

    testWidgets('lays the first column out on the right under RTL', (
      tester,
    ) async {
      await tester.pumpWidget(_table(TextDirection.rtl));
      await tester.pumpAndSettle();

      expect(
        tester.getTopLeft(find.text('first')).dx,
        greaterThan(tester.getTopLeft(find.text('second')).dx),
      );
      expect(
        tester.getTopLeft(find.text('second')).dx,
        greaterThan(tester.getTopLeft(find.text('third')).dx),
      );
    });

    testWidgets('mirrors column positions rather than reindexing them', (
      tester,
    ) async {
      await tester.pumpWidget(_table(TextDirection.ltr));
      await tester.pumpAndSettle();
      final ltr = <String, Rect>{
        for (final label in ['first', 'second', 'third'])
          label: tester.getRect(find.text(label)),
      };

      await tester.pumpWidget(_table(TextDirection.rtl));
      await tester.pumpAndSettle();

      for (final label in ['first', 'second', 'third']) {
        final rtl = tester.getRect(find.text(label));
        // Each cell keeps the width its own column index asked for, and lands
        // the same distance from the opposite edge.
        expect(
          rtl.width,
          closeTo(ltr[label]!.width, 0.01),
          reason: '$label should keep its column width',
        );
        expect(
          300 - rtl.right,
          closeTo(ltr[label]!.left, 0.01),
          reason: '$label should mirror across the table',
        );
      }
    });

    testWidgets('takes the direction from the ambient Directionality', (
      tester,
    ) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 300,
                  child: Table(
                    defaultRowHeight: const FixedTableSize(40),
                    columnWidths: const {
                      0: FixedTableSize(100),
                      1: FixedTableSize(100),
                    },
                    rows: const [
                      TableRow(
                        cells: [
                          TableCell(child: Text('first')),
                          TableCell(child: Text('second')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getTopLeft(find.text('first')).dx,
        greaterThan(tester.getTopLeft(find.text('second')).dx),
      );
    });

    testWidgets('freezes the first column against the right edge under RTL', (
      tester,
    ) async {
      // The viewport is narrower than the table, so column 0 is frozen and
      // must pin to the logical start — the right edge in RTL.
      await tester.pumpWidget(
        _table(
          TextDirection.rtl,
          frozenCells: const FrozenTableData(frozenColumns: [TableRef(0)]),
        ),
      );
      await tester.pumpAndSettle();

      final frozen = tester.getRect(find.text('first'));
      final table = tester.getRect(find.byType(Table));
      expect(frozen.right, closeTo(table.right, 0.01));
    });
  });
}
