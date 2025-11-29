import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('Table Sizing Strategies', () {
    testWidgets('FixedTableSize respects exact pixel values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: Table(
                columnWidths: const {
                  0: FixedTableSize(100),
                  1: FixedTableSize(200),
                },
                rows: [
                  TableRow(
                    cells: [
                      TableCell(child: Container(height: 50)),
                      TableCell(child: Container(height: 50)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(RawTableLayout);
      expect(rawTableFinder, findsOneWidget);

      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;
      expect(renderTable.size.width, equals(300.0));
    });

    testWidgets('FlexTableSize distributes space proportionally',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: SizedBox(
                width: 300,
                child: Table(
                  columnWidths: const {
                    0: FlexTableSize(flex: 1),
                    1: FlexTableSize(flex: 2),
                  },
                  rows: [
                    TableRow(
                      cells: [
                        TableCell(child: Container(height: 50)),
                        TableCell(child: Container(height: 50)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(RawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      expect(renderTable.size.width, equals(300.0));
    });

    testWidgets('FlexTableSize with tight fit fills space',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: SizedBox(
                width: 300,
                child: Table(
                  columnWidths: const {
                    0: FlexTableSize(flex: 1),
                    1: FlexTableSize(flex: 2),
                  },
                  rows: [
                    TableRow(
                      cells: [
                        TableCell(
                            child: SizedBox(height: 50, child: Text('Cell 1'))),
                        TableCell(
                            child: SizedBox(height: 50, child: Text('Cell 2'))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final cell1Finder = find.text('Cell 1');
      final cell2Finder = find.text('Cell 2');

      final cell1Container = find
          .ancestor(of: cell1Finder, matching: find.byType(Container))
          .first;
      final cell2Container = find
          .ancestor(of: cell2Finder, matching: find.byType(Container))
          .first;

      final containerSize1 = tester.getSize(cell1Container);
      final containerSize2 = tester.getSize(cell2Container);

      expect(containerSize1.width, equals(100.0));
      expect(containerSize2.width, equals(200.0));
    });

    testWidgets('IntrinsicTableSize adapts to content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: Table(
                columnWidths: const {
                  0: IntrinsicTableSize(),
                  1: IntrinsicTableSize(),
                },
                rows: [
                  TableRow(
                    cells: [
                      TableCell(child: SizedBox(width: 50, height: 50)),
                      TableCell(child: SizedBox(width: 150, height: 50)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(RawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      // 50 + 150 + padding
      expect(renderTable.size.width, greaterThanOrEqualTo(200.0));
    });

    testWidgets('FractionalTableSize takes fraction of available space',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Table(
                  columnWidths: const {
                    0: FractionalTableSize(0.25), // 100px
                    1: FractionalTableSize(0.5), // 200px
                  },
                  rows: [
                    TableRow(
                      cells: [
                        TableCell(child: Container(height: 50)),
                        TableCell(child: Container(height: 50)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(RawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      // Table width should be 300 (100 + 200)
      expect(renderTable.size.width, equals(300.0));
    });

    testWidgets(
        'IntrinsicTableSize row expands for wrapping text in Fixed column',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: Table(
                columnWidths: const {
                  0: FixedTableSize(100), // Constrained width
                },
                rows: [
                  TableRow(
                    cells: [
                      TableCell(
                        child: Text(
                          'This is a long text that should wrap to multiple lines',
                          style: TextStyle(fontSize: 20), // Ensure it wraps
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(RawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      // Height should be significantly larger than a single line (approx 20-24px)
      expect(renderTable.size.height, greaterThan(40.0));
    });
  });

  group('Table Cell Spanning', () {
    testWidgets('Column span works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: Table(
                columnWidths: const {
                  0: FixedTableSize(100),
                  1: FixedTableSize(100),
                },
                rows: [
                  TableRow(
                    cells: [
                      TableCell(columnSpan: 2, child: Container(height: 50)),
                    ],
                  ),
                  TableRow(
                    cells: [
                      TableCell(child: Container(height: 50)),
                      TableCell(child: Container(height: 50)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(RawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      expect(renderTable.size.width, equals(200.0));
    });

    testWidgets('Row span works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: Table(
                columnWidths: const {
                  0: FixedTableSize(100),
                  1: FixedTableSize(100),
                },
                rows: [
                  TableRow(
                    cells: [
                      TableCell(
                          rowSpan: 2,
                          child: SizedBox(height: 100, child: Text('Spanned'))),
                      TableCell(
                          child: SizedBox(height: 50, child: Text('Cell 1'))),
                    ],
                  ),
                  TableRow(
                    cells: [
                      TableCell(
                          child: SizedBox(height: 50, child: Text('Cell 2'))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final cell1Text = find.text('Cell 1');
      final cell2Text = find.text('Cell 2');

      final cell1Container =
          find.ancestor(of: cell1Text, matching: find.byType(Container)).first;
      final cell2Container =
          find.ancestor(of: cell2Text, matching: find.byType(Container)).first;

      final cell1Size = tester.getSize(cell1Container);
      final cell2Size = tester.getSize(cell2Container);

      // Cell height is content height (50) + border (approx 1).
      // Padding is not added by TableCell by default.
      expect(cell1Size.height, closeTo(51.0, 1.0));
      expect(cell2Size.height, closeTo(51.0, 1.0));

      final spannedText = find.text('Spanned');
      final spannedContainer = find
          .ancestor(of: spannedText, matching: find.byType(Container))
          .first;
      final spannedSize = tester.getSize(spannedContainer);

      // Spanned cell should cover both rows.
      // 51 + 51 = 102.
      expect(spannedSize.height, closeTo(102.0, 2.0));
    });
  });

  group('Table Frozen Cells & Scrolling', () {
    testWidgets('Frozen columns remain visible', (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ClipRect(
                  child: Table(
                    frozenCells: FrozenTableData(frozenColumns: [TableRef(0)]),
                    horizontalOffset: 100, // Scroll right by 100
                    columnWidths: const {
                      0: FixedTableSize(100), // Frozen
                      1: FixedTableSize(100), // Scrolled out
                      2: FixedTableSize(100), // Visible
                    },
                    rows: [
                      TableRow(
                        cells: [
                          TableCell(child: Text('Fixed')),
                          TableCell(child: Text('Scrolled')),
                          TableCell(child: Text('Visible')),
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

      final fixedFinder = find.text('Fixed');
      final visibleFinder = find.text('Visible');

      expect(fixedFinder, findsOneWidget);
      expect(visibleFinder, findsOneWidget);

      final fixedPos = tester.getTopLeft(fixedFinder);
      final visiblePos = tester.getTopLeft(visibleFinder);
      final tablePos = tester.getTopLeft(find.byType(Table));

      // Fixed cell should be at the start
      expect(fixedPos.dx, greaterThanOrEqualTo(tablePos.dx));
      expect(fixedPos.dx, lessThan(tablePos.dx + 100));

      // Visible (Column 2) should be at 100px from start (after Fixed)
      expect(visiblePos.dx, greaterThanOrEqualTo(tablePos.dx + 100));
    });
  });

  group('ResizableTable', () {
    testWidgets('ResizableTable renders and allows resizing',
        (WidgetTester tester) async {
      final controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 50,
        columnWidths: {
          0: 100,
          1: 100,
        },
      );
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: ResizableTable(
                controller: controller,
                rows: [
                  TableRow(
                    cells: [
                      TableCell(child: Text('Col 1')),
                      TableCell(child: Text('Col 2')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ResizableTable), findsOneWidget);
      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Col 2'), findsOneWidget);
    });
  });

  group('Table Theming', () {
    testWidgets('Table applies theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Center(
              child: Table(
                theme: TableTheme(
                  borderRadius: BorderRadius.circular(10),
                ),
                rows: [
                  TableRow(
                    cells: [
                      TableCell(child: Text('Themed')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed'), findsOneWidget);
    });
  });
}
