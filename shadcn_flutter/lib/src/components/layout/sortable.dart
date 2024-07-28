import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef SortableCallback = void Function(int oldIndex, int newIndex);
typedef SortableDisposal = void Function(int index);
typedef SortableConsumer<T> = void Function(int index, T child);
typedef SortableDividerBuilder = Widget Function(
    BuildContext context, int index);
typedef SortablePredicate<T> = bool Function(DropDetails<T> details);
typedef SortableBuilder<T> = Widget Function(BuildContext context, T value);

class DropDetails<T> {
  final T child;
  final int index;
  final SortableState container;

  DropDetails(this.child, this.index, this.container);

  SortableController get controller => container.widget.controller;
}

class SortableItem<T> {
  final GlobalKey _key = GlobalKey();
  final T value;

  SortableItem(this.value);
}

class SortableValue<T> {
  final List<SortableItem<T>> items;

  SortableValue(this.items);
}

class SortableController<T> extends ValueNotifier<SortableValue<T>> {
  factory SortableController([List<T>? children]) {
    if (children == null) {
      return SortableController._([]);
    }
    return SortableController._(children.map((e) => SortableItem(e)).toList());
  }

  SortableController._(List<SortableItem<T>> items)
      : super(SortableValue(items));

  void insert(int index, T child) {
    List<SortableItem<T>> items = List.from(value.items);
    items.insert(index, SortableItem(child));
    value = SortableValue(items);
  }

  void remove(int index) {
    List<SortableItem<T>> items = List.from(value.items);
    items.removeAt(index);
    value = SortableValue(items);
  }

  void sort(int oldIndex, int newIndex) {
    List<SortableItem<T>> items = List.from(value.items);
    var item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    value = SortableValue(items);
  }

  List<T> get items => value.items.map((e) => e.value).toList();

  void clear() {
    value = SortableValue([]);
  }

  int get length => value.items.length;

  T operator [](int index) => value.items[index].value;
}

class Sortable<T> extends StatefulWidget {
  final SortableController<T> controller;
  final Axis direction;
  final bool lockDragAxis;
  final DismissMode dismissMode;
  final DragMode dragMode;
  final SortableDividerBuilder? dividerBuilder;
  final SortablePredicate<T>? canAccept;
  final SortableBuilder<T> builder;

  const Sortable({
    Key? key,
    required this.controller,
    this.direction = Axis.vertical,
    this.lockDragAxis = false,
    this.dismissMode = DismissMode.cancel,
    this.dragMode = DragMode.insert,
    this.dividerBuilder,
    this.canAccept,
    required this.builder,
  }) : super(key: key);

  @override
  State<Sortable<T>> createState() => SortableState();
}

class _SortSession {
  final SortableLayerEntry overlayEntry;
  final int index;
  final Offset handleOffset;
  final SortableState sourceContainer;
  final Widget child;
  final ValueNotifier<Offset> dragOffset;
  final Rect rect;
  _SortSession(
    this.overlayEntry,
    this.index,
    this.handleOffset,
    this.sourceContainer,
    this.child,
    this.dragOffset,
    this.rect,
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
  final int oldIndex;
  final int index;
  final SortableState sourceContainer;
  final Widget child;
  final ValueNotifier<double> sendingProgress;
  final SortableLayerEntry overlayEntry;
  final SortableItemPositionSupplier positionSupplier;
  final ValueNotifier<Offset> dragOffset;
  final Offset handleOffset;
  _SortTransferSession(
    this.oldIndex,
    this.index,
    this.sourceContainer,
    this.child,
    this.sendingProgress,
    this.overlayEntry,
    this.positionSupplier,
    this.dragOffset,
    this.handleOffset,
  );
}

const kDefaultMoveDuration = Duration(milliseconds: 300);

class SortableLayer extends StatefulWidget {
  final Widget child;

  const SortableLayer({Key? key, required this.child}) : super(key: key);

  @override
  State<SortableLayer> createState() => _SortableLayerState();
}

class SortableLayerEntry {
  final WidgetBuilder builder;

  _SortableLayerState? _state;

  SortableLayerEntry(this.builder);

