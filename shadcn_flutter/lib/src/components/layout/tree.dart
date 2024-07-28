import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class TreeNode<T> {
  List<TreeNode<T>> get children;
  bool get expanded;

  TreeNode<T> copyWith({
    List<TreeNode<T>>? children,
    bool? expanded,
  });
}

class TreeItem<T> extends TreeNode<T> {
  final T data;
  @override
  final List<TreeNode<T>> children;
  @override
  final bool expanded;

  TreeItem({
    required this.data,
    this.children = const [],
    this.expanded = false,
  });

  @override
  TreeItem<T> copyWith({
    List<TreeNode<T>>? children,
    bool? expanded,
  }) {
    return TreeItem(
      data: data,
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
    );
  }
}

class TreeRoot<T> extends TreeNode<T> {
  @override
  final List<TreeNode<T>> children;
  @override
  final bool expanded;

  TreeRoot({
    required this.children,
    this.expanded = true,
  });

  @override
  TreeRoot<T> copyWith({
    List<TreeNode<T>>? children,
    bool? expanded,
  }) {
    return TreeRoot(
      children: children ?? this.children,
      expanded: expanded ?? this.expanded,
    );
  }
}

class TreeNodeData<T> {
  final TreeNode<T> node;
  final IndentGuide indentGuide;
  final bool expanded;
  final List<TreeNodeDepth> depth;
  TreeNodeData(this.depth, this.node, this.indentGuide, this.expanded);
}

class TreeNodeDepth {
  final int childIndex;
  final int childCount;

  TreeNodeDepth(this.childIndex, this.childCount);
}

typedef TreeNodeUnaryOperator<K> = TreeNode<K>? Function(TreeNode<K> node);

class TreeView<T> extends StatefulWidget {
  static List<TreeNode<K>>? _mapNodes<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperator<K> operator) {
    List<TreeNode<K>> newNodes = List.from(nodes);
    bool changed = false;
    for (int i = 0; i < newNodes.length; i++) {
      final node = newNodes[i];
      var newNode = operator(node);
      List<TreeNode<K>>? newChildren =
          _mapNodes((newNode ?? node).children, operator);
      if (newChildren != null) {
        newNode = (newNode ?? node).copyWith(children: newChildren);
      }
      if (newNode != null) {
        newNodes[i] = newNode;
        changed = true;
      }
    }
    return changed ? newNodes : null;
  }

  static List<TreeNode<K>> mapNodes<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperator<K> operator) {
    return _mapNodes(nodes, operator) ?? nodes;
  }

  static List<TreeNode<K>> replaceNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> oldNode, TreeNode<K> newNode) {
    return mapNodes(nodes, (node) {
      return node == oldNode ? newNode : null;
    });
  }

  static List<TreeNode<K>> expandAll<K>(List<TreeNode<K>> nodes) {
    return mapNodes(nodes, (node) {
      return node.copyWith(expanded: true);
    });
  }

  static List<TreeNode<K>> collapseAll<K>(List<TreeNode<K>> nodes) {
    return mapNodes(nodes, (node) {
      return node.copyWith(expanded: false);
    });
  }

  static List<TreeNode<K>> expandNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return mapNodes(nodes, (node) {
      return node == target ? node.copyWith(expanded: true) : null;
    });
  }

  static List<TreeNode<K>> collapseNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return mapNodes(nodes, (node) {
      return node == target ? node.copyWith(expanded: false) : null;
    });
  }

  final List<TreeNode<T>> nodes;
  final Widget Function(BuildContext context, TreeItem<T> node) builder;
  final bool shrinkWrap;
  final ScrollController? controller;
  final IndentGuide indentGuide;

  const TreeView({
    super.key,
    required this.nodes,
    required this.builder,
    this.shrinkWrap = false,
    this.controller,
    this.indentGuide = IndentGuide.path,
  });

  @override
  State<TreeView<T>> createState() => _TreeViewState<T>();
}

typedef _TreeWalker<T> = void Function(
    bool parentExpanded, TreeNode<T> node, List<TreeNodeDepth> depth);

