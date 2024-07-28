import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class TreeNode<T> {
  List<TreeNode<T>> get children;
  bool get expanded;

  bool get leaf => children.isEmpty;

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

extension TreeNodeListExtension<K> on List<TreeNode<K>> {
  List<TreeNode<K>> mapNodes(TreeNodeUnaryOperator<K> operator) {
    return TreeView.mapNodes(this, operator);
  }

  List<TreeNode<K>> replaceNode(TreeNode<K> oldNode, TreeNode<K> newNode) {
    return TreeView.replaceNode(this, oldNode, newNode);
  }

  List<TreeNode<K>> replaceItem(K oldItem, TreeNode<K> newItem) {
    return TreeView.replaceItem(this, oldItem, newItem);
  }

  List<TreeNode<K>> expandAll() {
    return TreeView.expandAll(this);
  }

  List<TreeNode<K>> collapseAll() {
    return TreeView.collapseAll(this);
  }

  List<TreeNode<K>> expandNode(TreeNode<K> target) {
    return TreeView.expandNode(this, target);
  }

  List<TreeNode<K>> expandItem(K target) {
    return TreeView.expandItem(this, target);
  }

  List<TreeNode<K>> collapseNode(TreeNode<K> target) {
    return TreeView.collapseNode(this, target);
  }

  List<TreeNode<K>> collapseItem(K target) {
    return TreeView.collapseItem(this, target);
  }
}

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

  static List<TreeNode<K>> replaceItem<K>(
      List<TreeNode<K>> nodes, K oldItem, TreeNode<K> newItem) {
    return mapNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == oldItem) {
        return newItem;
      }
      return null;
    });
  }

  static List<TreeNode<K>> expandAll<K>(List<TreeNode<K>> nodes) {
    return mapNodes(nodes, (node) {
      return node.expanded ? null : node.copyWith(expanded: true);
    });
  }

  static List<TreeNode<K>> collapseAll<K>(List<TreeNode<K>> nodes) {
    return mapNodes(nodes, (node) {
      return node.expanded ? node.copyWith(expanded: false) : null;
    });
  }

  static List<TreeNode<K>> expandNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return mapNodes(nodes, (node) {
      return node == target ? node.copyWith(expanded: true) : null;
    });
  }

  static List<TreeNode<K>> expandItem<K>(List<TreeNode<K>> nodes, K target) {
    return mapNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target && !node.expanded) {
        return node.copyWith(expanded: true);
      }
      return null;
    });
  }

  static List<TreeNode<K>> collapseNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return mapNodes(nodes, (node) {
      return node == target ? node.copyWith(expanded: false) : null;
    });
  }

  static List<TreeNode<K>> collapseItem<K>(List<TreeNode<K>> nodes, K target) {
    return mapNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target && node.expanded) {
        return node.copyWith(expanded: false);
      }
      return null;
    });
  }

  final List<TreeNode<T>> nodes;
  final Widget Function(BuildContext context, TreeItem<T> node) builder;
  final bool shrinkWrap;
  final ScrollController? controller;
  final IndentGuide indentGuide;
  final EdgeInsetsGeometry? padding;

  const TreeView({
    super.key,
    required this.nodes,
    required this.builder,
    this.shrinkWrap = false,
    this.controller,
    this.indentGuide = IndentGuide.path,
    this.padding,
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
      padding: widget.padding ?? const EdgeInsets.all(8),
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
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index);
}

class IndentGuideNone implements IndentGuide {
  const IndentGuideNone();

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    return const SizedBox();
  }
}

class IndentGuideLine implements IndentGuide {
  final Color? color;

  const IndentGuideLine({this.color});

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    if (index == 0) {
      return const SizedBox();
    }
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
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    bool top = true;
    bool right = true;
    bool bottom = true;

    final current = depth[index];

    if (index != depth.length - 1) {
      right = false;
      if (current.childIndex >= current.childCount - 1) {
        top = false;
      }
    }

    if (current.childIndex >= current.childCount - 1) {
      bottom = false;
    }

