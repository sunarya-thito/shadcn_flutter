import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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
  const TreeTheme({
    this.branchLine,
    this.padding,
    this.expandIcon,
    this.allowMultiSelect,
    this.recursiveSelection,
  });

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
  TreeTheme copyWith({
    ValueGetter<BranchLine?>? branchLine,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<bool?>? expandIcon,
    ValueGetter<bool?>? allowMultiSelect,
    ValueGetter<bool?>? recursiveSelection,
  }) {
    return TreeTheme(
      branchLine: branchLine == null ? this.branchLine : branchLine(),
      padding: padding == null ? this.padding : padding(),
      expandIcon: expandIcon == null ? this.expandIcon : expandIcon(),
      allowMultiSelect:
          allowMultiSelect == null ? this.allowMultiSelect : allowMultiSelect(),
      recursiveSelection: recursiveSelection == null
          ? this.recursiveSelection
          : recursiveSelection(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is TreeTheme &&
      other.branchLine == branchLine &&
      other.padding == padding &&
      other.expandIcon == expandIcon &&
      other.allowMultiSelect == allowMultiSelect &&
      other.recursiveSelection == recursiveSelection;

  @override
  int get hashCode => Object.hash(
      branchLine, padding, expandIcon, allowMultiSelect, recursiveSelection);

  @override
  String toString() =>
      'TreeTheme(branchLine: $branchLine, padding: $padding, expandIcon: $expandIcon, allowMultiSelect: $allowMultiSelect, recursiveSelection: $recursiveSelection)';
}

/// Abstract base class representing a node in a tree structure.
///
/// TreeNode defines the interface for all nodes in the tree hierarchy, providing
/// access to children, expansion state, and selection state. It supports immutable
/// updates through copy methods that return new instances with modified state.
///
/// The generic type parameter [T] represents the data type stored in tree items.
/// TreeNode is implemented by [TreeItem] for data-bearing nodes and [TreeRoot]
/// for the invisible root container.
///
/// Key operations include state updates for expansion and selection, child
/// manipulation, and leaf node detection. All state changes return new instances
/// to maintain immutability.
///
/// Example:
/// ```dart
/// TreeNode<String> node = TreeItem(
///   data: 'parent',
///   children: [TreeItem(data: 'child1'), TreeItem(data: 'child2')],
/// );
///
/// // Expand the node
/// TreeNode<String> expanded = node.updateState(expanded: true);
///
/// // Check if it's a leaf
/// bool isLeaf = node.leaf; // false, has children
/// ```
abstract class TreeNode<T> {
  /// List of child nodes belonging to this node.
  ///
  /// Returns: `List<TreeNode<T>>`. An empty list indicates a leaf node with no children.
  /// The list defines the hierarchical structure beneath this node.
  List<TreeNode<T>> get children;

  /// Whether this node is currently expanded to show its children.
  ///
  /// Returns: `bool`. True when the node is expanded and children are visible,
  /// false when collapsed. Root nodes are always considered expanded.
  bool get expanded;

  /// Whether this node is currently selected.
  ///
  /// Returns: `bool`. True when the node is part of the current selection,
  /// false otherwise. Selection affects visual appearance and behavior.
  bool get selected;

  /// Whether this node is a leaf (has no children).
  ///
  /// Returns: `bool`. True when [children] is empty, false when the node has child nodes.
  /// Convenient property for determining if a node can be expanded.
  bool get leaf => children.isEmpty;

  /// Creates a new instance with updated expansion and/or selection state.
  ///
  /// Returns a new TreeNode instance with the specified state changes while
  /// preserving all other properties. This maintains immutability of tree structures.
  ///
  /// Parameters:
  /// - [expanded] (bool?, optional): New expansion state, or null to keep current
  /// - [selected] (bool?, optional): New selection state, or null to keep current
  ///
  /// Returns: A new `TreeNode<T>` instance with updated state
  ///
  /// Example:
  /// ```dart
  /// TreeNode<String> expandedNode = node.updateState(expanded: true);
  /// TreeNode<String> selectedNode = node.updateState(selected: true);
  /// TreeNode<String> both = node.updateState(expanded: true, selected: true);
  /// ```
  TreeNode<T> updateState({
    bool? expanded,
    bool? selected,
  });

  /// Creates a new instance with updated children list.
  ///
  /// Returns a new TreeNode instance with the specified children while preserving
  /// all other properties including state. Used for structural modifications.
  ///
  /// Parameters:
  /// - [children] (`List<TreeNode<T>>`): New list of child nodes
  ///
  /// Returns: A new `TreeNode<T>` instance with updated children
  ///
  /// Example:
  /// ```dart
  /// List<TreeNode<String>> newChildren = [TreeItem(data: 'new_child')];
  /// TreeNode<String> updated = node.updateChildren(newChildren);
  /// ```
  TreeNode<T> updateChildren(List<TreeNode<T>> children);
}

/// A concrete tree node implementation that holds data and state.
///
/// TreeItem represents a data-bearing node in the tree structure with support
/// for hierarchical organization, expansion/collapse state, and selection state.
/// It implements the immutable pattern where state changes return new instances.
///
/// Each TreeItem contains user data of type [T], a list of child nodes, and
/// boolean flags for expansion and selection state. The class provides equality
/// comparison based on all properties and implements proper hash codes.
///
/// TreeItem supports deep hierarchies through its children list, which can
/// contain other TreeItem instances or TreeRoot containers. The expansion state
/// controls visibility of children in tree views.
///
/// Example:
/// ```dart
/// // Create a simple item
/// TreeItem<String> item = TreeItem(
///   data: 'Document',
///   expanded: true,
///   selected: false,
///   children: [
///     TreeItem(data: 'Chapter 1'),
///     TreeItem(data: 'Chapter 2'),
///   ],
/// );
///
/// // Update its state
/// TreeItem<String> selected = item.updateState(selected: true);
/// ```
class TreeItem<T> extends TreeNode<T> {
  /// The data value stored in this tree item.
  ///
  /// Type: `T`. This is the actual content that the tree item represents,
  /// such as a string, object, or any other data type.
  final T data;

  /// List of child nodes beneath this item in the tree hierarchy.
  ///
  /// Type: `List<TreeNode<T>>`. Empty list indicates a leaf node. Children
  /// are only visible when this item's [expanded] state is true.
  @override
  final List<TreeNode<T>> children;

  /// Whether this item is currently expanded to show its children.
  ///
  /// Type: `bool`. When true, child nodes are visible in tree views.
  /// When false, children are hidden but still present in the data structure.
  @override
  final bool expanded;

  /// Whether this item is currently selected.
  ///
  /// Type: `bool`. Selection affects visual appearance and can trigger
  /// recursive selection of children depending on tree configuration.
  @override
  final bool selected;

  /// Creates a [TreeItem] with the specified data and configuration.
  ///
  /// Constructs a tree item node with user data and optional children,
  /// expansion state, and selection state.
  ///
  /// Parameters:
  /// - [data] (T, required): The data value to store in this tree item
  /// - [children] (`List<TreeNode<T>>`, default: []): Child nodes list
  /// - [expanded] (bool, default: false): Initial expansion state
  /// - [selected] (bool, default: false): Initial selection state
  ///
  /// Example:
  /// ```dart
  /// // Simple leaf item
  /// TreeItem<String> leaf = TreeItem(data: 'Leaf Node');
  ///
  /// // Parent with children
  /// TreeItem<String> parent = TreeItem(
  ///   data: 'Parent Node',
  ///   expanded: true,
  ///   children: [
  ///     TreeItem(data: 'Child 1'),
  ///     TreeItem(data: 'Child 2'),
  ///   ],
  /// );
  /// ```
  TreeItem({
    required this.data,
    this.children = const [],
    this.expanded = false,
    this.selected = false,
  });

  @override
  TreeItem<T> updateState({
    bool? expanded,
    bool? selected,
  }) {
    return TreeItem(
      data: data,
      children: children,
      expanded: expanded ?? this.expanded,
      selected: selected ?? this.selected,
    );
  }

  @override
  TreeItem<T> updateChildren(List<TreeNode<T>> children) {
    return TreeItem(
      data: data,
      children: children,
      expanded: expanded,
      selected: selected,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TreeItem<T> &&
        other.data == data &&
        listEquals(other.children, children) &&
        other.expanded == expanded &&
        other.selected == selected;
  }

  @override
  int get hashCode {
    return Object.hash(data, children, expanded, selected);
  }

  @override
  String toString() {
    return 'TreeItem(data: $data, children: $children, expanded: $expanded, selected: $selected)';
  }
}

/// A special tree node that serves as an invisible root container.
///
/// TreeRoot represents the invisible root of a tree structure that contains
/// other tree nodes but doesn't appear in the visual tree. It's always considered
/// expanded and never selected, serving purely as a container for organizing
/// multiple top-level tree items.
///
/// This is useful when you need to group multiple tree items under a common
/// parent without showing that parent in the tree view. All children of a
/// TreeRoot appear at the top level of the tree.
///
/// TreeRoot maintains immutability like other tree nodes, but state update
/// operations (expanded/selected) have no effect since these properties are
/// fixed by design.
///
/// Example:
/// ```dart
/// TreeRoot<String> root = TreeRoot(
///   children: [
///     TreeItem(data: 'First Section'),
///     TreeItem(data: 'Second Section'),
///     TreeItem(data: 'Third Section'),
///   ],
/// );
///
/// // Root is always expanded and never selected
/// print(root.expanded); // true
/// print(root.selected); // false
/// ```
class TreeRoot<T> extends TreeNode<T> {
  /// List of child nodes contained in this root.
  ///
  /// Type: `List<TreeNode<T>>`. These children appear as top-level items
  /// in the tree view since the root itself is invisible.
  @override
  final List<TreeNode<T>> children;

  /// Always returns true since root containers are conceptually always expanded.
  ///
  /// Returns: `bool`. TreeRoot is always expanded to show its children.
  @override
  bool get expanded => true;

  /// Always returns false since root containers cannot be selected.
  ///
  /// Returns: `bool`. TreeRoot can never be selected in tree operations.
  @override
  bool get selected => false;

  /// Creates a [TreeRoot] container with the specified children.
  ///
  /// Constructs an invisible root node that serves as a container for
  /// multiple top-level tree items.
  ///
  /// Parameters:
  /// - [children] (`List<TreeNode<T>>`, required): Child nodes to contain
  ///
  /// Example:
  /// ```dart
  /// TreeRoot<String> root = TreeRoot(
  ///   children: [
  ///     TreeItem(data: 'Item 1'),
  ///     TreeItem(data: 'Item 2'),
  ///     TreeItem(data: 'Item 3'),
  ///   ],
  /// );
  /// ```
  TreeRoot({
    required this.children,
  });

  @override
  TreeRoot<T> updateState({
    bool? expanded,
    bool? selected,
  }) {
    return this;
  }

  @override
  TreeRoot<T> updateChildren(List<TreeNode<T>> children) {
    return TreeRoot(
      children: children,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TreeRoot<T> && listEquals(other.children, children);
  }

  @override
  int get hashCode {
    return children.hashCode;
  }

  @override
  String toString() => 'TreeRoot(children: $children)';
}

/// Represents the visual position of a selected item within a group.
///
/// Used to determine border radius styling for selected tree items
/// when multiple consecutive items are selected.
enum SelectionPosition {
  /// First item in a selection group.
  start,

  /// Middle item in a selection group.
  middle,

  /// Last item in a selection group.
  end,

  /// Single selected item (not part of a group).
  single,
}

/// Reason for a focus change event in tree navigation.
///
/// Used to differentiate between programmatic focus changes and
/// user-initiated focus changes.
enum FocusChangeReason {
  /// Focus changed due to focus scope management.
  focusScope,

  /// Focus changed due to direct user interaction.
  userInteraction,
}

BorderRadius _borderRadiusFromPosition(
    SelectionPosition? position, double value) {
  if (position == SelectionPosition.start) {
    return BorderRadius.vertical(top: Radius.circular(value));
  } else if (position == SelectionPosition.end) {
    return BorderRadius.vertical(bottom: Radius.circular(value));
  } else if (position == SelectionPosition.single) {
    return BorderRadius.all(Radius.circular(value));
  }
  return BorderRadius.zero;
}

/// Data container for rendering a tree node.
///
/// Holds all information needed to display a single tree node including
/// its position, expansion state, and visual styling.
class TreeNodeData<T> {
  /// The tree node being rendered.
  final TreeNode<T> node;

  /// The branch line style for this node.
  final BranchLine indentGuide;

  /// Whether this node is currently expanded.
  final bool expanded;

  /// List of depth information from root to this node.
  final List<TreeNodeDepth> depth;

  /// Whether to show the expand/collapse icon.
  final bool expandIcon;

  /// Callback when focus changes for this node.
  final void Function(FocusChangeReason reason)? onFocusChanged;

  /// Visual position of this node within a selection group.
  SelectionPosition? selectionPosition;

  /// Creates a [TreeNodeData] with the specified properties.
  TreeNodeData(this.depth, this.node, this.indentGuide, this.expanded,
      this.expandIcon, this.onFocusChanged);
}

/// Represents depth information for a tree node.
///
/// Contains index and count information used for rendering
/// indent guides and branch lines.
class TreeNodeDepth {
  /// Index of this child among its siblings (0-based).
  final int childIndex;

  /// Total number of children at this level.
  final int childCount;

  /// Creates a [TreeNodeDepth] with the specified index and count.
  TreeNodeDepth(this.childIndex, this.childCount);
}

/// Function that transforms a tree node, optionally returning a new node.
///
/// Used for operations like updating, replacing, or removing nodes.
/// Return null to remove the node, or return a modified node to replace it.
typedef TreeNodeUnaryOperator<K> = TreeNode<K>? Function(TreeNode<K> node);

/// Function that transforms a tree node with parent context.
///
/// Similar to [TreeNodeUnaryOperator] but provides access to the parent node.
/// Useful for operations that need parent-child relationship information.
typedef TreeNodeUnaryOperatorWithParent<K> = TreeNode<K>? Function(
    TreeNode<K>? parent, TreeNode<K> node);

/// Extension methods for manipulating lists of tree nodes.
///
/// Provides convenience methods for common tree operations like expansion,
/// collapse, selection, and node replacement. All methods return a new list
/// and do not modify the original.
extension TreeNodeListExtension<K> on List<TreeNode<K>> {
  /// Applies an operator to all nodes in the tree.
  ///
  /// Parameters:
  /// - [operator] (`TreeNodeUnaryOperator<K>`, required): Transform function.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with transformed nodes.
  List<TreeNode<K>> replaceNodes(TreeNodeUnaryOperator<K> operator) {
    return TreeView.replaceNodes(this, operator);
  }

  /// Replaces a specific node in the tree.
  ///
  /// Parameters:
  /// - [oldNode] (`TreeNode<K>`, required): Node to replace.
  /// - [newNode] (`TreeNode<K>`, required): Replacement node.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node replaced.
  List<TreeNode<K>> replaceNode(TreeNode<K> oldNode, TreeNode<K> newNode) {
    return TreeView.replaceNode(this, oldNode, newNode);
  }

  /// Replaces a node by its item value.
  ///
  /// Parameters:
  /// - [oldItem] (`K`, required): Item value to find.
  /// - [newItem] (`TreeNode<K>`, required): Replacement node.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item replaced.
  List<TreeNode<K>> replaceItem(K oldItem, TreeNode<K> newItem) {
    return TreeView.replaceItem(this, oldItem, newItem);
  }

  /// Expands all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes expanded.
  List<TreeNode<K>> expandAll() {
    return TreeView.expandAll(this);
  }

  /// Collapses all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes collapsed.
  List<TreeNode<K>> collapseAll() {
    return TreeView.collapseAll(this);
  }

  /// Expands a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to expand.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node expanded.
  List<TreeNode<K>> expandNode(TreeNode<K> target) {
    return TreeView.expandNode(this, target);
  }

  /// Expands a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and expand.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item expanded.
  List<TreeNode<K>> expandItem(K target) {
    return TreeView.expandItem(this, target);
  }

  /// Collapses a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to collapse.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node collapsed.
  List<TreeNode<K>> collapseNode(TreeNode<K> target) {
    return TreeView.collapseNode(this, target);
  }

  /// Collapses a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and collapse.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item collapsed.
  List<TreeNode<K>> collapseItem(K target) {
    return TreeView.collapseItem(this, target);
  }

  /// Gets all selected nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — list of selected nodes.
  List<TreeNode<K>> get selectedNodes {
    return TreeView.getSelectedNodes(this);
  }

  /// Gets all selected item values in the tree.
  ///
  /// Returns: `List<K>` — list of selected item values.
  List<K> get selectedItems {
    return TreeView.getSelectedItems(this);
  }

  /// Selects a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node selected.
  List<TreeNode<K>> selectNode(TreeNode<K> target) {
    return TreeView.selectNode(this, target);
  }

  /// Selects a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item selected.
  List<TreeNode<K>> selectItem(K target) {
    return TreeView.selectItem(this, target);
  }

  /// Deselects a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node deselected.
  List<TreeNode<K>> deselectNode(TreeNode<K> target) {
    return TreeView.deselectNode(this, target);
  }

  /// Deselects a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item deselected.
  List<TreeNode<K>> deselectItem(K target) {
    return TreeView.deselectItem(this, target);
  }

  /// Toggles selection state of a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node selection toggled.
  List<TreeNode<K>> toggleSelectNode(TreeNode<K> target) {
    return TreeView.toggleSelectNode(this, target);
  }

  /// Toggles selection state of multiple nodes.
  ///
  /// Parameters:
  /// - [targets] (`Iterable<TreeNode<K>>`, required): Nodes to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with nodes toggled.
  List<TreeNode<K>> toggleSelectNodes(Iterable<TreeNode<K>> targets) {
    return TreeView.toggleSelectNodes(this, targets);
  }

  /// Toggles selection state of a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item toggled.
  List<TreeNode<K>> toggleSelectItem(K target) {
    return TreeView.toggleSelectItem(this, target);
  }

  /// Toggles selection state of multiple items.
  ///
  /// Parameters:
  /// - [targets] (`Iterable<K>`, required): Item values to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with items toggled.
  List<TreeNode<K>> toggleSelectItems(Iterable<K> targets) {
    return TreeView.toggleSelectItems(this, targets);
  }

  /// Selects all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes selected.
  List<TreeNode<K>> selectAll() {
    return TreeView.selectAll(this);
  }

  /// Deselects all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes deselected.
  List<TreeNode<K>> deselectAll() {
    return TreeView.deselectAll(this);
  }

  /// Toggles selection state of all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all selections toggled.
  List<TreeNode<K>> toggleSelectAll() {
    return TreeView.toggleSelectAll(this);
  }

  /// Selects specific nodes.
  ///
  /// Parameters:
  /// - [nodes] (`Iterable<TreeNode<K>>`, required): Nodes to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with nodes selected.
  List<TreeNode<K>> selectNodes(Iterable<TreeNode<K>> nodes) {
    return TreeView.selectNodes(this, nodes);
  }

  /// Selects nodes by their item values.
  ///
  /// Parameters:
  /// - [items] (`Iterable<K>`, required): Item values to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with items selected.
  List<TreeNode<K>> selectItems(Iterable<K> items) {
    return TreeView.selectItems(this, items);
  }

  /// Deselects specific nodes.
  ///
  /// Parameters:
  /// - [nodes] (`Iterable<TreeNode<K>>`, required): Nodes to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with nodes deselected.
  List<TreeNode<K>> deselectNodes(Iterable<TreeNode<K>> nodes) {
    return TreeView.deselectNodes(this, nodes);
  }

  /// Deselects nodes by their item values.
  ///
  /// Parameters:
  /// - [items] (`Iterable<K>`, required): Item values to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with items deselected.
  List<TreeNode<K>> deselectItems(Iterable<K> items) {
    return TreeView.deselectItems(this, items);
  }

  /// Sets the selected nodes, replacing current selection.
  ///
  /// Parameters:
  /// - [nodes] (`Iterable<TreeNode<K>>`, required): Nodes to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with only specified nodes selected.
  List<TreeNode<K>> setSelectedNodes(Iterable<TreeNode<K>> nodes) {
    return TreeView.setSelectedNodes(this, nodes);
  }

  /// Sets the selected items by value, replacing current selection.
  ///
  /// Parameters:
  /// - [items] (`Iterable<K>`, required): Item values to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with only specified items selected.
  List<TreeNode<K>> setSelectedItems(Iterable<K> items) {
    return TreeView.setSelectedItems(this, items);
  }

  /// Applies an operator to all nodes with parent context.
  ///
  /// Parameters:
  /// - [operator] (`TreeNodeUnaryOperatorWithParent<K>`, required): Transform function with parent.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with transformed nodes.
  List<TreeNode<K>> replaceNodesWithParent(
      TreeNodeUnaryOperatorWithParent<K> operator) {
    return TreeView.replaceNodesWithParent(this, operator);
  }

  /// Updates selection state based on recursive selection rules.
  ///
  /// Ensures parent-child selection consistency when recursive selection is enabled.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with updated selection state.
  List<TreeNode<K>> updateRecursiveSelection() {
    return TreeView.updateRecursiveSelection(this);
  }
}

/// Callback invoked when tree node selection changes.
///
/// Parameters:
/// - [selectedNodes]: The nodes affected by the selection change
/// - [multiSelect]: Whether the operation allows multiple selection
/// - [selected]: Whether the nodes are being selected (true) or deselected (false)
typedef TreeNodeSelectionChanged<T> = void Function(
    List<TreeNode<T>> selectedNodes, bool multiSelect, bool selected);

/// Default handler for tree node selection changes.
///
/// Manages selection state updates by toggling, adding, or setting
/// selected nodes based on selection mode.
///
/// Example:
/// ```dart
/// final handler = TreeSelectionDefaultHandler(nodes, (updated) {
///   setState(() => nodes = updated);
/// });
/// ```
class TreeSelectionDefaultHandler<T> {
  /// The current list of tree nodes.
  final List<TreeNode<T>> nodes;

  /// Callback when selection state changes.
  final ValueChanged<List<TreeNode<T>>> onChanged;

  /// Creates a [TreeSelectionDefaultHandler].
  TreeSelectionDefaultHandler(this.nodes, this.onChanged);

  /// Handles a selection change event.
  ///
  /// Parameters:
  /// - [selectedNodes]: Nodes to select or deselect
  /// - [multiSelect]: Whether multi-selection is enabled
  /// - [selected]: Whether to select (true) or deselect (false)
  void call(List<TreeNode<T>> selectedNodes, bool multiSelect, bool selected) {
    if (multiSelect) {
      if (selected) {
        onChanged(nodes.selectNodes(selectedNodes));
      } else {
        onChanged(nodes.deselectNodes(selectedNodes));
      }
    } else {
      onChanged(nodes.setSelectedNodes(selectedNodes));
    }
  }
}

/// Default handler for tree item expand/collapse operations.
///
/// Manages the expansion state of tree nodes when users interact
/// with expand/collapse controls.
///
/// Example:
/// ```dart
/// final handler = TreeItemExpandDefaultHandler(nodes, targetNode, (updated) {
///   setState(() => nodes = updated);
/// });
/// ```
class TreeItemExpandDefaultHandler<T> {
  /// The current list of tree nodes.
  final List<TreeNode<T>> nodes;

  /// Callback when expansion state changes.
  final ValueChanged<List<TreeNode<T>>> onChanged;

  /// The target node to expand or collapse.
  final TreeNode<T> target;

  /// Creates a [TreeItemExpandDefaultHandler].
  TreeItemExpandDefaultHandler(this.nodes, this.target, this.onChanged);

  /// Handles an expand/collapse event.
  ///
  /// Parameters:
  /// - [expanded]: Whether to expand (true) or collapse (false) the node
  void call(bool expanded) {
    if (expanded) {
      onChanged(nodes.expandNode(target));
    } else {
      onChanged(nodes.collapseNode(target));
    }
  }
}

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
  /// Creates a default selection changed handler for tree nodes.
  ///
  /// Returns a handler that manages node selection state changes in a tree view.
  /// The handler updates the tree structure when selection changes occur.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Current tree node list
  /// - [onChanged] (`ValueChanged<List<TreeNode<K>>>`, required): Callback when nodes change
  ///
  /// Returns a `TreeNodeSelectionChanged<K>` function that handles selection changes.
  static TreeNodeSelectionChanged<K> defaultSelectionHandler<K>(
      List<TreeNode<K>> nodes, ValueChanged<List<TreeNode<K>>> onChanged) {
    return TreeSelectionDefaultHandler(nodes, onChanged).call;
  }

  /// Creates a default expand/collapse handler for tree items.
  ///
  /// Returns a handler that manages the expanded/collapsed state of a specific
  /// tree node. The handler updates the tree structure when expansion changes.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Current tree node list
  /// - [target] (`TreeNode<K>`, required): The node being expanded/collapsed
  /// - [onChanged] (`ValueChanged<List<TreeNode<K>>>`, required): Callback when nodes change
  ///
  /// Returns a `ValueChanged<bool>` function that handles expand/collapse events.
  static ValueChanged<bool> defaultItemExpandHandler<K>(List<TreeNode<K>> nodes,
      TreeNode<K> target, ValueChanged<List<TreeNode<K>>> onChanged) {
    return TreeItemExpandDefaultHandler(nodes, target, onChanged).call;
  }

  static List<TreeNode<K>>? _replaceNodes<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperator<K> operator) {
    List<TreeNode<K>> newNodes = List.from(nodes);
    bool changed = false;
    for (int i = 0; i < newNodes.length; i++) {
      final node = newNodes[i];
      var newNode = operator(node);
      List<TreeNode<K>>? newChildren =
          _replaceNodes((newNode ?? node).children, operator);
      if (newChildren != null) {
        newNode = (newNode ?? node).updateChildren(newChildren);
      }
      if (newNode != null) {
        newNodes[i] = newNode;
        changed = true;
      }
    }
    return changed ? newNodes : null;
  }

  static List<TreeNode<K>>? _replaceNodesWithParent<K>(TreeNode<K>? parent,
      List<TreeNode<K>> nodes, TreeNodeUnaryOperatorWithParent<K> operator) {
    List<TreeNode<K>> newNodes = List.from(nodes);
    bool changed = false;
    for (int i = 0; i < newNodes.length; i++) {
      final node = newNodes[i];
      var newNode = operator(parent, node);
      List<TreeNode<K>>? newChildren = _replaceNodesWithParent(
          newNode ?? node, (newNode ?? node).children, operator);
      if (newChildren != null) {
        newNode = (newNode ?? node).updateChildren(newChildren);
      }
      if (newNode != null) {
        newNodes[i] = newNode;
        changed = true;
      }
    }
    return changed ? newNodes : null;
  }

  /// Applies a transformation operator to all nodes in a tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [operator] (`TreeNodeUnaryOperator<K>`, required): Transformation function.
  ///
  /// Returns: `List<TreeNode<K>>` — transformed tree.
  static List<TreeNode<K>> replaceNodes<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperator<K> operator) {
    return _replaceNodes(nodes, operator) ?? nodes;
  }

  /// Applies a transformation operator to all nodes with parent context.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [operator] (`TreeNodeUnaryOperatorWithParent<K>`, required): Transformation function.
  ///
  /// Returns: `List<TreeNode<K>>` — transformed tree.
  static List<TreeNode<K>> replaceNodesWithParent<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperatorWithParent<K> operator) {
    return _replaceNodesWithParent(null, nodes, operator) ?? nodes;
  }

  /// Replaces a specific node in the tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [oldNode] (`TreeNode<K>`, required): Node to replace.
  /// - [newNode] (`TreeNode<K>`, required): Replacement node.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with node replaced.
  static List<TreeNode<K>> replaceNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> oldNode, TreeNode<K> newNode) {
    return replaceNodes(nodes, (node) {
      return node == oldNode ? newNode : null;
    });
  }

  /// Replaces a node by matching its item value.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [oldItem] (`K`, required): Item value to find.
  /// - [newItem] (`TreeNode<K>`, required): Replacement node.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with item replaced.
  static List<TreeNode<K>> replaceItem<K>(
      List<TreeNode<K>> nodes, K oldItem, TreeNode<K> newItem) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == oldItem) {
        return newItem;
      }
      return null;
    });
  }

  /// Updates selection state to maintain parent-child consistency.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with updated selection.
  static List<TreeNode<K>> updateRecursiveSelection<K>(
      List<TreeNode<K>> nodes) {
    return replaceNodesWithParent(nodes, (parent, node) {
      if (node is TreeItem<K> &&
          !node.selected &&
          parent != null &&
          parent.selected) {
        return node.updateState(selected: true);
      }
      return null;
    });
  }

  /// Gets all selected nodes from the tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<TreeNode<K>>` — selected nodes.
  static List<TreeNode<K>> getSelectedNodes<K>(List<TreeNode<K>> nodes) {
    return nodes.where((node) => node.selected).toList();
  }

  /// Gets all selected item values from the tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<K>` — selected item values.
  static List<K> getSelectedItems<K>(List<TreeNode<K>> nodes) {
    return nodes
        .whereType<TreeItem<K>>()
        .where((node) => node.selected)
        .map((node) => node.data)
        .toList();
  }

  /// Expands all nodes in the tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with all nodes expanded.
  static List<TreeNode<K>> expandAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.expanded ? null : node.updateState(expanded: true);
    });
  }

  /// Collapses all nodes in the tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with all nodes collapsed.
  static List<TreeNode<K>> collapseAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.expanded ? node.updateState(expanded: false) : null;
    });
  }

  /// Expands a specific node.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`TreeNode<K>`, required): Node to expand.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with node expanded.
  static List<TreeNode<K>> expandNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(expanded: true) : null;
    });
  }

  /// Expands a node by its item value.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`K`, required): Item value to expand.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with item expanded.
  static List<TreeNode<K>> expandItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target && !node.expanded) {
        return node.updateState(expanded: true);
      }
      return null;
    });
  }

  /// Collapses a specific node.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`TreeNode<K>`, required): Node to collapse.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with node collapsed.
  static List<TreeNode<K>> collapseNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(expanded: false) : null;
    });
  }

  /// Collapses a node by its item value.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`K`, required): Item value to collapse.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with item collapsed.
  static List<TreeNode<K>> collapseItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target) {
        return node.updateState(expanded: false);
      }
      return null;
    });
  }

  /// Selects a specific node.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`TreeNode<K>`, required): Node to select.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with node selected.
  static List<TreeNode<K>> selectNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(selected: true) : null;
    });
  }

  /// Selects a node by its item value.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`K`, required): Item value to select.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with item selected.
  static List<TreeNode<K>> selectItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target) {
        return node.updateState(selected: true);
      }
      return null;
    });
  }

  /// Deselects a specific node.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`TreeNode<K>`, required): Node to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with node deselected.
  static List<TreeNode<K>> deselectNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(selected: false) : null;
    });
  }

  /// Deselects a node by its item value.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`K`, required): Item value to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with item deselected.
  static List<TreeNode<K>> deselectItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target) {
        return node.updateState(selected: false);
      }
      return null;
    });
  }

  /// Toggles selection state of a specific node.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`TreeNode<K>`, required): Node to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with node selection toggled.
  static List<TreeNode<K>> toggleSelectNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(selected: !node.selected) : null;
    });
  }

  /// Toggles selection state of multiple nodes.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [targets] (`Iterable<TreeNode<K>>`, required): Nodes to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with nodes toggled.
  static List<TreeNode<K>> toggleSelectNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> targets) {
    return replaceNodes(nodes, (node) {
      return targets.contains(node)
          ? node.updateState(selected: !node.selected)
          : null;
    });
  }

  /// Toggles selection state of a node by its item value.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [target] (`K`, required): Item value to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with item toggled.
  static List<TreeNode<K>> toggleSelectItem<K>(
      List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target) {
        return node.updateState(selected: !node.selected);
      }
      return null;
    });
  }

  /// Toggles selection state of multiple items.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [targets] (`Iterable<K>`, required): Item values to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with items toggled.
  static List<TreeNode<K>> toggleSelectItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> targets) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && targets.contains(node.data)) {
        return node.updateState(selected: !node.selected);
      }
      return null;
    });
  }

  /// Selects all nodes in the tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with all nodes selected.
  static List<TreeNode<K>> selectAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: true);
    });
  }

  /// Deselects all nodes in the tree.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with all nodes deselected.
  static List<TreeNode<K>> deselectAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: false);
    });
  }

  /// Toggles selection state of all nodes.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with all selections toggled.
  static List<TreeNode<K>> toggleSelectAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: !node.selected);
    });
  }

  /// Selects specific nodes.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [selectedNodes] (`Iterable<TreeNode<K>>`, required): Nodes to select.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with specified nodes selected.
  static List<TreeNode<K>> selectNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> selectedNodes) {
    return replaceNodes(nodes, (node) {
      return selectedNodes.contains(node)
          ? node.updateState(selected: true)
          : null;
    });
  }

  /// Selects nodes by their item values.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [selectedItems] (`Iterable<K>`, required): Item values to select.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with specified items selected.
  static List<TreeNode<K>> selectItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> selectedItems) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && selectedItems.contains(node.data)) {
        return node.updateState(selected: true);
      }
      return null;
    });
  }

  /// Deselects specific nodes.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [deselectedNodes] (`Iterable<TreeNode<K>>`, required): Nodes to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with specified nodes deselected.
  static List<TreeNode<K>> deselectNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> deselectedNodes) {
    return replaceNodes(nodes, (node) {
      return deselectedNodes.contains(node)
          ? node.updateState(selected: false)
          : null;
    });
  }

  /// Deselects nodes by their item values.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [deselectedItems] (`Iterable<K>`, required): Item values to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — tree with specified items deselected.
  static List<TreeNode<K>> deselectItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> deselectedItems) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && deselectedItems.contains(node.data)) {
        return node.updateState(selected: false);
      }
      return null;
    });
  }

  /// Sets the selected nodes, replacing current selection.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [selectedNodes] (`Iterable<TreeNode<K>>`, required): Nodes to select (all others deselected).
  ///
  /// Returns: `List<TreeNode<K>>` — tree with only specified nodes selected.
  static List<TreeNode<K>> setSelectedNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> selectedNodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: selectedNodes.contains(node));
    });
  }

  /// Sets the selected items by value, replacing current selection.
  ///
  /// Parameters:
  /// - [nodes] (`List<TreeNode<K>>`, required): Tree nodes.
  /// - [selectedItems] (`Iterable<K>`, required): Item values to select (all others deselected).
  ///
  /// Returns: `List<TreeNode<K>>` — tree with only specified items selected.
  static List<TreeNode<K>> setSelectedItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> selectedItems) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K>) {
        return node.updateState(selected: selectedItems.contains(node.data));
      }
      return null;
    });
  }

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
  /// - [nodes] (`List<TreeNode<T>>`, required): Root-level tree nodes to display
  /// - [builder] (Widget Function(BuildContext, `TreeItem<T>`), required): Builder for tree items
  /// - [shrinkWrap] (bool, default: false): Whether to size to content
  /// - [controller] (ScrollController?, optional): Scroll controller for the tree
  /// - [branchLine] (BranchLine?, optional): Style for connecting lines
  /// - [padding] (EdgeInsetsGeometry?, optional): Padding around content
  /// - [expandIcon] (bool?, optional): Whether to show expand/collapse icons
  /// - [allowMultiSelect] (bool?, optional): Whether to allow multi-selection
  /// - [focusNode] (FocusScopeNode?, optional): Focus node for keyboard navigation
  /// - [onSelectionChanged] (`TreeNodeSelectionChanged<T>?`, optional): Selection callback
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
  const TreeView({
    super.key,
    required this.nodes,
    required this.builder,
    this.shrinkWrap = false,
    this.controller,
    this.branchLine,
    this.padding,
    this.expandIcon,
    this.allowMultiSelect,
    this.focusNode,
    this.onSelectionChanged,
    this.recursiveSelection,
  });

  @override
  State<TreeView<T>> createState() => _TreeViewState<T>();
}