class _TreeViewState<T> extends State<TreeView<T>> {
  void _walkFlattened(_TreeWalker<T> walker, List<TreeNode<T>> nodes,
      bool parentExpanded, List<TreeNodeDepth> depth) {
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

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    _walkFlattened((expanded, node, depth) {
      if (node is! TreeItem<T>) return;
      children.add(
        Data<TreeNodeData>(
          data: TreeNodeData(depth, node, widget.indentGuide, expanded),
          child: Builder(builder: (context) {
            return widget.builder(context, node);
          }),
        ),
      );
    }, widget.nodes, true, []);
    return ListView(
      shrinkWrap: widget.shrinkWrap,
      controller: widget.controller,
      children: children,
    );
  }
}

abstract class IndentGuide {
  static const none = IndentGuideNone();
  static const line = IndentGuideLine();
  static const path = IndentGuidePath();
  Widget build(BuildContext context, int depth, int childIndex, int childCount);
}

class IndentGuideNone implements IndentGuide {
  const IndentGuideNone();

  @override
  Widget build(
      BuildContext context, int depth, int childIndex, int childCount) {
    return const SizedBox();
  }
}

class IndentGuideLine implements IndentGuide {
  final Color? color;

  const IndentGuideLine({this.color});

  @override
  Widget build(
      BuildContext context, int depth, int childIndex, int childCount) {
    return CustomPaint(
      painter: _PathPainter(
        color: color ?? Theme.of(context).colorScheme.border,
        top: true,
        bottom: true,
      ),
    );
  }
}

class IndentGuidePath implements IndentGuide {
  final Color? color;

  const IndentGuidePath({this.color});

  @override
  Widget build(
      BuildContext context, int depth, int childIndex, int childCount) {
    final top = childIndex > 0;
    final bottom = childIndex < childCount - 1;
    return CustomPaint(
      painter: _PathPainter(
        color: color ?? Theme.of(context).colorScheme.border,
        top: top,
        bottom: bottom,
        right: true,
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  final Color color;
  final bool top;
  final bool right;
  final bool bottom;

  _PathPainter({
    required this.color,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
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

class TreeItemView extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final ValueChanged<bool>? onExpand;
  final bool? expandable;

  const TreeItemView({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onTap,
    this.onDoubleTap,
    this.onExpand,
    this.expandable,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<TreeNodeData>(context);
    assert(data != null, 'TreeItemView must be a descendant of TreeView');
    List<Widget> rowChildren = [];
    for (final depth in data!.depth) {
      rowChildren.add(SizedBox(
        width: 16,
        child: data.indentGuide.build(
          context,
          depth.childIndex,
          depth.childIndex,
          depth.childCount,
        ),
      ));
    }
    if (expandable ?? data.node.children.isNotEmpty) {
      rowChildren.add(
        GestureDetector(
          onTap: () {
            if (onExpand != null) {
              onExpand!(!data.node.expanded);
            }
          },
          child: AnimatedRotation(
            duration: kDefaultDuration,
            turns: data.node.expanded ? 0.25 : 0,
            child: const Icon(Icons.chevron_right, size: 16),
          ),
        ),
      );
    } else {
      rowChildren.add(const SizedBox(width: 16));
    }
    if (leading != null) {
      rowChildren.add(leading!);
      rowChildren.add(const SizedBox(width: 8));
    }
    rowChildren.add(Expanded(child: child));
    if (trailing != null) {
      rowChildren.add(const SizedBox(width: 8));
      rowChildren.add(trailing!);
    }
    return AnimatedCrossFade(
      duration: kDefaultDuration,
      firstCurve: Curves.easeInOut,
      secondCurve: Curves.easeInOut,
      crossFadeState:
          data.expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      secondChild: const SizedBox(),
      firstChild: IntrinsicHeight(
        child: Clickable(
          onPressed: onTap,
          onDoubleTap: onDoubleTap == null && onExpand == null
              ? null
              : () {
                  if (onDoubleTap != null) {
                    onDoubleTap!();
                  }
                  if (onExpand != null) {
                    onExpand!(!data.node.expanded);
                  }
                },
          enabled: onTap != null || onDoubleTap != null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowChildren,
          ),
        ),
      ),
    );
  }
}
