# TreeTheme

Theme configuration for [TreeView] appearance and behavior.

## Usage

### Tree Example
```dart
import 'package:docs/pages/docs/components/tree/tree_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TreeExample extends StatelessWidget {
  const TreeExample({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tree',
      description:
          'A tree is a way of displaying a hierarchical list of items.',
      displayName: 'Tree',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/tree/tree_example_1.dart',
          child: TreeExample1(),
        ),
      ],
    );
  }
}

```

### Tree Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates TreeView with expandable items, branch lines (path/line),
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
    TreeItem(
      data: 'Apple',
      expanded: true,
      children: [
        TreeItem(data: 'Red Apple', children: [
          TreeItem(data: 'Red Apple 1'),
          TreeItem(data: 'Red Apple 2'),
        ]),
        TreeItem(data: 'Green Apple'),
      ],
    ),
    TreeItem(
      data: 'Banana',
      children: [
        TreeItem(data: 'Yellow Banana'),
        TreeItem(data: 'Green Banana', children: [
          TreeItem(data: 'Green Banana 1'),
          TreeItem(data: 'Green Banana 2'),
          TreeItem(data: 'Green Banana 3'),
        ]),
      ],
    ),
    TreeItem(
      data: 'Cherry',
      children: [
        TreeItem(data: 'Red Cherry'),
        TreeItem(data: 'Green Cherry'),
      ],
    ),
    TreeItem(
      data: 'Date',
    ),
    // Tree Root acts as a parent node with no data,
    // it will flatten the children into the parent node
    TreeRoot(
      children: [
        TreeItem(
          data: 'Elderberry',
          children: [
            TreeItem(data: 'Black Elderberry'),
            TreeItem(data: 'Red Elderberry'),
          ],
        ),
        TreeItem(
          data: 'Fig',
          children: [
            TreeItem(data: 'Green Fig'),
            TreeItem(data: 'Purple Fig'),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedContainer(
          child: SizedBox(
            height: 300,
            width: 250,
            child: TreeView(
              // Show a separate expand/collapse icon when true; otherwise use row affordance.
              expandIcon: expandIcon,
              shrinkWrap: true,
              // When true, selecting a parent can affect children (see below toggle).
              recursiveSelection: recursiveSelection,
              nodes: treeItems,
              // Draw connecting lines either as path curves or straight lines.
              branchLine: usePath ? BranchLine.path : BranchLine.line,
              // Use a built-in handler to update selection state across nodes.
              onSelectionChanged: TreeView.defaultSelectionHandler(
                treeItems,
                (value) {
                  setState(() {
                    treeItems = value;
                  });
                },
              ),
              builder: (context, node) {
                return TreeItemView(
                  onPressed: () {},
                  trailing: node.leaf
                      ? Container(
                          width: 16,
                          height: 16,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      : null,
                  leading: node.leaf
                      ? const Icon(BootstrapIcons.fileImage)
                      : Icon(node.expanded
                          ? BootstrapIcons.folder2Open
                          : BootstrapIcons.folder2),
                  // Expand/collapse handling; updates treeItems with new expanded state.
                  onExpand: TreeView.defaultItemExpandHandler(treeItems, node,
                      (value) {
                    setState(() {
                      treeItems = value;
                    });
                  }),
                  child: Text(node.data),
                );
              },
            ),
          ),
        ),
        const Gap(16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              onPressed: () {
                setState(() {
                  treeItems = treeItems.expandAll();
                });
              },
              child: const Text('Expand All'),
            ),
            const Gap(8),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  treeItems = treeItems.collapseAll();
                });
              },
              child: const Text('Collapse All'),
            ),
          ],
        ),
        const Gap(8),
        Checkbox(
          state: expandIcon ? CheckboxState.checked : CheckboxState.unchecked,
          onChanged: (value) {
            setState(() {
              expandIcon = value == CheckboxState.checked;
            });
          },
          trailing: const Text('Expand Icon'),
        ),
        const Gap(8),
        Checkbox(
          state: usePath ? CheckboxState.checked : CheckboxState.unchecked,
          onChanged: (value) {
            setState(() {
              usePath = value == CheckboxState.checked;
            });
          },
          trailing: const Text('Use Path Branch Line'),
        ),
        const Gap(8),
        Checkbox(
          state: recursiveSelection
              ? CheckboxState.checked
              : CheckboxState.unchecked,
          onChanged: (value) {
            setState(() {
              recursiveSelection = value == CheckboxState.checked;
              if (recursiveSelection) {
                // Update nodes so parent/child reflect selected state recursively.
                treeItems = treeItems.updateRecursiveSelection();
              }
            });
          },
          trailing: const Text('Recursive Selection'),
        ),
      ],
    );
  }
}

```

### Tree Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/tree/tree_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TreeTile extends StatelessWidget implements IComponentPage {
  const TreeTile({super.key});

  @override
  String get title => 'Tree';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'tree',
      title: 'Tree',
      scale: 1.5,
      example: TreeExample1(),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `branchLine` | `BranchLine?` | The branch line style for connecting tree nodes.  Type: `BranchLine?`. If null, uses BranchLine.path. Controls how visual connections are drawn between parent and child nodes in the tree hierarchy. |
| `padding` | `EdgeInsetsGeometry?` | Padding around the entire tree view content.  Type: `EdgeInsetsGeometry?`. If null, uses 8 pixels on all sides. This padding is applied to the scroll view containing all tree items. |
| `expandIcon` | `bool?` | Whether to show expand/collapse icons for nodes with children.  Type: `bool?`. If null, defaults to true. When false, nodes cannot be visually expanded or collapsed, though the data structure remains hierarchical. |
| `allowMultiSelect` | `bool?` | Whether multiple nodes can be selected simultaneously.  Type: `bool?`. If null, defaults to true. When false, selecting a node automatically deselects all other nodes, enforcing single selection mode. |
| `recursiveSelection` | `bool?` | Whether selecting a parent node also selects its children.  Type: `bool?`. If null, defaults to true. When true, selection operations recursively affect all descendant nodes. |
