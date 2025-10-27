---
title: "Example: components/table/table_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates ResizableTable with controller defaults (sizes/constraints)
// and thin per-cell borders; users can drag to resize columns/rows.

class TableExample2 extends StatefulWidget {
  const TableExample2({super.key});

  @override
  State<TableExample2> createState() => _TableExample2State();
}

class _TableExample2State extends State<TableExample2> {
  // Builds a single cell with a thin border using the theme's border color.
  // Optionally right-aligns the content (useful for numeric values).
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

  // Controller sets defaults for column/row sizes and min constraints.
  // Users can still drag to resize each column and row at runtime.
  final ResizableTableController controller = ResizableTableController(
    defaultColumnWidth: 150,
    defaultRowHeight: 40,
    defaultHeightConstraint: const ConstrainedTableSize(min: 40),
    defaultWidthConstraint: const ConstrainedTableSize(min: 80),
  );

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      child: ResizableTable(
        controller: controller,
        // A header row followed by regular rows; all cells share the same
        // border/spacing style via buildCell.
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
```
