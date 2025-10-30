import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Handles overlay presentation for popover components.
///
/// Manages the display, positioning, and lifecycle of popover overlays
/// with support for alignment, constraints, and modal behavior.
class PopoverOverlayHandler extends OverlayHandler {
  /// Creates a [PopoverOverlayHandler].
  const PopoverOverlayHandler();
  @override
  OverlayCompleter<T> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    ui.Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    ui.Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    ui.Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    TextDirection textDirection = Directionality.of(context);
    Alignment resolvedAlignment = alignment.resolve(textDirection);
    anchorAlignment ??= alignment * -1;
    Alignment resolvedAnchorAlignment = anchorAlignment.resolve(textDirection);
    final OverlayState overlay = Overlay.of(context, rootOverlay: rootOverlay);
    final themes = InheritedTheme.capture(from: context, to: overlay.context);
    final data = Data.capture(from: context, to: overlay.context);

    Size? anchorSize;
    if (position == null) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      Offset pos = renderBox.localToGlobal(Offset.zero);
      anchorSize ??= renderBox.size;
      position = Offset(
        pos.dx +
            anchorSize.width / 2 +
            anchorSize.width / 2 * resolvedAnchorAlignment.x,
        pos.dy +
            anchorSize.height / 2 +
            anchorSize.height / 2 * resolvedAnchorAlignment.y,
      );
    }
    final OverlayPopoverEntry<T> popoverEntry = OverlayPopoverEntry();
    final completer = popoverEntry.completer;
    final animationCompleter = popoverEntry.animationCompleter;
    ValueNotifier<bool> isClosed = ValueNotifier(false);
    OverlayEntry? barrierEntry;
    late OverlayEntry overlayEntry;
    if (modal) {
      if (consumeOutsideTaps) {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      } else {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      }
    }

    overlayEntry = OverlayEntry(
      builder: (innerContext) {
        return RepaintBoundary(
          child: AnimatedBuilder(
              animation: isClosed,
              builder: (innerContext, child) {
                return FocusScope(
                  autofocus: dismissBackdropFocus,
                  canRequestFocus: !isClosed.value,
                  child: AnimatedValueBuilder.animation(
                      value: isClosed.value ? 0.0 : 1.0,
                      initialValue: 0.0,
                      curve: isClosed.value
                          ? const Interval(0, 2 / 3)
                          : Curves.linear,
                      duration: isClosed.value
                          ? (showDuration ?? kDefaultDuration)
                          : (dismissDuration ??
                              const Duration(milliseconds: 100)),
                      onEnd: (value) {
                        if (value == 0.0 && isClosed.value) {
                          popoverEntry.remove();
                          popoverEntry.dispose();
                          animationCompleter.complete();
                        }
                      },
                      builder: (innerContext, animation) {
                        var popoverAnchor = PopoverOverlayWidget(
                          animation: animation,
                          onTapOutside: () {
                            if (isClosed.value) return;
                            if (!modal) {
                              isClosed.value = true;
                              completer.complete();
                            }
                          },
                          key: key,
                          anchorContext: context,
                          position: position!,
                          alignment: resolvedAlignment,
                          themes: themes,
                          builder: builder,
                          anchorSize: anchorSize,
                          // anchorAlignment: anchorAlignment ?? alignment * -1,
                          anchorAlignment: resolvedAnchorAlignment,
                          widthConstraint: widthConstraint,
                          heightConstraint: heightConstraint,
                          regionGroupId: regionGroupId,
                          offset: offset,
                          transitionAlignment: transitionAlignment,
                          margin: margin,
                          follow: follow,
                          consumeOutsideTaps: consumeOutsideTaps,
                          onTickFollow: onTickFollow,
                          allowInvertHorizontal: allowInvertHorizontal,
                          allowInvertVertical: allowInvertVertical,
                          data: data,
                          onClose: () {
                            if (isClosed.value) return Future.value();
                            isClosed.value = true;
                            completer.complete();
                            return animationCompleter.future;
                          },
                          onImmediateClose: () {
                            popoverEntry.remove();
                            completer.complete();
                          },
                          onCloseWithResult: (value) {
                            if (isClosed.value) return Future.value();
                            isClosed.value = true;
                            completer.complete(value as T);
                            return animationCompleter.future;
                          },
                        );
                        return popoverAnchor;
                      }),
                );
              }),
        );
      },
    );
    popoverEntry.initialize(overlayEntry, barrierEntry);
    if (barrierEntry != null) {
      overlay.insert(barrierEntry);
    }
    overlay.insert(overlayEntry);
    return popoverEntry;
  }
}

/// Internal widget for rendering popover overlays.
///
/// Manages positioning, constraints, and lifecycle of popover content
/// relative to an anchor widget.
class PopoverOverlayWidget extends StatefulWidget {
  /// Creates a [PopoverOverlayWidget].
  const PopoverOverlayWidget({
    super.key,
    required this.anchorContext,
    this.position,
    required this.alignment,
    this.themes,
    required this.builder,
    required this.animation,
    required this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.anchorSize,
    // this.route,
    this.onTapOutside,
    this.regionGroupId,
    this.offset,
    this.transitionAlignment,
    this.margin,
    this.follow = true,
    this.consumeOutsideTaps = true,
    this.onTickFollow,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
    this.data,
    this.onClose,
    this.onImmediateClose,
    this.onCloseWithResult,
    this.layerLink,
  });

  /// Explicit position for the popover.
  final Offset? position;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry alignment;

  /// Alignment point on the anchor widget.
  final AlignmentGeometry anchorAlignment;

  /// Captured theme data from context.
  final CapturedThemes? themes;

  /// Captured inherited data from context.
  final CapturedData? data;

  /// Builder function for popover content.
  final WidgetBuilder builder;

  /// Size of the anchor widget.
  final Size? anchorSize;

  /// Animation controller for show/hide transitions.
  final Animation<double> animation;

  /// Width constraint mode for the popover.
  final PopoverConstraint widthConstraint;

