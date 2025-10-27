---
title: "Example: components/table/table_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a basic Table with a header row and body rows,
// including right-aligned numeric cells for amounts.

class TableExample1 extends StatefulWidget {
  const TableExample1({super.key});

  @override
  State<TableExample1> createState() => _TableExample1State();
}

class _TableExample1State extends State<TableExample1> {
  // Helper to build a header cell with muted, semibold text.
  TableCell buildHeaderCell(String text, [bool alignRight = false]) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignRight ? Alignment.centerRight : null,
        child: Text(text).muted().semiBold(),
      ),
    );
  }

  // Helper to build a regular body cell with optional right alignment.
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
        // Header row: typically use TableHeader, but a TableRow works for simple cases.
        TableRow(
          cells: [
            buildHeaderCell('Invoice'),
            buildHeaderCell('Status'),
            buildHeaderCell('Method'),
            buildHeaderCell('Amount', true),
          ],
        ),
        // Body rows with invoice data.
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
```
