# Tree

A comprehensive tree widget with hierarchical data display and interaction.

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
        TreeItemNode(
          data: 'Fig',
          children: [
            TreeItemNode(data: 'Green Fig'),
            TreeItemNode(data: 'Purple Fig'),
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
            child: Tree(
              // Show a separate expand/collapse icon when true; otherwise use row affordance.
              expandIcon: expandIcon,
              shrinkWrap: true,
              // When true, selecting a parent can affect children (see below toggle).
              recursiveSelection: recursiveSelection,
              nodes: treeItems,
              // Draw connecting lines either as path curves or straight lines.
              branchLine: usePath ? BranchLine.path : BranchLine.line,
              // Use a built-in handler to update selection state across nodes.
              onSelectionChanged: Tree.defaultSelectionHandler(
                treeItems,
                (value) {
                  setState(() {
                    treeItems = value;
                  });
                },
              ),
              builder: (context, node) {
                return TreeItem(
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
                  onExpand:
                      Tree.defaultItemExpandHandler(treeItems, node, (value) {
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
| `nodes` | `List<TreeNode<T>>` | List of tree nodes to display in the tree view.  Type: `List<TreeNode<T>>`. The root-level nodes that will be rendered in the tree. Can contain TreeItemNode instances and TreeRootNode containers. |
| `builder` | `Widget Function(BuildContext context, TreeItemNode<T> node)` | Builder function to create widgets for tree items.  Type: `Widget Function(BuildContext, TreeItemNode<T>)`. Called for each visible tree item to create its visual representation. Receives the build context and the tree item data. |
| `shrinkWrap` | `bool` | Whether the tree view should size itself to its content.  Type: `bool`, default: `false`. When true, the tree takes only the space needed for its content instead of expanding to fill available space. |
| `controller` | `ScrollController?` | Optional scroll controller for the tree's scroll view.  Type: `ScrollController?`. Allows external control of scrolling behavior and position within the tree view. |
| `branchLine` | `BranchLine?` | The style of branch lines connecting tree nodes.  Type: `BranchLine?`. If null, uses the theme's branch line or BranchLine.path. Controls the visual connections drawn between parent and child nodes. |
| `padding` | `EdgeInsetsGeometry?` | Padding around the tree view content.  Type: `EdgeInsetsGeometry?`. If null, uses 8 pixels on all sides. Applied to the entire tree view scroll area. |
| `expandIcon` | `bool?` | Whether to show expand/collapse icons for nodes with children.  Type: `bool?`. If null, defaults to true from theme. When false, nodes cannot be visually expanded or collapsed. |
| `allowMultiSelect` | `bool?` | Whether multiple tree nodes can be selected simultaneously.  Type: `bool?`. If null, defaults to true from theme. When false, selecting a node automatically deselects all others. |
| `focusNode` | `FocusScopeNode?` | Optional focus scope node for keyboard navigation.  Type: `FocusScopeNode?`. Controls focus behavior within the tree view for keyboard navigation and accessibility. |
| `onSelectionChanged` | `TreeNodeSelectionChanged<T>?` | Callback invoked when node selection changes.  Type: `TreeNodeSelectionChanged<T>?`. Called with the affected nodes, whether multi-select mode is active, and the new selection state. |
| `recursiveSelection` | `bool?` | Whether selecting a parent node also selects its children.  Type: `bool?`. If null, defaults to true from theme. When true, selection operations recursively affect all descendant nodes. |
