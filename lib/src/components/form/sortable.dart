import 'package:flutter/scheduler.dart';

import '../../../shadcn_flutter.dart';

class SortableLayer extends StatefulWidget {
  final Widget child;

  const SortableLayer({
    super.key,
    required this.child,
  });

  @override
  State<SortableLayer> createState() => SortableLayerState();
}

class _SortableDraggedItem {
  final SortableItemState itemContainer;
  final ValueNotifier<Offset> position;
  final _SortableItemTransform transform;

  _SortableDraggedItem({
    required this.itemContainer,
    required this.position,
    required this.transform,
  });
}

class _SortableTransferItem {
  final _SortableDraggedItem item;
  final ValueNotifier<double> transferProgress;
  final SortableItemState newItemContainer;

  _SortableTransferItem({
    required this.item,
    required this.transferProgress,
    required this.newItemContainer,
  });
}

const kTransferDuration = Duration(milliseconds: 200);

class SortableLayerState extends State<SortableLayer> {
  _SortableDraggedItem? _currentDraggedItem;
  final List<_SortableTransferItem> _transferItems = [];
  late Ticker _transferTicker;
  Duration? _lastTime;

  RenderBox get _renderBox {
    return context.findRenderObject() as RenderBox;
  }

  _SortableTransferItem? findTransferItem(SortableItem item) {
    for (var transferItem in _transferItems) {
      if (transferItem.item.itemContainer.widget.handler.item == item) {
        return transferItem;
      }
    }
    return null;
  }

  void _beginTransfer(
      SortableItemState newItemContainer, _SortableDraggedItem item) {
    final transferProgress = ValueNotifier(0.0);
    setState(() {
      _transferItems.add(
        _SortableTransferItem(
          item: item,
          transferProgress: transferProgress,
          newItemContainer: newItemContainer,
        ),
      );
    });
    _checkTicker();
  }

  void _dragStart(
      SortableItemState itemContainer, _SortableItemTransform transform) {
    setState(() {
      _currentDraggedItem = _SortableDraggedItem(
        itemContainer: itemContainer,
        position: ValueNotifier(Offset.zero),
        transform: transform,
      );
    });
  }

  void _dragUpdate(Offset delta) {
    _currentDraggedItem!.position.value += delta;
  }

  void _dragEnd() {
    setState(() {
      _currentDraggedItem = null;
    });
  }

  void _checkTicker() {
    if (!_transferTicker.isActive && _transferItems.isNotEmpty) {
      _lastTime = null;
      _transferTicker.start();
    } else if (_transferTicker.isActive && _transferItems.isEmpty) {
      _transferTicker.stop();
      _lastTime = null;
    }
  }

  void _tick(Duration elapsed) {
    Duration delta = _lastTime == null ? Duration.zero : elapsed - _lastTime!;
    _lastTime = elapsed;
    for (int i = _transferItems.length - 1; i >= 0; i--) {
      var item = _transferItems[i];
      double newValue = item.transferProgress.value +
          delta.inMilliseconds / kTransferDuration.inMilliseconds;
      if (newValue >= 1) {
        newValue = 1;
        _transferItems.removeAt(i);
      }
      item.transferProgress.value = newValue;
    }
    _checkTicker();
  }

  @override
  void initState() {
    super.initState();
    _transferTicker = Ticker(_tick);
  }

  @override
  void dispose() {
    _transferTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(widget.child);
    for (var transferItem in _transferItems) {
      children.add(
        AnimatedBuilder(
          animation: transferItem.transferProgress,
          builder: (context, child) {
            return Positioned(
              left: transferItem.item.position.value.dx,
              top: transferItem.item.position.value.dy,
              child: Transform(
                transform: transferItem.item.transform.transform,
                child: SizedBox.fromSize(
                  size: transferItem.item.transform.size,
                  child: transferItem.item.itemContainer.widget,
                ),
              ),
            );
          },
        ),
      );
    }
    var currentDraggedItem = _currentDraggedItem;
    if (currentDraggedItem != null) {
      children.add(
        AnimatedBuilder(
          animation: currentDraggedItem.position,
          builder: (context, child) {
            var position = currentDraggedItem.position.value;
            return Positioned(
              left: position.dx,
              top: position.dy,
              child: Transform(
                transform: currentDraggedItem.transform.transform,
                child: SizedBox.fromSize(
                  size: currentDraggedItem.transform.size,
                  child: currentDraggedItem.itemContainer.widget,
                ),
              ),
            );
          },
        ),
      );
    }
    return Data.inherit(
      data: this,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: children,
      ),
    );
  }
}

