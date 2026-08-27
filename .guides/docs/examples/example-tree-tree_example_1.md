---
title: "Example: components/tree/tree_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates Tree with expandable items, branch lines (path/line),
// and optional recursive selection behavior.

class TreeExample1 extends StatefulWidget {
  const TreeExample1({super.key});

  @override
  State<TreeExample1> createState() => _TreeExample1State();
}

class _TreeExample1State extends State<TreeExample1> {
  bool expandIcon = false;
  bool usePath = true;
  bool recursiveSelection = false;
  List<TreeNode<String>> treeItems = [
    TreeItemNode(
      data: 'Apple',
      expanded: true,
      children: [
        TreeItemNode(data: 'Red Apple', children: [
          TreeItemNode(data: 'Red Apple 1'),
          TreeItemNode(data: 'Red Apple 2'),
        ]),
        TreeItemNode(data: 'Green Apple'),
      ],
    ),
    TreeItemNode(
      data: 'Banana',
      children: [
        TreeItemNode(data: 'Yellow Banana'),
        TreeItemNode(data: 'Green Banana', children: [
          TreeItemNode(data: 'Green Banana 1'),
          TreeItemNode(data: 'Green Banana 2'),
          TreeItemNode(data: 'Green Banana 3'),
        ]),
      ],
    ),
    TreeItemNode(
      data: 'Cherry',
      children: [
        TreeItemNode(data: 'Red Cherry'),
        TreeItemNode(data: 'Green Cherry'),
      ],
    ),
    TreeItemNode(
      data: 'Date',
    ),
    // Tree Root acts as a parent node with no data,
    // it will flatten the children into the parent node
    TreeRootNode(
      children: [
        TreeItemNode(
          data: 'Elderberry',
          children: [
            TreeItemNode(data: 'Black Elderberry'),
            TreeItemNode(data: 'Red Elderberry'),
          ],
        ),
```
