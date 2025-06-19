import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableExample3 extends StatefulWidget {
  const TableExample3({super.key});

  @override
  State<TableExample3> createState() => _TableExample3State();
}

class _TableExample3State extends State<TableExample3> {
  TableCell buildCell(String text, [bool alignRight = false]) {
    final theme = Theme.of(context);
    return TableCell(
      theme: TableCellTheme(
        border: WidgetStatePropertyAll(
          Border.all(
            color: theme.colorScheme.border,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignRight ? Alignment.topRight : null,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
        overscroll: false,
      ),
      child: SizedBox(
        height: 400,
        child: OutlinedContainer(
          child: ScrollableClient(
              diagonalDragBehavior: DiagonalDragBehavior.free,
              builder: (context, offset, viewportSize, child) {
                return Table(
                  horizontalOffset: offset.dx,
                  verticalOffset: offset.dy,
                  viewportSize: viewportSize,
                  defaultColumnWidth: const FixedTableSize(150),
                  defaultRowHeight: const FixedTableSize(40),
                  frozenCells: const FrozenTableData(
                    frozenRows: [
                      TableRef(0),
                      TableRef(3),
                    ],
                    frozenColumns: [
                      TableRef(0),
                      TableRef(2),
                    ],
                  ),
                  rows: [
                    TableHeader(
                      cells: [
                        buildCell('Invoice'),
                        buildCell('Status'),
                        buildCell('Method'),
                        buildCell('Amount', true),
                        buildCell('Verification'),
                        buildCell('Last Updated'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV001'),
                        buildCell('Paid'),
                        buildCell('Credit Card'),
                        buildCell('\$250.00', true),
                        buildCell('Verified'),
                        buildCell('2 hours ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV002'),
                        buildCell('Pending'),
                        buildCell('PayPal'),
                        buildCell('\$150.00', true),
                        buildCell('Pending'),
                        buildCell('1 day ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV003'),
                        buildCell('Unpaid'),
                        buildCell('Bank Transfer'),
                        buildCell('\$350.00', true),
                        buildCell('Unverified'),
                        buildCell('1 week ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV004'),
                        buildCell('Paid'),
                        buildCell('Credit Card'),
                        buildCell('\$450.00', true),
                        buildCell('Verified'),
                        buildCell('2 weeks ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV005'),
                        buildCell('Paid'),
                        buildCell('PayPal'),
                        buildCell('\$550.00', true),
                        buildCell('Verified'),
                        buildCell('3 weeks ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV006'),
                        buildCell('Pending'),
                        buildCell('Bank Transfer'),
                        buildCell('\$200.00', true),
                        buildCell('Pending'),
                        buildCell('1 month ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV007'),
                        buildCell('Unpaid'),
                        buildCell('Credit Card'),
                        buildCell('\$300.00', true),
                        buildCell('Unverified'),
                        buildCell('1 year ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV008'),
                        buildCell('Paid'),
                        buildCell('Credit Card'),
                        buildCell('\$250.00', true),
                        buildCell('Verified'),
                        buildCell('2 hours ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV009'),
                        buildCell('Pending'),
                        buildCell('PayPal'),
                        buildCell('\$150.00', true),
                        buildCell('Pending'),
                        buildCell('1 day ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV010'),
                        buildCell('Unpaid'),
                        buildCell('Bank Transfer'),
                        buildCell('\$350.00', true),
                        buildCell('Unverified'),
                        buildCell('1 week ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV011'),
                        buildCell('Paid'),
                        buildCell('Credit Card'),
                        buildCell('\$450.00', true),
                        buildCell('Verified'),
                        buildCell('2 weeks ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV012'),
                        buildCell('Paid'),
                        buildCell('PayPal'),
                        buildCell('\$550.00', true),
                        buildCell('Verified'),
                        buildCell('3 weeks ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV013'),
                        buildCell('Pending'),
                        buildCell('Bank Transfer'),
                        buildCell('\$200.00', true),
                        buildCell('Pending'),
                        buildCell('1 month ago'),
                      ],
                    ),
                    TableRow(
                      cells: [
                        buildCell('INV014'),
                        buildCell('Unpaid'),
                        buildCell('Credit Card'),
                        buildCell('\$300.00', true),
                        buildCell('Unverified'),
                        buildCell('1 year ago'),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
