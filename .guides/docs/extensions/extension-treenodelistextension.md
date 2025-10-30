---
title: "Extension: TreeNodeListExtension"
description: "Extension methods for manipulating lists of tree nodes."
---

```dart
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
  List<TreeNode<K>> replaceNodes(TreeNodeUnaryOperator<K> operator);
  /// Replaces a specific node in the tree.
  ///
  /// Parameters:
  /// - [oldNode] (`TreeNode<K>`, required): Node to replace.
  /// - [newNode] (`TreeNode<K>`, required): Replacement node.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node replaced.
  List<TreeNode<K>> replaceNode(TreeNode<K> oldNode, TreeNode<K> newNode);
  /// Replaces a node by its item value.
  ///
  /// Parameters:
  /// - [oldItem] (`K`, required): Item value to find.
  /// - [newItem] (`TreeNode<K>`, required): Replacement node.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item replaced.
  List<TreeNode<K>> replaceItem(K oldItem, TreeNode<K> newItem);
  /// Expands all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes expanded.
  List<TreeNode<K>> expandAll();
  /// Collapses all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes collapsed.
  List<TreeNode<K>> collapseAll();
  /// Expands a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to expand.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node expanded.
  List<TreeNode<K>> expandNode(TreeNode<K> target);
  /// Expands a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and expand.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item expanded.
  List<TreeNode<K>> expandItem(K target);
  /// Collapses a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to collapse.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node collapsed.
  List<TreeNode<K>> collapseNode(TreeNode<K> target);
  /// Collapses a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and collapse.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item collapsed.
  List<TreeNode<K>> collapseItem(K target);
  /// Gets all selected nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — list of selected nodes.
  List<TreeNode<K>> get selectedNodes;
  /// Gets all selected item values in the tree.
  ///
  /// Returns: `List<K>` — list of selected item values.
  List<K> get selectedItems;
  /// Selects a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node selected.
  List<TreeNode<K>> selectNode(TreeNode<K> target);
  /// Selects a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item selected.
  List<TreeNode<K>> selectItem(K target);
  /// Deselects a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node deselected.
  List<TreeNode<K>> deselectNode(TreeNode<K> target);
  /// Deselects a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to find and deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item deselected.
  List<TreeNode<K>> deselectItem(K target);
  /// Toggles selection state of a specific node.
  ///
  /// Parameters:
  /// - [target] (`TreeNode<K>`, required): Node to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with node selection toggled.
  List<TreeNode<K>> toggleSelectNode(TreeNode<K> target);
  /// Toggles selection state of multiple nodes.
  ///
  /// Parameters:
  /// - [targets] (`Iterable<TreeNode<K>>`, required): Nodes to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with nodes toggled.
  List<TreeNode<K>> toggleSelectNodes(Iterable<TreeNode<K>> targets);
  /// Toggles selection state of a node by its item value.
  ///
  /// Parameters:
  /// - [target] (`K`, required): Item value to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with item toggled.
  List<TreeNode<K>> toggleSelectItem(K target);
  /// Toggles selection state of multiple items.
  ///
  /// Parameters:
  /// - [targets] (`Iterable<K>`, required): Item values to toggle.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with items toggled.
  List<TreeNode<K>> toggleSelectItems(Iterable<K> targets);
  /// Selects all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes selected.
  List<TreeNode<K>> selectAll();
  /// Deselects all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all nodes deselected.
  List<TreeNode<K>> deselectAll();
  /// Toggles selection state of all nodes in the tree.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with all selections toggled.
  List<TreeNode<K>> toggleSelectAll();
  /// Selects specific nodes.
  ///
  /// Parameters:
  /// - [nodes] (`Iterable<TreeNode<K>>`, required): Nodes to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with nodes selected.
  List<TreeNode<K>> selectNodes(Iterable<TreeNode<K>> nodes);
  /// Selects nodes by their item values.
  ///
  /// Parameters:
  /// - [items] (`Iterable<K>`, required): Item values to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with items selected.
  List<TreeNode<K>> selectItems(Iterable<K> items);
  /// Deselects specific nodes.
  ///
  /// Parameters:
  /// - [nodes] (`Iterable<TreeNode<K>>`, required): Nodes to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with nodes deselected.
  List<TreeNode<K>> deselectNodes(Iterable<TreeNode<K>> nodes);
  /// Deselects nodes by their item values.
  ///
  /// Parameters:
  /// - [items] (`Iterable<K>`, required): Item values to deselect.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with items deselected.
  List<TreeNode<K>> deselectItems(Iterable<K> items);
  /// Sets the selected nodes, replacing current selection.
  ///
  /// Parameters:
  /// - [nodes] (`Iterable<TreeNode<K>>`, required): Nodes to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with only specified nodes selected.
  List<TreeNode<K>> setSelectedNodes(Iterable<TreeNode<K>> nodes);
  /// Sets the selected items by value, replacing current selection.
  ///
  /// Parameters:
  /// - [items] (`Iterable<K>`, required): Item values to select.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with only specified items selected.
  List<TreeNode<K>> setSelectedItems(Iterable<K> items);
  /// Applies an operator to all nodes with parent context.
  ///
  /// Parameters:
  /// - [operator] (`TreeNodeUnaryOperatorWithParent<K>`, required): Transform function with parent.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with transformed nodes.
  List<TreeNode<K>> replaceNodesWithParent(TreeNodeUnaryOperatorWithParent<K> operator);
  /// Updates selection state based on recursive selection rules.
  ///
  /// Ensures parent-child selection consistency when recursive selection is enabled.
  ///
  /// Returns: `List<TreeNode<K>>` — new tree with updated selection state.
  List<TreeNode<K>> updateRecursiveSelection();
}
```
