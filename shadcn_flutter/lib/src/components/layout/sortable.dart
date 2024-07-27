import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef SortableCallback = void Function(int oldIndex, int newIndex);
typedef SortableDisposal = void Function(int index);
typedef SortableConsumer<T> = void Function(int index, T child);

class Sortable<T extends Widget> extends StatefulWidget {
  final List<T> children;
  final SortableCallback? onSort;
  final SortableDisposal? onTaken; // when dragged out of the list
  final SortableConsumer<T>? onInsert; // when dragged into the list
  final Axis direction;
  final bool lockDragMovement;
  final DismissMode dismissMode;
  final DragMode dragMode;

  const Sortable({
    Key? key,
    required this.children,
    this.onSort,
    this.onTaken,
    this.onInsert,
    this.direction = Axis.vertical,
    this.lockDragMovement = false,
    this.dismissMode = DismissMode.cancel,
    this.dragMode = DragMode.insert,
  }) : super(key: key);

  @override
  State<Sortable<T>> createState() => _SortableState();
}

class _SortSession {
  final OverlayEntry overlayEntry;
  final int index;
  final Offset handleOffset;
  final _SortableState sourceContainer;
  final Widget child;
  final ValueNotifier<Offset> dragOffset;
  _SortSession(
    this.overlayEntry,
    this.index,
    this.handleOffset,
    this.sourceContainer,
    this.child,
    this.dragOffset,
  );
}

enum DismissMode {
  cancel,
  remove;
}

enum DragMode {
  insert,
  swap;
}

class _SortTransferSession {
  final int index;
  final _SortableState sourceContainer;
  final Widget child;
  final ValueNotifier<double> sendingProgress;
  final OverlayEntry overlayEntry;
  final SortableItemPositionSupplier positionSupplier;
  _SortTransferSession(
    this.index,
    this.sourceContainer,
    this.child,
    this.sendingProgress,
    this.overlayEntry,
    this.positionSupplier,
  );
}

const kDefaultMoveDuration = Duration(milliseconds: 300);

