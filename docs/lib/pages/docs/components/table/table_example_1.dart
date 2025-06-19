import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableExample1 extends StatefulWidget {
  const TableExample1({super.key});

  @override
  State<TableExample1> createState() => _TableExample1State();
}

class _TableExample1State extends State<TableExample1> {
  TableCell buildHeaderCell(String text, [bool alignRight = false]) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignRight ? Alignment.centerRight : null,
        child: Text(text).muted().semiBold(),
      ),
    );
  }

  TableCell buildCell(String text, [bool alignRight = false]) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignRight ? Alignment.centerRight : null,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      rows: [
        TableRow(
          cells: [
            buildHeaderCell('Invoice'),
            buildHeaderCell('Status'),
            buildHeaderCell('Method'),
            buildHeaderCell('Amount', true),
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
                    const Text('Total'),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: const Text('\$2,300.00').semiBold(),
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
