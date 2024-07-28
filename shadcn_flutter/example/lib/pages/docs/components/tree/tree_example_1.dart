import 'package:shadcn_flutter/shadcn_flutter.dart';

class TreeExample1 extends StatefulWidget {
  const TreeExample1({super.key});

  @override
  State<TreeExample1> createState() => _TreeExample1State();
}

class _TreeExample1State extends State<TreeExample1> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      child: SizedBox(
        height: 300,
        width: 250,
        child: TreeView(
          shrinkWrap: true,
          nodes: treeItems,
          builder: (context, node) {
            return TreeItemView(
              onPressed: () {},
              trailing: node.leaf
                  ? Container(
                      width: 16,
                      height: 16,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : null,
              leading: Icon(Icons.folder),
              onExpand: (expanded) {
                if (expanded) {
                  setState(() {
                    treeItems = TreeView.expandNode(treeItems, node);
                  });
                } else {
                  setState(() {
                    treeItems = TreeView.collapseNode(treeItems, node);
                  });
                }
              },
              child: Text(node.data),
            );
          },
        ),
      ),
    );
  }
}
