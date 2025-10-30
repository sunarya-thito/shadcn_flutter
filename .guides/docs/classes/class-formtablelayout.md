---
title: "Class: FormTableLayout"
description: "A table-based layout for multiple form fields."
---

```dart
/// A table-based layout for multiple form fields.
///
/// Arranges form fields in a table layout for structured data entry.
class FormTableLayout extends StatelessWidget {
  /// List of form field rows to display in the table.
  final List<FormField> rows;
  /// Vertical spacing between rows.
  final double? spacing;
  /// Creates a [FormTableLayout].
  ///
  /// Parameters:
  /// - [rows] (`List<FormField>`, required): Form fields to arrange in rows.
  /// - [spacing] (`double?`, optional): Custom row spacing.
  const FormTableLayout({super.key, required this.rows, this.spacing});
  Widget build(BuildContext context);
}
```
