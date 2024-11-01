import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class TreeNode<T> {
  List<TreeNode<T>> get children;
  bool get expanded;
  bool get selected;

  bool get leaf => children.isEmpty;

  TreeNode<T> updateState({
    bool? expanded,
    bool? selected,
  });

  TreeNode<T> updateChildren(List<TreeNode<T>> children);
}

class TreeItem<T> extends TreeNode<T> {
  final T data;
  @override
  final List<TreeNode<T>> children;
  @override
  final bool expanded;
  @override
  final bool selected;

  TreeItem({
    required this.data,
    this.children = const [],
    this.expanded = false,
    this.selected = false,
  });

  @override
  TreeItem<T> updateState({
    bool? expanded,
    bool? selected,
  }) {
    return TreeItem(
      data: data,
      children: children,
      expanded: expanded ?? this.expanded,
      selected: selected ?? this.selected,
    );
  }

  @override
  TreeItem<T> updateChildren(List<TreeNode<T>> children) {
    return TreeItem(
      data: data,
      children: children,
      expanded: expanded,
      selected: selected,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TreeItem<T> &&
        other.data == data &&
        listEquals(other.children, children) &&
        other.expanded == expanded &&
        other.selected == selected;
  }

  @override
  int get hashCode {
    return Object.hash(data, children, expanded, selected);
  }

  @override
  String toString() {
    return 'TreeItem(data: $data, children: $children, expanded: $expanded, selected: $selected)';
  }
}

class TreeRoot<T> extends TreeNode<T> {
  @override
  final List<TreeNode<T>> children;
  @override
  bool get expanded => true;
  @override
  bool get selected => false;

  TreeRoot({
    required this.children,
  });

  @override
  TreeRoot<T> updateState({
    bool? expanded,
    bool? selected,
  }) {
    return this;
  }

  @override
  TreeRoot<T> updateChildren(List<TreeNode<T>> children) {
    return TreeRoot(
      children: children,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TreeRoot<T> && listEquals(other.children, children);
  }

  @override
  int get hashCode {
    return children.hashCode;
  }

  @override
  String toString() => 'TreeRoot(children: $children)';
}

enum SelectionPosition {
  start,
  middle,
  end,
  single,
}

enum FocusChangeReason {
  focusScope,
  userInteraction,
}

BorderRadius _borderRadiusFromPosition(
    SelectionPosition? position, double value) {
  if (position == SelectionPosition.start) {
    return BorderRadius.vertical(top: Radius.circular(value));
  } else if (position == SelectionPosition.end) {
    return BorderRadius.vertical(bottom: Radius.circular(value));
  } else if (position == SelectionPosition.single) {
    return BorderRadius.all(Radius.circular(value));
  }
  return BorderRadius.zero;
}

class TreeNodeData<T> {
  final TreeNode<T> node;
  final BranchLine indentGuide;
  final bool expanded;
  final List<TreeNodeDepth> depth;
  final bool expandIcon;
  final void Function(FocusChangeReason reason)? onFocusChanged;
  SelectionPosition? selectionPosition;
  TreeNodeData(this.depth, this.node, this.indentGuide, this.expanded,
      this.expandIcon, this.onFocusChanged);
}

class TreeNodeDepth {
  final int childIndex;
  final int childCount;