  /// Height constraint mode for the popover.
  final PopoverConstraint heightConstraint;

  // final PopoverRoute? route;

  /// Callback when popover is closing.
  final FutureVoidCallback? onClose;

  /// Callback for immediate close without animation.
  final VoidCallback? onImmediateClose;

  /// Callback when user taps outside the popover.
  final VoidCallback? onTapOutside;

  /// Region group identifier for coordinating multiple overlays.
  final Object? regionGroupId;

  /// Additional offset applied to popover position.
  final Offset? offset;

  /// Alignment for transition animations.
  final AlignmentGeometry? transitionAlignment;

  /// Margin around the popover.
  final EdgeInsetsGeometry? margin;

  /// Whether popover follows anchor movement.
  final bool follow;

  /// Build context of the anchor widget.
  final BuildContext anchorContext;

  /// Whether to consume taps outside the popover.
  final bool consumeOutsideTaps;

  /// Callback on each frame when following anchor.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;

  /// Allow horizontal inversion when constrained.
  final bool allowInvertHorizontal;

  /// Allow vertical inversion when constrained.
  final bool allowInvertVertical;

  /// Callback when closing with a result value.
  final PopoverFutureVoidCallback<Object?>? onCloseWithResult;

  /// Layer link for positioning.
  final LayerLink? layerLink;

  @override
  State<PopoverOverlayWidget> createState() => PopoverOverlayWidgetState();
}

/// Callback type for popover futures with value transformation.
///
/// Parameters:
/// - [value] (T): Input value to transform
///
/// Returns a [Future] with the transformed value.
typedef PopoverFutureVoidCallback<T> = Future<T> Function(T value);

/// Size constraint strategies for popover overlays.
///
/// - `flexible`: Size flexibly based on content and available space
/// - `intrinsic`: Use intrinsic content size
/// - `anchorFixedSize`: Match anchor's exact size
/// - `anchorMinSize`: Use anchor size as minimum
/// - `anchorMaxSize`: Use anchor size as maximum
enum PopoverConstraint {
  /// Size flexibly based on content and available space
  flexible,

  /// Use intrinsic content size
  intrinsic,

  /// Match anchor's exact size
  anchorFixedSize,

  /// Use anchor size as minimum
  anchorMinSize,

  /// Use anchor size as maximum
  anchorMaxSize,
}