    return CustomPaint(
      painter: _PathPainter(
        color: color ?? Theme.of(context).colorScheme.border,
        top: top,
        right: right,
        bottom: bottom,
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
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final path = Path();
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    // to prevent overlapping lines
    if (top && bottom && right) {
      path.moveTo(halfWidth, 0);
      path.lineTo(halfWidth, size.height);
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(size.width, halfHeight);
    } else if (top && bottom) {
      path.moveTo(halfWidth, 0);
      path.lineTo(halfWidth, size.height);
    } else if (top && right) {
      path.moveTo(halfWidth, 0);
      path.lineTo(halfWidth, halfHeight);
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(size.width, halfHeight);
    } else if (bottom && right) {
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(size.width, halfHeight);
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(halfWidth, size.height);
    } else if (top) {
      path.moveTo(halfWidth, 0);
      path.lineTo(halfWidth, halfHeight);
    } else if (right) {
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(size.width, halfHeight);
    } else if (bottom) {
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

class TreeItemView extends StatefulWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final VoidCallback? onDoublePressed;
  final ValueChanged<bool>? onExpand;
  final bool? expandable;
  final FocusNode? focusNode;

  const TreeItemView({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onDoublePressed,
    this.onExpand,
    this.expandable,
    this.focusNode,
  });

  @override
  State<TreeItemView> createState() => _TreeItemViewState();
}

class _TreeItemViewState extends State<TreeItemView> {
  late FocusNode _focusNode;
  int _tapCount = 0;
  int _lastTapTime = 0;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<TreeNodeData>(context);
    assert(data != null, 'TreeItemView must be a descendant of TreeView');
    List<Widget> rowChildren = [];
    rowChildren.add(const SizedBox(width: 8));
    for (int i = 0; i < data!.depth.length; i++) {
      if (i == 0) {
        continue; // skip the first depth
      }
      rowChildren.add(SizedBox(
        width: 16,
        child: data.indentGuide.build(
          context,
          data.depth,
          i,
        ),
      ));
    }
    List<Widget> subRowChildren = [];
    if (widget.expandable ?? data.node.children.isNotEmpty) {
      rowChildren.add(
        GestureDetector(
          onTap: () {
            if (widget.onExpand != null) {
              widget.onExpand!(!data.node.expanded);
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
    if (widget.leading != null) {
      subRowChildren.add(widget.leading!);
      subRowChildren.add(const SizedBox(width: 8));
    }
    subRowChildren.add(Expanded(child: widget.child));
    if (widget.trailing != null) {
      subRowChildren.add(const SizedBox(width: 8));
      subRowChildren.add(widget.trailing!);
    }
    rowChildren.add(
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: subRowChildren,
          ),
        ),
      ),
    );
    final theme = Theme.of(context);
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      child: AnimatedCrossFade(
        duration: kDefaultDuration,
        firstCurve: Curves.easeInOut,
        secondCurve: Curves.easeInOut,
        crossFadeState: data.expanded
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        secondChild: const SizedBox(),
        firstChild: IntrinsicHeight(
          child: Clickable(
            focusNode: _focusNode,
            focusOutline: false,
            disableTransition: true,
            shortcuts: {
              if (widget.onExpand != null &&
                  (widget.expandable ?? data.node.children.isNotEmpty))
                LogicalKeySet(LogicalKeyboardKey.arrowRight):
                    const ExpandIntent(),
              if (widget.onExpand != null &&
                  (widget.expandable ?? data.node.children.isNotEmpty))
                LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                    const CollapseIntent(),
            },
            actions: {
              ActivateIntent: CallbackAction(
                onInvoke: (e) {
                  if (widget.onExpand != null &&
                      (widget.expandable ?? data.node.children.isNotEmpty)) {
                    widget.onExpand!(!data.node.expanded);
                  }
                  widget.onPressed?.call();
                  return null;
                },
              ),
              CollapseIntent: CallbackAction(
                onInvoke: (e) {
                  if (widget.onExpand != null &&
                      (widget.expandable ?? data.node.children.isNotEmpty)) {
                    widget.onExpand!(false);
                  }
                  return null;
                },
              ),
              ExpandIntent: CallbackAction(
                onInvoke: (e) {
                  if (widget.onExpand != null &&
                      (widget.expandable ?? data.node.children.isNotEmpty)) {
                    widget.onExpand!(true);
                  }
                  return null;
                },
              ),
            },
            decoration: WidgetStateProperty.resolveWith(
              (states) {
                if (states.contains(WidgetState.focused)) {
                  return BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: theme.borderRadiusMd,
                  );
                }
                return const BoxDecoration();
              },
            ),
            behavior: HitTestBehavior.translucent,
            mouseCursor: widget.onDoublePressed != null ||
                    widget.onPressed != null ||
                    (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty))
                ? const WidgetStatePropertyAll(SystemMouseCursors.click)
                : const WidgetStatePropertyAll(SystemMouseCursors.basic),
            onPressed: () {
              final now = DateTime.now().millisecondsSinceEpoch;
              if (now - _lastTapTime < 300) {
                _tapCount++;
              } else {
                _tapCount = 1;
              }
              _lastTapTime = now;
              if (_tapCount >= 2) {
                if (widget.onDoublePressed != null) {
                  widget.onDoublePressed!();
                }
                if (widget.onExpand != null) {
                  widget.onExpand!(!data.node.expanded);
                }
              } else if (widget.onPressed != null) {
                widget.onPressed!();
              }
              _focusNode.requestFocus();
            },
            enabled: widget.onPressed != null ||
                widget.onDoublePressed != null ||
                (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rowChildren,
            ),
          ),
        ),
      ).iconSmall(),
    );
  }
}

class ExpandIntent extends Intent {
  const ExpandIntent();
}

class CollapseIntent extends Intent {
  const CollapseIntent();
}