  TreeNodeDepth(this.childIndex, this.childCount);
}

typedef TreeNodeUnaryOperator<K> = TreeNode<K>? Function(TreeNode<K> node);
typedef TreeNodeUnaryOperatorWithParent<K> = TreeNode<K>? Function(
    TreeNode<K>? parent, TreeNode<K> node);

extension TreeNodeListExtension<K> on List<TreeNode<K>> {
  List<TreeNode<K>> replaceNodes(TreeNodeUnaryOperator<K> operator) {
    return TreeView.replaceNodes(this, operator);
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

  List<TreeNode<K>> get selectedNodes {
    return TreeView.getSelectedNodes(this);
  }

  List<K> get selectedItems {
    return TreeView.getSelectedItems(this);
  }

  List<TreeNode<K>> selectNode(TreeNode<K> target) {
    return TreeView.selectNode(this, target);
  }

  List<TreeNode<K>> selectItem(K target) {
    return TreeView.selectItem(this, target);
  }

  List<TreeNode<K>> deselectNode(TreeNode<K> target) {
    return TreeView.deselectNode(this, target);
  }

  List<TreeNode<K>> deselectItem(K target) {
    return TreeView.deselectItem(this, target);
  }

  List<TreeNode<K>> toggleSelectNode(TreeNode<K> target) {
    return TreeView.toggleSelectNode(this, target);
  }

  List<TreeNode<K>> toggleSelectNodes(Iterable<TreeNode<K>> targets) {
    return TreeView.toggleSelectNodes(this, targets);
  }

  List<TreeNode<K>> toggleSelectItem(K target) {
    return TreeView.toggleSelectItem(this, target);
  }

  List<TreeNode<K>> toggleSelectItems(Iterable<K> targets) {
    return TreeView.toggleSelectItems(this, targets);
  }

  List<TreeNode<K>> selectAll() {
    return TreeView.selectAll(this);
  }

  List<TreeNode<K>> deselectAll() {
    return TreeView.deselectAll(this);
  }

  List<TreeNode<K>> toggleSelectAll() {
    return TreeView.toggleSelectAll(this);
  }

  List<TreeNode<K>> selectNodes(Iterable<TreeNode<K>> nodes) {
    return TreeView.selectNodes(this, nodes);
  }

  List<TreeNode<K>> selectItems(Iterable<K> items) {
    return TreeView.selectItems(this, items);
  }

  List<TreeNode<K>> deselectNodes(Iterable<TreeNode<K>> nodes) {
    return TreeView.deselectNodes(this, nodes);
  }

  List<TreeNode<K>> deselectItems(Iterable<K> items) {
    return TreeView.deselectItems(this, items);
  }

  List<TreeNode<K>> setSelectedNodes(Iterable<TreeNode<K>> nodes) {
    return TreeView.setSelectedNodes(this, nodes);
  }

  List<TreeNode<K>> setSelectedItems(Iterable<K> items) {
    return TreeView.setSelectedItems(this, items);
  }

  List<TreeNode<K>> replaceNodesWithParent(
      TreeNodeUnaryOperatorWithParent<K> operator) {
    return TreeView.replaceNodesWithParent(this, operator);
  }

  List<TreeNode<K>> updateRecursiveSelection() {
    return TreeView.updateRecursiveSelection(this);
  }
}

typedef TreeNodeSelectionChanged<T> = void Function(
    List<TreeNode<T>> selectedNodes, bool multiSelect, bool selected);

class TreeSelectionDefaultHandler<T> {
  final List<TreeNode<T>> nodes;
  final ValueChanged<List<TreeNode<T>>> onChanged;

  TreeSelectionDefaultHandler(this.nodes, this.onChanged);

  void call(List<TreeNode<T>> selectedNodes, bool multiSelect, bool selected) {
    if (multiSelect) {
      if (selected) {
        onChanged(nodes.selectNodes(selectedNodes));
      } else {
        onChanged(nodes.deselectNodes(selectedNodes));
      }
    } else {
      onChanged(nodes.setSelectedNodes(selectedNodes));
    }
  }
}

class TreeItemExpandDefaultHandler<T> {
  final List<TreeNode<T>> nodes;
  final ValueChanged<List<TreeNode<T>>> onChanged;
  final TreeNode<T> target;

  TreeItemExpandDefaultHandler(this.nodes, this.target, this.onChanged);

  void call(bool expanded) {
    if (expanded) {
      onChanged(nodes.expandNode(target));
    } else {
      onChanged(nodes.collapseNode(target));
    }
  }
}

class TreeView<T> extends StatefulWidget {
  static TreeNodeSelectionChanged<K> defaultSelectionHandler<K>(
      List<TreeNode<K>> nodes, ValueChanged<List<TreeNode<K>>> onChanged) {
    return TreeSelectionDefaultHandler(nodes, onChanged).call;
  }

  static ValueChanged<bool> defaultItemExpandHandler<K>(List<TreeNode<K>> nodes,
      TreeNode<K> target, ValueChanged<List<TreeNode<K>>> onChanged) {
    return TreeItemExpandDefaultHandler(nodes, target, onChanged).call;
  }