class SortableItem {
  final GlobalKey _key = GlobalKey();
  final Widget child;

  SortableItem({required this.child});

  @override
  String toString() {
    return 'SortableItem(child: $child)';
  }
}

abstract class AbstractSortable extends StatefulWidget {
  final List<SortableItem> items;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final void Function(int oldIndex, int newIndex)? onSwap;
  final void Function(int index, SortableItem item)? onAdded;
  final void Function(int index)? onRemoved;
  final bool Function(int index, SortableItem item)? canAdd;
  final bool Function(int index, int oldIndex)? canReorder;
  final bool Function(int index, int oldIndex)? canSwap;
  final bool Function(int index)? canRemove;
  final Axis direction;
  final bool shrinkWrap;
  final ScrollController? controller;
  final bool reverse;
  final bool primary;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool removeOnDismiss;

  const AbstractSortable({
    super.key,
    required this.items,
    this.onReorder,
    this.onAdded,
    this.onRemoved,
    this.onSwap,
    this.canAdd,
    this.canReorder,
    this.canSwap,
    this.canRemove,
    this.direction = Axis.vertical,
    this.shrinkWrap = false,
    this.controller,
    this.reverse = false,
    this.primary = false,
    this.physics,
    this.padding,
    this.removeOnDismiss = false,
  });

  @override
  State<AbstractSortable> createState();
}

abstract class AbstractSortableState<T> extends State<AbstractSortable> {
  late List<_SortableItemHandler> _handlers;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void handleInteractionDismiss(
      SortableLayerState layer, SortableItemState itemState) {
    if (widget.removeOnDismiss) {
      return;
    }
    // add back to the list
    final item = itemState.widget.handler.item;
    final index = itemState.widget.handler.index;
    widget.onAdded!.call(index, item);
    layer._beginTransfer(
        itemState,
        _SortableDraggedItem(
          itemContainer: itemState,
          position: ValueNotifier(Offset.zero),
          transform: itemState._getTransformToLayer(layer._renderBox),
        ));
  }

  @override
  void initState() {
    super.initState();
    _handlers = widget.items.asMap().entries.map((entry) {
      return _SortableItemHandler(
        item: entry.value,
        index: entry.key,
        containerState: this,
      );
    }).toList();
  }

  _SortableItemHandler? findHandler(SortableItem item) {
    for (var handler in _handlers) {
      if (handler.item == item) {
        return handler;
      }
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant AbstractSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    List<_SortableItemHandler> newHandlers = [];
    for (int i = 0; i < widget.items.length; i++) {
      var item = widget.items[i];
      var handler = findHandler(item);
      if (handler == null) {
        handler = _SortableItemHandler(
          item: item,
          index: i,
          containerState: this,
        );
        _listKey.currentState!.insertItem(i);
      } else {
        handler.index = i;
      }
      newHandlers.add(handler);
    }
    for (var handler in _handlers) {
      if (!newHandlers.contains(handler)) {
        _listKey.currentState!.removeItem(handler.index,
            duration: kDefaultDuration, (context, animation) {
          return Opacity(
            opacity: 0,
            child: SizeTransition(
              sizeFactor: animation,
              axis: widget.direction,
              child: _SortableItem(
                handler: handler,
                direction: widget.direction,
                child: handler.item.child,
              ),
            ),
          );
        });
      }
    }
    _handlers = newHandlers;
  }

  @override
  Widget build(BuildContext context) {
    final layerState = Data.maybeOf<SortableLayerState>(context);
    assert(
        layerState != null, 'Sortable must be a descendant of SortableLayer');
    return AnimatedList(
      key: _listKey,
      initialItemCount: widget.items.length,
      shrinkWrap: widget.shrinkWrap,
      controller: widget.controller,
      reverse: widget.reverse,
      primary: widget.primary,
      physics: widget.physics,
      padding: widget.padding,
      scrollDirection: widget.direction,
      itemBuilder: (context, index, animation) {
        var handler = _handlers[index];
        return KeyedSubtree(
          key: handler.item._key,
          child: _SortableItem(
            key: handler.handlerKey,
            handler: handler,
            direction: widget.direction,
            activeTransfer: layerState!.findTransferItem(handler.item),
            child: widget.items[index].child,
          ),
        );
      },
    );
  }
}

class _SortableItem extends StatefulWidget {
  final _SortableItemHandler handler;
  final Axis direction;
  final Widget child;
  final _SortableTransferItem? activeTransfer;

