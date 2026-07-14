import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

Widget _defaultItemBuilder(BuildContext context, TreeItemNode<String> node) {
  return TreeItem(
    child: Text(node.data),
  );
}

void main() {
  group('Tree', () {
    testWidgets('keeps collapsed descendants in the tree (animated collapse)',
        (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItemNode(
          data: 'Fruits',
          expanded: false,
          children: [
            TreeItemNode(data: 'Apple'),
            TreeItemNode(data: 'Banana'),
          ],
        ),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: Tree<String>(
              shrinkWrap: true,
              nodes: nodes,
              builder: _defaultItemBuilder,
            ),
          ),
        ),
      );

      // Collapsed descendants are still built (just animated to zero size),
      // which is what makes the smooth collapse/expand transition possible.
      expect(find.byType(TreeItem), findsNWidgets(3));
    });

    testWidgets('shows children when a node is expanded', (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItemNode(
          data: 'Fruits',
          expanded: true,
          children: [
            TreeItemNode(data: 'Apple'),
            TreeItemNode(data: 'Banana'),
          ],
        ),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: Tree<String>(
              shrinkWrap: true,
              nodes: nodes,
              builder: _defaultItemBuilder,
            ),
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
    });
  });
}
