import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableExample1 extends StatelessWidget {
  const TableExample1({super.key});

  Color generateColor(int col, int row) {
    Random random = Random(col * 100 + row);
    return HSVColor.fromAHSV(1, random.nextInt(360).toDouble(), 6 / 10, 0.3)
        .toColor();
  }

  TableCell buildCell(int col, int row, String name,
      {int colSpan = 1, int rowSpan = 1}) {
    return TableCell(
        column: col,
        row: row,
        columnSpan: colSpan,
        rowSpan: rowSpan,
        child: Container(
          decoration: BoxDecoration(
            color: generateColor(col, row),
            border: Border.all(
                color: Colors.gray, strokeAlign: BorderSide.strokeAlignOutside),
          ),
          // padding: EdgeInsets.all(8),
          child: Text(name, style: TextStyle(color: Colors.white)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      cells: [
        buildCell(0, 0, 'No.', rowSpan: 2),
        buildCell(1, 0, 'Public Information', colSpan: 3),
        buildCell(1, 1, 'Name'),
        buildCell(2, 1, 'Age'),
        buildCell(3, 1, 'Address'),
        buildCell(10, 10, 'Test'),
      ],
    );
  }
}
