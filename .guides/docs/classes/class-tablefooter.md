---
title: "Class: TableFooter"
description: "Specialized row for table footers."
---

```dart
/// Specialized row for table footers.
///
/// Extends [TableRow] with default styling appropriate for footer rows,
/// including muted background colors and custom hover effects.
///
/// Example:
/// ```dart
/// TableFooter(
///   cells: [
///     TableCell(child: Text('Total: \$100')),
///     TableCell(child: Text('Paid')),
///   ],
/// )
/// ```
class TableFooter extends TableRow {
  /// Creates a [TableFooter].
  const TableFooter({required super.cells, super.cellTheme});
  TableCellTheme buildDefaultTheme(BuildContext context);
}
```
