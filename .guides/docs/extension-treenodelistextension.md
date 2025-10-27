---
title: "Extension: TreeNodeListExtension"
description: "Reference for extension"
---

```dart
extension TreeNodeListExtension<K> on List<TreeNode<K>> {
  List<TreeNode<K>> replaceNodes(TreeNodeUnaryOperator<K> operator);
  List<TreeNode<K>> replaceNode(TreeNode<K> oldNode, TreeNode<K> newNode);
  List<TreeNode<K>> replaceItem(K oldItem, TreeNode<K> newItem);
  List<TreeNode<K>> expandAll();
  List<TreeNode<K>> collapseAll();
  List<TreeNode<K>> expandNode(TreeNode<K> target);
  List<TreeNode<K>> expandItem(K target);
  List<TreeNode<K>> collapseNode(TreeNode<K> target);
  List<TreeNode<K>> collapseItem(K target);
  List<TreeNode<K>> get selectedNodes;
  List<K> get selectedItems;
  List<TreeNode<K>> selectNode(TreeNode<K> target);
  List<TreeNode<K>> selectItem(K target);
  List<TreeNode<K>> deselectNode(TreeNode<K> target);
  List<TreeNode<K>> deselectItem(K target);
  List<TreeNode<K>> toggleSelectNode(TreeNode<K> target);
  List<TreeNode<K>> toggleSelectNodes(Iterable<TreeNode<K>> targets);
  List<TreeNode<K>> toggleSelectItem(K target);
  List<TreeNode<K>> toggleSelectItems(Iterable<K> targets);
  List<TreeNode<K>> selectAll();
  List<TreeNode<K>> deselectAll();
  List<TreeNode<K>> toggleSelectAll();
  List<TreeNode<K>> selectNodes(Iterable<TreeNode<K>> nodes);
  List<TreeNode<K>> selectItems(Iterable<K> items);
  List<TreeNode<K>> deselectNodes(Iterable<TreeNode<K>> nodes);
  List<TreeNode<K>> deselectItems(Iterable<K> items);
  List<TreeNode<K>> setSelectedNodes(Iterable<TreeNode<K>> nodes);
  List<TreeNode<K>> setSelectedItems(Iterable<K> items);
  List<TreeNode<K>> replaceNodesWithParent(TreeNodeUnaryOperatorWithParent<K> operator);
  List<TreeNode<K>> updateRecursiveSelection();
}
```
