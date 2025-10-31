import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Extension on `Set<WidgetState>` providing convenient boolean getters for common states.
///
/// This extension simplifies checking for widget states by providing readable
/// property accessors instead of using `contains()` calls.
///
/// ## Example
///
/// ```dart
/// Set<WidgetState> states = {WidgetState.hovered, WidgetState.focused};
///
/// if (states.hovered) {
///   // Handle hover state
/// }
/// if (states.disabled) {
///   // Handle disabled state
/// }
/// ```
extension WidgetStateExtension on Set<WidgetState> {
  /// Whether the widget is in a disabled state.
  bool get disabled => contains(WidgetState.disabled);

  /// Whether the widget is in an error state.
  bool get error => contains(WidgetState.error);

  /// Whether the widget is in a selected state.
  bool get selected => contains(WidgetState.selected);

  /// Whether the widget is in a pressed state.
  bool get pressed => contains(WidgetState.pressed);

  /// Whether the widget is in a hovered state.
  bool get hovered => contains(WidgetState.hovered);

  /// Whether the widget is in a focused state.
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
  /// - [order] (`List<WidgetState>`, default: defaultStateOrder): State priority order
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
  /// - [states] (`Map<Object, Widget>`, required): Map of state-to-widget mappings
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

/// A widget that provides widget state information to descendants via `Data`.
///
/// [WidgetStatesProvider] manages and propagates widget states (like hovered,
/// pressed, disabled) down the widget tree using the Data inheritance mechanism.
/// It supports both static state sets and dynamic controller-based states.
///
/// ## Overview
///
/// Use [WidgetStatesProvider] to:
/// - Share widget states with descendant widgets
/// - Control states programmatically via [WidgetStatesController]
/// - Inherit states from ancestor providers
/// - Create state boundaries to isolate state contexts
///
/// ## Example
///
/// ```dart
/// WidgetStatesProvider(
///   states: {WidgetState.hovered},
///   child: StatedWidget(
///     child: Text('Normal'),
///     hovered: Text('Hovered'),
///   ),
/// )
/// ```
class WidgetStatesProvider extends StatelessWidget {
  /// Optional controller for programmatic state management.
  final WidgetStatesController? controller;

  /// Static set of widget states to provide.
  final Set<WidgetState>? states;

  /// The child widget that can access the provided states.
  final Widget child;

  /// Whether to inherit states from ancestor providers.
  ///
  /// When `true`, combines local states with inherited states.
  final bool inherit;

  /// Whether this provider acts as a state boundary.
  final bool boundary;

  /// Creates a widget states provider with optional controller and states.
  ///
  /// ## Parameters
  ///
  /// * [controller] - Optional controller for dynamic state management.
  /// * [child] - The descendant widget that can access states.
  /// * [states] - Static set of states to provide. Defaults to empty set.
  /// * [inherit] - Whether to inherit from ancestors. Defaults to `true`.
  const WidgetStatesProvider({
    super.key,
    this.controller,
    required this.child,
    this.states = const {},
    this.inherit = true,
  }) : boundary = false;

  /// Creates a widget states provider that acts as a state boundary.
  ///
  /// A boundary provider blocks state inheritance from ancestors, creating
  /// an isolated state context for its descendants.
  ///
  /// ## Parameters
  ///
  /// * [child] - The descendant widget.
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

/// Data class wrapping a set of widget states.
///
/// [WidgetStatesData] is a simple container for a `Set<WidgetState>` that can
/// be passed through the widget tree using the [Data] inherited widget system.
/// It's used by components like [Clickable] to propagate state information
/// (hovered, pressed, focused, etc.) to descendant widgets.
///
/// Example:
/// ```dart
/// const statesData = WidgetStatesData({WidgetState.hovered, WidgetState.focused});
/// ```
class WidgetStatesData {
  /// The set of current widget states.
  ///
  /// Common states include [WidgetState.hovered], [WidgetState.pressed],
  /// [WidgetState.focused], [WidgetState.disabled], and [WidgetState.selected].
  final Set<WidgetState> states;

  /// Creates widget states data with the specified states.
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

/// A highly configurable clickable widget with extensive gesture and state support.
///
/// [Clickable] provides a comprehensive foundation for interactive widgets, handling
/// various input gestures (tap, double-tap, long-press, etc.), visual states, and
/// accessibility features. It manages decoration, styling, and transitions based on
/// widget states like hover, focus, and press.
///
/// ## Overview
///
/// Use [Clickable] when building custom interactive components that need:
/// - Fine-grained gesture control (primary, secondary, tertiary taps)
/// - State-aware styling (decoration, text style, mouse cursor, etc.)
/// - Focus management and keyboard shortcuts
/// - Smooth transitions between states
/// - Accessibility features like focus outlines
///
/// ## Example
///
/// ```dart
/// Clickable(
///   onPressed: () => print('Clicked!'),
///   decoration: WidgetStateProperty.resolveWith((states) {
///     if (states.contains(WidgetState.pressed)) {
///       return BoxDecoration(color: Colors.blue.shade700);
///     }
///     return BoxDecoration(color: Colors.blue);
///   }),
///   child: Padding(
///     padding: EdgeInsets.all(8),
///     child: Text('Click Me'),
///   ),
/// )
/// ```
class Clickable extends StatefulWidget {
  /// The child widget displayed within the clickable area.
  final Widget child;

