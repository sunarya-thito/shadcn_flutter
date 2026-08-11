import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
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

    testWidgets(
        'space/enter reaches IME (not consumed) when TextField in '
        'builder content has focus', (tester) async {
      var pressedCount = 0;
      var selectionChanged = false;
      final nodes = <TreeNode<String>>[TreeItemNode(data: 'Item')];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: Tree<String>(
              shrinkWrap: true,
              nodes: nodes,
              onSelectionChanged: (selected, multiSelect, selectedState) {
                selectionChanged = true;
              },
              builder: (context, node) => TreeItem(
                onPressed: () => pressedCount++,
                child: const SizedBox(
                  width: 100,
                  child: TextField(),
                ),
              ),
            ),
          ),
        ),
      );

      // Focus the TextField directly (no tap, so no tree activation).
      await tester.showKeyboard(find.byType(TextField));
      await tester.pump();

      final editableText = tester.widget<EditableText>(
        find.descendant(
          of: find.byType(TextField),
          matching: find.byType(EditableText),
        ),
      );
      expect(editableText.focusNode.hasFocus, isTrue);

      // Space/enter must NOT be consumed by the framework — sendKeyEvent
      // returns false when the key reaches the platform (IME). If the
      // Clickable's Shortcuts consumed them, the return would be true and
      // the IME would never see the key.
      for (final key in [
        LogicalKeyboardKey.space,
        LogicalKeyboardKey.enter,
      ]) {
        final handled = await tester.sendKeyEvent(key);
        await tester.pump();
        expect(handled, isFalse,
            reason: 'key $key was consumed by framework; IME would not see it');
        expect(editableText.focusNode.hasFocus, isTrue,
            reason: 'focus stolen from TextField by $key');
        expect(pressedCount, 0,
            reason: 'tree item activated on $key while TextField focused');
        expect(selectionChanged, isFalse,
            reason: 'selection changed on $key while TextField focused');
      }
    });

    testWidgets('space still activates tree item when the item has focus',
        (tester) async {
      var pressedCount = 0;
      final nodes = <TreeNode<String>>[TreeItemNode(data: 'Item')];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: Tree<String>(
              shrinkWrap: true,
              nodes: nodes,
              builder: (context, node) => TreeItem(
                onPressed: () => pressedCount++,
                child: Text(node.data),
              ),
            ),
          ),
        ),
      );

      // Tap the item: activates it and gives the item focus.
      await tester.tap(find.text('Item'));
      await tester.pump();
      expect(pressedCount, 1);

      // With the item itself focused (no focus inside builder content),
      // space still triggers the tree's activation path.
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();
      expect(pressedCount, 2);
    });

    testWidgets('double-tap on content toggles expand/collapse',
        (tester) async {
      var expandCalls = <bool>[];
      var nodes = <TreeNode<String>>[
        TreeItemNode(
          data: 'Folder',
          children: [TreeItemNode(data: 'File')],
        ),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Tree<String>(
                  shrinkWrap: true,
                  nodes: nodes,
                  builder: (context, node) => TreeItem(
                    onExpand: (expanded) {
                      expandCalls.add(expanded);
                      setState(() {
                        nodes = expanded
                            ? nodes.expandNode(node)
                            : nodes.collapseNode(node);
                      });
                    },
                    child: Text(node.data),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Initially collapsed: the descendant stays in the tree (the animated
      // collapse keeps it built, zero-size) but is hidden.
      expect(find.text('Folder'), findsOneWidget);
      expect(_crossFadeOf(tester, 'File').crossFadeState,
          CrossFadeState.showSecond);

      // Double-tap to expand (two rapid taps within kDoubleTapMinTime).
      await tester.tap(find.text('Folder'));
      await tester.tap(find.text('Folder'));
      await tester.pumpAndSettle();

      expect(expandCalls, [true]);
      expect(_crossFadeOf(tester, 'File').crossFadeState,
          CrossFadeState.showFirst);

      // Double-tap to collapse.
      await tester.tap(find.text('Folder'));
      await tester.tap(find.text('Folder'));
      await tester.pumpAndSettle();

      expect(expandCalls, [true, false]);
      expect(_crossFadeOf(tester, 'File').crossFadeState,
          CrossFadeState.showSecond);
    });

    testWidgets('arrow up/down moves the hover highlight between rows',
        (tester) async {
      final pressed = <String>[];
      final nodes = <TreeNode<String>>[
        TreeItemNode(data: 'A'),
        TreeItemNode(data: 'B'),
        TreeItemNode(data: 'C'),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: Tree<String>(
              shrinkWrap: true,
              nodes: nodes,
              builder: (context, node) => TreeItem(
                onPressed: () => pressed.add(node.data),
                child: Text(node.data),
              ),
            ),
          ),
        ),
      );

      final accent =
          Theme.of(tester.element(find.text('B'))).colorScheme.accent;

      // Tap focuses row A (no onSelectionChanged -> A is not selected, so it
      // shows the accent fill purely from focus).
      await tester.tap(find.text('A'));
      await tester.pump();
      expect(pressed, ['A']);
      expect(_contentColorsOf(tester, 'A'), contains(accent));

      // Down -> highlight moves to B; A clears.
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(_contentColorsOf(tester, 'B'), contains(accent));
      expect(_contentColorsOf(tester, 'A'), isNot(contains(accent)));

      // Space activates the highlighted row (B), proving focus really moved.
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();
      expect(pressed, ['A', 'B']);

      // Down -> C.
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(_contentColorsOf(tester, 'C'), contains(accent));
      expect(_contentColorsOf(tester, 'B'), isNot(contains(accent)));

      // Up -> back to B.
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();
      expect(_contentColorsOf(tester, 'B'), contains(accent));
      expect(_contentColorsOf(tester, 'C'), isNot(contains(accent)));
    });

    testWidgets('hovering a content row shows the hover highlight',
        (tester) async {
      final nodes = <TreeNode<String>>[
        TreeItemNode(data: 'A'),
        TreeItemNode(data: 'B'),
      ];

      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            height: 300,
            width: 250,
            child: Tree<String>(
              shrinkWrap: true,
              nodes: nodes,
              builder: (context, node) => TreeItem(
                onPressed: () {},
                child: Text(node.data),
              ),
            ),
          ),
        ),
      );

      final accent =
          Theme.of(tester.element(find.text('B'))).colorScheme.accent;
      expect(_contentColorsOf(tester, 'B'), isNot(contains(accent)));

      final gesture =
          await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      await gesture.moveTo(tester.getCenter(find.text('B')));
      await tester.pump();

      expect(_contentColorsOf(tester, 'B'), contains(accent));
      expect(_contentColorsOf(tester, 'A'), isNot(contains(accent)));

      // Move away -> B clears, A lights up.
      await gesture.moveTo(tester.getCenter(find.text('A')));
      await tester.pump();
      expect(_contentColorsOf(tester, 'B'), isNot(contains(accent)));
      expect(_contentColorsOf(tester, 'A'), contains(accent));
    });
  });
}

AnimatedCrossFade _crossFadeOf(WidgetTester tester, String label) {
  return tester.widget<AnimatedCrossFade>(
    find
        .descendant(
          of: find
              .ancestor(
                of: find.text(label),
                matching: find.byType(TreeItem),
              )
              .first,
          matching: find.byType(AnimatedCrossFade),
        )
        .first,
  );
}

List<Color?> _contentColorsOf(WidgetTester tester, String label) {
  final itemFinder = find
      .ancestor(of: find.text(label), matching: find.byType(TreeItem))
      .first;
  return find
      .descendant(of: itemFinder, matching: find.byType(DecoratedBox))
      .evaluate()
      .map((e) {
    final d = (e.widget as DecoratedBox).decoration;
    return d is BoxDecoration ? d.color : null;
  }).toList();
}
