import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A draggable widget that supports drag-and-drop reordering with directional drop zones.
///
/// The Sortable widget enables drag-and-drop interactions with support for four directional
/// drop zones (top, left, right, bottom). It provides customizable callbacks for handling
/// drop events, visual feedback during dragging, and placeholder widgets for smooth
/// reordering animations.
///
/// Features:
/// - Four directional drop zones with individual accept/reject logic
/// - Customizable ghost and placeholder widgets during drag operations
/// - Automatic scroll support when wrapped in ScrollableSortableLayer
/// - Visual feedback with animated placeholders and fallback widgets
/// - Robust drag session management with proper cleanup
///
/// The widget must be wrapped in a [SortableLayer] to function properly. Use
/// [ScrollableSortableLayer] for automatic scrolling during drag operations.
///
/// Example:
/// ```dart
/// SortableLayer(
///   child: Column(
///     children: [
///       Sortable<String>(
///         data: SortableData('Item 1'),
///         onAcceptTop: (data) => reorderAbove(data.data),
///         onAcceptBottom: (data) => reorderBelow(data.data),
///         child: Card(child: Text('Item 1')),
///       ),
///       Sortable<String>(
///         data: SortableData('Item 2'),
///         onAcceptTop: (data) => reorderAbove(data.data),
///         onAcceptBottom: (data) => reorderBelow(data.data),
///         child: Card(child: Text('Item 2')),
///       ),
///     ],
///   ),
/// )
/// ```
class Sortable<T> extends StatefulWidget {
  /// Predicate to determine if data can be accepted when dropped above this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the top are not accepted.
  /// Called before [onAcceptTop] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptTop;

  /// Predicate to determine if data can be accepted when dropped to the left of this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the left are not accepted.
  /// Called before [onAcceptLeft] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptLeft;

  /// Predicate to determine if data can be accepted when dropped to the right of this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the right are not accepted.
  /// Called before [onAcceptRight] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptRight;

  /// Predicate to determine if data can be accepted when dropped below this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the bottom are not accepted.
  /// Called before [onAcceptBottom] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptBottom;

  /// Callback invoked when data is successfully dropped above this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptTop]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptTop;

  /// Callback invoked when data is successfully dropped to the left of this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptLeft]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptLeft;

  /// Callback invoked when data is successfully dropped to the right of this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptRight]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptRight;

  /// Callback invoked when data is successfully dropped below this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptBottom]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptBottom;

  /// Callback invoked when a drag operation starts on this widget.
  ///
  /// Type: `VoidCallback?`. Called immediately when the user begins dragging
  /// this sortable item. Useful for providing haptic feedback or updating UI state.
  final VoidCallback? onDragStart;

  /// Callback invoked when a drag operation ends successfully.
  ///
  /// Type: `VoidCallback?`. Called when the drag completes with a successful drop.
  /// This is called before the appropriate accept callback.
  final VoidCallback? onDragEnd;

  /// Callback invoked when a drag operation is cancelled.
  ///
  /// Type: `VoidCallback?`. Called when the drag is cancelled without a successful
  /// drop, such as when the user releases outside valid drop zones.
  final VoidCallback? onDragCancel;

  /// The main child widget that will be made sortable.
  ///
  /// Type: `Widget`. This widget is displayed normally and becomes draggable
  /// when drag interactions are initiated.
  final Widget child;

  /// The data associated with this sortable item.
  ///
  /// Type: `SortableData<T>`. Contains the actual data being sorted and provides
  /// identity for the drag-and-drop operations.
  final SortableData<T> data;

  /// Widget displayed in drop zones when this item is being dragged over them.
  ///
  /// Type: `Widget?`. If null, uses [SizedBox.shrink]. This creates visual
  /// space in potential drop locations, providing clear feedback about where
  /// the item will be placed if dropped.
  final Widget? placeholder;

  /// Widget displayed while dragging instead of the original child.
  ///
  /// Type: `Widget?`. If null, uses [child]. Typically a semi-transparent
  /// or styled version of the child to provide visual feedback during dragging.
  final Widget? ghost;

  /// Widget displayed in place of the child while it's being dragged.
  ///
  /// Type: `Widget?`. If null, the original child becomes invisible but maintains
  /// its space. Used to show an alternative representation at the original location.
  final Widget? fallback;

  /// Widget displayed when the item is a candidate for dropping.
  ///
  /// Type: `Widget?`. Shows alternative styling when the dragged item hovers
  /// over this sortable as a potential drop target.
  final Widget? candidateFallback;

  /// Whether drag interactions are enabled for this sortable.
  ///
  /// Type: `bool`, default: `true`. When false, the widget cannot be dragged
  /// and will not respond to drag gestures.
  final bool enabled;

  /// How hit-testing behaves for drag gesture recognition.
  ///
  /// Type: `HitTestBehavior`, default: `HitTestBehavior.deferToChild`.
  /// Controls how the gesture detector participates in hit testing.
  final HitTestBehavior behavior;

  /// Callback invoked when a drop operation fails.
  ///
  /// Type: `VoidCallback?`. Called when the user drops outside of any valid
  /// drop zones or when drop validation fails.
  final VoidCallback? onDropFailed;

