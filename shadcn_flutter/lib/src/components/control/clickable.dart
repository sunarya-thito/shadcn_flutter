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
  final bool? isSemanticButton;
  final bool disableHoverEffect;
  final WidgetStatesController? statesController;

  const Clickable({
    super.key,
    required this.child,
    this.statesController,
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
    this.disableHoverEffect = false,
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
    this.isSemanticButton = true,
  });

  @override
  State<Clickable> createState() => _ClickableState();
}

const kDoubleTapMinTime = Duration(milliseconds: 300);

class _ClickableState extends State<Clickable> {
  late FocusNode _focusNode;
  late WidgetStatesController _controller;
  DateTime? _lastTap;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.statesController ?? WidgetStatesController();
    _controller.update(WidgetState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(covariant Clickable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.statesController != oldWidget.statesController) {
      _controller = widget.statesController ?? WidgetStatesController();
    }
    _controller.update(WidgetState.disabled, !widget.enabled);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (widget.disableHoverEffect) {
      _controller.update(WidgetState.hovered, false);
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
    if (!widget.enabled) return;
    Duration? deltaTap =
        _lastTap == null ? null : DateTime.now().difference(_lastTap!);
    _lastTap = DateTime.now();
    if (deltaTap != null && deltaTap < kDoubleTapMinTime) {
      _tapCount++;
    } else {
      _tapCount = 1;
    }

    if (_tapCount == 2 && widget.onDoubleTap != null) {
      widget.onDoubleTap!();
      _tapCount = 0;
    } else {
      if (widget.onPressed != null) {
        widget.onPressed!();
        if (widget.enableFeedback) {
          feedbackForTap(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var enabled = widget.enabled;
    return Semantics(
      enabled: enabled,
      container: true,
      button: widget.isSemanticButton,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          Decoration? decoration =
              widget.decoration?.resolve(_controller.value);
          BorderRadiusGeometry borderRadius;
          if (decoration is BoxDecoration) {
            borderRadius = decoration.borderRadius ?? theme.borderRadiusMd;
          } else {
            borderRadius = theme.borderRadiusMd;
          }
          var buttonContainer = _buildContainer(context, decoration);
          return FocusOutline(
            focused: widget.focusOutline &&
                _controller.value.contains(WidgetState.focused),
            borderRadius: borderRadius,
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
              onTapDown: widget.onPressed != null
                  ? (details) {
                      if (widget.enableFeedback) {
                        // also dispatch hover
                        _controller.update(WidgetState.hovered, true);
                      }
                      _controller.update(WidgetState.pressed, true);
                    }
                  : null,
              onTapUp: widget.onPressed != null
                  ? (details) {
                      if (widget.enableFeedback) {
                        // also dispatch hover
                        _controller.update(WidgetState.hovered, false);
                      }
                      _controller.update(WidgetState.pressed, false);
                    }
                  : null,
              onTapCancel: widget.onPressed != null
                  ? () {
                      if (widget.enableFeedback) {
                        // also dispatch hover
                        _controller.update(WidgetState.hovered, false);
                      }
                      _controller.update(WidgetState.pressed, false);
                    }
                  : null,
              child: FocusableActionDetector(
                enabled: enabled,
                focusNode: _focusNode,
                shortcuts: {
                  LogicalKeySet(LogicalKeyboardKey.enter):
                      const ActivateIntent(),
                  LogicalKeySet(LogicalKeyboardKey.space):
                      const ActivateIntent(),
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
                  _controller.update(
                      WidgetState.hovered, value && !widget.disableHoverEffect);
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
                            return tween.transform(t);
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
                      child: buttonContainer,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContainer(BuildContext context, Decoration? decoration) {
    var resolvedMargin = widget.margin?.resolve(_controller.value);
    var resolvedPadding = widget.padding?.resolve(_controller.value);
    if (widget.disableTransition) {
      return Container(
        margin: resolvedMargin,
        decoration: decoration,
        padding: resolvedPadding,
        child: widget.child,
      );
    }
    return AnimatedContainer(
      margin: resolvedMargin,
      duration: kDefaultDuration,
      decoration: decoration,
      padding: resolvedPadding,
      child: widget.child,
    );
  }
}
