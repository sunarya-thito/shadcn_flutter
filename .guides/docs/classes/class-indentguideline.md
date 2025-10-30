---
title: "Class: IndentGuideLine"
description: "Branch line implementation with simple vertical lines."
---

```dart
/// Branch line implementation with simple vertical lines.
///
/// Displays vertical lines alongside tree nodes to indicate hierarchy levels.
/// Does not draw horizontal connections.
///
/// Example:
/// ```dart
/// TreeView(
///   branchLine: BranchLine.line,
///   // or with custom color:
///   branchLine: IndentGuideLine(color: Colors.blue),
/// );
/// ```
class IndentGuideLine implements BranchLine {
  /// Custom color for the line. If null, uses the theme border color.
  final Color? color;
  /// Creates an [IndentGuideLine] with optional custom color.
  const IndentGuideLine({this.color});
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index);
}
```
