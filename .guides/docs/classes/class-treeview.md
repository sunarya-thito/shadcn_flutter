---
title: "Class: TreeView"
description: "A comprehensive tree view widget with hierarchical data display and interaction."
---

```dart
/// A comprehensive tree view widget with hierarchical data display and interaction.
///
/// TreeView provides a scrollable tree interface that displays hierarchical data
/// with support for expansion/collapse, multi-selection, keyboard navigation,
/// and visual branch lines. It handles complex tree operations like recursive
/// selection, range selection, and immutable state updates.
///
/// The widget supports both mouse and keyboard interaction including:
/// - Click to select items and toggle expansion
/// - Ctrl+Click for multi-selection  
/// - Shift+Click for range selection
/// - Arrow keys for navigation and selection
/// - Space bar for selection toggle
/// - Left/Right arrows for expand/collapse
///
/// Features:
/// - Hierarchical data display with customizable branch lines
/// - Single and multi-selection modes with recursive selection support
/// - Keyboard navigation and accessibility
/// - Scrollable content with shrink wrap support  
/// - Customizable expand icons and visual styling
/// - Immutable state management with helper methods
/// - Focus management and scope integration
///
/// The tree uses immutable data structures where all modifications return new
/// instances. Helper methods and extensions provide convenient operations for
/// common tree manipulations like expanding, selecting, and filtering nodes.
///
/// Example:
/// ```dart
/// TreeView<String>(
///   nodes: [
///     TreeItem(
///       data: 'Documents',
///       expanded: true,
///       children: [
///         TreeItem(data: 'document1.txt'),
///         TreeItem(data: 'document2.txt'),
///       ],
///     ),
///     TreeItem(data: 'Images'),
///   ],
///   builder: (context, item) => Text(item.data),
///   onSelectionChanged: (selected, multiSelect, isSelected) {
///     // Handle selection changes
///   },
/// )
/// ```
class TreeView<T> extends StatefulWidget {
  static TreeNodeSelectionChanged<K> defaultSelectionHandler<K>(List<TreeNode<K>> nodes, ValueChanged<List<TreeNode<K>>> onChanged);
  static ValueChanged<bool> defaultItemExpandHandler<K>(List<TreeNode<K>> nodes, TreeNode<K> target, ValueChanged<List<TreeNode<K>>> onChanged);
  static List<TreeNode<K>> replaceNodes<K>(List<TreeNode<K>> nodes, TreeNodeUnaryOperator<K> operator);
  static List<TreeNode<K>> replaceNodesWithParent<K>(List<TreeNode<K>> nodes, TreeNodeUnaryOperatorWithParent<K> operator);
  static List<TreeNode<K>> replaceNode<K>(List<TreeNode<K>> nodes, TreeNode<K> oldNode, TreeNode<K> newNode);
  static List<TreeNode<K>> replaceItem<K>(List<TreeNode<K>> nodes, K oldItem, TreeNode<K> newItem);
  static List<TreeNode<K>> updateRecursiveSelection<K>(List<TreeNode<K>> nodes);
  static List<TreeNode<K>> getSelectedNodes<K>(List<TreeNode<K>> nodes);
  static List<K> getSelectedItems<K>(List<TreeNode<K>> nodes);
  static List<TreeNode<K>> expandAll<K>(List<TreeNode<K>> nodes);
  static List<TreeNode<K>> collapseAll<K>(List<TreeNode<K>> nodes);
  static List<TreeNode<K>> expandNode<K>(List<TreeNode<K>> nodes, TreeNode<K> target);
  static List<TreeNode<K>> expandItem<K>(List<TreeNode<K>> nodes, K target);
  static List<TreeNode<K>> collapseNode<K>(List<TreeNode<K>> nodes, TreeNode<K> target);
  static List<TreeNode<K>> collapseItem<K>(List<TreeNode<K>> nodes, K target);
  static List<TreeNode<K>> selectNode<K>(List<TreeNode<K>> nodes, TreeNode<K> target);
  static List<TreeNode<K>> selectItem<K>(List<TreeNode<K>> nodes, K target);
  static List<TreeNode<K>> deselectNode<K>(List<TreeNode<K>> nodes, TreeNode<K> target);
  static List<TreeNode<K>> deselectItem<K>(List<TreeNode<K>> nodes, K target);
  static List<TreeNode<K>> toggleSelectNode<K>(List<TreeNode<K>> nodes, TreeNode<K> target);
  static List<TreeNode<K>> toggleSelectNodes<K>(List<TreeNode<K>> nodes, Iterable<TreeNode<K>> targets);
  static List<TreeNode<K>> toggleSelectItem<K>(List<TreeNode<K>> nodes, K target);
  static List<TreeNode<K>> toggleSelectItems<K>(List<TreeNode<K>> nodes, Iterable<K> targets);
  static List<TreeNode<K>> selectAll<K>(List<TreeNode<K>> nodes);
  static List<TreeNode<K>> deselectAll<K>(List<TreeNode<K>> nodes);
  static List<TreeNode<K>> toggleSelectAll<K>(List<TreeNode<K>> nodes);
  static List<TreeNode<K>> selectNodes<K>(List<TreeNode<K>> nodes, Iterable<TreeNode<K>> selectedNodes);
  static List<TreeNode<K>> selectItems<K>(List<TreeNode<K>> nodes, Iterable<K> selectedItems);
  static List<TreeNode<K>> deselectNodes<K>(List<TreeNode<K>> nodes, Iterable<TreeNode<K>> deselectedNodes);
  static List<TreeNode<K>> deselectItems<K>(List<TreeNode<K>> nodes, Iterable<K> deselectedItems);
  static List<TreeNode<K>> setSelectedNodes<K>(List<TreeNode<K>> nodes, Iterable<TreeNode<K>> selectedNodes);
  static List<TreeNode<K>> setSelectedItems<K>(List<TreeNode<K>> nodes, Iterable<K> selectedItems);
  /// List of tree nodes to display in the tree view.
  ///
  /// Type: `List<TreeNode<T>>`. The root-level nodes that will be rendered
  /// in the tree. Can contain TreeItem instances and TreeRoot containers.
  final List<TreeNode<T>> nodes;
  /// Builder function to create widgets for tree items.
  ///
  /// Type: `Widget Function(BuildContext, TreeItem<T>)`. Called for each
  /// visible tree item to create its visual representation. Receives the
  /// build context and the tree item data.
  final Widget Function(BuildContext context, TreeItem<T> node) builder;
  /// Whether the tree view should size itself to its content.
  ///
  /// Type: `bool`, default: `false`. When true, the tree takes only the space
  /// needed for its content instead of expanding to fill available space.
  final bool shrinkWrap;
  /// Optional scroll controller for the tree's scroll view.
  ///
  /// Type: `ScrollController?`. Allows external control of scrolling behavior
  /// and position within the tree view.
  final ScrollController? controller;
  /// The style of branch lines connecting tree nodes.
  ///
  /// Type: `BranchLine?`. If null, uses the theme's branch line or BranchLine.path.
  /// Controls the visual connections drawn between parent and child nodes.
  final BranchLine? branchLine;
  /// Padding around the tree view content.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses 8 pixels on all sides.
  /// Applied to the entire tree view scroll area.
  final EdgeInsetsGeometry? padding;
  /// Whether to show expand/collapse icons for nodes with children.
  ///
  /// Type: `bool?`. If null, defaults to true from theme. When false,
  /// nodes cannot be visually expanded or collapsed.
  final bool? expandIcon;
  /// Whether multiple tree nodes can be selected simultaneously.
  ///
  /// Type: `bool?`. If null, defaults to true from theme. When false,
  /// selecting a node automatically deselects all others.
  final bool? allowMultiSelect;
  /// Optional focus scope node for keyboard navigation.
  ///
  /// Type: `FocusScopeNode?`. Controls focus behavior within the tree view
  /// for keyboard navigation and accessibility.
  final FocusScopeNode? focusNode;
  /// Callback invoked when node selection changes.
  ///
  /// Type: `TreeNodeSelectionChanged<T>?`. Called with the affected nodes,
  /// whether multi-select mode is active, and the new selection state.
  final TreeNodeSelectionChanged<T>? onSelectionChanged;
  /// Whether selecting a parent node also selects its children.
  ///
  /// Type: `bool?`. If null, defaults to true from theme. When true,
  /// selection operations recursively affect all descendant nodes.
  final bool? recursiveSelection;
  /// Creates a [TreeView] with hierarchical data display and interaction.
  ///
  /// Configures a tree view widget that displays hierarchical data with support
  /// for expansion, selection, keyboard navigation, and visual styling.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [nodes] (List<TreeNode<T>>, required): Root-level tree nodes to display  
  /// - [builder] (Widget Function(BuildContext, TreeItem<T>), required): Builder for tree items
  /// - [shrinkWrap] (bool, default: false): Whether to size to content
  /// - [controller] (ScrollController?, optional): Scroll controller for the tree
  /// - [branchLine] (BranchLine?, optional): Style for connecting lines
  /// - [padding] (EdgeInsetsGeometry?, optional): Padding around content
  /// - [expandIcon] (bool?, optional): Whether to show expand/collapse icons
  /// - [allowMultiSelect] (bool?, optional): Whether to allow multi-selection
  /// - [focusNode] (FocusScopeNode?, optional): Focus node for keyboard navigation
  /// - [onSelectionChanged] (TreeNodeSelectionChanged<T>?, optional): Selection callback
  /// - [recursiveSelection] (bool?, optional): Whether to select children recursively
  ///
  /// Example:
  /// ```dart
  /// TreeView<FileItem>(
  ///   nodes: fileTreeNodes,
  ///   allowMultiSelect: true,
  ///   recursiveSelection: true,
  ///   branchLine: BranchLine.path,
  ///   builder: (context, item) => ListTile(
  ///     leading: Icon(item.data.isDirectory ? Icons.folder : Icons.file_copy),
  ///     title: Text(item.data.name),
  ///     subtitle: Text(item.data.path),
  ///   ),
  ///   onSelectionChanged: (selectedNodes, multiSelect, isSelected) {
  ///     handleSelectionChange(selectedNodes, isSelected);
  ///   },
  /// )
  /// ```
  const TreeView({super.key, required this.nodes, required this.builder, this.shrinkWrap = false, this.controller, this.branchLine, this.padding, this.expandIcon, this.allowMultiSelect, this.focusNode, this.onSelectionChanged, this.recursiveSelection});
  State<TreeView<T>> createState();
}
```
