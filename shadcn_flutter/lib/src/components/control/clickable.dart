import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

class Clickable extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final WidgetStateProperty<Decoration?>? decoration;
  final WidgetStateProperty<MouseCursor?>? mouseCursor;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;
  final WidgetStateProperty<TextStyle?>? textStyle;
  final WidgetStateProperty<IconThemeData?>? iconTheme;
  final WidgetStateProperty<EdgeInsetsGeometry?>? margin;
  final WidgetStateProperty<Matrix4?>? transform;
  final VoidCallback? onPressed;
  final VoidCallback? onDoubleTap;
  final FocusNode? focusNode;
  final HitTestBehavior behavior;
  final bool disableTransition;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final bool focusOutline;
  final bool enableFeedback;
  final VoidCallback? onLongPress;
  // delegate the rest onX from GestureDetector, except for onDoubleTap and pan/drag
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const Clickable({
    super.key,
    required this.child,
    this.enabled = true,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.onPressed,
    this.focusNode,
    this.behavior = HitTestBehavior.translucent,
    this.onHover,
    this.onFocus,
    this.disableTransition = false,
    this.margin,
    this.onDoubleTap,
    this.shortcuts,
    this.actions,
    this.focusOutline = true,
    this.enableFeedback = true,
    this.transform,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  State<Clickable> createState() => _ClickableState();
}

const kDoubleTapMinTime = Duration(milliseconds: 300);

class _ClickableState extends State<Clickable> {
  late FocusNode _focusNode;
  final WidgetStatesController _controller = WidgetStatesController();
  DateTime? _lastTap;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.update(WidgetState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(covariant Clickable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(WidgetState.disabled, !widget.enabled);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  static Future<void> feedbackForTap(BuildContext context) async {
    final currentPlatform = Theme.of(context).platform;
    context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
    switch (currentPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return SystemSound.play(SystemSoundType.click);
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Future<void>.value();
    }
  }

  void _onPressed() {
    Duration? deltaTap =
        _lastTap == null ? null : DateTime.now().difference(_lastTap!);
    _lastTap = DateTime.now();
    if (widget.onPressed != null) {
      // Regardless of the tapCount, onPressed should be called
      // every time the widget is tapped whether it is from
      // mouse, keyboard, or touch.
      // Original implementation from flutter
      // would dismiss the onTap in favor of onDoubleTap,
      // but this would also make a slight delay in the feedback.
      widget.onPressed!();
      if (widget.enableFeedback) {
        feedbackForTap(context);
      }
    }
    if (widget.onDoubleTap != null) {
      if (deltaTap != null && deltaTap < kDoubleTapMinTime) {
        _tapCount++;
        if (_tapCount == 2) {
          widget.onDoubleTap!();
          _tapCount = 0;
        }
      } else {
        _tapCount = 1;
      }
    }
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        var enabled = widget.enabled;
        return FocusOutline(
          focused: widget.focusOutline &&
              _controller.value.contains(WidgetState.focused),
          borderRadius: BorderRadius.circular(theme.radiusMd),
          child: GestureDetector(
            behavior: widget.behavior,
            onTap: widget.onPressed != null ? _onPressed : null,
            onLongPress: widget.onLongPress,
            // onDoubleTap: widget.onDoubleTap, HANDLED CUSTOMLY
            onSecondaryTapDown: widget.onSecondaryTapDown,
            onSecondaryTapUp: widget.onSecondaryTapUp,
            onSecondaryTapCancel: widget.onSecondaryTapCancel,
            onTertiaryTapDown: widget.onTertiaryTapDown,
            onTertiaryTapUp: widget.onTertiaryTapUp,
            onTertiaryTapCancel: widget.onTertiaryTapCancel,
            onLongPressStart: widget.onLongPressStart,
            onLongPressUp: widget.onLongPressUp,
            onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
            onLongPressEnd: widget.onLongPressEnd,
            onSecondaryLongPress: widget.onSecondaryLongPress,
            onTertiaryLongPress: widget.onTertiaryLongPress,
            onTapDown: (details) {
              _controller.update(WidgetState.pressed, true);
            },
            onTapUp: (details) {
              _controller.update(WidgetState.pressed, false);
            },
            onTapCancel: () {
              _controller.update(WidgetState.pressed, false);
            },
            child: FocusableActionDetector(
              enabled: enabled,
              focusNode: widget.focusNode,
              shortcuts: {
                LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
                LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
                LogicalKeySet(LogicalKeyboardKey.arrowUp):
                    const DirectionalFocusIntent(TraversalDirection.up),
                LogicalKeySet(LogicalKeyboardKey.arrowDown):
                    const DirectionalFocusIntent(TraversalDirection.down),
                LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                    const DirectionalFocusIntent(TraversalDirection.left),
                LogicalKeySet(LogicalKeyboardKey.arrowRight):
                    const DirectionalFocusIntent(TraversalDirection.right),
                ...?widget.shortcuts,
              },
              actions: {
                ActivateIntent: CallbackAction(
                  onInvoke: (e) {
                    _onPressed();
                    return null;
                  },
                ),
                DirectionalFocusIntent: CallbackAction(
                  onInvoke: (e) {
                    final direction = (e as DirectionalFocusIntent).direction;
                    final focus = Focus.of(context);
                    switch (direction) {
                      case TraversalDirection.up:
                        focus.focusInDirection(TraversalDirection.up);
                        break;
                      case TraversalDirection.down:
                        focus.focusInDirection(TraversalDirection.down);
                        break;
                      case TraversalDirection.left:
                        focus.focusInDirection(TraversalDirection.left);
                        break;
                      case TraversalDirection.right:
                        focus.focusInDirection(TraversalDirection.right);
                        break;
                    }
                    return null;
                  },
                ),
                ...?widget.actions,
              },
              onShowHoverHighlight: (value) {
                _controller.update(WidgetState.hovered, value);
                widget.onHover?.call(value);
              },
              onShowFocusHighlight: (value) {
                _controller.update(WidgetState.focused, value);
                widget.onFocus?.call(value);
              },
              mouseCursor: widget.mouseCursor?.resolve(_controller.value) ??
                  MouseCursor.defer,
              child: mergeAnimatedTextStyle(
                duration: kDefaultDuration,
                style: widget.textStyle?.resolve(_controller.value),
                child: AnimatedIconTheme.merge(
                  duration: kDefaultDuration,
                  data: widget.iconTheme?.resolve(_controller.value) ??
                      const IconThemeData(),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return AnimatedValueBuilder(
                        value: widget.transform?.resolve(_controller.value),
                        duration: const Duration(milliseconds: 50),
                        lerp: (a, b, t) {
                          Matrix4Tween tween = Matrix4Tween(
                            begin: a ?? Matrix4.identity(),
                            end: b ?? Matrix4.identity(),
                          );
                          return tween.lerp(t);
                        },
                        builder: (context, value, child) {
                          return Transform(
                            alignment: Alignment.center,
                            transform: value ?? Matrix4.identity(),
                            child: child,
                          );
                        },
                        child: child,
                      );
                    },
                    child: buildContainer(context),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildContainer(BuildContext context) {
    if (widget.disableTransition) {
      return Container(
        margin: widget.margin?.resolve(_controller.value),
        decoration: widget.decoration?.resolve(_controller.value),
        padding: widget.padding?.resolve(_controller.value),
        child: widget.child,
      );
    }
    return AnimatedContainer(
      duration: kDefaultDuration,
      margin: widget.margin?.resolve(_controller.value),
      decoration: widget.decoration?.resolve(_controller.value),
      padding: widget.padding?.resolve(_controller.value),
      child: widget.child,
    );
  }
}
