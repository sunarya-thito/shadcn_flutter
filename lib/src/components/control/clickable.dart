import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

extension WidgetStateExtension on Set<WidgetState> {
  bool get disabled => contains(WidgetState.disabled);
  bool get error => contains(WidgetState.error);
  bool get selected => contains(WidgetState.selected);
  bool get pressed => contains(WidgetState.pressed);
  bool get hovered => contains(WidgetState.hovered);
  bool get focused => contains(WidgetState.focused);
}

/// An abstract widget that provides state-aware visual variations.
///
/// Enables widgets to display different appearances based on their current
/// interactive state (disabled, selected, pressed, hovered, focused, error).
/// The widget automatically selects the appropriate visual representation
/// from provided alternatives based on a configurable state priority order.
///
/// Three factory constructors provide different approaches to state handling:
/// - Default constructor: Explicit widgets for each state
/// - `.map()`: Map-based state-to-widget associations  
/// - `.builder()`: Function-based dynamic state handling
///
/// The state resolution follows a priority order where earlier states in the
/// order take precedence over later ones. This ensures consistent behavior
/// when multiple states are active simultaneously.
///
/// Example:
/// ```dart
/// StatedWidget(
///   child: Text('Default'),
///   disabled: Text('Disabled State'),
///   hovered: Text('Hovered State'),  
///   pressed: Text('Pressed State'),
///   selected: Text('Selected State'),
/// )
/// ```
abstract class StatedWidget extends StatelessWidget {
  /// Default state priority order for resolving multiple active states.
  ///
  /// Defines the precedence when multiple widget states are active simultaneously.
  /// States earlier in the list take priority over later ones. The default order
  /// prioritizes accessibility and interaction feedback appropriately.
  static const List<WidgetState> defaultStateOrder = [
    WidgetState.disabled,
    WidgetState.error,
    WidgetState.selected,
    WidgetState.pressed,
    WidgetState.hovered,
    WidgetState.focused,
  ];

  const StatedWidget._({super.key});

  /// Creates a [StatedWidget] with explicit state-specific widgets.
  ///
  /// Provides dedicated widget instances for each supported state.
  /// The [child] serves as the default widget when no specific state
  /// matches or when no state-specific widget is provided.
  ///
  /// State resolution follows the [order] priority, with earlier states
  /// taking precedence. The first matching state with a non-null widget
  /// is selected for display.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Default widget for normal state
  /// - [order] (List<WidgetState>, default: defaultStateOrder): State priority order
  /// - [disabled] (Widget?, optional): Widget for disabled state
  /// - [selected] (Widget?, optional): Widget for selected state
  /// - [pressed] (Widget?, optional): Widget for pressed/active state
  /// - [hovered] (Widget?, optional): Widget for hover state
  /// - [focused] (Widget?, optional): Widget for focused state
  /// - [error] (Widget?, optional): Widget for error state
  ///
  /// Example:
  /// ```dart
  /// StatedWidget(
  ///   child: Icon(Icons.star_border),
  ///   selected: Icon(Icons.star, color: Colors.yellow),
  ///   hovered: Icon(Icons.star_border, color: Colors.grey),
  ///   disabled: Icon(Icons.star_border, color: Colors.grey.shade300),
  /// )
  /// ```
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

  /// Creates a [StatedWidget] using a map-based state configuration.
  ///
  /// Provides a flexible approach where states are defined using a map
  /// with keys representing state identifiers and values being the
  /// corresponding widgets. This approach is useful when states are
  /// determined dynamically or when working with custom state types.
  ///
  /// The [child] parameter serves as a fallback when no matching state
  /// is found in the states map. State resolution prioritizes exact
  /// matches in the provided map.
  ///
  /// Parameters:
  /// - [states] (Map<Object, Widget>, required): Map of state-to-widget mappings
  /// - [child] (Widget?, optional): Fallback widget when no state matches
  ///
  /// Example:
  /// ```dart
  /// StatedWidget.map(
  ///   states: {
  ///     WidgetState.selected: Icon(Icons.check_circle, color: Colors.green),
  ///     WidgetState.error: Icon(Icons.error, color: Colors.red),
  ///     'custom': Icon(Icons.star, color: Colors.blue),
  ///   },
  ///   child: Icon(Icons.circle_outlined),
  /// )
  /// ```
  const factory StatedWidget.map({
    Key? key,
    required Map<Object, Widget> states,
    Widget? child,
  }) = _MapStatedWidget;

  /// Creates a [StatedWidget] using a builder function for dynamic state handling.
  ///
  /// Provides maximum flexibility by using a builder function that receives
  /// the current set of active widget states and returns the appropriate
  /// widget. This approach allows for complex state logic, animations,
  /// and dynamic visual computations based on state combinations.
  ///
  /// The builder function is called whenever the widget states change,
  /// allowing for real-time adaptation to state transitions. This is
  /// ideal for complex UI that needs to respond to multiple simultaneous states.
  ///
  /// Parameters:
  /// - [builder] (Function, required): Builder function receiving context and states
  ///
  /// Example:
  /// ```dart
  /// StatedWidget.builder(
  ///   builder: (context, states) {
  ///     if (states.contains(WidgetState.disabled)) {
  ///       return Opacity(opacity: 0.5, child: Icon(Icons.block));
  ///     }
  ///     if (states.contains(WidgetState.selected)) {
  ///       return Icon(Icons.check_circle, color: Colors.green);
  ///     }
  ///     if (states.contains(WidgetState.hovered)) {
  ///       return AnimatedScale(scale: 1.1, child: Icon(Icons.star));
  ///     }
  ///     return Icon(Icons.star_border);
  ///   },
  /// )
  /// ```
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
    WidgetStatesData? statesData = Data.maybeOf<WidgetStatesData>(context);
    Set<WidgetState> states = statesData?.states ?? {};
    final child = _checkByOrder(states, 0);
    return child ?? const SizedBox();
  }
}