  static List<TreeNode<K>>? _replaceNodes<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperator<K> operator) {
    List<TreeNode<K>> newNodes = List.from(nodes);
    bool changed = false;
    for (int i = 0; i < newNodes.length; i++) {
      final node = newNodes[i];
      var newNode = operator(node);
      List<TreeNode<K>>? newChildren =
          _replaceNodes((newNode ?? node).children, operator);
      if (newChildren != null) {
        newNode = (newNode ?? node).updateChildren(newChildren);
      }
      if (newNode != null) {
        newNodes[i] = newNode;
        changed = true;
      }
    }
    return changed ? newNodes : null;
  }

  static List<TreeNode<K>>? _replaceNodesWithParent<K>(TreeNode<K>? parent,
      List<TreeNode<K>> nodes, TreeNodeUnaryOperatorWithParent<K> operator) {
    List<TreeNode<K>> newNodes = List.from(nodes);
    bool changed = false;
    for (int i = 0; i < newNodes.length; i++) {
      final node = newNodes[i];
      var newNode = operator(parent, node);
      List<TreeNode<K>>? newChildren = _replaceNodesWithParent(
          newNode ?? node, (newNode ?? node).children, operator);
      if (newChildren != null) {
        newNode = (newNode ?? node).updateChildren(newChildren);
      }
      if (newNode != null) {
        newNodes[i] = newNode;
        changed = true;
      }
    }
    return changed ? newNodes : null;
  }

  static List<TreeNode<K>> replaceNodes<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperator<K> operator) {
    return _replaceNodes(nodes, operator) ?? nodes;
  }

  static List<TreeNode<K>> replaceNodesWithParent<K>(
      List<TreeNode<K>> nodes, TreeNodeUnaryOperatorWithParent<K> operator) {
    return _replaceNodesWithParent(null, nodes, operator) ?? nodes;
  }

  static List<TreeNode<K>> replaceNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> oldNode, TreeNode<K> newNode) {
    return replaceNodes(nodes, (node) {
      return node == oldNode ? newNode : null;
    });
  }