/// State class for [PopoverOverlayWidget] managing popover positioning and lifecycle.
///
/// Handles dynamic positioning, anchor tracking, size constraints, and
/// animation for popover overlays. Implements [OverlayHandlerStateMixin]
/// for standard overlay lifecycle management.
class PopoverOverlayWidgetState extends State<PopoverOverlayWidget>
    with SingleTickerProviderStateMixin, OverlayHandlerStateMixin {
  late BuildContext _anchorContext;
  late Offset? _position;
  late Offset? _offset;
  late AlignmentGeometry _alignment;
  late AlignmentGeometry _anchorAlignment;
  late PopoverConstraint _widthConstraint;
  late PopoverConstraint _heightConstraint;
  late EdgeInsetsGeometry? _margin;
  Size? _anchorSize;
  late bool _follow;
  late bool _allowInvertHorizontal;
  late bool _allowInvertVertical;
  late Ticker _ticker;
  late LayerLink? _layerLink;

  @override
  set offset(Offset? offset) {
    if (offset != null) {
      setState(() {
        _offset = offset;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    _position = widget.position;
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
    _margin = widget.margin;
    _follow = widget.follow;
    _anchorContext = widget.anchorContext;
    _allowInvertHorizontal = widget.allowInvertHorizontal;
    _allowInvertVertical = widget.allowInvertVertical;
    _layerLink = widget.layerLink;
    _ticker = createTicker(_tick);
    if (_follow && _layerLink == null) {
      _ticker.start();
    }
  }

  @override
  Future<void> close([bool immediate = false]) {
    if (!immediate) {
      return widget.onClose?.call() ?? Future.value();
    } else {
      widget.onImmediateClose?.call();
    }
    return Future.value();
  }

  @override
  void closeLater() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onClose?.call();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant PopoverOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.alignment != widget.alignment) {
      _alignment = widget.alignment;
    }
    if (oldWidget.anchorSize != widget.anchorSize) {
      _anchorSize = widget.anchorSize;
    }
    if (oldWidget.anchorAlignment != widget.anchorAlignment) {
      _anchorAlignment = widget.anchorAlignment;
    }
    if (oldWidget.widthConstraint != widget.widthConstraint) {
      _widthConstraint = widget.widthConstraint;
    }
    if (oldWidget.heightConstraint != widget.heightConstraint) {
      _heightConstraint = widget.heightConstraint;
    }
    if (oldWidget.offset != widget.offset) {
      _offset = widget.offset;
    }

    if (oldWidget.margin != widget.margin) {
      _margin = widget.margin;
    }
    bool shouldStartTicker = false;
    if (oldWidget.follow != widget.follow) {
      _follow = widget.follow;
      if (widget.follow) {
        shouldStartTicker = true;
      }
    }
    if (_layerLink != widget.layerLink) {
      _layerLink = widget.layerLink;
      if (_layerLink != null) {
        shouldStartTicker = false;
      }
    }
    if (shouldStartTicker && !_ticker.isActive) {
      _ticker.start();
    } else if (!shouldStartTicker && _ticker.isActive) {
      _ticker.stop();
    }
    if (oldWidget.anchorContext != widget.anchorContext) {
      _anchorContext = widget.anchorContext;
    }
    if (oldWidget.allowInvertHorizontal != widget.allowInvertHorizontal) {
      _allowInvertHorizontal = widget.allowInvertHorizontal;
    }
    if (oldWidget.allowInvertVertical != widget.allowInvertVertical) {
      _allowInvertVertical = widget.allowInvertVertical;
    }
    if (oldWidget.position != widget.position && !_follow) {
      _position = widget.position;
    }
  }

  /// Gets the anchor widget's size.
  Size? get anchorSize => _anchorSize;

  /// Gets the anchor alignment for positioning.
  AlignmentGeometry get anchorAlignment => _anchorAlignment;

  /// Gets the explicit position offset.
  Offset? get position => _position;

  /// Gets the popover alignment.
  AlignmentGeometry get alignment => _alignment;

  /// Gets the width constraint strategy.
  PopoverConstraint get widthConstraint => _widthConstraint;

  /// Gets the height constraint strategy.
  PopoverConstraint get heightConstraint => _heightConstraint;

  /// Gets the position offset.
  Offset? get offset => _offset;

  /// Gets the margin around the popover.
  EdgeInsetsGeometry? get margin => _margin;

  /// Gets whether the popover follows the anchor on movement.
  bool get follow => _follow;

  /// Gets the anchor build context.
  BuildContext get anchorContext => _anchorContext;

  /// Gets whether horizontal inversion is allowed.
  bool get allowInvertHorizontal => _allowInvertHorizontal;

  /// Gets whether vertical inversion is allowed.
  bool get allowInvertVertical => _allowInvertVertical;

  /// Gets the layer link for positioning.
  LayerLink? get layerLink => _layerLink;

  /// Sets the layer link for positioning.
  ///
  /// Updates the layer link and manages ticker state for anchor tracking.
  set layerLink(LayerLink? value) {
    if (_layerLink != value) {
      setState(() {
        _layerLink = value;
        if (_follow && _layerLink == null) {
          if (!_ticker.isActive) {
            _ticker.start();
          }
        } else {
          _ticker.stop();
        }
      });
    }
  }

  @override
  set alignment(AlignmentGeometry value) {
    if (_alignment != value) {
      setState(() {
        _alignment = value;
      });
    }
  }

  /// Sets the popover position.
  ///
  /// Updates the explicit position and triggers a rebuild.
  set position(Offset? value) {
    if (_position != value) {
      setState(() {
        _position = value;
      });
    }
  }

  @override
  set anchorAlignment(AlignmentGeometry value) {
    if (_anchorAlignment != value) {
      setState(() {
        _anchorAlignment = value;
      });
    }
  }

  @override
  set widthConstraint(PopoverConstraint value) {
    if (_widthConstraint != value) {
      setState(() {
        _widthConstraint = value;
      });
    }
  }

  @override
  set heightConstraint(PopoverConstraint value) {
    if (_heightConstraint != value) {
      setState(() {
        _heightConstraint = value;
      });
    }
  }

  @override
  set margin(EdgeInsetsGeometry? value) {
    if (_margin != value) {
      setState(() {
        _margin = value;
      });
    }
  }

  @override
  set follow(bool value) {
    if (_follow != value) {
      setState(() {
        _follow = value;
        if (_follow) {
          _ticker.start();
        } else {
          _ticker.stop();
        }
      });
    }
  }

  @override
  set anchorContext(BuildContext value) {
    if (_anchorContext != value) {
      setState(() {
        _anchorContext = value;
      });
    }
  }

  @override
  set allowInvertHorizontal(bool value) {
    if (_allowInvertHorizontal != value) {
      setState(() {
        _allowInvertHorizontal = value;
      });
    }
  }

  @override
  set allowInvertVertical(bool value) {
    if (_allowInvertVertical != value) {
      setState(() {
        _allowInvertVertical = value;
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    if (!mounted || !anchorContext.mounted) return;
    // update position based on anchorContext
    RenderBox? renderBox = anchorContext.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Offset pos = renderBox.localToGlobal(Offset.zero);
      Size size = renderBox.size;
      var anchorAlignment = _anchorAlignment.optionallyResolve(context);
      Offset newPos = Offset(
        pos.dx + size.width / 2 + size.width / 2 * anchorAlignment.x,
        pos.dy + size.height / 2 + size.height / 2 * anchorAlignment.y,
      );
      if (_position != newPos) {
        setState(() {
          _anchorSize = size;
          _position = newPos;
          widget.onTickFollow?.call(this);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = Data<OverlayHandlerStateMixin>.inherit(
      data: this,
      child: TapRegion(
        // enabled: widget.consumeOutsideTaps,
        onTapOutside: widget.onTapOutside != null
            ? (event) {
                widget.onTapOutside?.call();
              }
            : null,
        groupId: widget.regionGroupId,
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          removeLeft: true,
          removeRight: true,
          removeTop: true,
          child: AnimatedBuilder(
            animation: widget.animation,
            builder: (context, child) {
              final theme = Theme.of(context);
              final scaling = theme.scaling;
              return PopoverLayout(
                alignment: _alignment.optionallyResolve(context),
                position: _position,
                anchorSize: _anchorSize,
                anchorAlignment: _anchorAlignment.optionallyResolve(context),
                widthConstraint: _widthConstraint,
                heightConstraint: _heightConstraint,
                offset: _offset,
                margin: _margin?.optionallyResolve(context) ??
                    (const EdgeInsets.all(8) * scaling),
                scale: tweenValue(0.9, 1.0, widget.animation.value),
                scaleAlignment: (widget.transitionAlignment ?? _alignment)
                    .optionallyResolve(context),
                allowInvertVertical: _allowInvertVertical,
                allowInvertHorizontal: _allowInvertHorizontal,
                child: child!,
              );
            },
            child: FadeTransition(
              opacity: widget.animation,
              child: Builder(builder: (context) {
                return widget.builder(context);
              }),
            ),
          ),
        ),
      ),
    );
    if (widget.themes != null) {
      childWidget = widget.themes!.wrap(childWidget);
    }
    if (widget.data != null) {
      childWidget = widget.data!.wrap(childWidget);
    }
    return childWidget;
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    return widget.onCloseWithResult?.call(value) ?? Future.value();
  }
}

/// Closes the current popover overlay.
///
/// Deprecated: Use [closeOverlay] instead.
///
/// Parameters:
/// - [context] (`BuildContext`, required): Widget context.
/// - [result] (`T?`, optional): Result to return when closing.
///
/// Returns: `Future<void>` — completes when popover is closed.
@Deprecated('Use closeOverlay instead')
Future<void> closePopover<T>(BuildContext context, [T? result]) {
  return closeOverlay<T>(context, result);
}

/// Implementation of [OverlayCompleter] for popover overlays.
///
/// Manages the lifecycle of a popover overlay entry, tracking completion
/// state and handling overlay/barrier entry disposal.
class OverlayPopoverEntry<T> implements OverlayCompleter<T> {
  late OverlayEntry _overlayEntry;
  late OverlayEntry? _barrierEntry;

  /// Completer for the popover's result value.
  final Completer<T?> completer = Completer();

  /// Completer that tracks the popover's animation lifecycle.
  ///
  /// Completes when the popover's entry and exit animations finish.
  /// Used internally to coordinate animation timing and cleanup.
  final Completer<T?> animationCompleter = Completer();

  bool _removed = false;
  bool _disposed = false;

  @override
  bool get isCompleted => completer.isCompleted;

  /// Initializes the popover entry with overlay entries.
  ///
  /// Must be called before the popover can be displayed.
  ///
  /// Parameters:
  /// - [overlayEntry] (OverlayEntry, required): Main overlay entry
  /// - [barrierEntry] (OverlayEntry?): Optional barrier entry
  void initialize(OverlayEntry overlayEntry, [OverlayEntry? barrierEntry]) {
    _overlayEntry = overlayEntry;
    _barrierEntry = barrierEntry;
  }

  @override
  void remove() {
    if (_removed) return;
    _removed = true;
    _overlayEntry.remove();
    _barrierEntry?.remove();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _overlayEntry.dispose();
    _barrierEntry?.dispose();
  }

  @override
  Future<T?> get future => completer.future;

  @override
  Future<T?> get animationFuture => animationCompleter.future;

  @override
  bool get isAnimationCompleted => animationCompleter.isCompleted;
}

/// Displays a popover overlay with specified alignment and behavior.
///
/// Parameters:
/// - [context] (`BuildContext`, required): Widget context.
/// - [alignment] (`AlignmentGeometry`, required): Popover alignment relative to anchor.
/// - [builder] (`WidgetBuilder`, required): Builds popover content.
/// - [position] (`Offset?`, optional): Explicit position.
/// - [anchorAlignment] (`AlignmentGeometry?`, optional): Anchor alignment point.
/// - [widthConstraint] (`PopoverConstraint`, optional): Width constraint mode. Default: flexible.
/// - [heightConstraint] (`PopoverConstraint`, optional): Height constraint mode. Default: flexible.
/// - [key] (`Key?`, optional): Widget key.
/// - [rootOverlay] (`bool`, optional): Use root overlay. Default: true.
/// - [modal] (`bool`, optional): Modal behavior. Default: true.
/// - [barrierDismissable] (`bool`, optional): Tap outside to dismiss. Default: true.
/// - [clipBehavior] (`Clip`, optional): Clipping behavior. Default: Clip.none.
/// - [regionGroupId] (`Object?`, optional): Region grouping identifier.
/// - [offset] (`Offset?`, optional): Additional offset.
/// - [transitionAlignment] (`AlignmentGeometry?`, optional): Transition origin.
/// - [margin] (`EdgeInsetsGeometry?`, optional): Popover margin.
/// - [follow] (`bool`, optional): Follow anchor movement. Default: true.
/// - [consumeOutsideTaps] (`bool`, optional): Consume outside taps. Default: true.
/// - [onTickFollow] (`ValueChanged<PopoverOverlayWidgetState>?`, optional): Follow callback.
/// - [allowInvertHorizontal] (`bool`, optional): Allow horizontal inversion. Default: true.
/// - [allowInvertVertical] (`bool`, optional): Allow vertical inversion. Default: true.
/// - [dismissBackdropFocus] (`bool`, optional): Dismiss on backdrop focus. Default: true.
/// - [showDuration] (`Duration?`, optional): Show animation duration.
/// - [dismissDuration] (`Duration?`, optional): Dismiss animation duration.
/// - [overlayBarrier] (`OverlayBarrier?`, optional): Custom barrier configuration.
/// - [handler] (`OverlayHandler?`, optional): Custom overlay handler.
///
/// Returns: `OverlayCompleter<T?>` — handle to control the popover.
///
/// Example:
/// ```dart
/// showPopover(
///   context: context,
///   alignment: Alignment.bottomCenter,
///   builder: (context) => Text('Popover content'),
/// );
/// ```
OverlayCompleter<T?> showPopover<T>({
  required BuildContext context,
  required AlignmentGeometry alignment,
  required WidgetBuilder builder,
  Offset? position,
  AlignmentGeometry? anchorAlignment,
  PopoverConstraint widthConstraint = PopoverConstraint.flexible,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  Key? key,
  bool rootOverlay = true,
  bool modal = true,
  bool barrierDismissable = true,
  Clip clipBehavior = Clip.none,
  Object? regionGroupId,
  Offset? offset,
  AlignmentGeometry? transitionAlignment,
  EdgeInsetsGeometry? margin,
  bool follow = true,
  bool consumeOutsideTaps = true,
  ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
  bool allowInvertHorizontal = true,
  bool allowInvertVertical = true,
  bool dismissBackdropFocus = true,
  Duration? showDuration,
  Duration? dismissDuration,
  OverlayBarrier? overlayBarrier,
  OverlayHandler? handler,
}) {
  handler ??= OverlayManager.of(context);
  return handler.show<T>(
    context: context,
    alignment: alignment,
    builder: builder,
    position: position,
    anchorAlignment: anchorAlignment,
    widthConstraint: widthConstraint,
    heightConstraint: heightConstraint,
    key: key,
    rootOverlay: rootOverlay,
    modal: modal,
    barrierDismissable: barrierDismissable,
    clipBehavior: clipBehavior,
    regionGroupId: regionGroupId,
    offset: offset,
    transitionAlignment: transitionAlignment,
    margin: margin,
    follow: follow,
    consumeOutsideTaps: consumeOutsideTaps,
    onTickFollow: onTickFollow,
    allowInvertHorizontal: allowInvertHorizontal,
    allowInvertVertical: allowInvertVertical,
    dismissBackdropFocus: dismissBackdropFocus,
    showDuration: showDuration,
    dismissDuration: dismissDuration,
    overlayBarrier: overlayBarrier,
  );
}

/// A comprehensive popover overlay system for displaying contextual content.
///
/// [Popover] provides a flexible foundation for creating overlay widgets that appear
/// relative to anchor elements. It handles positioning, layering, and lifecycle
/// management for temporary content displays such as dropdowns, menus, tooltips,
/// and dialogs. The system automatically manages positioning constraints and
/// viewport boundaries.
///
/// The popover system consists of:
/// - [Popover]: Individual popover instances with control methods
/// - [PopoverController]: Manager for multiple popovers with lifecycle control
/// - [PopoverLayout]: Positioning and constraint resolution
/// - Overlay integration for proper z-ordering and event handling
///
/// Key features:
/// - Intelligent positioning with automatic viewport constraint handling
/// - Multiple attachment points and alignment options
/// - Modal and non-modal display modes
/// - Animation and transition support
/// - Barrier dismissal with configurable behavior
/// - Follow-anchor behavior for responsive positioning
/// - Multi-popover management with close coordination
///
/// Positioning capabilities:
/// - Flexible alignment relative to anchor widgets
/// - Automatic inversion when space is constrained
/// - Custom offset adjustments
/// - Margin and padding controls
/// - Width and height constraint options
///
/// Example usage:
/// ```dart
/// final controller = PopoverController();
///
/// // Show a popover
/// final popover = await controller.show<String>(
///   context: context,
///   alignment: Alignment.bottomStart,
///   anchorAlignment: Alignment.topStart,
///   builder: (context) => PopoverMenu(
///     children: [
///       PopoverMenuItem(child: Text('Option 1')),
///       PopoverMenuItem(child: Text('Option 2')),
///     ],
///   ),
/// );
/// ```
class Popover {
  /// Global key for accessing the overlay handler state.
  final GlobalKey<OverlayHandlerStateMixin> key;

  /// The overlay completer that manages this popover's lifecycle.
  final OverlayCompleter entry;

  /// Creates a popover instance with the specified key and entry.
  ///
  /// This constructor is typically used internally by the popover system.
  /// Use [PopoverController.show] to create and display popovers.
  Popover._(this.key, this.entry);

  /// Closes this popover with optional immediate dismissal.
  ///
  /// If [immediate] is true, skips closing animations and removes the popover
  /// immediately. Otherwise, plays the closing animation before removal.
  ///
  /// Returns a Future that completes when the popover is fully dismissed.
  ///
  /// Parameters:
  /// - [immediate] (bool, default: false): Whether to skip closing animations
  ///
  /// Example:
  /// ```dart
  /// await popover.close(); // Animated close
  /// await popover.close(true); // Immediate close
  /// ```
  Future<void> close([bool immediate = false]) {
    var currentState = key.currentState;
    if (currentState != null) {
      return currentState.close(immediate);
    } else {
      entry.remove();
    }
    return Future.value();
  }

  /// Schedules this popover to close after the current frame.
  ///
  /// This method queues the close operation for the next frame, allowing
  /// any current operations to complete before dismissing the popover.
  void closeLater() {
    var currentState = key.currentState;
    if (currentState != null) {
      currentState.closeLater();
    } else {
      entry.remove();
    }
  }

  /// Immediately removes this popover from the overlay without animations.
  ///
  /// This method bypasses all closing animations and state management,
  /// directly removing the popover from the overlay stack. Use with caution
  /// as it may interrupt ongoing operations.
  void remove() {
    entry.remove();
  }

  /// Gets the current overlay handler state if the popover is mounted.
  ///
  /// Returns null if the popover has been disposed or is not currently
  /// in the widget tree. Useful for checking popover status and accessing
  /// advanced control methods.
  OverlayHandlerStateMixin? get currentState => key.currentState;
}

/// A controller for managing multiple popovers and their lifecycle.
///
/// [PopoverController] provides centralized management for popover instances,
/// including creation, lifecycle tracking, and coordination between multiple
/// popovers. It handles the complexity of overlay management and provides
/// a clean API for popover operations.
///
/// Key responsibilities:
/// - Creating and showing new popovers
/// - Tracking active popover instances
/// - Coordinating close operations across popovers
/// - Managing popover lifecycle states
/// - Providing status queries for open/mounted popovers
///
/// The controller maintains a list of active popovers and provides methods
/// to query their status, close them individually or collectively, and
/// coordinate their display behavior.
///
/// Example:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   _MyWidgetState createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> {
///   final PopoverController _popoverController = PopoverController();
///
///   @override
///   void dispose() {
///     _popoverController.dispose();
///     super.dispose();
///   }
///
///   void _showMenu() async {
///     await _popoverController.show(
///       context: context,
///       alignment: Alignment.bottomStart,
///       builder: (context) => MyPopoverContent(),
///     );
///   }
/// }
/// ```
class PopoverController extends ChangeNotifier {
  bool _disposed = false;
  final List<Popover> _openPopovers = [];

  /// Whether there are any open popovers that haven't completed.
  ///
  /// Returns true if any popover is currently open and not yet completed.
  bool get hasOpenPopover =>
      _openPopovers.isNotEmpty &&
      _openPopovers.any((element) => !element.entry.isCompleted);

  /// Whether there are any mounted popovers with animations in progress.
  ///
  /// Returns true if any popover is mounted and its animation hasn't completed.
  bool get hasMountedPopover =>
      _openPopovers.isNotEmpty &&
      _openPopovers.any((element) => !element.entry.isAnimationCompleted);

  /// Gets an unmodifiable view of currently open popovers.
  ///
  /// Returns an iterable of [Popover] instances that are currently managed
  /// by this controller.
  Iterable<Popover> get openPopovers => List.unmodifiable(_openPopovers);

  /// Shows a popover with the specified configuration.
  ///
  /// Creates and displays a popover overlay with extensive customization options.
  /// If [closeOthers] is true, closes existing popovers before showing the new one.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [builder] (WidgetBuilder, required): Popover content builder
  /// - [alignment] (AlignmentGeometry, required): Popover alignment
  /// - [anchorAlignment] (AlignmentGeometry?): Anchor alignment
  /// - [widthConstraint] (PopoverConstraint): Width constraint, defaults to flexible
  /// - [heightConstraint] (PopoverConstraint): Height constraint, defaults to flexible
  /// - [modal] (bool): Modal behavior, defaults to true
  /// - [closeOthers] (bool): Close other popovers, defaults to true
  /// - [offset] (Offset?): Position offset
  /// - [key] (`GlobalKey<OverlayHandlerStateMixin>?`): Widget key
  /// - [regionGroupId] (Object?): Region group ID
  /// - [transitionAlignment] (AlignmentGeometry?): Transition alignment
  /// - [consumeOutsideTaps] (bool): Consume outside taps, defaults to true
  /// - [margin] (EdgeInsetsGeometry?): Popover margin
  /// - [onTickFollow] (`ValueChanged<PopoverOverlayWidgetState>?`): Follow tick callback
  /// - [follow] (bool): Follow anchor on move, defaults to true
  /// - [allowInvertHorizontal] (bool): Allow horizontal inversion, defaults to true
  /// - [allowInvertVertical] (bool): Allow vertical inversion, defaults to true
  /// - [dismissBackdropFocus] (bool): Dismiss on backdrop focus, defaults to true
  /// - [showDuration] (Duration?): Show animation duration
  /// - [hideDuration] (Duration?): Hide animation duration
  /// - [overlayBarrier] (OverlayBarrier?): Custom barrier configuration
  /// - [handler] (OverlayHandler?): Custom overlay handler
  ///
  /// Returns a [Future] that completes with the popover result when dismissed.
  Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    required AlignmentGeometry alignment,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    bool modal = true,
    bool closeOthers = true,
    Offset? offset,
    GlobalKey<OverlayHandlerStateMixin>? key,
    Object? regionGroupId,
    AlignmentGeometry? transitionAlignment,
    bool consumeOutsideTaps = true,
    EdgeInsetsGeometry? margin,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool follow = true,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? hideDuration,
    OverlayBarrier? overlayBarrier,
    OverlayHandler? handler,
  }) async {
    if (closeOthers) {
      close();
    }
    key ??= GlobalKey<OverlayHandlerStateMixin>(
        debugLabel: 'PopoverAnchor$hashCode');

    OverlayCompleter<T?> res = showPopover<T>(
      context: context,
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      builder: builder,
      modal: modal,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      consumeOutsideTaps: consumeOutsideTaps,
      margin: margin,
      onTickFollow: onTickFollow,
      follow: follow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: hideDuration,
      overlayBarrier: overlayBarrier,
      handler: handler,
    );
    var popover = Popover._(
      key,
      res,
    );
    _openPopovers.add(popover);
    notifyListeners();
    await res.future;
    _openPopovers.remove(popover);
    if (!_disposed) {
      notifyListeners();
    }
    return res.future;
  }

  /// Closes all managed popovers.
  ///
  /// Closes all popovers managed by this controller. If [immediate] is true,
  /// closes without animation.
  ///
  /// Parameters:
  /// - [immediate] (bool): Skip animation if true, defaults to false
  void close([bool immediate = false]) {
    for (Popover key in _openPopovers) {
      key.close(immediate);
    }
    _openPopovers.clear();
    notifyListeners();
  }

  /// Schedules closure of all popovers for the next frame.
  ///
  /// Defers closing to avoid issues when called during widget builds.
  void closeLater() {
    for (Popover key in _openPopovers) {
      key.closeLater();
    }
    _openPopovers.clear();
    notifyListeners();
  }

  set anchorContext(BuildContext value) {
    for (Popover key in _openPopovers) {
      key.currentState?.anchorContext = value;
    }
  }

  set alignment(AlignmentGeometry value) {
    for (Popover key in _openPopovers) {
      key.currentState?.alignment = value;
    }
  }

  set anchorAlignment(AlignmentGeometry value) {
    for (Popover key in _openPopovers) {
      key.currentState?.anchorAlignment = value;
    }
  }

  set widthConstraint(PopoverConstraint value) {
    for (Popover key in _openPopovers) {
      key.currentState?.widthConstraint = value;
    }
  }

  set heightConstraint(PopoverConstraint value) {
    for (Popover key in _openPopovers) {
      key.currentState?.heightConstraint = value;
    }
  }

  set margin(EdgeInsets value) {
    for (Popover key in _openPopovers) {
      key.currentState?.margin = value;
    }
  }

  set follow(bool value) {
    for (Popover key in _openPopovers) {
      key.currentState?.follow = value;
    }
  }

  set offset(Offset? value) {
    for (Popover key in _openPopovers) {
      key.currentState?.offset = value;
    }
  }

  set allowInvertHorizontal(bool value) {
    for (Popover key in _openPopovers) {
      key.currentState?.allowInvertHorizontal = value;
    }
  }

  set allowInvertVertical(bool value) {
    for (Popover key in _openPopovers) {
      key.currentState?.allowInvertVertical = value;
    }
  }

  /// Disposes all managed popovers.
  ///
  /// Schedules closure of all popovers. Called automatically when the
  /// controller is disposed.
  void disposePopovers() {
    for (Popover key in _openPopovers) {
      key.closeLater();
    }
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    disposePopovers();
    super.dispose();
  }
}

/// Custom layout widget for positioning popover content.
///
/// Handles popover positioning with alignment, sizing constraints, and
/// automatic inversion when content would overflow screen bounds.
class PopoverLayout extends SingleChildRenderObjectWidget {
  /// Popover alignment relative to anchor.
  final Alignment alignment;

  /// Anchor alignment for positioning.
  final Alignment anchorAlignment;

  /// Explicit position offset (overrides alignment).
  final Offset? position;

  /// Size of the anchor widget.
  final Size? anchorSize;

  /// Width constraint strategy.
  final PopoverConstraint widthConstraint;

  /// Height constraint strategy.
  final PopoverConstraint heightConstraint;

  /// Additional offset from computed position.
  final Offset? offset;

  /// Margin around the popover.
  final EdgeInsets margin;

  /// Scale factor for the popover.
  final double scale;

  /// Alignment point for scaling transformation.
  final Alignment scaleAlignment;

  /// Filter quality for scaled content.
  final FilterQuality? filterQuality;

  /// Whether to allow horizontal position inversion.
  final bool allowInvertHorizontal;

  /// Whether to allow vertical position inversion.
  final bool allowInvertVertical;

  /// Creates a popover layout widget.
  const PopoverLayout({
    super.key,
    required this.alignment,
    required this.position,
    required this.anchorAlignment,
    required this.widthConstraint,
    required this.heightConstraint,
    this.anchorSize,
    this.offset,
    required this.margin,
    required Widget super.child,
    required this.scale,
    required this.scaleAlignment,
    this.filterQuality,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return PopoverLayoutRender(
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      anchorSize: anchorSize,
      offset: offset,
      margin: margin,
      scale: scale,
      scaleAlignment: scaleAlignment,
      filterQuality: filterQuality,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant PopoverLayoutRender renderObject) {
    bool hasChanged = false;
    if (renderObject._alignment != alignment) {
      renderObject._alignment = alignment;
      hasChanged = true;
    }
    if (renderObject._position != position) {
      renderObject._position = position;
      hasChanged = true;
    }
    if (renderObject._anchorAlignment != anchorAlignment) {
      renderObject._anchorAlignment = anchorAlignment;
      hasChanged = true;
    }
    if (renderObject._widthConstraint != widthConstraint) {
      renderObject._widthConstraint = widthConstraint;
      hasChanged = true;
    }
    if (renderObject._heightConstraint != heightConstraint) {
      renderObject._heightConstraint = heightConstraint;
      hasChanged = true;
    }
    if (renderObject._anchorSize != anchorSize) {
      renderObject._anchorSize = anchorSize;
      hasChanged = true;
    }
    if (renderObject._offset != offset) {
      renderObject._offset = offset;
      hasChanged = true;
    }
    if (renderObject._margin != margin) {
      renderObject._margin = margin;
      hasChanged = true;
    }
    if (renderObject._scale != scale) {
      renderObject._scale = scale;
      hasChanged = true;
    }
    if (renderObject._scaleAlignment != scaleAlignment) {
      renderObject._scaleAlignment = scaleAlignment;
      hasChanged = true;
    }
    if (renderObject._filterQuality != filterQuality) {
      renderObject._filterQuality = filterQuality;
      hasChanged = true;
    }
    if (renderObject._allowInvertHorizontal != allowInvertHorizontal) {
      renderObject._allowInvertHorizontal = allowInvertHorizontal;
      hasChanged = true;
    }
    if (renderObject._allowInvertVertical != allowInvertVertical) {
      renderObject._allowInvertVertical = allowInvertVertical;
      hasChanged = true;
    }
    if (hasChanged) {
      renderObject.markNeedsLayout();
    }
  }
}

/// Custom render object for popover layout positioning.
///
/// Handles the low-level layout calculations for positioning popover content
/// relative to an anchor with automatic constraint adjustments and inversion
/// when the popover would overflow the viewport.
class PopoverLayoutRender extends RenderShiftedBox {
  Alignment _alignment;
  Alignment _anchorAlignment;
  Offset? _position;
  Size? _anchorSize;
  PopoverConstraint _widthConstraint;
  PopoverConstraint _heightConstraint;
  Offset? _offset;
  EdgeInsets _margin;
  double _scale;
  Alignment _scaleAlignment;
  FilterQuality? _filterQuality;
  bool _allowInvertHorizontal;
  bool _allowInvertVertical;

  bool _invertX = false;
  bool _invertY = false;

  /// Creates a popover layout render object.
  ///
  /// All parameters control how the popover is positioned and sized relative
  /// to its anchor.
  PopoverLayoutRender({
    RenderBox? child,
    required Alignment alignment,
    required Offset? position,
    required Alignment anchorAlignment,
    required PopoverConstraint widthConstraint,
    required PopoverConstraint heightConstraint,
    Size? anchorSize,
    Offset? offset,
    EdgeInsets margin = const EdgeInsets.all(8),
    required double scale,
    required Alignment scaleAlignment,
    FilterQuality? filterQuality,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
  })  : _alignment = alignment,
        _position = position,
        _anchorAlignment = anchorAlignment,
        _widthConstraint = widthConstraint,
        _heightConstraint = heightConstraint,
        _anchorSize = anchorSize,
        _offset = offset,
        _margin = margin,
        _scale = scale,
        _scaleAlignment = scaleAlignment,
        _filterQuality = filterQuality,
        _allowInvertHorizontal = allowInvertHorizontal,
        _allowInvertVertical = allowInvertVertical,
        super(child);

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  Matrix4 get _effectiveTransform {
    Size childSize = child!.size;
    Offset childOffset = (child!.parentData as BoxParentData).offset;
    var scaleAlignment = _scaleAlignment;
    if (_invertX || _invertY) {
      scaleAlignment = Alignment(
        _invertX ? -scaleAlignment.x : scaleAlignment.x,
        _invertY ? -scaleAlignment.y : scaleAlignment.y,
      );
    }
    Matrix4 transform = Matrix4.identity();
    Offset alignmentTranslation = scaleAlignment.alongSize(childSize);
    transform.translateByDouble(childOffset.dx, childOffset.dy, 0, 1);
    transform.translateByDouble(
        alignmentTranslation.dx, alignmentTranslation.dy, 0, 1);
    transform.scaleByDouble(_scale, _scale, 1, 1);
    transform.translateByDouble(
        -alignmentTranslation.dx, -alignmentTranslation.dy, 0, 1);
    transform.translateByDouble(-childOffset.dx, -childOffset.dy, 0, 1);
    return transform;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return result.addWithPaintTransform(
      transform: _effectiveTransform,
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        return super.hitTestChildren(result, position: position);
      },
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    Matrix4 effectiveTransform = _effectiveTransform;
    transform.multiply(effectiveTransform);
    super.applyPaintTransform(child, transform);
  }

  @override
  bool get alwaysNeedsCompositing => child != null && _filterQuality != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final Matrix4 transform = _effectiveTransform;
      if (_filterQuality == null) {
        final Offset? childOffset = MatrixUtils.getAsTranslation(transform);
        if (childOffset == null) {
          final double det = transform.determinant();
          if (det == 0 || !det.isFinite) {
            layer = null;
            return;
          }
          layer = context.pushTransform(
            needsCompositing,
            offset,
            transform,
            super.paint,
            oldLayer: layer is TransformLayer ? layer as TransformLayer? : null,
          );
        } else {
          super.paint(context, offset + childOffset);
          layer = null;
        }
      } else {
        final Matrix4 effectiveTransform =
            Matrix4.translationValues(offset.dx, offset.dy, 0.0)
              ..multiply(transform)
              ..translateByDouble(-offset.dx, -offset.dy, 0, 1);
        final ui.ImageFilter filter = ui.ImageFilter.matrix(
          effectiveTransform.storage,
          filterQuality: _filterQuality!,
        );
        if (layer is ImageFilterLayer) {
          final ImageFilterLayer filterLayer = layer! as ImageFilterLayer;
          filterLayer.imageFilter = filter;
        } else {
          layer = ImageFilterLayer(imageFilter: filter);
        }
        context.pushLayer(layer!, super.paint, offset);
        assert(() {
          layer!.debugCreator = debugCreator;
          return true;
        }());
      }
    }
  }

  /// Computes appropriate box constraints for the popover child.
  ///
  /// Applies width and height constraint strategies to the child based on
  /// anchor size, viewport constraints, and margin settings.
  ///
  /// Parameters:
  /// - [constraints]: The incoming constraints from parent
  ///
  /// Returns box constraints with min/max values for width and height.
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double minWidth = 0;
    double maxWidth = constraints.maxWidth;
    double minHeight = 0;
    double maxHeight = constraints.maxHeight;
    if (_widthConstraint == PopoverConstraint.anchorFixedSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minWidth = _anchorSize!.width;
      maxWidth = _anchorSize!.width;
    } else if (_widthConstraint == PopoverConstraint.anchorMinSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minWidth = _anchorSize!.width;
    } else if (_widthConstraint == PopoverConstraint.anchorMaxSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      maxWidth = _anchorSize!.width;
    } else if (_widthConstraint == PopoverConstraint.intrinsic) {
      double intrinsicWidth = child!.getMaxIntrinsicWidth(double.infinity);
      if (intrinsicWidth.isFinite) {
        maxWidth = max(minWidth, intrinsicWidth);
      }
    }
    if (_heightConstraint == PopoverConstraint.anchorFixedSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minHeight = _anchorSize!.height;
      maxHeight = _anchorSize!.height;
    } else if (_heightConstraint == PopoverConstraint.anchorMinSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minHeight = _anchorSize!.height;
    } else if (_heightConstraint == PopoverConstraint.anchorMaxSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      maxHeight = _anchorSize!.height;
    } else if (_heightConstraint == PopoverConstraint.intrinsic) {
      double intrinsicHeight = child!.getMaxIntrinsicHeight(double.infinity);
      if (intrinsicHeight.isFinite) {
        maxHeight = max(minHeight, intrinsicHeight);
      }
    }
    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  @override
  void performLayout() {
    child!.layout(getConstraintsForChild(constraints), parentUsesSize: true);
    size = constraints.biggest;
    Size childSize = child!.size;
    double offsetX = _offset?.dx ?? 0;
    double offsetY = _offset?.dy ?? 0;
    var position = _position;
    position ??= Offset(
      size.width / 2 + size.width / 2 * _anchorAlignment.x,
      size.height / 2 + size.height / 2 * _anchorAlignment.y,
    );
    double x = position.dx -
        childSize.width / 2 -
        (childSize.width / 2 * _alignment.x);
    double y = position.dy -
        childSize.height / 2 -
        (childSize.height / 2 * _alignment.y);
    double left = x - _margin.left;
    double top = y - _margin.top;
    double right = x + childSize.width + _margin.right;
    double bottom = y + childSize.height + _margin.bottom;
    if ((left < 0 || right > size.width) && _allowInvertHorizontal) {
      x = position.dx -
          childSize.width / 2 -
          (childSize.width / 2 * -_alignment.x);
      if (_anchorSize != null) {
        x -= _anchorSize!.width * _anchorAlignment.x;
      }
      left = x - _margin.left;
      right = x + childSize.width + _margin.right;
      offsetX *= -1;
      _invertX = true;
    } else {
      _invertX = false;
    }
    if ((top < 0 || bottom > size.height) && _allowInvertVertical) {
      y = position.dy -
          childSize.height / 2 -
          (childSize.height / 2 * -_alignment.y);
      if (_anchorSize != null) {
        y -= _anchorSize!.height * _anchorAlignment.y;
      }
      top = y - _margin.top;
      bottom = y + childSize.height + _margin.bottom;
      offsetY *= -1;
      _invertY = true;
    } else {
      _invertY = false;
    }
    final double dx = left < 0
        ? -left
        : right > size.width
            ? size.width - right
            : 0;
    final double dy = top < 0
        ? -top
        : bottom > size.height
            ? size.height - bottom
            : 0;
    Offset result = Offset(x + dx + offsetX, y + dy + offsetY);
    BoxParentData childParentData = child!.parentData as BoxParentData;
    childParentData.offset = result;
  }
}
