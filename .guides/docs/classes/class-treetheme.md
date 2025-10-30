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
  /// Creates a theme for tree view components.
  ///
  /// This constructor allows customization of tree visualization and behavior
  /// including branch lines, spacing, icons, and selection modes.
  ///
  /// Parameters:
  /// - [branchLine] (BranchLine?): Visual style for lines connecting tree nodes
  /// - [padding] (EdgeInsetsGeometry?): Padding around tree items
  /// - [expandIcon] (bool?): Whether to show expand/collapse icons
  /// - [allowMultiSelect] (bool?): Whether multiple nodes can be selected simultaneously
  /// - [recursiveSelection] (bool?): Whether selecting parent selects all children
  ///
  /// Example:
  /// ```dart
  /// TreeTheme(
  ///   branchLine: BranchLine.solid,
  ///   padding: EdgeInsets.all(8),
  ///   allowMultiSelect: true,
  /// )
  /// ```
  const TreeTheme({this.branchLine, this.padding, this.expandIcon, this.allowMultiSelect, this.recursiveSelection});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [branchLine] (`ValueGetter<BranchLine?>?`, optional): New branch line style.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding.
  /// - [expandIcon] (`ValueGetter<bool?>?`, optional): New expand icon visibility.
  /// - [allowMultiSelect] (`ValueGetter<bool?>?`, optional): New multi-select setting.
  /// - [recursiveSelection] (`ValueGetter<bool?>?`, optional): New recursive selection setting.
  ///
  /// Returns: A new [TreeTheme] with updated properties.
  TreeTheme copyWith({ValueGetter<BranchLine?>? branchLine, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<bool?>? expandIcon, ValueGetter<bool?>? allowMultiSelect, ValueGetter<bool?>? recursiveSelection});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