  void remove() {
    _state?.remove(this);
  }
}

class _SortableLayerState extends State<SortableLayer> {
  final List<SortableLayerEntry> _children = [];

  _SortSession? _sortSession;

  void add(SortableLayerEntry child) {
    setState(() {
      _children.add(child);
      child._state = this;
    });
  }

  void remove(SortableLayerEntry child) {
    setState(() {
      child._state = null;
      _children.remove(child);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Data(
      data: this,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: [
          widget.child,
          for (var child in _children) child.builder(context),
        ],
      ),
    );
  }
}

class SortableState<T> extends State<Sortable<T>>
    with SingleTickerProviderStateMixin {
  final List<_SortTransferSession> _sortTransferSessions = [];
  late Ticker _ticker;
  Duration? _lastTime;
  int? _hoveringChildrenIndex;

  _SortableLayerState? layerState;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant Sortable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newLayerState = Data.of<_SortableLayerState>(context);
    if (layerState != newLayerState) {
      if (layerState?._sortSession?.sourceContainer == this) {
        var sortSession = layerState?._sortSession;
        if (sortSession != null) {
          sortSession.overlayEntry.remove();
          layerState?._sortSession = null;
          newLayerState._sortSession = sortSession;
          newLayerState.add(sortSession.overlayEntry);
        }
      }
      layerState = newLayerState;
    }
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
          _sortTransferSessions.removeAt(i);
          session.overlayEntry.remove();
        });
      }
    }
    _checkTick();
  }

  void _stopDragging(
      int index, bool cancel, SortableItemPositionSupplier supplier) {
    var layerState = Data.of<_SortableLayerState>(context);
    var session = layerState._sortSession;
    if (session != null) {
      layerState._sortSession = null;
      session.overlayEntry.remove();
      if (cancel && widget.dismissMode == DismissMode.cancel) {
        final progressNotifier = ValueNotifier<double>(0);
        final overlayEntry = SortableLayerEntry(
          (context) {
            return AnimatedBuilder(
              animation: progressNotifier,
              builder: (context, _) {
                final rect = supplier();
                final curvedProgress = Curves.easeInOut.transform(
                  progressNotifier.value.clamp(0, 1),
                );
                final tweenedOffset = Offset.lerp(
                  session.dragOffset.value,
                  rect.topLeft,
                  curvedProgress,
                )!;
                final tweenedSize = Size.lerp(
                  session.rect.size,
                  rect.size,
                  curvedProgress,
                );
                return Positioned(
                  left: tweenedOffset.dx,
                  top: tweenedOffset.dy,
                  child: SizedBox(
                    width: tweenedSize!.width,
                    height: tweenedSize.height,
                    child: IgnorePointer(
                      child: session.child,
                    ),
                  ),
                );
              },
            );
          },
        );
        layerState.add(overlayEntry);
        setState(() {
          _sortTransferSessions.add(
            _SortTransferSession(
              index,
              index,
              session.sourceContainer,
              session.child,
              progressNotifier,
              overlayEntry,
              supplier,
              session.dragOffset,
              session.handleOffset,
            ),
          );
        });
        _checkTick();
      }
    }
  }

  void _dropTarget(_SortSession session, int hoveringIndex) {
    // _sortSession = null;
    layerState!._sortSession = null;

    if (hoveringIndex == -1) {
      hoveringIndex = widget.controller.length;
    }
    var newIndex = hoveringIndex;
    if (newIndex > session.index) {
      newIndex -= 1;
    }
    if (session.sourceContainer != this) {
      session.sourceContainer.widget.controller.remove(session.index);
      var value = session.sourceContainer.widget.controller[session.index];
      widget.controller.insert(hoveringIndex, value);
    } else {
      widget.controller.sort(session.index, newIndex);
    }
    session.overlayEntry.remove();
    final progressNotifier = ValueNotifier<double>(0);
    final overlayEntry = SortableLayerEntry(
      (context) {
        return AnimatedBuilder(
          animation: progressNotifier,
          builder: (context, _) {
            final curvedProgress = Curves.easeInOut.transform(
              progressNotifier.value.clamp(0, 1),
            );
            var targetKey = widget.controller.value.items[newIndex]._key;
            var currentContext = targetKey.currentContext!;
            var renderBox = currentContext.findRenderObject() as RenderBox;
            var rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
            final tweenedOffset = Offset.lerp(
              session.dragOffset.value,
              rect.topLeft,
              curvedProgress,
            )!;
            final tweenedSize = Size.lerp(
              session.rect.size,
              rect.size,
              curvedProgress,
            );
            return Positioned(
              left: tweenedOffset.dx,
              top: tweenedOffset.dy,
              child: SizedBox(
                width: tweenedSize!.width,
                height: tweenedSize.height,
                child: IgnorePointer(
                  child: session.child,
                ),
              ),
            );
          },
        );
      },
    );
    Data.of<_SortableLayerState>(context).add(overlayEntry);
    setState(() {
      _sortTransferSessions.add(
        _SortTransferSession(
          session.index,
          newIndex,
          session.sourceContainer,
          session.child,
          progressNotifier,
          overlayEntry,
          () {
            var targetKey = widget.controller.value.items[newIndex]._key;
            var renderBox =
                targetKey.currentContext!.findRenderObject() as RenderBox;
            return renderBox.localToGlobal(Offset.zero) & renderBox.size;
          },
          session.dragOffset,
          session.handleOffset,
        ),
      );
    });
    _checkTick();
  }

  void _startDragging(
      int index,
      Rect rect,
      Offset dragOffset,
      Offset handleOffset,
      SortableState sourceContainer,
      SortableItemPositionSupplier supplier) {
    var session = layerState!._sortSession;
    if (session != null) {
      return;
    }
    final child =
        widget.builder(context, widget.controller.value.items[index].value);
    final dragOffsetNotifier = ValueNotifier<Offset>(dragOffset);
    final overlayEntry = SortableLayerEntry(
      (context) {
        return AnimatedBuilder(
            animation: dragOffsetNotifier,
            builder: (context, _) {
              return Positioned(
                left: dragOffsetNotifier.value.dx,
                top: dragOffsetNotifier.value.dy,
                child: SizedBox(
                  width: rect.width,
                  height: rect.height,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.grabbing,
                    opaque: false,
                    child: IgnorePointer(
                      child: child,
                    ),
                  ),
                ),
              );
            });
      },
    );
    Data.of<_SortableLayerState>(context).add(overlayEntry);
    layerState!._sortSession = _SortSession(
      overlayEntry,
      index,
      handleOffset,
      sourceContainer,
      child,
      dragOffsetNotifier,
      rect,
    );
    setState(() {});
  }

  void _updateDragging(int index, Offset offset) {
    var session = layerState!._sortSession;
    if (session != null) {
      if (widget.lockDragAxis) {
        final renderObject = context.findRenderObject() as RenderBox;
        Rect containerRect =
            renderObject.localToGlobal(Offset.zero) & renderObject.size;
        if (widget.direction == Axis.horizontal) {
          session.dragOffset.value = Offset(
              offset.dx,
              session.dragOffset.value.dy.clamp(
                containerRect.top,
                containerRect.bottom - containerRect.height,
              ));
        } else {
          session.dragOffset.value = Offset(
              session.dragOffset.value.dx.clamp(
                containerRect.left,
                containerRect.right - containerRect.width,
              ),
              offset.dy);
        }
      } else {
        session.dragOffset.value = offset - session.handleOffset;
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _ticker.dispose();
    for (var session in _sortTransferSessions) {
      session.overlayEntry.remove();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.controller.length; i++) {
      _SortSession? session = layerState?._sortSession;
      children.add(
        Builder(builder: (context) {
          return MouseRegion(
            onEnter: (event) {
              setState(() {
                _hoveringChildrenIndex = i;
              });
            },
            onExit: (event) {
              if (_hoveringChildrenIndex == i) {
                setState(() {
                  _hoveringChildrenIndex = null;
                });
              }
            },
            child: _SortableItem(
              key: widget.controller.value.items[i]._key,
              index: i,
              container: this,
              dragging: session?.index == i,
              reserving:
                  _sortTransferSessions.any((element) => element.index == i),
              canAccept: layerState?._sortSession != null,
              direction: widget.direction,
              dividerBuilder: widget.dividerBuilder,
              child: widget.builder(
                  context, widget.controller.value.items[i].value),
            ),
          );
        }),
      );
    }
    // divider
    List<Widget> dividedChildren;
    if (widget.dividerBuilder != null) {
      dividedChildren = [];
      for (int i = 0; i < widget.controller.length - 1; i++) {
        Widget divider = widget.dividerBuilder!(context, i);
        dividedChildren.add(children[i]);
        var session = layerState?._sortSession;
        dividedChildren.add(
          AnimatedSize(
            duration: kDefaultDuration,
            child: session?.index == i ? const SizedBox() : divider,
          ),
        );
      }
      if (dividedChildren.isNotEmpty) {
        dividedChildren.add(children.last);
      }
    } else {
      dividedChildren = children;
    }
    var session = layerState?._sortSession;
    if (widget.dividerBuilder != null) {
      dividedChildren.add(
        AnimatedSize(
          duration: kDefaultDuration,
          child: session == null ||
                  dividedChildren.isEmpty ||
                  (_hoveringChildrenIndex != null &&
                      _hoveringChildrenIndex != -1)
              ? const SizedBox()
              : Opacity(
                  opacity: 0,
                  child: widget.dividerBuilder!(context, session.index)),
        ),
      );
    }
    dividedChildren.add(
      AnimatedSize(
          duration: kDefaultDuration,
          child: session == null ||
                  (_hoveringChildrenIndex != null &&
                      _hoveringChildrenIndex != -1)
              ? const SizedBox()
              : Builder(builder: (context) {
                  return MouseRegion(
                    onEnter: (event) {
                      setState(() {
                        _hoveringChildrenIndex =
                            -1; // -1 marks as the last non-exist index
                      });
                    },
                    onExit: (event) {
                      if (_hoveringChildrenIndex == -1) {
                        setState(() {
                          _hoveringChildrenIndex = null;
                        });
                      }
                    },
                    child: _SortableItem(
                      index: -1,
                      container: this,
                      dragging: false,
                      reserving: false,
                      canAccept: false,
                      direction: widget.direction,
                      dividerBuilder: widget.dividerBuilder,
                      child: SizedBox.fromSize(
                        size: session.rect.size,
                      ),
                    ),
                  );
                })),
    );
    // Widget flexWidget = Flex(
    //   direction: widget.direction,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: dividedChildren,
    // );
    // if (widget.direction == Axis.horizontal) {
    //   flexWidget = IntrinsicHeight(
    //     child: flexWidget,
    //   );
    // } else {
    //   flexWidget = IntrinsicWidth(
    //     child: flexWidget,
    //   );
    // }
    return MetaData(
      metaData: this,
      child: ListView(
        scrollDirection: widget.direction,
        shrinkWrap: true,
        children: dividedChildren,
      ),
    );
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
  _SortableItemState? _sortableItemState;

  void _checkHit(Offset position) {
    HitTestResult result = HitTestResult();
    WidgetsBinding.instance
        .hitTestInView(result, position, View.of(context).viewId);
    for (var entry in result.path) {
      if (entry.target is RenderMetaData) {
        dynamic metaData = (entry.target as RenderMetaData).metaData;
        if (metaData is _SortableItemState) {
          _sortableItemState?._onExit();
          _sortableItemState = metaData;
          _sortableItemState?._onEnter();
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<SortableItemData>(context);
    final layerState = Data.of<_SortableLayerState>(context);
    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: GestureDetector(
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
            _checkHit(details.globalPosition);
          }
        },
        onPanEnd: (details) {
          if (data != null) {
            _sortableItemState?._onExit();
            HitTestResult result = HitTestResult();
            WidgetsBinding.instance.hitTestInView(
                result, details.globalPosition, View.of(context).viewId);
            for (var entry in result.path) {
              if (entry.target is RenderMetaData) {
                dynamic metaData = (entry.target as RenderMetaData).metaData;
                if (metaData is _SortableItemState) {
                  var session = layerState._sortSession!;
                  var canAccept = metaData.widget.container.widget.canAccept;
                  if (canAccept != null &&
                      !canAccept(DropDetails(
                          data.container.widget.controller[data.index],
                          metaData.widget.index,
                          metaData.widget.container))) {
                    data.container
                        ._stopDragging(data.index, true, data.sizeSupplier);
                    return;
                  }
                  metaData.widget.container
                      ._dropTarget(session, metaData.widget.index);
                  return;
                } else if (metaData is SortableState) {
                  var session = layerState._sortSession!;
                  var canAccept = metaData.widget.canAccept;
                  if (canAccept != null &&
                      !canAccept(DropDetails(
                          data.container.widget.controller[data.index],
                          -1,
                          metaData))) {
                    metaData._stopDragging(data.index, true, data.sizeSupplier);
                    return;
                  }
                  metaData._dropTarget(session, -1);
                  return;
                }
              }
            }
            data.container._stopDragging(data.index, true, data.sizeSupplier);
          }
        },
        onPanUpdate: (details) {
          if (data != null) {
            data.container._updateDragging(data.index, details.globalPosition);
            _checkHit(details.globalPosition);
          }
        },
        child: widget.child,
      ),
    );
  }
}

class SortableItemData {
  final int index;
  final SortableState container;
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
  final Widget? child;
  final int index;
  final SortableState container;
  final bool dragging;
  final bool reserving;
  final Axis direction;
  final SortableDividerBuilder? dividerBuilder;
  final bool canAccept;
  const _SortableItem({
    Key? key,
    required this.child,
    required this.index,
    required this.container,
    required this.dragging,
    required this.reserving,
    required this.direction,
    required this.dividerBuilder,
    this.canAccept = true,
  }) : super(key: key);

  @override
  State<_SortableItem> createState() => _SortableItemState();
}

class _SortableItemState extends State<_SortableItem> {
  final GlobalKey _key = GlobalKey();
  Rect? _hoveringRect;

  void _onEnter() {
    if (!mounted) {
      return;
    }
    final layerState = Data.of<_SortableLayerState>(context);
    if (layerState._sortSession != null) {
      setState(() {
        _hoveringRect = layerState._sortSession!.rect;
      });
    }
  }

  void _onExit() {
    if (!mounted) {
      return;
    }
    if (_hoveringRect == null) {
      return;
    }
    setState(() {
      _hoveringRect = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layerState = Data.of<_SortableLayerState>(context);
    Widget childWidget = Builder(builder: (context) {
      return Data(
          data: SortableItemData(
            widget.index,
            widget.container,
            () {
              final RenderBox renderBox =
                  context.findRenderObject() as RenderBox;
              return renderBox.localToGlobal(Offset.zero) & renderBox.size;
            },
            widget.dragging,
          ),
          child: AnimatedSize(
            duration: kDefaultDuration,
            child: widget.child == null
                ? null
                : Offstage(
                    offstage: widget.dragging,
                    child: Opacity(
                      key: _key,
                      opacity: widget.reserving ? 0 : 1,
                      child: widget.child!,
                    ),
                  ),
          ));
    });
    var hoveringRect = widget.canAccept ? _hoveringRect : null;
    List<Widget> children = [
      AnimatedSize(
        duration: kDefaultDuration,
        child: SizedBox.fromSize(
          size: hoveringRect?.size,
        ),
      ),
      // invisible divider
      if (widget.dividerBuilder != null)
        AnimatedSize(
          duration: kDefaultDuration,
          child: hoveringRect == null
              ? const SizedBox()
              : Opacity(
                  opacity: 0,
                  child: widget.dividerBuilder!(context, widget.index),
                ),
        ),
      childWidget,
    ];
    Widget flexWidget;
    if (widget.direction == Axis.horizontal) {
      flexWidget = IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      );
    } else {
      flexWidget = IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      );
    }
    return MetaData(
      metaData: this,
      behavior: HitTestBehavior.translucent,
      child: flexWidget,
    );
  }
}

typedef SortableItemPositionSupplier = Rect Function();
