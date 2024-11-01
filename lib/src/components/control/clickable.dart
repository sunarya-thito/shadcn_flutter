import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

abstract class StatedWidget extends StatelessWidget {
  static const List<WidgetState> defaultStateOrder = [
    WidgetState.disabled,
    WidgetState.error,
    WidgetState.selected,
    WidgetState.pressed,
    WidgetState.hovered,
    WidgetState.focused,
  ];
  const StatedWidget._({super.key});
  const factory StatedWidget({
    Key? key,
    required Widget child,
    List<WidgetState> order,
    Widget? disabled,
    Widget? selected,
    Widget? pressed,
    Widget? hovered,
    Widget? focused,
    Widget? error,
  }) = _ParamStatedWidget;
  const factory StatedWidget.map({
    Key? key,
    required Map<Object, Widget> states,
    Widget? child,
  }) = _MapStatedWidget;
  const factory StatedWidget.builder({
    Key? key,
    required Widget Function(BuildContext context, Set<WidgetState> states)
        builder,
  }) = _BuilderStatedWidget;
}

class _ParamStatedWidget extends StatedWidget {
  final List<WidgetState> order;
  final Widget? child;
  final Widget? disabled;
  final Widget? selected;
  final Widget? pressed;
  final Widget? hovered;
  final Widget? focused;
  final Widget? error;

  const _ParamStatedWidget({
    super.key,
    this.order = StatedWidget.defaultStateOrder,
    this.child,
    this.disabled,
    this.selected,
    this.pressed,
    this.hovered,
    this.focused,
    this.error,
  }) : super._();

  Widget? _checkByOrder(Set<WidgetState> states, int index) {
    if (index >= order.length) {
      return child;
    }
    final state = order[index];
    if (states.contains(state)) {
      switch (state) {
        case WidgetState.disabled:
          return disabled;
        case WidgetState.pressed:
          return pressed;
        case WidgetState.hovered:
          return hovered;
        case WidgetState.focused:
          return focused;
        case WidgetState.selected:
          return selected;
        case WidgetState.error:
          return error;
        default:
          return child;
      }
    }
    return _checkByOrder(states, index + 1);
  }

  @override
  Widget build(BuildContext context) {
    WidgetStatesController? statesController = Data.maybeOf(context);
    if (statesController == null) {
      return child ?? const SizedBox();
    }
    return ListenableBuilder(
      listenable: statesController,
      builder: (context, child) {
        final states = statesController.value;
        final child = _checkByOrder(states, 0);
        return child ?? const SizedBox();
      },
      child: child,
    );
  }
}

class _MapStatedWidget extends StatedWidget {
  static final Map<String, WidgetState> _mappedNames =
      WidgetState.values.asNameMap();
  final Map<Object, Widget> states;
  final Widget? child;

  const _MapStatedWidget({
    super.key,
    required this.states,
    this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    WidgetStatesController? statesController = Data.maybeOf(context);
    if (statesController == null) {
      return child ?? const SizedBox();
    }
    return ListenableBuilder(
      listenable: statesController,
      builder: (context, child) {
        for (var entry in states.entries) {
          final keys = entry.key;
          if (keys is Iterable<WidgetState>) {
            if (statesController.value.containsAll(keys)) {
              return entry.value;
            }
          } else if (keys is WidgetState) {
            if (statesController.value.contains(keys)) {
              return entry.value;
            }
          } else if (keys is String) {
            final state = _mappedNames[keys];
            if (state != null && statesController.value.contains(state)) {
              return entry.value;
            }
          } else {
            assert(false,
                'Invalid key type in states map (${keys.runtimeType}) expected WidgetState, Iterable<WidgetState>, or String');
          }
        }
        return child ?? const SizedBox();
      },
      child: child,
    );
  }
}

class _BuilderStatedWidget extends StatedWidget {
  final Widget Function(BuildContext context, Set<WidgetState> states) builder;

  const _BuilderStatedWidget({
    super.key,
    required this.builder,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    WidgetStatesController? statesController = Data.maybeOf(context);
    if (statesController == null) {
      return const SizedBox();
    }
    return ListenableBuilder(
      listenable: statesController,
      builder: (context, child) {
        return builder(context, statesController.value);
      },
    );
  }
}

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
  final AlignmentGeometry? marginAlignment;
  final bool disableFocusOutline;

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
    this.marginAlignment,
    this.disableFocusOutline = false,
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
    if (isMobile(currentPlatform)) {
      return SystemSound.play(SystemSoundType.click);
    }
    return Future<void>.value();
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
    var enabled = widget.enabled;
    return Semantics(
      enabled: enabled,
      container: true,
      button: widget.isSemanticButton,
      child: Data<WidgetStatesController>.inherit(
        data: _controller,
        child: AnimatedBuilder(
          animation: _controller,
          builder: _builder,
        ),
      ),
    );
  }

  Widget _builder(BuildContext context, Widget? _) {
    final theme = Theme.of(context);
    final enabled = widget.enabled;
    Decoration? decoration = widget.decoration?.resolve(_controller.value);
    BorderRadiusGeometry borderRadius;
    if (decoration is BoxDecoration) {
      borderRadius = decoration.borderRadius ?? theme.borderRadiusMd;
    } else {
      borderRadius = theme.borderRadiusMd;
    }
    var buttonContainer = _buildContainer(context, decoration);
    return FocusOutline(
      focused: widget.focusOutline &&
          _controller.value.contains(WidgetState.focused) &&
          !widget.disableFocusOutline,
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
                final focus = _focusNode;
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
          child: DefaultTextStyle.merge(
            style: widget.textStyle?.resolve(_controller.value),
            child: IconTheme.merge(
              data: widget.iconTheme?.resolve(_controller.value) ??
                  const IconThemeData(),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return AnimatedValueBuilder(
                    value: widget.transform?.resolve(_controller.value),
                    duration: const Duration(milliseconds: 50),
                    lerp: lerpMatrix4,
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
  }

  Matrix4? lerpMatrix4(Matrix4? a, Matrix4? b, double t) {
    if (a == null && b == null) {
      return null;
    }
    Matrix4Tween tween = Matrix4Tween(
      begin: a ?? Matrix4.identity(),
      end: b ?? Matrix4.identity(),
    );
    return tween.transform(t);
  }

  Widget _buildContainer(BuildContext context, Decoration? decoration) {
    var resolvedMargin = widget.margin?.resolve(_controller.value);
    var resolvedPadding = widget.padding?.resolve(_controller.value);
    if (widget.disableTransition) {
      Widget container = Container(
        clipBehavior: Clip.antiAlias,
        margin: resolvedMargin,
        decoration: decoration,
        padding: resolvedPadding,
        child: widget.child,
      );
      if (widget.marginAlignment != null) {
        container = Align(
          alignment: widget.marginAlignment!,
          child: container,
        );
      }
      return container;
    }
    Widget animatedContainer = AnimatedContainer(
      clipBehavior: decoration == null ? Clip.none : Clip.antiAlias,
      margin: resolvedMargin,
      duration: kDefaultDuration,
      decoration: decoration,
      padding: resolvedPadding,
      child: widget.child,
    );
    if (widget.marginAlignment != null) {
      animatedContainer = AnimatedAlign(
        duration: kDefaultDuration,
        alignment: widget.marginAlignment!,
        child: animatedContainer,
      );
    }
    return animatedContainer;
  }
}