  /// Whether the widget is enabled and can respond to interactions.
  final bool enabled;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// State-aware decoration for the widget.
  final WidgetStateProperty<Decoration?>? decoration;

  /// State-aware mouse cursor style.
  final WidgetStateProperty<MouseCursor?>? mouseCursor;

  /// State-aware padding around the child.
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  /// State-aware text style applied to text descendants.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// State-aware icon theme applied to icon descendants.
  final WidgetStateProperty<IconThemeData?>? iconTheme;

  /// State-aware margin around the widget.
  final WidgetStateProperty<EdgeInsetsGeometry?>? margin;

  /// State-aware transformation matrix.
  final WidgetStateProperty<Matrix4?>? transform;

  /// Called when the widget is tapped (primary button).
  final VoidCallback? onPressed;

  /// Called when the widget is double-tapped.
  final VoidCallback? onDoubleTap;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// How to behave during hit testing.
  final HitTestBehavior behavior;

  /// Whether to disable state transition animations.
  final bool disableTransition;

  /// Keyboard shortcuts to handle.
  final Map<LogicalKeySet, Intent>? shortcuts;

  /// Actions to handle for intents.
  final Map<Type, Action<Intent>>? actions;

  /// Whether to show focus outline for accessibility.
  final bool focusOutline;

  /// Whether to enable haptic/audio feedback.
  final bool enableFeedback;

  /// Called when long-pressed.
  final VoidCallback? onLongPress;

  /// Called on primary tap down.
  final GestureTapDownCallback? onTapDown;

  /// Called on primary tap up.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called on secondary (right-click) tap down.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called on secondary tap up.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called on tertiary (middle-click) tap down.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called on tertiary tap up.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called on secondary long press completion.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called on tertiary long press completion.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Whether to disable hover visual effects.
  final bool disableHoverEffect;

  /// Optional controller for programmatic state management.
  final WidgetStatesController? statesController;

  /// Alignment for applying margin.
  final AlignmentGeometry? marginAlignment;

  /// Whether to disable the focus outline.
  final bool disableFocusOutline;

  /// Creates a [Clickable] widget.
  ///
  /// A clickable area with state-dependent styling and comprehensive gesture support.
  ///
  /// Parameters:
  /// - [child] (required): The widget to display and make clickable
  /// - [enabled]: Whether the widget is enabled. Defaults to `true`
  /// - [onPressed]: Primary tap callback. If `null`, widget is disabled
  /// - [decoration], [mouseCursor], [padding], [textStyle], [iconTheme], [margin], [transform]:
  ///   State-dependent property functions for styling
  /// - [focusNode]: Optional focus node for keyboard focus management
  /// - [behavior]: Hit test behavior. Defaults to [HitTestBehavior.translucent]
  /// - [onHover], [onFocus]: State change callbacks
  /// - [disableTransition]: If `true`, disables animation transitions. Defaults to `false`
  /// - [disableHoverEffect]: If `true`, disables hover visual effects. Defaults to `false`
  /// - [onDoubleTap]: Double tap callback
  /// - [shortcuts], [actions]: Keyboard shortcuts and actions
  /// - [focusOutline]: Whether to show focus outline. Defaults to `true`
  /// - [enableFeedback]: Whether to enable haptic/audio feedback. Defaults to `true`
  /// - [onTapDown], [onTapUp], [onTapCancel]: Primary tap gesture callbacks
  /// - [onSecondaryTapDown], [onSecondaryTapUp], [onSecondaryTapCancel]: Secondary tap callbacks
  /// - [onTertiaryTapDown], [onTertiaryTapUp], [onTertiaryTapCancel]: Tertiary tap callbacks
  /// - [onLongPress], [onLongPressStart], [onLongPressUp], [onLongPressMoveUpdate], [onLongPressEnd]:
  ///   Long press gesture callbacks
  /// - [onSecondaryLongPress], [onTertiaryLongPress]: Secondary and tertiary long press callbacks
  /// - [statesController]: Optional controller for programmatic state management
  /// - [marginAlignment]: Alignment for applying margin
  /// - [disableFocusOutline]: Whether to disable the focus outline. Defaults to `false`
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
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  @override
  State<Clickable> createState() => _ClickableState();
}

/// Minimum time interval between taps to be considered a double tap.
///
/// Taps that occur within this duration (300ms) of a previous tap are counted
/// as part of a multi-tap gesture sequence. Used internally by [Clickable] to
/// detect double-tap gestures.
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
                if (widget.enableFeedback) {
                  // also dispatch hover
                  _controller.update(WidgetState.hovered, true);
                }
                _controller.update(WidgetState.pressed, true);
                widget.onTapDown?.call(details);
              }
            : widget.onTapDown,
        onTapUp: widget.onPressed != null
            ? (details) {
                if (widget.enableFeedback) {
                  // also dispatch hover
                  _controller.update(WidgetState.hovered, false);
                }
                _controller.update(WidgetState.pressed, false);
                widget.onTapUp?.call(details);
              }
            : widget.onTapUp,
        onTapCancel: widget.onPressed != null
            ? () {
                if (widget.enableFeedback) {
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