class _SortableState<T extends Widget> extends State<Sortable<T>>
    with SingleTickerProviderStateMixin {
  final List<_SortSession> _sortSessions = [];
  final List<_SortTransferSession> _sortTransferSessions = [];
  late Ticker _ticker;
  Duration? _lastTime;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  void _checkTick() {
    if (!_ticker.isActive && _sortTransferSessions.isNotEmpty) {
      _lastTime = null;
      _ticker.start();
    } else if (_ticker.isActive && _sortTransferSessions.isEmpty) {
      _ticker.stop();
    }
  }

  void _tick(Duration elapsed) {
    Duration delta = _lastTime == null ? Duration.zero : elapsed - _lastTime!;
    _lastTime = elapsed;
    for (int i = _sortTransferSessions.length - 1; i >= 0; i--) {
      var session = _sortTransferSessions[i];
      session.sendingProgress.value +=
          delta.inMilliseconds / kDefaultMoveDuration.inMilliseconds;
      if (session.sendingProgress.value >= 1) {
        setState(() {
          _sortSessions.removeAt(i);
          session.overlayEntry.remove();
        });
      }
    }
    _checkTick();
  }

  void _stopDragging(
      int index, bool cancel, SortableItemPositionSupplier supplier) {
    _SortSession? session =
        _sortSessions.where((element) => element.index == index).firstOrNull;
    if (session != null) {
      _sortSessions.remove(session);
      session.overlayEntry.remove();
    }
  }

  void _startDragging(
      int index,
      Rect rect,
      Offset dragOffset,
      Offset handleOffset,
      _SortableState sourceContainer,
      SortableItemPositionSupplier supplier) {
    _SortSession? session =
        _sortSessions.where((element) => element.index == index).firstOrNull;
    if (session != null) {
      return;
    }
    final child = widget.children[index];
    final dragOffsetNotifier = ValueNotifier<Offset>(dragOffset);
    final sendingProgress = ValueNotifier<double>(0);
    final targetDragRect = ValueNotifier<Rect>(rect);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
            animation: Listenable.merge(
                [dragOffsetNotifier, sendingProgress, targetDragRect]),
            builder: (context, _) {
              double curvedSendingProgress =
                  Curves.easeInOut.transform(sendingProgress.value.clamp(0, 1));
              Offset tweenedOffset = Offset.lerp(dragOffsetNotifier.value,
                  targetDragRect.value.topLeft, curvedSendingProgress)!;
              Size tweenedSize = Size.lerp(
                  rect.size,
                  targetDragRect.value.size,
                  Curves.easeInOut
                      .transform(sendingProgress.value.clamp(0, 1)))!;
              return Positioned(
                // left: dragOffsetNotifier.value.dx,
                // top: dragOffsetNotifier.value.dy,
                left: tweenedOffset.dx,
                top: tweenedOffset.dy,
                child: SizedBox(
                  // width: rect.width,
                  // height: rect.height,
                  width: tweenedSize.width,
                  height: tweenedSize.height,
                  child: IgnorePointer(
                    child: Hero(
                      tag: 'sortable_item_$index',
                      child: child,
                    ),
                  ),
                ),
              );
            });
      },
    );
    Overlay.of(context).insert(overlayEntry);
    _sortSessions.add(_SortSession(
      overlayEntry,
      index,
      handleOffset,
      sourceContainer,
      child,
      dragOffsetNotifier,
    ));
    setState(() {});
  }

  void _updateDragging(int index, Offset offset) {
    // _dragOffset.value = offset - _handleOffset!;
    _SortSession? session =
        _sortSessions.where((element) => element.index == index).firstOrNull;
    if (session != null) {
      session.dragOffset.value = offset - session.handleOffset;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    for (var session in _sortSessions) {
      session.overlayEntry.remove();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.children.length; i++) {
      _SortSession? session =
          _sortSessions.where((element) => element.index == i).firstOrNull;
      children.add(
        _SortableItem(
          index: i,
          container: this,
          child: widget.children[i],
          dragging: session != null,
        ),
      );
    }
    Widget flexWidget = Flex(
      direction: widget.direction,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
    if (widget.direction == Axis.horizontal) {
      flexWidget = IntrinsicHeight(
        child: flexWidget,
      );
    } else {
      flexWidget = IntrinsicWidth(
        child: flexWidget,
      );
    }
    return flexWidget;
  }
}

class SortableItemHandle extends StatefulWidget {
  final Widget child;
  final HitTestBehavior behavior;

  const SortableItemHandle({
    Key? key,
    required this.child,
    this.behavior = HitTestBehavior.translucent,
  }) : super(key: key);

  @override
  State<SortableItemHandle> createState() => _SortableItemHandleState();
}

class _SortableItemHandleState extends State<SortableItemHandle> {
  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<SortableItemData>(context);
    return GestureDetector(
      onPanStart: (details) {
        if (data != null) {
          Rect rect = data.sizeSupplier();
          data.container._startDragging(
            data.index,
            rect,
            rect.topLeft,
            details.globalPosition - rect.topLeft,
            data.container,
            data.sizeSupplier,
          );
        }
      },
      onPanEnd: (details) {
        if (data != null) {
          data.container._stopDragging(data.index, true, data.sizeSupplier);
        }
      },
      onPanUpdate: (details) {
        if (data != null) {
          data.container._updateDragging(data.index, details.globalPosition);
        }
      },
      child: widget.child,
    );
  }
}

class SortableItemData {
  final int index;
  final _SortableState container;
  final SortableItemPositionSupplier sizeSupplier;
  final bool dragging;

  SortableItemData(
      this.index, this.container, this.sizeSupplier, this.dragging);

  @override
  bool operator ==(Object other) {
    if (other is SortableItemData) {
      return other.index == index && other.container == container;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(index, container);
}

class _SortableItem extends StatefulWidget {
  final Widget child;
  final int index;
  final _SortableState container;
  final bool dragging;

  const _SortableItem({
    Key? key,
    required this.child,
    required this.index,
    required this.container,
    required this.dragging,
  }) : super(key: key);

  @override
  State<_SortableItem> createState() => _SortableItemState();
}

class _SortableItemState extends State<_SortableItem> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Data(
        data: SortableItemData(
          widget.index,
          widget.container,
          () {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            return renderBox.localToGlobal(Offset.zero) & renderBox.size;
          },
          widget.dragging,
        ),
        child: AnimatedSize(
          duration: kDefaultDuration,
          child: Offstage(
            key: _key,
            offstage: widget.dragging,
            child: widget.child,
          ),
        ));
  }
}

typedef SortableItemPositionSupplier = Rect Function();
