import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableExample2 extends StatefulWidget {
  const TableExample2({super.key});

  @override
  State<TableExample2> createState() => _TableExample2State();
}

class _TableExample2State extends State<TableExample2> {
  TableCell buildCell(String text, [bool alignRight = false]) {
    final theme = Theme.of(context);
    return TableCell(
      theme: TableCellTheme(
          border: WidgetStatePropertyAll(Border.all(
        color: theme.colorScheme.border,
      ))),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignRight ? Alignment.topRight : null,
        child: Text(text),
      ),
    );
  }

  final ResizableTableController controller = ResizableTableController(
    defaultColumnWidth: 150,
    defaultRowHeight: 40,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ResizableTable(
      controller: controller,
      theme: ResizableTableTheme(
          tableTheme: TableTheme(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.border),
      )),
      rows: [
        TableHeader(
          cells: [
            buildCell('Invoice'),
            buildCell('Status'),
            buildCell('Method'),
            buildCell('Amount', true),
          ],
        ),
        TableRow(
          cells: [
            buildCell('INV001'),
            buildCell('Paid'),
            buildCell('Credit Card'),
            buildCell('\$250.00', true),
          ],
        ),
        TableRow(
          cells: [
            buildCell('INV002'),
            buildCell('Pending'),
            buildCell('PayPal'),
            buildCell('\$150.00', true),
          ],
        ),
        TableRow(
          cells: [
            buildCell('INV003'),
            buildCell('Unpaid'),
            buildCell('Bank Transfer'),
            buildCell('\$350.00', true),
          ],
        ),
        TableRow(
          cells: [
            buildCell('INV004'),
            buildCell('Paid'),
            buildCell('Credit Card'),
            buildCell('\$450.00', true),
          ],
        ),
        TableRow(
          cells: [
            buildCell('INV005'),
            buildCell('Paid'),
            buildCell('PayPal'),
            buildCell('\$550.00', true),
          ],
        ),
        TableRow(
          cells: [
            buildCell('INV006'),
            buildCell('Pending'),
            buildCell('Bank Transfer'),
            buildCell('\$200.00', true),
          ],
        ),
        TableRow(
          cells: [
            buildCell('INV007'),
            buildCell('Unpaid'),
            buildCell('Credit Card'),
            buildCell('\$300.00', true),
          ],
        ),
        TableFooter(
          cells: [
            TableCell(
              columnSpan: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text('Total'),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('\$2,300.00').semiBold(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
