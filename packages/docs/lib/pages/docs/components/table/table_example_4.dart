import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates Table.textDirection. Flip the toggle to see the same table laid
// out right-to-left: column 0 moves to the right edge, the frozen first column
// pins there, and horizontal scrolling starts there and runs leftwards.
//
// Column indices never change. columnWidths key 0 and TableRef(0) still mean
// the first column in both directions.

class TableExample4 extends StatefulWidget {
  const TableExample4({super.key});

  @override
  State<TableExample4> createState() => _TableExample4State();
}

class _TableExample4State extends State<TableExample4> {
  bool _rtl = false;

  // Builds a bordered cell; the first column is tinted so it is easy to follow
  // as it moves from one edge to the other.
  TableCell buildCell(String text, {bool highlight = false}) {
    final theme = Theme.of(context);
    return TableCell(
      theme: TableCellTheme(
        border: WidgetStatePropertyAll(
          Border.all(
            color: theme.colorScheme.border,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        backgroundColor:
            highlight ? WidgetStatePropertyAll(theme.colorScheme.muted) : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final direction = _rtl ? TextDirection.rtl : TextDirection.ltr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Checkbox(
              state: _rtl ? CheckboxState.checked : CheckboxState.unchecked,
              onChanged: (state) {
                setState(() {
                  _rtl = state == CheckboxState.checked;
                });
              },
              trailing: const Text('Right-to-left'),
            ),
          ],
        ),
        const Gap(16),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
            overscroll: false,
          ),
          child: SizedBox(
            height: 280,
            child: OutlinedContainer(
              child: ScrollableClient(
                diagonalDragBehavior: DiagonalDragBehavior.free,
                // Reversed so that scroll offset zero is the first column,
                // which under RTL sits at the right edge.
                horizontalDetails: ScrollableDetails.horizontal(reverse: _rtl),
                builder: (context, offset, viewportSize, child) {
                  return Table(
                    textDirection: direction,
                    horizontalOffset: offset.dx,
                    verticalOffset: offset.dy,
                    viewportSize: viewportSize,
                    defaultColumnWidth: const FixedTableSize(150),
                    defaultRowHeight: const FixedTableSize(40),
                    // Row 0 and column 0 stay pinned. Under RTL the frozen
                    // column pins to the right rather than the left.
                    frozenCells: const FrozenTableData(
                      frozenRows: [TableRef(0)],
                      frozenColumns: [TableRef(0)],
                    ),
                    rows: [
                      TableHeader(
                        cells: [
                          buildCell('Invoice', highlight: true),
                          buildCell('Status'),
                          buildCell('Method'),
                          buildCell('Amount'),
                          buildCell('Verification'),
                          buildCell('Last Updated'),
                        ],
                      ),
                      for (final row in const [
                        [
                          'INV001',
                          'Paid',
                          'Credit Card',
                          '250.00',
                          'Verified',
                          '2 hours ago'
                        ],
                        [
                          'INV002',
                          'Pending',
                          'PayPal',
                          '150.00',
                          'Pending',
                          '1 day ago'
                        ],
                        [
                          'INV003',
                          'Unpaid',
                          'Bank Transfer',
                          '350.00',
                          'Unverified',
                          '1 week ago'
                        ],
                        [
                          'INV004',
                          'Paid',
                          'Credit Card',
                          '450.00',
                          'Verified',
                          '2 weeks ago'
                        ],
                        [
                          'INV005',
                          'Paid',
                          'PayPal',
                          '550.00',
                          'Verified',
                          '3 weeks ago'
                        ],
                        [
                          'INV006',
                          'Pending',
                          'Bank Transfer',
                          '200.00',
                          'Pending',
                          '1 month ago'
                        ],
                      ])
                        TableRow(
                          cells: [
                            buildCell(row[0], highlight: true),
                            buildCell(row[1]),
                            buildCell(row[2]),
                            buildCell('\$${row[3]}'),
                            buildCell(row[4]),
                            buildCell(row[5]),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