  /// Creates a [Sortable] widget with drag-and-drop functionality.
  ///
  /// Configures a widget that can be dragged and accepts drops from other
  /// sortable items. The widget supports directional drop zones and provides
  /// extensive customization for drag interactions and visual feedback.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [data] (`SortableData<T>`, required): Data associated with this sortable item
  /// - [child] (Widget, required): The main widget to make sortable
  /// - [enabled] (bool, default: true): Whether drag interactions are enabled
  /// - [canAcceptTop] (`Predicate<SortableData<T>>?`, optional): Validation for top drops
  /// - [canAcceptLeft] (`Predicate<SortableData<T>>?`, optional): Validation for left drops
  /// - [canAcceptRight] (`Predicate<SortableData<T>>?`, optional): Validation for right drops
  /// - [canAcceptBottom] (`Predicate<SortableData<T>>?`, optional): Validation for bottom drops
  /// - [onAcceptTop] (`ValueChanged<SortableData<T>>?`, optional): Handler for top drops
  /// - [onAcceptLeft] (`ValueChanged<SortableData<T>>?`, optional): Handler for left drops
  /// - [onAcceptRight] (`ValueChanged<SortableData<T>>?`, optional): Handler for right drops
  /// - [onAcceptBottom] (`ValueChanged<SortableData<T>>?`, optional): Handler for bottom drops
  /// - [placeholder] (Widget?, default: SizedBox()): Widget shown in drop zones
  /// - [ghost] (Widget?, optional): Widget displayed while dragging
  /// - [fallback] (Widget?, optional): Widget shown at original position during drag
  /// - [candidateFallback] (Widget?, optional): Widget shown when item is drop candidate
  /// - [onDragStart] (VoidCallback?, optional): Called when drag starts
  /// - [onDragEnd] (VoidCallback?, optional): Called when drag ends successfully
  /// - [onDragCancel] (VoidCallback?, optional): Called when drag is cancelled
  /// - [behavior] (HitTestBehavior, default: HitTestBehavior.deferToChild): Hit test behavior
  /// - [onDropFailed] (VoidCallback?, optional): Called when drop fails
  ///
  /// Example:
  /// ```dart
  /// Sortable<String>(
  ///   data: SortableData('item_1'),
  ///   onAcceptTop: (data) => moveAbove(data.data),
  ///   onAcceptBottom: (data) => moveBelow(data.data),
  ///   placeholder: Container(height: 2, color: Colors.blue),
  ///   child: ListTile(title: Text('Draggable Item')),
  /// )
  /// ```
  const Sortable({
    super.key,
    this.enabled = true,
    required this.data,
    this.canAcceptTop,
    this.canAcceptLeft,
    this.canAcceptRight,
    this.canAcceptBottom,
    this.onAcceptTop,
    this.onAcceptLeft,
    this.onAcceptRight,
    this.onAcceptBottom,
    this.placeholder = const SizedBox(),
    this.ghost,
    this.fallback,
    this.candidateFallback,
    this.onDragStart,
    this.onDragEnd,
    this.onDragCancel,
    this.behavior = HitTestBehavior.deferToChild,
    this.onDropFailed,
    required this.child,
  });

  @override
  State<Sortable<T>> createState() => _SortableState<T>();
}

class _SortableDraggingSession<T> {
  final GlobalKey key = GlobalKey();
  final Matrix4 transform;
  final Size size;
  final Widget ghost;
  final Widget placeholder;
  final SortableData<T> data;
  final ValueNotifier<Offset> offset;
  final _SortableLayerState layer;
  final RenderBox layerRenderBox;
  final Offset minOffset;
  final Offset maxOffset;
  final bool lock;
  final _SortableState<T> target;

  _SortableDraggingSession({
    required this.target,
    required this.layer,
    required this.layerRenderBox,
    required this.maxOffset,
    required this.transform,
    required this.size,
    required this.ghost,
    required this.placeholder,
    required this.data,
    required this.minOffset,
    required this.lock,
    required Offset offset,
  }) : offset = ValueNotifier(offset);
}

enum _SortableDropLocation {
  top,
  left,
  right,
  bottom,
}

_SortableDropLocation? _getPosition(Offset position, Size size,
    {bool acceptTop = false,
    bool acceptLeft = false,
    bool acceptRight = false,
    bool acceptBottom = false}) {
  double dx = position.dx;
  double dy = position.dy;
  double width = size.width;
  double height = size.height;
  if (acceptTop && !acceptBottom) {
    return _SortableDropLocation.top;
  } else if (acceptBottom && !acceptTop) {
    return _SortableDropLocation.bottom;
  } else if (acceptLeft && !acceptRight) {
    return _SortableDropLocation.left;
  } else if (acceptRight && !acceptLeft) {
    return _SortableDropLocation.right;
  }
  if (acceptTop && dy <= height / 2) {
    return _SortableDropLocation.top;
  }
  if (acceptLeft && dx <= width / 2) {
    return _SortableDropLocation.left;
  }
  if (acceptRight && dx >= width / 2) {
    return _SortableDropLocation.right;
  }
  if (acceptBottom && dy >= height / 2) {
    return _SortableDropLocation.bottom;
  }
  return null;
}

/// A fallback drop zone for sortable items when dropped outside specific sortable widgets.
///
/// SortableDropFallback provides a catch-all drop zone that can accept sortable
/// items when they're dropped outside of any specific sortable widget drop zones.
/// This is useful for implementing deletion zones, creation areas, or general
/// drop handling areas.
///
/// The widget wraps its child with an invisible hit test layer that can detect
/// and accept dropped sortable items based on configurable acceptance criteria.
///
/// Example:
/// ```dart
/// SortableDropFallback<String>(
///   canAccept: (data) => data.data.startsWith('temp_'),
///   onAccept: (data) => deleteItem(data.data),
///   child: Container(
///     height: 100,
///     child: Center(child: Text('Drop here to delete')),
///   ),
/// )
/// ```
class SortableDropFallback<T> extends StatefulWidget {
  /// Callback invoked when a sortable item is dropped on this fallback zone.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. Receives the dropped item's data
  /// and should handle the drop operation. Only called if [canAccept] validation
  /// passes or is null.
  final ValueChanged<SortableData<T>>? onAccept;

  /// Predicate to determine if dropped data can be accepted by this fallback zone.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, all sortable items are accepted.
  /// Return true to accept the drop, false to reject it.
  final Predicate<SortableData<T>>? canAccept;

  /// The child widget that defines the drop zone area.
  ///
  /// Type: `Widget`. This widget's bounds determine the area where drops can
  /// be detected. The child is rendered normally with an invisible overlay
  /// for drop detection.
  final Widget child;

  /// Creates a [SortableDropFallback] drop zone.
  ///
  /// Configures a fallback drop zone that can accept sortable items dropped
  /// outside of specific sortable widget drop zones.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): The widget that defines the drop zone area
  /// - [onAccept] (`ValueChanged<SortableData<T>>?`, optional): Handler for accepted drops
  /// - [canAccept] (`Predicate<SortableData<T>>?`, optional): Validation for drops
  ///
  /// Example:
  /// ```dart
  /// SortableDropFallback<String>(
  ///   canAccept: (data) => data.data.contains('removable'),
  ///   onAccept: (data) => removeFromList(data.data),
  ///   child: Icon(Icons.delete, size: 48),
  /// )
  /// ```
  const SortableDropFallback({
    super.key,
    required this.child,
    this.onAccept,
    this.canAccept,
  });

  @override
  State<SortableDropFallback<T>> createState() =>
      _SortableDropFallbackState<T>();
}