typedef _TreeWalker<T> = void Function(
    bool parentExpanded, TreeNode<T> node, List<TreeNodeDepth> depth);

typedef _NodeWalker<T> = void Function(TreeNode<T> node);

class _TreeViewState<T> extends State<TreeView<T>> {
  bool _multiSelect = false;
  bool _rangeMultiSelect = false;

  int? _currentFocusedIndex;
  int? _startFocusedIndex;

  void _walkFlattened(
    _TreeWalker<T> walker,
    List<TreeNode<T>> nodes,
    bool parentExpanded,
    List<TreeNodeDepth> depth,
  ) {
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is TreeItem<T>) {
        List<TreeNodeDepth> newDepth = List.from(depth);
        newDepth.add(TreeNodeDepth(i, nodes.length));
        walker(parentExpanded, node, newDepth);
        _walkFlattened(
            walker, node.children, parentExpanded && node.expanded, newDepth);
      } else if (node is TreeRoot<T>) {
        _walkFlattened(walker, node.children, parentExpanded, depth);
      }
    }
  }

  void _walkNodes(_NodeWalker<T> walker, List<TreeNode<T>> nodes) {
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is TreeItem<T>) {
        walker(node);
        _walkNodes(walker, node.children);
      } else if (node is TreeRoot<T>) {
        _walkNodes(walker, node.children);
      }
    }
  }

  void _onChangeSelectionRange(
      List<TreeNodeData<T>> children, int start, int end, bool recursive) {
    if (start > end) {
      final temp = start;
      start = end;
      end = temp;
    }
    final selectedItems = <TreeNode<T>>[];
    for (int i = start; i <= end; i++) {
      if (recursive) {
        _walkNodes((node) {
          selectedItems.add(node);
        }, [children[i].node]);
      } else {
        selectedItems.add(children[i].node);
      }
    }
    widget.onSelectionChanged?.call(selectedItems, false, true);
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<TreeTheme>(context);
    final branchLine =
        widget.branchLine ?? compTheme?.branchLine ?? BranchLine.path;
    final expandIcon = widget.expandIcon ?? compTheme?.expandIcon ?? true;
    final allowMultiSelect =
        widget.allowMultiSelect ?? compTheme?.allowMultiSelect ?? true;
    final recursiveSelection =
        widget.recursiveSelection ?? compTheme?.recursiveSelection ?? true;
    final padding = widget.padding ?? compTheme?.padding;
    List<TreeNodeData<T>> children = [];
    int index = 0;
    _walkFlattened((expanded, node, depth) {
      if (node is! TreeItem<T>) return;
      final int currentIndex = index++;
      children.add(TreeNodeData(
        depth,
        node,
        branchLine,
        expanded,
        expandIcon,
        (reason) {
          if (reason == FocusChangeReason.focusScope) {
            _startFocusedIndex = currentIndex;
            _currentFocusedIndex = currentIndex;
            return;
          }
          _currentFocusedIndex = currentIndex;
          if (_rangeMultiSelect && _startFocusedIndex != null) {
            var start = _startFocusedIndex!;
            var end = _currentFocusedIndex!;
            _onChangeSelectionRange(children, start, end, recursiveSelection);
          } else {
            _startFocusedIndex = currentIndex;
            if (recursiveSelection) {
              final selectedItems = <TreeNode<T>>[];
              _walkNodes((node) {
                selectedItems.add(node);
              }, [node]);
              widget.onSelectionChanged
                  ?.call(selectedItems, _multiSelect, !node.selected);
            } else {
              widget.onSelectionChanged
                  ?.call([node], _multiSelect, !node.selected);
            }
          }
        },
      ));
    }, widget.nodes, true, []);
    int selectedCount = 0;
    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      if (child.node is! TreeItem<T> || !child.node.selected) {
        continue;
      }
      if (child.node.selected) {
        bool isNextSelected = false;
        for (int j = i + 1; j < children.length; j++) {
          if (!children[j].expanded || children[j].node is! TreeItem<T>) {
            continue;
          }
          isNextSelected = children[j].node.selected;
          break;
        }
        if (selectedCount == 0) {
          if (isNextSelected) {
            child.selectionPosition = SelectionPosition.start;
          } else {
            child.selectionPosition = SelectionPosition.single;
            selectedCount = 0;
            continue;
          }
        } else {
          if (isNextSelected) {
            child.selectionPosition = SelectionPosition.middle;
          } else {
            child.selectionPosition = SelectionPosition.end;
            selectedCount = 0;
            continue;
          }
        }
        selectedCount++;
      } else {
        child.selectionPosition = null;
        selectedCount = 0;
      }
    }
    return Shortcuts(
      shortcuts: {
        if (allowMultiSelect) ...{
          // range select
          LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),

          // multi select
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
          LogicalKeySet(
                  LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
          LogicalKeySet(
                  LogicalKeyboardKey.controlRight, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
        }
      },
      child: Actions(
        actions: {
          SelectTreeNodeIntent: CallbackAction(
            onInvoke: (e) {
              if (_currentFocusedIndex != null) {
                final selectedNode = children[_currentFocusedIndex!];
                if (recursiveSelection) {
                  final selectedItems = <TreeNode<T>>[];
                  _walkNodes((node) {
                    selectedItems.add(node);
                  }, [selectedNode.node]);
                  widget.onSelectionChanged?.call(
                      selectedItems, _multiSelect, !selectedNode.node.selected);
                } else {
                  widget.onSelectionChanged?.call([selectedNode.node],
                      _multiSelect, !selectedNode.node.selected);
                }
              }
              return null;
            },
          ),
          DirectionalSelectTreeNodeIntent: CallbackAction(
            onInvoke: (e) {
              final bool down = (e as DirectionalSelectTreeNodeIntent).forward;
              var currentIndex = _currentFocusedIndex ?? 0;
              _startFocusedIndex ??= _currentFocusedIndex;
              var reverseSelection = currentIndex < _startFocusedIndex!;
              var equalSelection = currentIndex == _startFocusedIndex!;
              if (down) {
                for (int i = currentIndex + 1; i < children.length; i++) {
                  if (children[i].node is TreeItem<T> &&
                      children[i].expanded &&
                      (equalSelection
                          ? !children[i].node.selected
                          : (reverseSelection
                              ? children[i].node.selected
                              : !children[i].node.selected))) {
                    _currentFocusedIndex = i;
                    break;
                  }
                }
              } else {
                for (int i = currentIndex - 1; i >= 0; i--) {
                  if (children[i].node is TreeItem<T> &&
                      children[i].expanded &&
                      (equalSelection
                          ? !children[i].node.selected
                          : (reverseSelection
                              ? !children[i].node.selected
                              : children[i].node.selected))) {
                    _currentFocusedIndex = i;
                    break;
                  }
                }
              }
              _onChangeSelectionRange(children, _startFocusedIndex!,
                  _currentFocusedIndex!, recursiveSelection);
              return null;
            },
          ),
        },
        child: FocusScope(
          node: widget.focusNode,
          onKeyEvent: (node, event) {
            if (!allowMultiSelect) return KeyEventResult.ignored;
            if (event is KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.shift ||
                  event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                  event.logicalKey == LogicalKeyboardKey.shiftRight) {
                _rangeMultiSelect = true;
              } else if (event.logicalKey == LogicalKeyboardKey.control ||
                  event.logicalKey == LogicalKeyboardKey.controlLeft ||
                  event.logicalKey == LogicalKeyboardKey.controlRight) {
                _multiSelect = true;
              }
            } else if (event is KeyUpEvent) {
              if (event.logicalKey == LogicalKeyboardKey.shift ||
                  event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                  event.logicalKey == LogicalKeyboardKey.shiftRight) {
                _rangeMultiSelect = false;
              } else if (event.logicalKey == LogicalKeyboardKey.control ||
                  event.logicalKey == LogicalKeyboardKey.controlLeft ||
                  event.logicalKey == LogicalKeyboardKey.controlRight) {
                _multiSelect = false;
              }
            }
            return KeyEventResult.ignored;
          },
          child: ListView(
            padding: padding ?? const EdgeInsets.all(8),
            shrinkWrap: widget.shrinkWrap,
            controller: widget.controller,
            children: children
                .map((data) => Data<TreeNodeData>.inherit(
                      data: data,
                      child: Builder(builder: (context) {
                        return widget.builder(
                            context, data.node as TreeItem<T>);
                      }),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

/// Abstract base class for defining tree branch line styles.
///
/// BranchLine defines how visual connections are drawn between parent and child
/// nodes in tree views. Different implementations provide various visual styles
/// from no lines to complex path-based connections.
///
/// The class provides static instances for common branch line styles:
/// - [BranchLine.none] - No visual connections
/// - [BranchLine.line] - Simple vertical lines
/// - [BranchLine.path] - Connected path lines showing hierarchy
///
/// Custom implementations can be created by extending this class and implementing
/// the [build] method to return appropriate connection widgets.
///
/// Example:
/// ```dart
/// // Using built-in styles
/// TreeView(
///   branchLine: BranchLine.path, // Connected paths
///   // ... other properties
/// );
///
/// // Custom branch line implementation
/// class CustomBranchLine extends BranchLine {
///   @override
///   Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
///     return CustomPaint(painter: MyCustomLinePainter());
///   }
/// }
/// ```
abstract class BranchLine {
  /// Predefined branch line style with no visual connections.
  static const none = IndentGuideNone();

  /// Predefined branch line style with simple vertical lines.
  static const line = IndentGuideLine();

  /// Predefined branch line style with connected path lines.
  static const path = IndentGuidePath();

  /// Builds the visual representation of branch lines for a tree node.
  ///
  /// Creates a widget that shows the connection lines between tree nodes
  /// based on the node's position in the hierarchy and its depth information.
  ///
  /// Parameters:
  /// - [context] (BuildContext): Build context for theme access
  /// - [depth] (`List<TreeNodeDepth>`): Hierarchical depth information
  /// - [index] (int): Index within the current depth level
  ///
  /// Returns: A [Widget] representing the branch line visualization
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index);
}

/// Branch line implementation with no visual connections.
///
/// Displays tree nodes without any connecting lines between parent and child
/// nodes. Use this for a minimal tree appearance.
///
/// Example:
/// ```dart
/// TreeView(
///   branchLine: BranchLine.none,
///   // ...
/// );
/// ```
class IndentGuideNone implements BranchLine {
  /// Creates an [IndentGuideNone].
  const IndentGuideNone();

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    return const SizedBox();
  }
}

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

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    if (index <= 0) {
      return const SizedBox();
    }
    return CustomPaint(
      painter: _PathPainter(
        color: color ?? Theme.of(context).colorScheme.border,
        top: true,
        bottom: true,
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    bool top = true;
    bool right = true;
    bool bottom = true;
    bool left = false;

    if (index >= 0) {
      final current = depth[index];
      if (index != depth.length - 1) {
        right = false;
        if (current.childIndex >= current.childCount - 1) {
          top = false;
        }
      }

      if (current.childIndex >= current.childCount - 1) {
        bottom = false;
      }
    } else {
      left = true;
      top = false;
      bottom = false;
    }

    return CustomPaint(
      painter: _PathPainter(
        color: color ?? Theme.of(context).colorScheme.border,
        top: top,
        right: right,
        bottom: bottom,
        left: left,
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  final Color color;
  final bool top;
  final bool right;
  final bool bottom;
  final bool left;

  _PathPainter({
    required this.color,
    this.top = false,
    this.right = false,
    this.bottom = false,
    this.left = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final path = Path();
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    if (top) {
      path.moveTo(halfWidth, 0);
      path.lineTo(halfWidth, halfHeight);
    }
    if (right) {
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(size.width, halfHeight);
    }
    if (bottom) {
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(halfWidth, size.height);
    }
    if (left) {
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(0, halfHeight);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PathPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.top != top ||
        oldDelegate.right != right ||
        oldDelegate.bottom != bottom;
  }
}

/// A comprehensive tree item widget with interaction, expansion, and selection support.
///
/// TreeItemView provides a complete tree item interface that handles user
/// interaction, visual feedback, expansion/collapse behavior, and keyboard
/// navigation. It's designed to work within a TreeView context but can be
/// used independently for custom tree implementations.
///
/// The widget supports both single and double-click interactions, optional
/// leading and trailing widgets, expandable content, and focus management.
/// It automatically integrates with the tree's selection and expansion state
/// when used within a TreeView.
///
/// Features:
/// - Click and double-click interaction support
/// - Optional expand/collapse functionality for nodes with children
/// - Leading and trailing widget support for icons or actions
/// - Keyboard navigation with arrow keys and space bar
/// - Visual selection feedback with customizable styling
/// - Focus management and accessibility support
/// - Integration with tree branch lines and indentation
///
/// The widget automatically applies appropriate styling based on selection state,
/// focus state, and tree depth. It handles the visual representation of tree
/// hierarchy through indentation and branch line integration.
///
/// Example:
/// ```dart
/// TreeItemView(
///   leading: Icon(isDirectory ? Icons.folder : Icons.insert_drive_file),
///   trailing: PopupMenuButton(items: contextMenuItems),
///   expandable: hasChildren,
///   onPressed: () => selectItem(item),
///   onDoublePressed: () => openItem(item),
///   onExpand: (expanded) => toggleExpansion(item, expanded),
///   child: Text(item.name),
/// )
/// ```
class TreeItemView extends StatefulWidget {
  /// The main content widget for this tree item.
  ///
  /// Type: `Widget`. This widget represents the primary content of the tree item,
  /// typically text or a combination of text and icons.
  final Widget child;

  /// Optional widget displayed at the leading edge of the item.
  ///
  /// Type: `Widget?`. Commonly used for icons that represent the item type,
  /// such as folder or file icons. Positioned before the main content.
  final Widget? leading;

  /// Optional widget displayed at the trailing edge of the item.
  ///
  /// Type: `Widget?`. Commonly used for action buttons, status indicators,
  /// or context menus. Positioned after the main content.
  final Widget? trailing;

  /// Callback invoked when the tree item is pressed/clicked.
  ///
  /// Type: `VoidCallback?`. Called for single-click interactions. If null,
  /// the item will not respond to press gestures.
  final VoidCallback? onPressed;

  /// Callback invoked when the tree item is double-pressed/double-clicked.
  ///
  /// Type: `VoidCallback?`. Called for double-click interactions. If null,
  /// the item will not respond to double-click gestures.
  final VoidCallback? onDoublePressed;

  /// Callback invoked when the expand/collapse state should change.
  ///
  /// Type: `ValueChanged<bool>?`. Called with the desired expansion state
  /// when the user interacts with expand controls or uses keyboard shortcuts.
  final ValueChanged<bool>? onExpand;

  /// Whether this item can be expanded to show children.
  ///
  /// Type: `bool?`. If null, determined automatically based on whether the
  /// tree node has children. When true, expand/collapse controls are shown.
  final bool? expandable;

  /// Optional focus node for keyboard navigation and focus management.
  ///
  /// Type: `FocusNode?`. If null, a focus node is created automatically.
  /// Allows external control of focus state for this tree item.
  final FocusNode? focusNode;

  /// Creates a [TreeItemView] with comprehensive tree item functionality.
  ///
  /// Configures a tree item widget with interaction support, optional expansion,
  /// and customizable leading/trailing elements.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): Main content widget for the tree item
  /// - [leading] (Widget?, optional): Widget displayed before the content
  /// - [trailing] (Widget?, optional): Widget displayed after the content
  /// - [onPressed] (VoidCallback?, optional): Callback for press/click events
  /// - [onDoublePressed] (VoidCallback?, optional): Callback for double-click events
  /// - [onExpand] (`ValueChanged<bool>?`, optional): Callback for expansion changes
  /// - [expandable] (bool?, optional): Whether the item can be expanded
  /// - [focusNode] (FocusNode?, optional): Focus node for keyboard navigation
  ///
  /// Example:
  /// ```dart
  /// TreeItemView(
  ///   leading: Icon(Icons.folder),
  ///   trailing: Badge(child: Text('3')),
  ///   expandable: true,
  ///   onPressed: () => handleSelection(),
  ///   onDoublePressed: () => handleOpen(),
  ///   onExpand: (expanded) => handleExpansion(expanded),
  ///   child: Text('Project Folder'),
  /// )
  /// ```
  const TreeItemView({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onDoublePressed,
    this.onExpand,
    this.expandable,
    this.focusNode,
  });

  @override
  State<TreeItemView> createState() => _TreeItemViewState();
}

class _TreeItemViewState extends State<TreeItemView> {
  late FocusNode _focusNode;
  final WidgetStatesController _statesController = WidgetStatesController();

  TreeNodeData? _data;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant TreeItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    if (_data != null && _focusNode.hasFocus) {
      _data!.onFocusChanged?.call(FocusChangeReason.focusScope);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newData = Data.maybeOf<TreeNodeData>(context);
    if (_data != newData) {
      _data = newData;
      if (_data != null) {
        _statesController.update(WidgetState.selected, _data!.node.selected);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = _data;
    assert(data != null, 'TreeItemView must be a descendant of TreeView');
    List<Widget> rowChildren = [];
    if (data!.expandIcon) rowChildren.add(SizedBox(width: 8 * scaling));
    for (int i = 0; i < data.depth.length; i++) {
      if (i == 0) {
        continue; // skip the first depth
      }
      if (!data.expandIcon) rowChildren.add(SizedBox(width: 8 * scaling));
      rowChildren.add(SizedBox(
        width: 16 * scaling,
        child: data.indentGuide.build(
          context,
          data.depth,
          i,
        ),
      ));
    }
    List<Widget> subRowChildren = [];
    if (data.expandIcon) {
      if (widget.expandable ?? data.node.children.isNotEmpty) {
        rowChildren.add(
          GestureDetector(
            onTap: () {
              if (widget.onExpand != null) {
                widget.onExpand!(!data.node.expanded);
              }
            },
            child: AnimatedRotation(
              duration: kDefaultDuration,
              turns: data.node.expanded ? 0.25 : 0,
              child: const Icon(Icons.chevron_right).iconSmall(),
            ),
          ),
        );
      } else {
        if (data.depth.length > 1) {
          rowChildren.add(SizedBox(
            width: 16 * scaling,
            child: data.indentGuide.build(
              context,
              data.depth,
              -1,
            ),
          ));
        } else {
          rowChildren.add(SizedBox(
            width: 16 * scaling,
          ));
        }
      }
    }
    if (widget.leading != null) {
      subRowChildren.add(widget.leading!);
      subRowChildren.add(SizedBox(width: 8 * scaling));
    }
    subRowChildren.add(Expanded(child: widget.child));
    if (widget.trailing != null) {
      subRowChildren.add(SizedBox(width: 8 * scaling));
      subRowChildren.add(widget.trailing!);
    }
    rowChildren.add(
      Expanded(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4) * scaling,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: subRowChildren,
          ),
        ),
      ),
    );
    return ExcludeFocus(
      excluding: !data.expanded && !data.node.expanded,
      child: DefaultTextStyle.merge(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        child: AnimatedCrossFade(
          duration: kDefaultDuration,
          firstCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOut,
          crossFadeState: data.expanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          secondChild: const SizedBox(),
          firstChild: IntrinsicHeight(
            child: Clickable(
              focusNode: _focusNode,
              focusOutline: !(_data?.node.selected ?? false),
              disableTransition: true,
              statesController: _statesController,
              shortcuts: {
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty))
                  LogicalKeySet(LogicalKeyboardKey.arrowRight):
                      const ExpandTreeNodeIntent(),
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty))
                  LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                      const CollapseTreeNodeIntent(),
              },
              actions: {
                ActivateIntent: CallbackAction(
                  onInvoke: (e) {
                    if (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty)) {
                      widget.onExpand!(!data.node.expanded);
                    }
                    widget.onPressed?.call();
                    return null;
                  },
                ),
                CollapseTreeNodeIntent: CallbackAction(
                  onInvoke: (e) {
                    if (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty)) {
                      widget.onExpand!(false);
                    }
                    return null;
                  },
                ),
                ExpandTreeNodeIntent: CallbackAction(
                  onInvoke: (e) {
                    if (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty)) {
                      widget.onExpand!(true);
                    }
                    return null;
                  },
                ),
              },
              decoration: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    if (states.contains(WidgetState.focused)) {
                      return BoxDecoration(
                        color: theme.colorScheme.primary.scaleAlpha(0.1),
                        borderRadius: _borderRadiusFromPosition(
                          data.selectionPosition,
                          theme.radiusMd,
                        ),
                      );
                    }
                    return BoxDecoration(
                      color: theme.colorScheme.primary.scaleAlpha(0.05),
                      borderRadius: _borderRadiusFromPosition(
                        data.selectionPosition,
                        theme.radiusMd,
                      ),
                    );
                  }
                  return const BoxDecoration();
                },
              ),
              behavior: HitTestBehavior.translucent,
              mouseCursor: widget.onDoublePressed != null ||
                      widget.onPressed != null ||
                      (widget.onExpand != null &&
                          (widget.expandable ?? data.node.children.isNotEmpty))
                  ? const WidgetStatePropertyAll(SystemMouseCursors.click)
                  : const WidgetStatePropertyAll(SystemMouseCursors.basic),
              onDoubleTap: () {
                if (widget.onDoublePressed != null) {
                  widget.onDoublePressed!();
                }
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty)) {
                  widget.onExpand!(!data.node.expanded);
                }
                _focusNode.requestFocus();
              },
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
                _focusNode.requestFocus();
                _data!.onFocusChanged?.call(FocusChangeReason.userInteraction);
              },
              enabled: widget.onPressed != null ||
                  widget.onDoublePressed != null ||
                  (widget.onExpand != null &&
                      (widget.expandable ?? data.node.children.isNotEmpty)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: rowChildren,
              ),
            ),
          ),
        ).iconSmall(),
      ),
    );
  }
}

/// Intent to expand a tree node.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// expand a collapsed tree node to show its children.
class ExpandTreeNodeIntent extends Intent {
  /// Creates an [ExpandTreeNodeIntent].
  const ExpandTreeNodeIntent();
}

/// Intent to collapse a tree node.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// collapse an expanded tree node to hide its children.
class CollapseTreeNodeIntent extends Intent {
  /// Creates a [CollapseTreeNodeIntent].
  const CollapseTreeNodeIntent();
}

/// Intent to select a tree node.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// select the currently focused tree node.
class SelectTreeNodeIntent extends Intent {
  /// Creates a [SelectTreeNodeIntent].
  const SelectTreeNodeIntent();
}

/// Intent to navigate and select tree nodes directionally.
///
/// Used with Flutter's Actions/Shortcuts system to move focus
/// up or down the tree and optionally select nodes.
class DirectionalSelectTreeNodeIntent extends Intent {
  /// Whether to move forward (true) or backward (false) in the tree.
  final bool forward;

  /// Creates a [DirectionalSelectTreeNodeIntent].
  const DirectionalSelectTreeNodeIntent(this.forward);
}