  static List<TreeNode<K>> replaceItem<K>(
      List<TreeNode<K>> nodes, K oldItem, TreeNode<K> newItem) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == oldItem) {
        return newItem;
      }
      return null;
    });
  }

  static List<TreeNode<K>> updateRecursiveSelection<K>(
      List<TreeNode<K>> nodes) {
    return replaceNodesWithParent(nodes, (parent, node) {
      if (node is TreeItem<K> &&
          !node.selected &&
          parent != null &&
          parent.selected) {
        return node.updateState(selected: true);
      }
      return null;
    });
  }

  static List<TreeNode<K>> getSelectedNodes<K>(List<TreeNode<K>> nodes) {
    return nodes.where((node) => node.selected).toList();
  }

  static List<K> getSelectedItems<K>(List<TreeNode<K>> nodes) {
    return nodes
        .whereType<TreeItem<K>>()
        .where((node) => node.selected)
        .map((node) => node.data)
        .toList();
  }

  static List<TreeNode<K>> expandAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.expanded ? null : node.updateState(expanded: true);
    });
  }

  static List<TreeNode<K>> collapseAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.expanded ? node.updateState(expanded: false) : null;
    });
  }

  static List<TreeNode<K>> expandNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(expanded: true) : null;
    });
  }

  static List<TreeNode<K>> expandItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target && !node.expanded) {
        return node.updateState(expanded: true);
      }
      return null;
    });
  }

  static List<TreeNode<K>> collapseNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(expanded: false) : null;
    });
  }

  static List<TreeNode<K>> collapseItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target && node.expanded) {
        return node.updateState(expanded: false);
      }
      return null;
    });
  }

  static List<TreeNode<K>> selectNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(selected: true) : null;
    });
  }

  static List<TreeNode<K>> selectItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target) {
        return node.updateState(selected: true);
      }
      return null;
    });
  }

  static List<TreeNode<K>> deselectNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(selected: false) : null;
    });
  }

  static List<TreeNode<K>> deselectItem<K>(List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target) {
        return node.updateState(selected: false);
      }
      return null;
    });
  }

  static List<TreeNode<K>> toggleSelectNode<K>(
      List<TreeNode<K>> nodes, TreeNode<K> target) {
    return replaceNodes(nodes, (node) {
      return node == target ? node.updateState(selected: !node.selected) : null;
    });
  }

  static List<TreeNode<K>> toggleSelectNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> targets) {
    return replaceNodes(nodes, (node) {
      return targets.contains(node)
          ? node.updateState(selected: !node.selected)
          : null;
    });
  }

  static List<TreeNode<K>> toggleSelectItem<K>(
      List<TreeNode<K>> nodes, K target) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && node.data == target) {
        return node.updateState(selected: !node.selected);
      }
      return null;
    });
  }

  static List<TreeNode<K>> toggleSelectItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> targets) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && targets.contains(node.data)) {
        return node.updateState(selected: !node.selected);
      }
      return null;
    });
  }

  static List<TreeNode<K>> selectAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: true);
    });
  }

  static List<TreeNode<K>> deselectAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: false);
    });
  }

  static List<TreeNode<K>> toggleSelectAll<K>(List<TreeNode<K>> nodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: !node.selected);
    });
  }

  static List<TreeNode<K>> selectNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> selectedNodes) {
    return replaceNodes(nodes, (node) {
      return selectedNodes.contains(node)
          ? node.updateState(selected: true)
          : null;
    });
  }

  static List<TreeNode<K>> selectItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> selectedItems) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && selectedItems.contains(node.data)) {
        return node.updateState(selected: true);
      }
      return null;
    });
  }

  static List<TreeNode<K>> deselectNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> deselectedNodes) {
    return replaceNodes(nodes, (node) {
      return deselectedNodes.contains(node)
          ? node.updateState(selected: false)
          : null;
    });
  }

  static List<TreeNode<K>> deselectItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> deselectedItems) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K> && deselectedItems.contains(node.data)) {
        return node.updateState(selected: false);
      }
      return null;
    });
  }

  static List<TreeNode<K>> setSelectedNodes<K>(
      List<TreeNode<K>> nodes, Iterable<TreeNode<K>> selectedNodes) {
    return replaceNodes(nodes, (node) {
      return node.updateState(selected: selectedNodes.contains(node));
    });
  }

  static List<TreeNode<K>> setSelectedItems<K>(
      List<TreeNode<K>> nodes, Iterable<K> selectedItems) {
    return replaceNodes(nodes, (node) {
      if (node is TreeItem<K>) {
        return node.updateState(selected: selectedItems.contains(node.data));
      }
      return null;
    });
  }

  final List<TreeNode<T>> nodes;
  final Widget Function(BuildContext context, TreeItem<T> node) builder;
  final bool shrinkWrap;
  final ScrollController? controller;
  final BranchLine branchLine;
  final EdgeInsetsGeometry? padding;
  final bool expandIcon;
  final bool allowMultiSelect;
  final FocusScopeNode? focusNode;
  final TreeNodeSelectionChanged<T>? onSelectionChanged;
  final bool recursiveSelection;

  const TreeView({
    super.key,
    required this.nodes,
    required this.builder,
    this.shrinkWrap = false,
    this.controller,
    this.branchLine = BranchLine.path,
    this.padding,
    this.expandIcon = true,
    this.allowMultiSelect = true,
    this.focusNode,
    this.onSelectionChanged,
    this.recursiveSelection = true,
  });

  @override
  State<TreeView<T>> createState() => _TreeViewState<T>();
}

typedef _TreeWalker<T> = void Function(
    bool parentExpanded, TreeNode<T> node, List<TreeNodeDepth> depth);

typedef _NodeWalker<T> = void Function(TreeNode<T> node);

class _TreeViewState<T> extends State<TreeView<T>> {
  bool _multiSelect = false;
  bool _rangeMultiSelect = false;

  int? _currentFocusedIndex;
  int? _startFocusedIndex;