class _SortableDropFallbackState<T> extends State<SortableDropFallback<T>> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: MetaData(
            behavior: HitTestBehavior.translucent,
            metaData: this,
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _DroppingTarget<T> {
  final _SortableState<T> source;
  final ValueNotifier<_SortableDraggingSession<T>?> candidate;
  final _SortableDropLocation location;

  _DroppingTarget({
    required this.source,
    required this.candidate,
    required this.location,
  });

  void dispose(_SortableDraggingSession<T> target) {
    if (candidate.value == target) {
      candidate.value = null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _DroppingTarget<T> &&
        other.source == source &&
        other.candidate == candidate &&
        other.location == location;
  }

  @override
  int get hashCode => Object.hash(source, candidate, location);

  @override
  String toString() => '_DroppingTarget($source, $location)';
}

class _DropTransform {
  final _SortableLayerState layer;
  final Matrix4 from;
  final Matrix4 to;
  final Widget child;
  final _SortableState state;

  Duration? start;

  final ValueNotifier<double> progress = ValueNotifier(0);

  _DropTransform({
    required this.layer,
    required this.from,
    required this.to,
    required this.child,
    required this.state,
  });
}

class _SortableState<T> extends State<Sortable<T>>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<_SortableDraggingSession<T>?> topCandidate =
      ValueNotifier(null);
  final ValueNotifier<_SortableDraggingSession<T>?> leftCandidate =
      ValueNotifier(null);
  final ValueNotifier<_SortableDraggingSession<T>?> rightCandidate =
      ValueNotifier(null);
  final ValueNotifier<_SortableDraggingSession<T>?> bottomCandidate =
      ValueNotifier(null);

  final ValueNotifier<_DroppingTarget<T>?> _currentTarget = ValueNotifier(null);
  final ValueNotifier<_SortableDropFallbackState<T>?> _currentFallback =
      ValueNotifier(null);
  final ValueNotifier<bool> _hasClaimedDrop = ValueNotifier(false);
  final ValueNotifier<bool> _hasDraggedOff = ValueNotifier(false);

  (_SortableState<T>, Offset)? _findState(
      _SortableLayerState target, Offset globalPosition) {
    BoxHitTestResult result = BoxHitTestResult();
    RenderBox renderBox = target.context.findRenderObject() as RenderBox;
    renderBox.hitTest(result, position: globalPosition);
    for (final HitTestEntry entry in result.path) {
      if (entry.target is RenderMetaData) {
        RenderMetaData metaData = entry.target as RenderMetaData;
        if (metaData.metaData is _SortableState<T> &&
            metaData.metaData != this) {
          return (
            metaData.metaData as _SortableState<T>,
            (entry as BoxHitTestEntry).localPosition
          );
        }
      }
    }
    return null;
  }

  _SortableDropFallbackState<T>? _findFallbackState(
      _SortableLayerState target, Offset globalPosition) {
    BoxHitTestResult result = BoxHitTestResult();
    RenderBox renderBox = target.context.findRenderObject() as RenderBox;
    renderBox.hitTest(result, position: globalPosition);
    for (final HitTestEntry entry in result.path) {
      if (entry.target is RenderMetaData) {
        RenderMetaData metaData = entry.target as RenderMetaData;
        if (metaData.metaData is _SortableDropFallbackState<T> &&
            metaData.metaData != this) {
          return metaData.metaData as _SortableDropFallbackState<T>;
        }
      }
    }
    return null;
  }

  bool _dragging = false;
  bool _claimUnchanged = false;
  _SortableDraggingSession<T>? _session;

  _ScrollableSortableLayerState? _scrollableLayer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollableLayer = Data.maybeOf<_ScrollableSortableLayerState>(context);
  }

  void _onDragStart(DragStartDetails details) {
    if (_hasClaimedDrop.value) {
      return;
    }
    _hasDraggedOff.value = false;
    _SortableLayerState? layer = Data.maybeFind<_SortableLayerState>(context);
    assert(layer != null, 'Sortable must be a descendant of SortableLayer');
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    RenderBox layerRenderBox = layer!.context.findRenderObject() as RenderBox;
    Matrix4 transform = renderBox.getTransformTo(layerRenderBox);
    Size size = renderBox.size;
    Offset minOffset = MatrixUtils.transformPoint(transform, Offset.zero);
    Offset maxOffset = MatrixUtils.transformPoint(
      transform,
      Offset(size.width, size.height),
    );
    final ghost = widget.ghost ?? widget.child;
    final candidateFallback = widget.candidateFallback;
    _session = _SortableDraggingSession(
      layer: layer,
      layerRenderBox: layerRenderBox,
      target: this,
      transform: transform,
      size: size,
      ghost: ListenableBuilder(
        listenable: _currentTarget,
        builder: (context, child) {
          if (_currentTarget.value != null) {
            return candidateFallback ?? widget.child;
          }
          return ghost;
        },
      ),
      placeholder: widget.placeholder ?? widget.child,
      data: widget.data,
      minOffset: minOffset,
      maxOffset: maxOffset,
      lock: layer.widget.lock,
      offset: Offset.zero,
    );
    layer.pushDraggingSession(_session!);
    widget.onDragStart?.call();
    setState(() {
      _dragging = true;
    });
    _scrollableLayer?._startDrag(this, details.globalPosition);
  }

  ValueNotifier<_SortableDraggingSession<T>?> _getByLocation(
      _SortableDropLocation location) {
    switch (location) {
      case _SortableDropLocation.top:
        return topCandidate;
      case _SortableDropLocation.left:
        return leftCandidate;
      case _SortableDropLocation.right:
        return rightCandidate;
      case _SortableDropLocation.bottom:
        return bottomCandidate;
    }
  }

  void _handleDrag(Offset delta) {
    Offset minOffset = _session!.minOffset;
    Offset maxOffset = _session!.maxOffset;
    if (_session != null) {
      RenderBox sessionRenderBox =
          _session!.layer.context.findRenderObject() as RenderBox;
      Size size = sessionRenderBox.size;
      if (_session!.lock) {
        double minX = -minOffset.dx;
        double maxX = size.width - maxOffset.dx;
        double minY = -minOffset.dy;
        double maxY = size.height - maxOffset.dy;
        _session!.offset.value = Offset(
          (_session!.offset.value.dx + delta.dx).clamp(
            min(minX, maxX),
            max(minX, maxX),
          ),
          (_session!.offset.value.dy + delta.dy).clamp(
            min(minY, maxY),
            max(minY, maxY),
          ),
        );
      } else {
        _session!.offset.value += delta;
      }
      Offset globalPosition = _session!.offset.value +
          minOffset +
          Offset((maxOffset.dx - minOffset.dx) / 2,
              (maxOffset.dy - minOffset.dy) / 2);
      (_SortableState<T>, Offset)? target =
          _findState(_session!.layer, globalPosition);
      if (target == null) {
        _SortableDropFallbackState<T>? fallback =
            _findFallbackState(_session!.layer, globalPosition);
        _currentFallback.value = fallback;
        if (_currentTarget.value != null && fallback == null) {
          _currentTarget.value!.dispose(_session!);
          _currentTarget.value = null;
        }
      } else {
        _hasDraggedOff.value = true;
        _currentFallback.value = null;
        if (_currentTarget.value != null) {
          _currentTarget.value!.dispose(_session!);
        }
        var targetRenderBox = target.$1.context.findRenderObject() as RenderBox;
        var size = targetRenderBox.size;
        _SortableDropLocation? location = _getPosition(
          target.$2,
          size,
          acceptTop: widget.onAcceptTop != null,
          acceptLeft: widget.onAcceptLeft != null,
          acceptRight: widget.onAcceptRight != null,
          acceptBottom: widget.onAcceptBottom != null,
        );
        if (location != null) {
          ValueNotifier<_SortableDraggingSession<T>?> candidate =
              target.$1._getByLocation(location);

          candidate.value = _session;
          _currentTarget.value = _DroppingTarget(
              candidate: candidate, source: target.$1, location: location);
        }
      }
    }
  }

  ValueChanged<SortableData<T>>? _getCallback(_SortableDropLocation location) {
    switch (location) {
      case _SortableDropLocation.top:
        return widget.onAcceptTop;
      case _SortableDropLocation.left:
        return widget.onAcceptLeft;
      case _SortableDropLocation.right:
        return widget.onAcceptRight;
      case _SortableDropLocation.bottom:
        return widget.onAcceptBottom;
    }
  }

  Predicate<SortableData<T>>? _getPredicate(_SortableDropLocation location) {
    switch (location) {
      case _SortableDropLocation.top:
        return widget.canAcceptTop;
      case _SortableDropLocation.left:
        return widget.canAcceptLeft;
      case _SortableDropLocation.right:
        return widget.canAcceptRight;
      case _SortableDropLocation.bottom:
        return widget.canAcceptBottom;
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_hasClaimedDrop.value) {
      return;
    }
    _handleDrag(details.delta);
    _scrollableLayer?._updateDrag(this, details.globalPosition);
  }

  void _onDragEnd(DragEndDetails details) {
    widget.onDragEnd?.call();
    if (_session != null) {
      if (_currentTarget.value != null) {
        _currentTarget.value!.dispose(_session!);
        var target = _currentTarget.value!.source;
        var location = _currentTarget.value!.location;
        var predicate = target._getPredicate(location);
        var sortData = _session!.data;
        if (predicate == null || predicate(sortData)) {
          var callback = target._getCallback(location);
          if (callback != null) {
            callback(sortData);
          }
        }
        _session!.layer.removeDraggingSession(_session!);
        _currentTarget.value = null;
      } else if (_hasDraggedOff.value) {
        var target = _currentFallback.value;
        if (target != null) {
          var sortData = _session!.data;
          if (target.widget.canAccept == null ||
              target.widget.canAccept!(sortData)) {
            target.widget.onAccept?.call(sortData);
          }
        }
        _session!.layer.removeDraggingSession(_session!);
        if (target == null) {
          _session!.layer._claimDrop(this, _session!.data, true);
        }
      } else {
        // basically the same as drag cancel, because the drag has not been
        // dragged off of itself
        _session!.layer.removeDraggingSession(_session!);
        widget.onDropFailed?.call();
        _session!.layer._claimDrop(this, _session!.data, true);
      }
      _claimUnchanged = true;
      _session = null;
    }
    setState(() {
      _dragging = false;
    });
    _scrollableLayer?._endDrag(this);
  }

  void _onDragCancel() {
    if (_session != null) {
      if (_currentTarget.value != null) {
        _currentTarget.value!.dispose(_session!);
        _currentTarget.value = null;
      }
      _session!.layer.removeDraggingSession(_session!);
      _session!.layer._claimDrop(this, _session!.data, true);
      _session = null;
    }
    setState(() {
      _dragging = false;
    });
    widget.onDragCancel?.call();
    _scrollableLayer?._endDrag(this);
  }

  @override
  void initState() {
    super.initState();
    final layer = Data.maybeFind<_SortableLayerState>(context);
    if (layer != null) {
      var data = widget.data;
      if (layer._canClaimDrop(this, data)) {
        _hasClaimedDrop.value = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted) {
            layer._claimDrop(this, data);
          }
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant Sortable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (!widget.enabled && _dragging) {
        _onDragCancel();
      }
    }
    if (widget.data != oldWidget.data || _claimUnchanged) {
      _claimUnchanged = false;
      final layer = Data.maybeFind<_SortableLayerState>(context);
      if (layer != null && layer._canClaimDrop(this, widget.data)) {
        _hasClaimedDrop.value = true;
        final data = widget.data;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted) {
            layer._claimDrop(this, data);
          }
        });
      }
    }
  }

  final GlobalKey _key = GlobalKey();
  final GlobalKey _gestureKey = GlobalKey();

  Widget _buildAnimatedSize({
    AlignmentGeometry alignment = Alignment.center,
    Widget? child,
    bool hasCandidate = false,
    required Duration duration,
  }) {
    if (!hasCandidate) {
      return child!;
    }
    return AnimatedSize(
      duration: duration,
      alignment: alignment,
      child: child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_dragging) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _scrollableLayer?._endDrag(this);
        _session!.layer.removeDraggingSession(_session!);
        _currentTarget.value = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final layer = Data.of<_SortableLayerState>(context);
    return MetaData(
      behavior: HitTestBehavior.translucent,
      metaData: this,
      // must define the generic type to avoid type inference _SortableState<T>
      child: Data<_SortableState>.inherit(
        data: this,
        child: ListenableBuilder(
          listenable: layer._sessions,
          builder: (context, child) {
            bool hasCandidate = layer._sessions.value.isNotEmpty;
            Widget container = GestureDetector(
              key: _gestureKey,
              behavior: widget.behavior,
              onPanStart: widget.enabled ? _onDragStart : null,
              onPanUpdate: widget.enabled ? _onDragUpdate : null,
              onPanEnd: widget.enabled ? _onDragEnd : null,
              onPanCancel: widget.enabled ? _onDragCancel : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AbsorbPointer(
                    child: _buildAnimatedSize(
                      duration: kDefaultDuration,
                      alignment: Alignment.centerRight,
                      hasCandidate: hasCandidate,
                      child: ListenableBuilder(
                        listenable: leftCandidate,
                        builder: (context, child) {
                          if (leftCandidate.value != null) {
                            return SizedBox.fromSize(
                              size: leftCandidate.value!.size,
                              child: leftCandidate.value!.placeholder,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AbsorbPointer(
                          child: _buildAnimatedSize(
                            duration: kDefaultDuration,
                            alignment: Alignment.bottomCenter,
                            hasCandidate: hasCandidate,
                            child: ListenableBuilder(
                              listenable: topCandidate,
                              builder: (context, child) {
                                if (topCandidate.value != null) {
                                  return SizedBox.fromSize(
                                    size: topCandidate.value!.size,
                                    child: topCandidate.value!.placeholder,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: _dragging
                              ? widget.fallback ??
                                  ListenableBuilder(
                                    listenable: _hasDraggedOff,
                                    builder: (context, child) {
                                      return (_hasDraggedOff.value
                                          ? AbsorbPointer(
                                              child: Visibility(
                                                visible: false,
                                                maintainState: true,
                                                child: KeyedSubtree(
                                                  key: _key,
                                                  child: widget.child,
                                                ),
                                              ),
                                            )
                                          : AbsorbPointer(
                                              child: Visibility(
                                                maintainSize: true,
                                                maintainAnimation: true,
                                                maintainState: true,
                                                visible: false,
                                                child: KeyedSubtree(
                                                  key: _key,
                                                  child: widget.child,
                                                ),
                                              ),
                                            ));
                                    },
                                  )
                              : ListenableBuilder(
                                  listenable: _hasClaimedDrop,
                                  builder: (context, child) {
                                    return IgnorePointer(
                                      ignoring:
                                          hasCandidate || _hasClaimedDrop.value,
                                      child: Visibility(
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        visible: !_hasClaimedDrop.value,
                                        child: KeyedSubtree(
                                          key: _key,
                                          child: widget.child,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        AbsorbPointer(
                          child: _buildAnimatedSize(
                            duration: kDefaultDuration,
                            alignment: Alignment.topCenter,
                            hasCandidate: hasCandidate,
                            child: ListenableBuilder(
                              listenable: bottomCandidate,
                              builder: (context, child) {
                                if (bottomCandidate.value != null) {
                                  return SizedBox.fromSize(
                                    size: bottomCandidate.value!.size,
                                    child: bottomCandidate.value!.placeholder,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AbsorbPointer(
                    child: _buildAnimatedSize(
                      duration: kDefaultDuration,
                      alignment: Alignment.centerLeft,
                      hasCandidate: hasCandidate,
                      child: ListenableBuilder(
                        listenable: rightCandidate,
                        builder: (context, child) {
                          if (rightCandidate.value != null) {
                            return SizedBox.fromSize(
                              size: rightCandidate.value!.size,
                              child: rightCandidate.value!.placeholder,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
            if (!hasCandidate) {
              return container;
            }
            return AnimatedSize(
              duration: kDefaultDuration,
              child: container,
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => _dragging;
}

/// A dedicated drag handle for initiating sortable drag operations.
///
/// SortableDragHandle provides a specific area within a sortable widget that
/// can be used to initiate drag operations. This is useful when you want to
/// restrict drag initiation to a specific handle area rather than the entire
/// sortable widget.
///
/// The handle automatically detects its parent Sortable widget and delegates
/// drag operations to it. It provides visual feedback with appropriate mouse
/// cursors and can be enabled/disabled independently.
///
/// Features:
/// - Dedicated drag initiation area within sortable widgets
/// - Automatic mouse cursor management (grab/grabbing states)
/// - Independent enable/disable control
/// - Automatic cleanup and lifecycle management
///
/// Example:
/// ```dart
/// Sortable<String>(
///   data: SortableData('item'),
///   child: Row(
///     children: [
///       SortableDragHandle(
///         child: Icon(Icons.drag_handle),
///       ),
///       Expanded(child: Text('Drag me by the handle')),
///     ],
///   ),
/// )
/// ```
class SortableDragHandle extends StatefulWidget {
  /// The child widget that serves as the drag handle.
  ///
  /// Type: `Widget`. This widget defines the visual appearance of the drag handle
  /// and responds to drag gestures. Commonly an icon like Icons.drag_handle.
  final Widget child;

  /// Whether the drag handle is enabled for drag operations.
  ///
  /// Type: `bool`, default: `true`. When false, the handle will not respond to
  /// drag gestures and shows the default cursor instead of grab cursors.
  final bool enabled;

  /// How hit-testing behaves for this drag handle.
  ///
  /// Type: `HitTestBehavior?`. Controls how the gesture detector and mouse region
  /// participate in hit testing. If null, uses default behavior.
  final HitTestBehavior? behavior;

  /// The mouse cursor displayed when hovering over the drag handle.
  ///
  /// Type: `MouseCursor?`. If null, uses SystemMouseCursors.grab when enabled,
  /// or MouseCursor.defer when disabled. Changes to SystemMouseCursors.grabbing
  /// during active drag operations.
  final MouseCursor? cursor;

  /// Creates a [SortableDragHandle] for initiating drag operations.
  ///
  /// Configures a dedicated drag handle that can initiate drag operations for
  /// its parent sortable widget. The handle provides visual feedback and can
  /// be independently enabled or disabled.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): The widget that serves as the drag handle
  /// - [enabled] (bool, default: true): Whether drag operations are enabled
  /// - [behavior] (HitTestBehavior?, optional): Hit test behavior for gestures
  /// - [cursor] (MouseCursor?, optional): Mouse cursor when hovering
  ///
  /// Example:
  /// ```dart
  /// SortableDragHandle(
  ///   enabled: isDragEnabled,
  ///   cursor: SystemMouseCursors.move,
  ///   child: Container(
  ///     padding: EdgeInsets.all(8),
  ///     child: Icon(Icons.drag_indicator),
  ///   ),
  /// )
  /// ```
  const SortableDragHandle(
      {super.key,
      required this.child,
      this.enabled = true,
      this.behavior,
      this.cursor});

  @override
  State<SortableDragHandle> createState() => _SortableDragHandleState();
}

class _SortableDragHandleState extends State<SortableDragHandle>
    with AutomaticKeepAliveClientMixin {
  _SortableState? _state;

  bool _dragging = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = Data.maybeOf<_SortableState>(context);
  }

  @override
  bool get wantKeepAlive {
    return _dragging;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MouseRegion(
      cursor: widget.enabled
          ? (widget.cursor ?? SystemMouseCursors.grab)
          : MouseCursor.defer,
      hitTestBehavior: widget.behavior,
      child: GestureDetector(
        behavior: widget.behavior,
        onPanStart: widget.enabled && _state != null
            ? (details) {
                _dragging = true;
                _state!._onDragStart(details);
              }
            : null,
        onPanUpdate:
            widget.enabled && _state != null ? _state!._onDragUpdate : null,
        onPanEnd: widget.enabled && _state != null
            ? (details) {
                _state!._onDragEnd(details);
                _dragging = false;
              }
            : null,
        onPanCancel: widget.enabled && _state != null
            ? () {
                _state!._onDragCancel();
                _dragging = false;
              }
            : null,
        child: widget.child,
      ),
    );
  }
}

/// Immutable data wrapper for sortable items in drag-and-drop operations.
///
/// SortableData wraps the actual data being sorted and provides identity for
/// drag-and-drop operations. Each sortable item must have associated data that
/// uniquely identifies it within the sorting context.
///
/// The class is immutable and uses reference equality for comparison, ensuring
/// that each sortable item maintains its identity throughout drag operations.
/// This is crucial for proper drop validation and handling.
///
/// Type parameter [T] represents the type of data being sorted, which can be
/// any type including primitive types, custom objects, or complex data structures.
///
/// Example:
/// ```dart
/// // Simple string data
/// SortableData<String>('item_1')
///
/// // Complex object data
/// SortableData<TodoItem>(TodoItem(id: 1, title: 'Task 1'))
///
/// // Map data
/// SortableData<Map<String, dynamic>>({'id': 1, 'name': 'Item'})
/// ```
@immutable
class SortableData<T> {
  /// The actual data being wrapped for sorting operations.
  ///
  /// Type: `T`. This is the data that will be passed to drop handlers and
  /// validation predicates. Can be any type that represents the sortable item.
  final T data;

  /// Creates a [SortableData] wrapper for the given data.
  ///
  /// Wraps the provided data in an immutable container that can be used with
  /// sortable widgets for drag-and-drop operations.
  ///
  /// Parameters:
  /// - [data] (T, required): The data to wrap for sorting operations
  ///
  /// Example:
  /// ```dart
  /// // Wrapping different data types
  /// SortableData('text_item')
  /// SortableData(42)
  /// SortableData(MyCustomObject(id: 1))
  /// ```
  const SortableData(this.data);

  @override
  @nonVirtual
  bool operator ==(Object other) => super == other;

  @override
  @nonVirtual
  int get hashCode => super.hashCode;

  @override
  String toString() => 'SortableData($data)';
}

/// A layer widget that manages drag-and-drop sessions for sortable widgets.
///
/// SortableLayer is a required wrapper that coordinates drag-and-drop operations
/// between multiple sortable widgets. It provides the infrastructure for managing
/// drag sessions, rendering ghost elements during dragging, and handling drop
/// animations.
///
/// The layer maintains the drag state and provides a rendering context for ghost
/// widgets that follow the cursor during drag operations. It also manages drop
/// animations and cleanup when drag operations complete.
///
/// Features:
/// - Centralized drag session management across multiple sortable widgets
/// - Ghost widget rendering with cursor following during drag operations
/// - Configurable drop animations with custom duration and curves
/// - Boundary locking to constrain drag operations within the layer bounds
/// - Automatic cleanup and state management for drag sessions
///
/// All sortable widgets must be descendants of a SortableLayer to function properly.
/// The layer should be placed at a level that encompasses all related sortable widgets.
///
/// Example:
/// ```dart
/// SortableLayer(
///   lock: true, // Constrain dragging within bounds
///   dropDuration: Duration(milliseconds: 300),
///   dropCurve: Curves.easeOut,
///   child: Column(
///     children: [
///       Sortable(...),
///       Sortable(...),
///       Sortable(...),
///     ],
///   ),
/// )
/// ```
class SortableLayer extends StatefulWidget {
  /// The child widget tree containing sortable widgets.
  ///
  /// Type: `Widget`. All sortable widgets must be descendants of this child
  /// tree to function properly with the layer.
  final Widget child;

  /// Whether to lock dragging within the layer's bounds.
  ///
  /// Type: `bool`, default: `false`. When true, dragged items cannot be moved
  /// outside the layer's visual bounds, providing spatial constraints.
  final bool lock;

  /// The clipping behavior for the layer.
  ///
  /// Type: `Clip?`. Controls how content is clipped. If null, uses Clip.hardEdge
  /// when [lock] is true, otherwise Clip.none.
  final Clip? clipBehavior;

  /// Duration for drop animations when drag operations complete.
  ///
  /// Type: `Duration?`. If null, uses the default duration. Set to Duration.zero
  /// to disable drop animations entirely.
  final Duration? dropDuration;

  /// Animation curve for drop transitions.
  ///
  /// Type: `Curve?`. If null, uses Curves.easeInOut. Controls the easing
  /// behavior of items animating to their final drop position.
  final Curve? dropCurve;

  /// Creates a [SortableLayer] to manage drag-and-drop operations.
  ///
  /// Configures the layer that coordinates drag sessions between sortable widgets
  /// and provides the rendering context for drag operations.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): The widget tree containing sortable widgets
  /// - [lock] (bool, default: false): Whether to constrain dragging within bounds
  /// - [clipBehavior] (Clip?, optional): How to clip the layer content
  /// - [dropDuration] (Duration?, optional): Duration for drop animations
  /// - [dropCurve] (Curve?, optional): Curve for drop animation easing
  ///
  /// Example:
  /// ```dart
  /// SortableLayer(
  ///   lock: true,
  ///   dropDuration: Duration(milliseconds: 250),
  ///   dropCurve: Curves.easeInOutCubic,
  ///   child: ListView(
  ///     children: sortableItems.map((item) => Sortable(...)).toList(),
  ///   ),
  /// )
  /// ```
  const SortableLayer({
    super.key,
    this.lock = false,
    this.clipBehavior,
    this.dropDuration,
    this.dropCurve,
    required this.child,
  });

  @override
  State<SortableLayer> createState() => _SortableLayerState();

  /// Ensures a pending drop operation is completed and dismisses it.
  ///
  /// Finds the sortable layer in the widget tree and ensures that any pending
  /// drop operation for the specified data is completed and dismissed. This is
  /// useful for programmatically finalizing drop operations.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to find the layer from
  /// - [data] (Object): The data associated with the drop operation to dismiss
  ///
  /// Example:
  /// ```dart
  /// // After programmatic reordering
  /// SortableLayer.ensureAndDismissDrop(context, sortableData);
  /// ```
  static void ensureAndDismissDrop(BuildContext context, Object data) {
    final layer = Data.of<_SortableLayerState>(context);
    layer.ensureAndDismissDrop(data);
  }

  /// Dismisses any pending drop operations.
  ///
  /// Finds the sortable layer in the widget tree and dismisses any currently
  /// pending drop operations. This clears any visual feedback or animations
  /// related to incomplete drops.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to find the layer from
  ///
  /// Example:
  /// ```dart
  /// // Clear any pending drops when navigating away
  /// SortableLayer.dismissDrop(context);
  /// ```
  static void dismissDrop(BuildContext context) {
    final layer = Data.of<_SortableLayerState>(context);
    layer.dismissDrop();
  }
}

class _PendingDropTransform {
  final Matrix4 from;
  final Widget child;
  final SortableData data;

  _PendingDropTransform({
    required this.from,
    required this.child,
    required this.data,
  });
}

class _SortableLayerState extends State<SortableLayer>
    with SingleTickerProviderStateMixin {
  final MutableNotifier<List<_SortableDraggingSession>> _sessions =
      MutableNotifier([]);
  final MutableNotifier<List<_DropTransform>> _activeDrops =
      MutableNotifier([]);

  final ValueNotifier<_PendingDropTransform?> _pendingDrop =
      ValueNotifier(null);

  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  void ensureAndDismissDrop(Object data) {
    if (_pendingDrop.value != null && data == _pendingDrop.value!.data) {
      _pendingDrop.value = null;
    }
  }

  void dismissDrop() {
    _pendingDrop.value = null;
  }

  bool _canClaimDrop(_SortableState item, Object? data) {
    return _pendingDrop.value != null && data == _pendingDrop.value!.data;
  }

  _DropTransform? _claimDrop(_SortableState item, SortableData data,
      [bool force = false]) {
    if (_pendingDrop.value != null &&
        (force || data == _pendingDrop.value!.data)) {
      RenderBox layerRenderBox = context.findRenderObject() as RenderBox;
      RenderBox itemRenderBox = item.context.findRenderObject() as RenderBox;
      var dropTransform = _DropTransform(
        layer: this,
        from: _pendingDrop.value!.from,
        to: itemRenderBox.getTransformTo(layerRenderBox),
        child: _pendingDrop.value!.child,
        state: item,
      );
      _activeDrops.mutate((value) {
        value.add(dropTransform);
      });
      item._hasClaimedDrop.value = true;
      _pendingDrop.value = null;
      if (!_ticker.isActive) {
        _ticker.start();
      }
      return dropTransform;
    }
    return null;
  }

  void _tick(Duration elapsed) {
    List<_DropTransform> toRemove = [];
    for (final drop in _activeDrops.value) {
      drop.start ??= elapsed;
      double progress = ((elapsed - drop.start!).inMilliseconds /
              (widget.dropDuration ?? kDefaultDuration).inMilliseconds)
          .clamp(0, 1);
      progress = (widget.dropCurve ?? Curves.easeInOut).transform(progress);
      if (progress >= 1 || !drop.state.mounted) {
        drop.state._hasClaimedDrop.value = false;
        toRemove.add(drop);
      } else {
        drop.progress.value = progress;
      }
    }
    _activeDrops.mutate((value) {
      value.removeWhere((element) => toRemove.contains(element));
    });
    if (_activeDrops.value.isEmpty) {
      _ticker.stop();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  Matrix4 _tweenMatrix(Matrix4 from, Matrix4 to, double progress) {
    return Matrix4Tween(
      begin: from,
      end: to,
    ).transform(progress);
  }

  void pushDraggingSession(_SortableDraggingSession session) {
    _sessions.mutate(
      (value) {
        value.add(session);
      },
    );
  }

  void removeDraggingSession(_SortableDraggingSession session) {
    if (!mounted) {
      return;
    }
    if (_sessions.value.contains(session)) {
      _sessions.mutate((value) {
        value.remove(session);
      });
      if (widget.dropDuration != Duration.zero) {
        RenderBox? ghostRenderBox =
            session.key.currentContext?.findRenderObject() as RenderBox?;
        if (ghostRenderBox != null) {
          RenderBox layerRenderBox = context.findRenderObject() as RenderBox;
          _pendingDrop.value = _PendingDropTransform(
            from: ghostRenderBox.getTransformTo(layerRenderBox),
            child: SizedBox.fromSize(
              size: session.size,
              child: session.ghost,
            ),
            data: session.data,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MetaData(
      metaData: this,
      behavior: HitTestBehavior.translucent,
      child: Data.inherit(
        data: this,
        child: Stack(
          fit: StackFit.passthrough,
          clipBehavior:
              widget.clipBehavior ?? (widget.lock ? Clip.hardEdge : Clip.none),
          children: [
            widget.child,
            ListenableBuilder(
              listenable: _sessions,
              builder: (context, child) {
                return Positioned.fill(
                  child: MouseRegion(
                    opaque: false,
                    hitTestBehavior: HitTestBehavior.translucent,
                    cursor: _sessions.value.isNotEmpty
                        ? SystemMouseCursors.grabbing
                        : MouseCursor.defer,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        for (final session in _sessions.value)
                          ListenableBuilder(
                            listenable: session.offset,
                            builder: (context, child) {
                              return Positioned(
                                left: session.offset.value.dx,
                                top: session.offset.value.dy,
                                child: IgnorePointer(
                                  child: Transform(
                                    transform: session.transform,
                                    child: SizedBox.fromSize(
                                      key: session.key,
                                      size: session.size,
                                      child: session.ghost,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _activeDrops,
              builder: (context, child) {
                return Positioned.fill(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (final drop in _activeDrops.value)
                        ListenableBuilder(
                          listenable: drop.progress,
                          builder: (context, child) {
                            return IgnorePointer(
                              child: Transform(
                                transform: _tweenMatrix(
                                  drop.from,
                                  drop.to,
                                  drop.progress.value,
                                ),
                                child: drop.child,
                              ),
                            );
                          },
                        ),
                      child!,
                    ],
                  ),
                );
              },
              child: ListenableBuilder(
                listenable: _pendingDrop,
                builder: (context, child) {
                  if (_pendingDrop.value != null) {
                    return IgnorePointer(
                      child: Transform(
                        transform: _pendingDrop.value!.from,
                        child: _pendingDrop.value!.child,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A sortable layer that provides automatic scrolling during drag operations.
///
/// ScrollableSortableLayer extends the basic sortable functionality with automatic
/// scrolling when dragged items approach the edges of scrollable areas. This provides
/// a smooth user experience when dragging items in long lists or grids that extend
/// beyond the visible area.
///
/// The layer monitors drag positions and automatically scrolls the associated
/// scroll controller when the drag position comes within the configured threshold
/// of the scroll area edges. Scrolling speed is proportional to proximity to edges.
///
/// Features:
/// - Automatic scrolling when dragging near scroll area edges
/// - Configurable scroll threshold distance from edges
/// - Proportional scrolling speed based on proximity
/// - Optional overscroll support for scrolling beyond normal bounds
/// - Integrated with standard Flutter ScrollController
///
/// This layer should wrap scrollable widgets like ListView, GridView, or CustomScrollView
/// that contain sortable items. The scroll controller must be provided to enable
/// automatic scrolling functionality.
///
/// Example:
/// ```dart
/// ScrollController scrollController = ScrollController();
///
/// ScrollableSortableLayer(
///   controller: scrollController,
///   scrollThreshold: 80.0,
///   child: ListView.builder(
///     controller: scrollController,
///     itemBuilder: (context, index) => Sortable(...),
///   ),
/// )
/// ```
class ScrollableSortableLayer extends StatefulWidget {
  /// The child widget containing sortable items within a scrollable area.
  ///
  /// Type: `Widget`. Typically a scrollable widget like ListView or GridView
  /// that contains sortable items and uses the same controller.
  final Widget child;

  /// The scroll controller that manages the scrollable area.
  ///
  /// Type: `ScrollController`. Must be the same controller used by the scrollable
  /// widget in the child tree. This allows the layer to control scrolling during
  /// drag operations.
  final ScrollController controller;

  /// Distance from scroll area edges that triggers automatic scrolling.
  ///
  /// Type: `double`, default: `50.0`. When a dragged item comes within this
  /// distance of the top or bottom edge (for vertical scrolling), automatic
  /// scrolling begins. Larger values provide earlier scroll activation.
  final double scrollThreshold;

  /// Whether to allow scrolling beyond the normal scroll bounds.
  ///
  /// Type: `bool`, default: `false`. When true, drag operations can trigger
  /// scrolling past the normal scroll limits, similar to overscroll behavior.
  final bool overscroll;

  /// Creates a [ScrollableSortableLayer] with automatic scrolling support.
  ///
  /// Configures a sortable layer that provides automatic scrolling when dragged
  /// items approach the edges of the scrollable area.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): The scrollable widget containing sortable items
  /// - [controller] (ScrollController, required): The scroll controller to manage
  /// - [scrollThreshold] (double, default: 50.0): Distance from edges for scroll trigger
  /// - [overscroll] (bool, default: false): Whether to allow overscroll behavior
  ///
  /// Example:
  /// ```dart
  /// final controller = ScrollController();
  ///
  /// ScrollableSortableLayer(
  ///   controller: controller,
  ///   scrollThreshold: 60.0,
  ///   overscroll: true,
  ///   child: ListView.builder(
  ///     controller: controller,
  ///     itemCount: items.length,
  ///     itemBuilder: (context, index) => Sortable<Item>(
  ///       data: SortableData(items[index]),
  ///       child: ItemWidget(items[index]),
  ///     ),
  ///   ),
  /// )
  /// ```
  const ScrollableSortableLayer({
    super.key,
    required this.child,
    required this.controller,
    this.scrollThreshold = 50,
    this.overscroll = false,
  });

  @override
  State<ScrollableSortableLayer> createState() =>
      _ScrollableSortableLayerState();
}

class _ScrollableSortableLayerState extends State<ScrollableSortableLayer>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker(_scroll);
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  _SortableState? _attached;
  Offset? _globalPosition;
  Duration? _lastElapsed;
  void _scroll(Duration elapsed) {
    var position = _globalPosition;
    if (position != null && _lastElapsed != null) {
      var renderBox = context.findRenderObject() as RenderBox;
      position = renderBox.globalToLocal(position);
      int delta = elapsed.inMicroseconds - _lastElapsed!.inMicroseconds;
      double scrollDelta = 0;
      var pos = widget.controller.position.axisDirection == AxisDirection.down
          ? position.dy
          : position.dx;
      var size = widget.controller.position.axisDirection == AxisDirection.down
          ? renderBox.size.height
          : renderBox.size.width;
      if (pos < widget.scrollThreshold) {
        scrollDelta = -delta / 10000;
      } else if (pos > size - widget.scrollThreshold) {
        scrollDelta = delta / 10000;
      }
      for (var pos in widget.controller.positions) {
        pos.pointerScroll(scrollDelta);
      }
      _attached?._handleDrag(Offset.zero);
    }
    _lastElapsed = elapsed;
  }

  void _startDrag(_SortableState state, Offset globalPosition) {
    if (_attached != null && _attached!.context.mounted) {
      return;
    }
    _attached = state;
    _globalPosition = globalPosition;
    if (!ticker.isActive) {
      ticker.start();
    }
  }

  void _updateDrag(_SortableState state, Offset globalPosition) {
    if (state != _attached) {
      return;
    }
    _globalPosition = globalPosition;
  }

  void _endDrag(_SortableState state) {
    if (state != _attached) {
      return;
    }
    if (ticker.isActive) {
      ticker.stop();
    }
    _globalPosition = null;
    _attached = null;
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: this,
      child: widget.child,
    );
  }
}
