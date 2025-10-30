---
title: "Class: TableHeader"
description: "Specialized row for table headers."
---

```dart
/// Specialized row for table headers.
///
/// Extends [TableRow] with default styling appropriate for header rows,
/// including bold text, muted background, and bottom border styling.
///
/// Example:
/// ```dart
/// TableHeader(
///   cells: [
///     TableCell(child: Text('Name')),
///     TableCell(child: Text('Age')),
///     TableCell(child: Text('City')),
///   ],
/// )
/// ```
class TableHeader extends TableRow {
  /// Creates a [TableHeader].
  const TableHeader({required super.cells, super.cellTheme});
  TableCellTheme buildDefaultTheme(BuildContext context);
}
```