  void _walkFlattened(
    _TreeWalker<T> walker,
    List<TreeNode<T>> nodes,
    bool parentExpanded,
    List<TreeNodeDepth> depth,
  ) {
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

  void _walkNodes(_NodeWalker<T> walker, List<TreeNode<T>> nodes) {
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is TreeItem<T>) {
        walker(node);
        _walkNodes(walker, node.children);
      } else if (node is TreeRoot<T>) {
        _walkNodes(walker, node.children);
      }
    }
  }

  void _onChangeSelectionRange(
      List<TreeNodeData<T>> children, int start, int end) {
    if (start > end) {
      final temp = start;
      start = end;
      end = temp;
    }
    final selectedItems = <TreeNode<T>>[];
    for (int i = start; i <= end; i++) {
      if (widget.recursiveSelection) {
        _walkNodes((node) {
          selectedItems.add(node);
        }, [children[i].node]);
      } else {
        selectedItems.add(children[i].node);
      }
    }
    widget.onSelectionChanged?.call(selectedItems, false, true);
  }

  @override
  Widget build(BuildContext context) {
    List<TreeNodeData<T>> children = [];
    int index = 0;
    _walkFlattened((expanded, node, depth) {
      if (node is! TreeItem<T>) return;
      final int currentIndex = index++;
      children.add(TreeNodeData(
        depth,
        node,
        widget.branchLine,
        expanded,
        widget.expandIcon,
        (reason) {
          if (reason == FocusChangeReason.focusScope) {
            _startFocusedIndex = currentIndex;
            _currentFocusedIndex = currentIndex;
            return;
          }
          _currentFocusedIndex = currentIndex;
          if (_rangeMultiSelect && _startFocusedIndex != null) {
            var start = _startFocusedIndex!;
            var end = _currentFocusedIndex!;
            _onChangeSelectionRange(children, start, end);
          } else {
            _startFocusedIndex = currentIndex;
            if (widget.recursiveSelection) {
              final selectedItems = <TreeNode<T>>[];
              _walkNodes((node) {
                selectedItems.add(node);
              }, [node]);
              widget.onSelectionChanged
                  ?.call(selectedItems, _multiSelect, !node.selected);
            } else {
              widget.onSelectionChanged
                  ?.call([node], _multiSelect, !node.selected);
            }
          }
        },
      ));
    }, widget.nodes, true, []);
    int selectedCount = 0;
    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      if (child.node is! TreeItem<T> || !child.node.selected) {
        continue;
      }
      if (child.node.selected) {
        bool isNextSelected = false;
        for (int j = i + 1; j < children.length; j++) {
          if (!children[j].expanded || children[j].node is! TreeItem<T>) {
            continue;
          }
          isNextSelected = children[j].node.selected;
          break;
        }
        if (selectedCount == 0) {
          if (isNextSelected) {
            child.selectionPosition = SelectionPosition.start;
          } else {
            child.selectionPosition = SelectionPosition.single;
            selectedCount = 0;
            continue;
          }
        } else {
          if (isNextSelected) {
            child.selectionPosition = SelectionPosition.middle;
          } else {
            child.selectionPosition = SelectionPosition.end;
            selectedCount = 0;
            continue;
          }
        }
        selectedCount++;
      } else {
        child.selectionPosition = null;
        selectedCount = 0;
      }
    }
    return Shortcuts(
      shortcuts: {
        if (widget.allowMultiSelect) ...{
          // range select
          LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),

          // multi select
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
          LogicalKeySet(
                  LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
          LogicalKeySet(
                  LogicalKeyboardKey.controlRight, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
        }
      },
      child: Actions(
        actions: {
          SelectTreeNodeIntent: CallbackAction(
            onInvoke: (e) {
              if (_currentFocusedIndex != null) {
                final selectedNode = children[_currentFocusedIndex!];
                if (widget.recursiveSelection) {
                  final selectedItems = <TreeNode<T>>[];
                  _walkNodes((node) {
                    selectedItems.add(node);
                  }, [selectedNode.node]);
                  widget.onSelectionChanged?.call(
                      selectedItems, _multiSelect, !selectedNode.node.selected);
                } else {
                  widget.onSelectionChanged?.call([selectedNode.node],
                      _multiSelect, !selectedNode.node.selected);
                }
              }
              return null;
            },
          ),
          DirectionalSelectTreeNodeIntent: CallbackAction(
            onInvoke: (e) {
              final bool down = (e as DirectionalSelectTreeNodeIntent).forward;
              var currentIndex = _currentFocusedIndex ?? 0;
              _startFocusedIndex ??= _currentFocusedIndex;
              var reverseSelection = currentIndex < _startFocusedIndex!;
              var equalSelection = currentIndex == _startFocusedIndex!;
              if (down) {
                for (int i = currentIndex + 1; i < children.length; i++) {
                  if (children[i].node is TreeItem<T> &&
                      children[i].expanded &&
                      (equalSelection
                          ? !children[i].node.selected
                          : (reverseSelection
                              ? children[i].node.selected
                              : !children[i].node.selected))) {
                    _currentFocusedIndex = i;
                    break;
                  }
                }
              } else {
                for (int i = currentIndex - 1; i >= 0; i--) {
                  if (children[i].node is TreeItem<T> &&
                      children[i].expanded &&
                      (equalSelection
                          ? !children[i].node.selected
                          : (reverseSelection
                              ? !children[i].node.selected
                              : children[i].node.selected))) {
                    _currentFocusedIndex = i;
                    break;
                  }
                }
              }
              _onChangeSelectionRange(
                  children, _startFocusedIndex!, _currentFocusedIndex!);
              return null;
            },
          ),
        },
        child: FocusScope(
          node: widget.focusNode,
          onKeyEvent: (node, event) {
            if (!widget.allowMultiSelect) return KeyEventResult.ignored;
            if (event is KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.shift ||
                  event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                  event.logicalKey == LogicalKeyboardKey.shiftRight) {
                _rangeMultiSelect = true;
              } else if (event.logicalKey == LogicalKeyboardKey.control ||
                  event.logicalKey == LogicalKeyboardKey.controlLeft ||
                  event.logicalKey == LogicalKeyboardKey.controlRight) {
                _multiSelect = true;
              }
            } else if (event is KeyUpEvent) {
              if (event.logicalKey == LogicalKeyboardKey.shift ||
                  event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                  event.logicalKey == LogicalKeyboardKey.shiftRight) {
                _rangeMultiSelect = false;
              } else if (event.logicalKey == LogicalKeyboardKey.control ||
                  event.logicalKey == LogicalKeyboardKey.controlLeft ||
                  event.logicalKey == LogicalKeyboardKey.controlRight) {
                _multiSelect = false;
              }
            }
            return KeyEventResult.ignored;
          },
          child: ListView(
            padding: widget.padding ?? const EdgeInsets.all(8),
            shrinkWrap: widget.shrinkWrap,
            controller: widget.controller,
            children: children
                .map((data) => Data<TreeNodeData>.inherit(
                      data: data,
                      child: Builder(builder: (context) {
                        return widget.builder(
                            context, data.node as TreeItem<T>);
                      }),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

abstract class BranchLine {
  static const none = IndentGuideNone();
  static const line = IndentGuideLine();
  static const path = IndentGuidePath();
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index);
}

class IndentGuideNone implements BranchLine {
  const IndentGuideNone();

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    return const SizedBox();
  }
}

class IndentGuideLine implements BranchLine {
  final Color? color;

  const IndentGuideLine({this.color});

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    if (index <= 0) {
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

class IndentGuidePath implements BranchLine {
  final Color? color;

  const IndentGuidePath({this.color});

  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    bool top = true;
    bool right = true;
    bool bottom = true;
    bool left = false;

    if (index >= 0) {
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
    } else {
      left = true;
      top = false;
      bottom = false;
    }

    return CustomPaint(
      painter: _PathPainter(
        color: color ?? Theme.of(context).colorScheme.border,
        top: top,
        right: right,
        bottom: bottom,
        left: left,
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  final Color color;
  final bool top;
  final bool right;
  final bool bottom;
  final bool left;

  _PathPainter({
    required this.color,
    this.top = false,
    this.right = false,
    this.bottom = false,
    this.left = false,
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
    if (left) {
      path.moveTo(halfWidth, halfHeight);
      path.lineTo(0, halfHeight);
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
  final WidgetStatesController _statesController = WidgetStatesController();

  TreeNodeData? _data;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant TreeItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    if (_data != null && _focusNode.hasFocus) {
      _data!.onFocusChanged?.call(FocusChangeReason.focusScope);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newData = Data.maybeOf<TreeNodeData>(context);
    if (_data != newData) {
      _data = newData;
      if (_data != null) {
        _statesController.update(WidgetState.selected, _data!.node.selected);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = _data;
    assert(data != null, 'TreeItemView must be a descendant of TreeView');
    List<Widget> rowChildren = [];
    if (data!.expandIcon) rowChildren.add(SizedBox(width: 8 * scaling));
    for (int i = 0; i < data.depth.length; i++) {
      if (i == 0) {
        continue; // skip the first depth
      }
      if (!data.expandIcon) rowChildren.add(SizedBox(width: 8 * scaling));
      rowChildren.add(SizedBox(
        width: 16 * scaling,
        child: data.indentGuide.build(
          context,
          data.depth,
          i,
        ),
      ));
    }
    List<Widget> subRowChildren = [];
    if (data.expandIcon) {
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
              child: const Icon(Icons.chevron_right).iconSmall(),
            ),
          ),
        );
      } else {
        if (data.depth.length > 1) {
          rowChildren.add(SizedBox(
            width: 16 * scaling,
            child: data.indentGuide.build(
              context,
              data.depth,
              -1,
            ),
          ));
        } else {
          rowChildren.add(SizedBox(
            width: 16 * scaling,
          ));
        }
      }
    }
    if (widget.leading != null) {
      subRowChildren.add(widget.leading!);
      subRowChildren.add(SizedBox(width: 8 * scaling));
    }
    subRowChildren.add(Expanded(child: widget.child));
    if (widget.trailing != null) {
      subRowChildren.add(SizedBox(width: 8 * scaling));
      subRowChildren.add(widget.trailing!);
    }
    rowChildren.add(
      Expanded(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4) * scaling,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: subRowChildren,
          ),
        ),
      ),
    );
    return ExcludeFocus(
      excluding: !data.expanded && !data.node.expanded,
      child: DefaultTextStyle.merge(
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
              focusOutline: !(_data?.node.selected ?? false),
              disableTransition: true,
              statesController: _statesController,
              shortcuts: {
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty))
                  LogicalKeySet(LogicalKeyboardKey.arrowRight):
                      const ExpandTreeNodeIntent(),
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty))
                  LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                      const CollapseTreeNodeIntent(),
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
                CollapseTreeNodeIntent: CallbackAction(
                  onInvoke: (e) {
                    if (widget.onExpand != null &&
                        (widget.expandable ?? data.node.children.isNotEmpty)) {
                      widget.onExpand!(false);
                    }
                    return null;
                  },
                ),
                ExpandTreeNodeIntent: CallbackAction(
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
                  if (states.contains(WidgetState.selected)) {
                    if (states.contains(WidgetState.focused)) {
                      return BoxDecoration(
                        color: theme.colorScheme.primary.scaleAlpha(0.1),
                        borderRadius: _borderRadiusFromPosition(
                          data.selectionPosition,
                          theme.radiusMd,
                        ),
                      );
                    }
                    return BoxDecoration(
                      color: theme.colorScheme.primary.scaleAlpha(0.05),
                      borderRadius: _borderRadiusFromPosition(
                        data.selectionPosition,
                        theme.radiusMd,
                      ),
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
              onDoubleTap: () {
                if (widget.onDoublePressed != null) {
                  widget.onDoublePressed!();
                }
                if (widget.onExpand != null &&
                    (widget.expandable ?? data.node.children.isNotEmpty)) {
                  widget.onExpand!(!data.node.expanded);
                }
                _focusNode.requestFocus();
              },
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
                _focusNode.requestFocus();
                _data!.onFocusChanged?.call(FocusChangeReason.userInteraction);
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
      ),
    );
  }
}

class ExpandTreeNodeIntent extends Intent {
  const ExpandTreeNodeIntent();
}

class CollapseTreeNodeIntent extends Intent {
  const CollapseTreeNodeIntent();
}

class SelectTreeNodeIntent extends Intent {
  const SelectTreeNodeIntent();
}

class DirectionalSelectTreeNodeIntent extends Intent {
  final bool forward;

  const DirectionalSelectTreeNodeIntent(this.forward);
}
