---
title: "Class: IndentGuidePath"
description: "Branch line implementation with connected path lines."
---

```dart
/// Branch line implementation with connected path lines.
///
/// Displays L-shaped or T-shaped connectors showing the hierarchical
/// structure of the tree. This is the most common branch line style.
///
/// Example:
/// ```dart
/// TreeView(
///   branchLine: BranchLine.path,
///   // or with custom color:
///   branchLine: IndentGuidePath(color: Colors.grey),
/// );
/// ```
class IndentGuidePath implements BranchLine {
  /// Custom color for the path. If null, uses the theme border color.
  final Color? color;
  /// Creates an [IndentGuidePath] with optional custom color.
  const IndentGuidePath({this.color});
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index);
}
```