  const _SortableItem({
    super.key,
    required this.handler,
    required this.direction,
    required this.child,
    this.activeTransfer,
  });

  @override
  State<_SortableItem> createState() => SortableItemState();
}

class _SortableItemTransform {
  final Size size;
  final Matrix4 transform;

  _SortableItemTransform({
    required this.size,
    required this.transform,
  });
}

class SortableItemState extends State<_SortableItem> {
  final GlobalKey _key = GlobalKey();
  _SortableItemTransform _getTransformToLayer(RenderObject renderObject) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return _SortableItemTransform(
        size: Size.zero,
        transform: Matrix4.identity(),
      );
    }
    final Matrix4 transform = renderBox.getTransformTo(renderObject);
    return _SortableItemTransform(
      size: renderBox.size,
      transform: transform,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.activeTransfer != null) {
      child = AnimatedBuilder(
        animation: widget.activeTransfer!.transferProgress,
        builder: (context, child) {
          final transferProgress =
              widget.activeTransfer!.transferProgress.value;
          return AnimatedSize(
            duration: kDefaultDuration,
            child: transferProgress == 0 ? const SizedBox() : widget.child,
          );
        },
      );
    }
    return Data.inherit(
      key: _key,
      data: this,
      child: child,
    );
  }
}

class SortableHandle extends StatelessWidget {
  final Widget child;

  const SortableHandle({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final SortableItemState? state = Data.maybeOf<SortableItemState>(context);
    final SortableLayerState? layerState =
        Data.maybeOf<SortableLayerState>(context);
    assert(
        state != null, 'SortableHandle must be a descendant of SortableItem');
    assert(layerState != null,
        'SortableHandle must be a descendant of SortableLayer');
    final containerState = state!.widget.handler.containerState;
    return GestureDetector(
      onPanStart: (details) {
        containerState.widget.onRemoved!.call(
          state.widget.handler.index,
        );
        final transform = state._getTransformToLayer(layerState!._renderBox);
        layerState._dragStart(state, transform);
      },
      onPanUpdate: (details) {
        layerState!._dragUpdate(details.delta);
      },
      onPanEnd: (details) {
        layerState!._dragEnd();
        containerState.handleInteractionDismiss(layerState, state);
      },
      child: child,
    );
  }
}

class _SortableItemHandler {
  final GlobalKey handlerKey = GlobalKey(
    debugLabel: '_SortableItemHandler',
  );
  SortableItem item;
  int index;
  final AbstractSortableState containerState;

  _SortableItemHandler({
    required this.item,
    required this.index,
    required this.containerState,
  });

  @override
  String toString() {
    return '_SortableItemHandler(item: $item, index: $index)';
  }
}

class DragSortable extends AbstractSortable {
  const DragSortable({super.key, 
    required super.items,
    required super.onReorder,
    required super.onRemoved,
    required super.onAdded,
    // super.onSwap, only for Swappable
    super.canAdd,
    super.canReorder,
    // super.canSwap, only for Swappable
    super.canRemove,
    super.direction = Axis.vertical,
    super.shrinkWrap = false,
    super.controller,
    super.reverse = false,
    super.primary = false,
    super.physics,
    super.padding,
  });

  @override
  State<AbstractSortable> createState() {
    return DragSortableState();
  }
}

class DragSortableState extends AbstractSortableState {}