class WidgetStatesProvider extends StatelessWidget {
  final WidgetStatesController? controller;
  final Set<WidgetState>? states;
  final Widget child;
  final bool inherit;
  final bool boundary;

  const WidgetStatesProvider({
    super.key,
    this.controller,
    required this.child,
    this.states = const {},
    this.inherit = true,
  }) : boundary = false;

  const WidgetStatesProvider.boundary({
    super.key,
    required this.child,
  })  : boundary = true,
        controller = null,
        states = null,
        inherit = false;

  @override
  Widget build(BuildContext context) {
    if (boundary) {
      return Data<WidgetStatesData>.boundary(
        child: child,
      );
    }
    Set<WidgetState>? parentStates;
    if (inherit) {
      WidgetStatesData? parentData = Data.maybeOf<WidgetStatesData>(context);
      parentStates = parentData?.states;
    }
    return ListenableBuilder(
      listenable: Listenable.merge([
        if (controller != null) controller!,
      ]),
      builder: (context, child) {
        Set<WidgetState> currentStates = states ?? {};
        if (controller != null) {
          currentStates = currentStates.union(controller!.value);
        }
        if (parentStates != null) {
          currentStates = currentStates.union(parentStates);
        }
        return Data<WidgetStatesData>.inherit(
          data: WidgetStatesData(currentStates),
          child: child!,
        );
      },
      child: child,
    );
  }
}

class WidgetStatesData {
  final Set<WidgetState> states;

  const WidgetStatesData(this.states);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WidgetStatesData && setEquals(states, other.states);
  }

  @override
  int get hashCode => states.hashCode;

  @override
  String toString() => 'WidgetStatesData(states: $states)';
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
    WidgetStatesData? statesData = Data.maybeOf<WidgetStatesData>(context);
    Set<WidgetState> widgetStates = statesData?.states ?? {};
    for (var entry in states.entries) {
      final keys = entry.key;
      if (keys is Iterable<WidgetState>) {
        if (widgetStates.containsAll(keys)) {
          return entry.value;
        }
      } else if (keys is WidgetState) {
        if (widgetStates.contains(keys)) {
          return entry.value;
        }
      } else if (keys is String) {
        final state = _mappedNames[keys];
        if (state != null && widgetStates.contains(state)) {
          return entry.value;
        }
      } else {
        assert(false,
            'Invalid key type in states map (${keys.runtimeType}) expected WidgetState, Iterable<WidgetState>, or String');
      }
    }
    return child ?? const SizedBox();
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
    WidgetStatesData? statesData = Data.maybeOf(context);
    Set<WidgetState> states = statesData?.states ?? {};
    return builder(context, states);
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
  final bool? enableFeedback;
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
    this.enableFeedback,
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
        if (widget.enableFeedback ?? Theme.of(context).defaultEnableFeedback) {
          feedbackForTap(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var enabled = widget.enabled;
    return WidgetStatesProvider(
      controller: _controller,
      states: {
        if (!enabled) WidgetState.disabled,
      },
      child: ListenableBuilder(
        listenable: _controller,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, Widget? _) {
    final theme = Theme.of(context);
    final enabled = widget.enabled;
    var widgetStates = Data.maybeOf<WidgetStatesData>(context)?.states ?? {};
    widgetStates = widgetStates.union(_controller.value);
    Decoration? decoration = widget.decoration?.resolve(widgetStates);
    BorderRadiusGeometry borderRadius;
    if (decoration is BoxDecoration) {
      borderRadius = decoration.borderRadius ?? theme.borderRadiusMd;
    } else {
      borderRadius = theme.borderRadiusMd;
    }
    var buttonContainer = _buildContainer(context, decoration, widgetStates);
    return FocusOutline(
      focused: widget.focusOutline &&
          widgetStates.contains(WidgetState.focused) &&
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
                if (widget.enableFeedback ?? Theme.of(context).defaultEnableFeedback) {
                  // also dispatch hover
                  _controller.update(WidgetState.hovered, true);
                }
                _controller.update(WidgetState.pressed, true);
                widget.onTapDown?.call(details);
              }
            : widget.onTapDown,
        onTapUp: widget.onPressed != null
            ? (details) {
                if (widget.enableFeedback ?? Theme.of(context).defaultEnableFeedback) {
                  // also dispatch hover
                  _controller.update(WidgetState.hovered, false);
                }
                _controller.update(WidgetState.pressed, false);
                widget.onTapUp?.call(details);
              }
            : widget.onTapUp,
        onTapCancel: widget.onPressed != null
            ? () {
                if (widget.enableFeedback ?? Theme.of(context).defaultEnableFeedback) {
                  // also dispatch hover
                  _controller.update(WidgetState.hovered, false);
                }
                _controller.update(WidgetState.pressed, false);
                widget.onTapCancel?.call();
              }
            : widget.onTapCancel,
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
            DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
              onInvoke: (e) {
                final direction = e.direction;
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
          mouseCursor:
              widget.mouseCursor?.resolve(widgetStates) ?? MouseCursor.defer,
          child: DefaultTextStyle.merge(
            style: widget.textStyle?.resolve(widgetStates),
            child: IconTheme.merge(
              data: widget.iconTheme?.resolve(widgetStates) ??
                  const IconThemeData(),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return AnimatedValueBuilder(
                    value: widget.transform?.resolve(widgetStates),
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

  Widget _buildContainer(BuildContext context, Decoration? decoration,
      Set<WidgetState> widgetStates) {
    var resolvedMargin = widget.margin?.resolve(widgetStates);
    var resolvedPadding = widget.padding?.resolve(widgetStates);
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
