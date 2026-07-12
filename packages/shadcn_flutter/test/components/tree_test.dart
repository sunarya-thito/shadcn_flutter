import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

Widget _defaultItemBuilder(BuildContext context, TreeItem<String> node) {
  return TreeItemView(
    child: Text(node.data),
  );
}

void main() {
  group('Tree', () {
    testWidgets('keeps collapsed descendants in the tree (animated collapse)',
        (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItem(
          data: 'Fruits',
          expanded: false,
          children: [
            TreeItem(data: 'Apple'),
            TreeItem(data: 'Banana'),
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
      expect(find.byType(TreeItemView), findsNWidgets(3));
    });

    testWidgets('shows children when a node is expanded', (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItem(
          data: 'Fruits',
          expanded: true,
          children: [
            TreeItem(data: 'Apple'),
            TreeItem(data: 'Banana'),
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

  group('TreeView', () {
    testWidgets('hides descendants of a collapsed node entirely',
        (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItem(
          data: 'Fruits',
          expanded: false,
          children: [
            TreeItem(data: 'Apple'),
            TreeItem(data: 'Banana'),
          ],
        ),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: TreeView<String>(
              shrinkWrap: true,
              nodes: nodes,
              builder: _defaultItemBuilder,
            ),
          ),
        ),
      );

      expect(find.byType(TreeItemView), findsNWidgets(1));
      expect(find.text('Fruits'), findsOneWidget);
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('shows children when a node is expanded', (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItem(
          data: 'Fruits',
          expanded: true,
          children: [
            TreeItem(data: 'Apple'),
            TreeItem(data: 'Banana'),
          ],
        ),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: TreeView<String>(
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

    testWidgets(
        'only builds visible top-level items even with thousands of collapsed descendants',
        (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItem(
          data: 'Big folder',
          expanded: false,
          children: [
            for (var i = 0; i < 2000; i++) TreeItem(data: 'File $i'),
          ],
        ),
        for (var i = 0; i < 50; i++) TreeItem(data: 'Sibling $i'),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: TreeView<String>(
              nodes: nodes,
              builder: _defaultItemBuilder,
            ),
          ),
        ),
      );

      // Only a handful of top-level rows should have been built (viewport +
      // cache extent) even though the collapsed folder has 2000 children -
      // those children must never be built at all since TreeView excludes
      // them from the flattened list entirely.
      expect(find.byType(TreeItemView).evaluate().length, lessThan(30));
      expect(find.text('Big folder'), findsOneWidget);
      expect(find.text('File 0'), findsNothing);
      expect(find.text('Sibling 49'), findsNothing);
    });
  });
}
