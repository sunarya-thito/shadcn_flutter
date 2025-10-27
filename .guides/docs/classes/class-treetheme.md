---
title: "Class: TreeTheme"
description: "Theme configuration for [TreeView] appearance and behavior."
---

```dart
/// Theme configuration for [TreeView] appearance and behavior.
///
/// TreeTheme defines the visual styling and behavioral options for tree view
/// components including branch lines, padding, expand icons, and selection modes.
/// All properties are optional and fall back to theme defaults when not specified.
///
/// Example:
/// ```dart
/// ComponentTheme<TreeTheme>(
///   data: TreeTheme(
///     branchLine: BranchLine.path,
///     padding: EdgeInsets.all(12),
///     expandIcon: true,
///     allowMultiSelect: true,
///     recursiveSelection: true,
///   ),
///   child: TreeView(...),
/// )
/// ```
class TreeTheme {
  /// The branch line style for connecting tree nodes.
  ///
  /// Type: `BranchLine?`. If null, uses BranchLine.path. Controls how visual
  /// connections are drawn between parent and child nodes in the tree hierarchy.
  final BranchLine? branchLine;
  /// Padding around the entire tree view content.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses 8 pixels on all sides.
  /// This padding is applied to the scroll view containing all tree items.
  final EdgeInsetsGeometry? padding;
  /// Whether to show expand/collapse icons for nodes with children.
  ///
  /// Type: `bool?`. If null, defaults to true. When false, nodes cannot be
  /// visually expanded or collapsed, though the data structure remains hierarchical.
  final bool? expandIcon;
  /// Whether multiple nodes can be selected simultaneously.
  ///
  /// Type: `bool?`. If null, defaults to true. When false, selecting a node
  /// automatically deselects all other nodes, enforcing single selection mode.
  final bool? allowMultiSelect;
  /// Whether selecting a parent node also selects its children.
  ///
  /// Type: `bool?`. If null, defaults to true. When true, selection operations
  /// recursively affect all descendant nodes.
  final bool? recursiveSelection;
  const TreeTheme({this.branchLine, this.padding, this.expandIcon, this.allowMultiSelect, this.recursiveSelection});
  TreeTheme copyWith({ValueGetter<BranchLine?>? branchLine, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<bool?>? expandIcon, ValueGetter<bool?>? allowMultiSelect, ValueGetter<bool?>? recursiveSelection});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
