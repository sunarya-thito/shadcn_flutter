import '../../../shadcn_flutter.dart';

/// A mixin that defines the interface for controlling component values.
///
/// This mixin combines the capabilities of [ValueNotifier] to provide
/// a standardized way for widgets to expose their current value and
/// notify listeners of changes. Components that implement this interface
/// can be controlled programmatically and integrated with form validation
/// systems.
///
/// The generic type [T] represents the type of value this controller manages.
mixin ComponentController<T> implements ValueNotifier<T> {}

/// A concrete implementation of [ComponentController] that manages a single value.
///
/// This controller provides a simple way to programmatically control any
/// component that accepts a [ComponentController]. It extends [ValueNotifier]
/// to provide change notification capabilities.
///
/// The controller maintains the current value and notifies listeners when
/// the value changes through the inherited [ValueNotifier.value] setter.
///
/// Example:
/// ```dart
/// final controller = ComponentValueController<String>('initial value');
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Value changed to: ${controller.value}');
/// });
///
/// // Update the value
/// controller.value = 'new value';
/// ```
class ComponentValueController<T> extends ValueNotifier<T>
    implements ComponentController<T> {
  /// Creates a [ComponentValueController] with the given initial [value].
  ///
  /// The [value] parameter sets the initial state of the controller.
  /// Listeners will be notified whenever this value changes.
  ComponentValueController(super.value);
}

/// A mixin that provides a standardized interface for controlled components.
///
/// This mixin defines the contract that all controlled form components should
/// follow. It provides properties for external control through a controller,
/// initial value specification, change notifications, and enabled state management.
///
/// Components that use this mixin can be controlled either through a
/// [ComponentController] (for programmatic control) or through direct
/// property values (for declarative control).
///
/// The generic type [T] represents the type of value this component manages.
mixin ControlledComponent<T> on Widget {
  /// The controller for managing this component's value programmatically.
  ///
  /// When provided, the controller takes precedence over [initialValue]
  /// and manages the component's state externally. This is useful for
  /// form validation, programmatic value changes, and state persistence.
  ComponentController<T>? get controller;

  /// The initial value for this component when no controller is provided.
  ///
  /// This value is used only when [controller] is null. It sets the
  /// component's initial state and is ignored if a controller is present.
  T? get initialValue;

  /// Callback invoked when the component's value changes.
  ///
  /// This callback is called whenever the user interacts with the component
  /// or when the value is changed programmatically. The callback receives
  /// the new value as its parameter.
  ValueChanged<T>? get onChanged;

  /// Whether this component is enabled and accepts user input.
  ///
  /// When false, the component is displayed in a disabled state and
  /// does not respond to user interactions. The visual appearance
  /// typically changes to indicate the disabled state.
  bool get enabled;
}

/// Immutable data container for controlled component state.
///
/// This class encapsulates the three essential pieces of state that
/// controlled components need: the current value, a change callback,
/// and the enabled status. It provides a convenient way to pass
/// this state to widget builders.
///
/// The generic type [T] represents the type of value being managed.
class ControlledComponentData<T> {
  /// The current value of the component.
  ///
  /// This represents the component's current state and should be
  /// used by the UI to display the correct value to the user.
  final T value;

  /// Callback to invoke when the value should change.
  ///
  /// This callback should be called whenever the user interaction
  /// or programmatic action requires the value to be updated.
  /// The new value should be passed as the parameter.
  final ValueChanged<T> onChanged;

  /// Whether the component should accept user input.
  ///
  /// When false, the component should display in a disabled state
  /// and ignore user interactions.
  final bool enabled;

  /// Creates a [ControlledComponentData] with the specified state.
  ///
  /// All parameters are required as they represent the essential
  /// state needed for any controlled component to function properly.
  ///
  /// Parameters:
  /// - [value] (T, required): The current value to display
  /// - [onChanged] (`ValueChanged<T>`, required): Callback for value changes
  /// - [enabled] (bool, required): Whether the component accepts input
  const ControlledComponentData({
    required this.value,
    required this.onChanged,
    required this.enabled,
  });
}

/// A widget adapter that bridges controlled component logic with custom UI implementations.
///
/// This adapter provides a standardized way to implement controlled components
/// by handling the common logic for value management, controller integration,
/// and state synchronization. It implements the [ControlledComponent] mixin
/// and manages the lifecycle of value updates between controllers and UI.
///
/// The adapter supports both controlled mode (with a [controller]) and
/// uncontrolled mode (with an [initialValue]). When a controller is provided,
/// it becomes the source of truth for the component's value. When no controller
/// is provided, the component maintains its own internal state.
///
/// The generic type [T] represents the type of value this adapter manages.
///
/// Example:
/// ```dart
/// ControlledComponentAdapter<String>(
///   initialValue: 'Hello',
///   onChanged: (value) => print('Value changed: $value'),
///   builder: (context, data) {
///     return GestureDetector(
///       onTap: () => data.onChanged('${data.value}!'),
///       child: Text(data.value),
///     );
///   },
/// );
/// ```
class ControlledComponentAdapter<T> extends StatefulWidget
    with ControlledComponent<T> {
  @override
  final T? initialValue;
  @override
  final ValueChanged<T>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<T>? controller;

  /// A builder function that creates the widget UI using the provided state data.
  ///
  /// This function receives the current [BuildContext] and [ControlledComponentData]
  /// containing the current value, change callback, and enabled state. The builder
  /// should create a widget that displays the current value and calls the
  /// onChanged callback when user interaction occurs.
  final Widget Function(BuildContext context, ControlledComponentData<T> data)
      builder;

  /// Creates a [ControlledComponentAdapter].
  ///
  /// Either [controller] or [initialValue] must be provided to establish
  /// the component's initial state. The [builder] function is required
  /// and will be called to construct the UI with the current state.
  ///
  /// Parameters:
  /// - [builder] (required): Function that builds the UI using state data
  /// - [initialValue] (T?, optional): Initial value when no controller is used
  /// - [onChanged] (`ValueChanged<T>?`, optional): Callback for value changes
  /// - [controller] (`ComponentController<T>?`, optional): External controller for value management
  /// - [enabled] (bool, default: true): Whether the component accepts user input
  ///
  /// Throws [AssertionError] if neither controller nor initialValue is provided.
  ///
  /// Example:
  /// ```dart
  /// ControlledComponentAdapter<bool>(
  ///   initialValue: false,
  ///   enabled: true,
  ///   builder: (context, data) => Switch(
  ///     value: data.value,
  ///     onChanged: data.enabled ? data.onChanged : null,
  ///   ),
  /// );
  /// ```
  const ControlledComponentAdapter({
    super.key,
    required this.builder,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.enabled = true,
  }) : assert(controller != null || initialValue is T,
            'Either controller or initialValue must be provided');

  @override
  State<ControlledComponentAdapter<T>> createState() =>
      _ControlledComponentAdapterState<T>();
}

class _ControlledComponentAdapterState<T>
    extends State<ControlledComponentAdapter<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    T? value = widget.controller?.value ?? widget.initialValue;
    assert(value != null, 'Either controller or initialValue must be provided');
    _value = value as T;
    widget.controller?.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {
      _value = widget.controller!.value;
    });
  }

  @override
  void didUpdateWidget(covariant ControlledComponentAdapter<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);
    }
  }

  void _onChanged(T value) {
    widget.onChanged?.call(value);
    final controller = widget.controller;
    if (controller != null) {
      controller.value = value;
    } else {
      setState(() {
        _value = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      ControlledComponentData(
        value: _value,
        onChanged: _onChanged,
        enabled: widget.enabled,
      ),
    );
  }
}
