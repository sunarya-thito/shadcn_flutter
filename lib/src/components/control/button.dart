import 'dart:math';

import '../../../shadcn_flutter.dart';

/// A controller for managing toggle state in toggle buttons and switches.
///
/// [ToggleController] extends [ValueNotifier] to provide reactive state management
/// for boolean toggle values. It implements [ComponentController] to integrate
/// with the shadcn_flutter form system and provides convenient methods for
/// programmatic state changes.
///
/// The controller maintains a boolean value representing the toggle state and
/// notifies listeners when the state changes, making it suitable for use with
/// toggle buttons, switches, and other binary state controls.
///
/// Example:
/// ```dart
/// final toggleController = ToggleController(false);
///
/// // Listen to changes
/// toggleController.addListener(() {
///   print('Toggle state: ${toggleController.value}');
/// });
///
/// // Toggle the state programmatically
/// toggleController.toggle();
///
/// // Set specific value
/// toggleController.value = true;
/// ```
class ToggleController extends ValueNotifier<bool>
    with ComponentController<bool> {
  /// Creates a [ToggleController] with an initial toggle state.
  ///
  /// Parameters:
  /// - [value] (bool, default: false): The initial toggle state.
  ///
  /// Example:
  /// ```dart
  /// // Create controller starting in off state
  /// final controller = ToggleController();
  ///
  /// // Create controller starting in on state
  /// final controller = ToggleController(true);
  /// ```
  ToggleController([super.value = false]);

  /// Toggles the current boolean state.
  ///
  /// Changes `true` to `false` and `false` to `true`, then notifies all listeners
  /// of the change. This is equivalent to setting `value = !value` but provides
  /// a more semantic API for toggle operations.
  ///
  /// Example:
  /// ```dart
  /// final controller = ToggleController(false);
  /// controller.toggle(); // value is now true
  /// controller.toggle(); // value is now false
  /// ```
  void toggle() {
    value = !value;
  }
}

/// A controlled version of [Toggle] that integrates with form state management.
///
/// [ControlledToggle] implements the [ControlledComponent] mixin to provide
/// automatic form integration, validation, and state management. It serves as
/// a bridge between external state management (via [ToggleController] or
/// [onChanged] callbacks) and the underlying [Toggle] widget.
///
/// This widget is ideal for use in forms where the toggle state needs to be
/// managed externally, validated, or persisted. It automatically handles the
/// conversion between controlled and uncontrolled modes based on the provided
/// parameters.
///
/// Example:
/// ```dart
/// final controller = ToggleController(false);
///
/// ControlledToggle(
///   controller: controller,
///   child: Row(
///     children: [
///       Icon(Icons.notifications),
///       Text('Enable notifications'),
///     ],
///   ),
/// );
/// ```
class ControlledToggle extends StatelessWidget with ControlledComponent<bool> {
  /// The initial toggle state when no controller is provided.
  ///
  /// Used only in uncontrolled mode. If both [controller] and [initialValue]
  /// are provided, [controller] takes precedence.
  @override
  final bool? initialValue;

  /// Callback invoked when the toggle state changes.
  ///
  /// Called with the new boolean value whenever the user toggles the button.
  /// If null, the toggle becomes read-only (though it can still be controlled
  /// via [controller] if provided).
  @override
  final ValueChanged<bool>? onChanged;

  /// Whether the toggle is interactive.
  ///
  /// When false, the toggle appears disabled and doesn't respond to user input.
  /// The toggle can still be changed programmatically via [controller].
  @override
  final bool enabled;

  /// Controller for managing toggle state externally.
  ///
  /// When provided, the toggle operates in controlled mode and its state is
  /// managed entirely by this controller. Changes are reflected immediately
  /// and [onChanged] is called when the user interacts with the toggle.
  @override
  final ToggleController? controller;

  /// The child widget to display inside the toggle button.
  ///
  /// Typically contains text, icons, or a combination of both. The child
  /// receives the visual styling and interaction behavior of the toggle button.
  final Widget child;

  /// Visual styling for the toggle button.
  ///
  /// Defines the appearance, colors, padding, and other visual characteristics
  /// of the toggle. Defaults to ghost button style with subtle appearance changes
  /// between toggled and untoggled states.
  final ButtonStyle style;

  /// Creates a [ControlledToggle] widget.
  ///
  /// Parameters:
  /// - [controller] (ToggleController?, optional): External state controller.
  /// - [initialValue] (bool?, optional): Initial state for uncontrolled mode.
  /// - [onChanged] (`ValueChanged<bool>?`, optional): State change callback.
  /// - [enabled] (bool, default: true): Whether the toggle is interactive.
  /// - [child] (Widget, required): Content to display in the toggle button.
  /// - [style] (ButtonStyle, default: ButtonStyle.ghost()): Visual styling.
  ///
  /// Example:
  /// ```dart
  /// ControlledToggle(
  ///   initialValue: false,
  ///   onChanged: (value) => print('Toggled: $value'),
  ///   enabled: true,
  ///   style: ButtonStyle.secondary(),
  ///   child: Text('Toggle Me'),
  /// );
  /// ```
  const ControlledToggle({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    required this.child,
    this.style = const ButtonStyle.ghost(),
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Toggle(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          style: style,
          child: child,
        );
      },
    );
  }
}

/// Simple toggle button with stateful on/off behavior.
///
/// A basic toggle button widget that maintains its own internal state for
/// on/off toggling. Provides a simplified interface compared to [ControlledToggle]
/// for cases where external state management is not required.
///
/// ## Features
///
/// - **Stateful toggling**: Built-in state management for simple use cases
/// - **Ghost button styling**: Default ghost button appearance
/// - **Form integration**: Automatic form field registration with boolean values
/// - **Accessibility**: Full screen reader and keyboard support
/// - **Custom styling**: Configurable button style and appearance
///
/// The widget automatically cycles between true/false states when pressed
/// and calls the [onChanged] callback with the new state.
///
/// Example:
/// ```dart
/// bool isEnabled = false;
///
/// Toggle(
///   value: isEnabled,
///   onChanged: (enabled) => setState(() => isEnabled = enabled),
///   child: Text('Enable notifications'),
/// );
/// ```
class Toggle extends StatefulWidget {
  /// The current toggle state (on/off).
  final bool value;

  /// Called when the toggle state changes.
  ///
  /// If `null`, the toggle is considered disabled and won't respond to user input.
  final ValueChanged<bool>? onChanged;

  /// The widget displayed inside the toggle button.
  final Widget child;

  /// The visual style for the button.
  ///
  /// Defaults to ghost style for a subtle appearance.
  final ButtonStyle style;

  /// Whether the toggle button is enabled.
  ///
  /// If `null`, the button is enabled only when [onChanged] is not `null`.
  final bool? enabled;

  /// Creates a [Toggle].
  ///
  /// The toggle button maintains its own state and calls [onChanged] when
  /// the state changes. Uses ghost button styling by default.
  ///
  /// Parameters:
  /// - [value] (bool, required): current toggle state
  /// - [onChanged] (`ValueChanged<bool>?`, optional): callback when state changes
  /// - [child] (Widget, required): content displayed inside the button
  /// - [enabled] (bool?, optional): whether button is interactive
  /// - [style] (ButtonStyle, default: ghost): button styling
  ///
  /// Example:
  /// ```dart
  /// Toggle(
  ///   value: isToggled,
  ///   onChanged: (value) => setState(() => isToggled = value),
  ///   child: Row(
  ///     children: [
  ///       Icon(Icons.notifications),
  ///       Text('Notifications'),
  ///     ],
  ///   ),
  /// )
  /// ```
  const Toggle({
    super.key,
    required this.value,
    this.onChanged,
    required this.child,
    this.enabled,
    this.style = const ButtonStyle.ghost(),
  });

  @override
  ToggleState createState() => ToggleState();
}

// toggle button is just ghost button
/// State class for [Toggle] that manages the toggle behavior and form integration.
///
/// This state class handles:
/// - Maintaining widget states (selected, pressed, hovered, etc.)
/// - Form value integration via [FormValueSupplier]
/// - Updating the selected state based on the toggle value
class ToggleState extends State<Toggle> with FormValueSupplier<bool, Toggle> {
  /// Controller for managing widget interaction states.
  final WidgetStatesController statesController = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    statesController.update(WidgetState.selected, widget.value);
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(Toggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      statesController.update(WidgetState.selected, widget.value);
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(bool value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Button(
        statesController: statesController,
        enabled: widget.enabled,
        style: widget.value
            ? ButtonStyle.secondary(
                density: widget.style.density,
                shape: widget.style.shape,
                size: widget.style.size,
              )
            : widget.style.copyWith(textStyle: (context, states, value) {
                final theme = Theme.of(context);
                return value.copyWith(
                  color: states.contains(WidgetState.hovered)
                      ? theme.colorScheme.mutedForeground
                      : null,
                );
              }, iconTheme: (context, states, value) {
                final theme = Theme.of(context);
                return value.copyWith(
                  color: states.contains(WidgetState.hovered)
                      ? theme.colorScheme.mutedForeground
                      : null,
                );
              }),
        onPressed: widget.onChanged != null
            ? () {
                widget.onChanged!(!widget.value);
              }
            : null,
        child: widget.child);
  }
}

/// A button that changes style based on its selected state.
///
/// [SelectedButton] provides a stateful button that displays different styles
/// when selected versus unselected. It supports all standard button gestures
/// including tap, long press, and hover interactions.
///
/// ## Overview
///
/// Use [SelectedButton] when you need a button that visually indicates selection
/// state, such as in tab bars, segmented controls, or toggle groups. The button
/// automatically switches between [style] (unselected) and [selectedStyle] (selected)
/// based on the [value] parameter.
///
/// ## Example
///
/// ```dart
/// SelectedButton(
///   value: isSelected,
///   onChanged: (selected) => setState(() => isSelected = selected),
///   style: const ButtonStyle.ghost(),
///   selectedStyle: const ButtonStyle.secondary(),
///   child: Text('Option A'),
/// )
/// ```
class SelectedButton extends StatefulWidget {
  /// The current selection state of the button.
  final bool value;

  /// Called when the selection state changes.
  ///
  /// If `null`, the button is disabled.
  final ValueChanged<bool>? onChanged;

  /// The widget displayed inside the button.
  final Widget child;

  /// The button style when not selected.
  ///
  /// Defaults to ghost style.
  final AbstractButtonStyle style;

  /// The button style when selected.
  ///
  /// Defaults to secondary style.
  final AbstractButtonStyle selectedStyle;

  /// Whether the button is enabled.
  ///
  /// If `null`, enabled state is determined by whether [onChanged] is non-null.
  final bool? enabled;

  /// The alignment of the child within the button.
  final AlignmentGeometry? alignment;

  /// The margin alignment for the button.
  final AlignmentGeometry? marginAlignment;

  /// Whether to disable style transition animations.
  ///
  /// Defaults to `false`. When `true`, style changes are instant.
  final bool disableTransition;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when a primary tap down event occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when a primary tap up event occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when a primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when a secondary tap down event occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when a secondary tap up event occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when a secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when a tertiary tap down event occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when a tertiary tap up event occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when a tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when a long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when a long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when a long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when a long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when a secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when a tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Whether to disable the hover effect.
  ///
  /// Defaults to `false`.
  final bool disableHoverEffect;

  /// Optional controller for programmatic state management.
  final WidgetStatesController? statesController;

  /// Called when the button is pressed (tapped).
  final VoidCallback? onPressed;

  /// Creates a [SelectedButton] widget.
  ///
  /// A button that toggles between selected and unselected states, applying
  /// different styles based on the current [value].
  ///
  /// Parameters:
  /// - [value] (required): The current selection state (`true` for selected).
  /// - [onChanged]: Callback invoked when the selection state changes. If `null`, the button is disabled.
  /// - [child] (required): The widget displayed inside the button.
  /// - [enabled]: Whether the button is enabled. Defaults to checking if [onChanged] is non-null.
  /// - [style]: Style applied when unselected. Defaults to [ButtonStyle.ghost].
  /// - [selectedStyle]: Style applied when selected. Defaults to [ButtonStyle.secondary].
  /// - [alignment]: Alignment of the child within the button.
  /// - [marginAlignment]: Margin alignment for the button.
  /// - [disableTransition]: If `true`, disables style transition animations. Defaults to `false`.
  /// - [onHover]: Called when the hover state changes.
  /// - [onFocus]: Called when the focus state changes.
  /// - [enableFeedback]: Whether to enable haptic/audio feedback.
  /// - [onTapDown], [onTapUp], [onTapCancel]: Primary tap gesture callbacks.
  /// - [onSecondaryTapDown], [onSecondaryTapUp], [onSecondaryTapCancel]: Secondary tap gesture callbacks.
  /// - [onTertiaryTapDown], [onTertiaryTapUp], [onTertiaryTapCancel]: Tertiary tap gesture callbacks.
  /// - [onLongPressStart], [onLongPressUp], [onLongPressMoveUpdate], [onLongPressEnd]: Long press gesture callbacks.
  /// - [onSecondaryLongPress], [onTertiaryLongPress]: Secondary and tertiary long press callbacks.
  /// - [disableHoverEffect]: If `true`, disables the hover effect. Defaults to `false`.
  /// - [statesController]: Optional controller for programmatic state management.
  /// - [onPressed]: Called when the button is tapped.
  ///
  /// Example:
  /// ```dart
  /// SelectedButton(
  ///   value: isSelected,
  ///   onChanged: (selected) => setState(() => isSelected = selected),
  ///   child: Text('Toggle Me'),
  /// )
  /// ```
  const SelectedButton({
    super.key,
    required this.value,
    this.onChanged,
    required this.child,
    this.enabled,
    this.style = const ButtonStyle.ghost(),
    this.selectedStyle = const ButtonStyle.secondary(),
    this.alignment,
    this.marginAlignment,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.disableHoverEffect = false,
    this.statesController,
    this.onPressed,
  });

  @override
  SelectedButtonState createState() => SelectedButtonState();
}

// toggle button is just ghost button
/// State class for [SelectedButton] managing selection and interaction states.
///
/// Handles widget state controller lifecycle and synchronizes the selected state
/// with the button's value.
class SelectedButtonState extends State<SelectedButton> {
  /// The controller managing widget states (selected, hovered, focused, etc.).
  ///
  /// This controller is either provided via [SelectedButton.statesController]
  /// or created automatically. It tracks and manages the button's interactive
  /// states and updates them based on user interactions and the selection value.
  late WidgetStatesController statesController;
  @override
  void initState() {
    super.initState();
    statesController = widget.statesController ?? WidgetStatesController();
    statesController.update(WidgetState.selected, widget.value);
  }

  @override
  void didUpdateWidget(SelectedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.statesController != widget.statesController) {
      statesController = widget.statesController ?? WidgetStatesController();
      statesController.update(WidgetState.selected, widget.value);
    }
    if (oldWidget.value != widget.value) {
      statesController.update(WidgetState.selected, widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Button(
        statesController: statesController,
        enabled: widget.enabled,
        style: widget.value ? widget.selectedStyle : widget.style,
        alignment: widget.alignment,
        marginAlignment: widget.marginAlignment,
        disableTransition: widget.disableTransition,
        onHover: widget.onHover,
        onFocus: widget.onFocus,
        enableFeedback: widget.enableFeedback,
        onTapDown: widget.onTapDown,
        onTapUp: widget.onTapUp,
        onTapCancel: widget.onTapCancel,
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
        disableHoverEffect: widget.disableHoverEffect,
        onPressed: () {
          if (widget.onChanged != null) {
            widget.onChanged!(!widget.value);
          }
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        child: widget.child);
  }
}

/// A versatile, customizable button widget with comprehensive styling and interaction support.
///
/// [Button] is the foundational interactive widget in the shadcn_flutter design system,
/// providing a consistent and accessible button implementation with extensive customization
/// options. It supports multiple visual variants, sizes, shapes, and interaction patterns
/// while maintaining design system consistency.
///
/// ## Key Features
/// - **Multiple Variants**: Primary, secondary, outline, ghost, link, text, destructive, and more
/// - **Flexible Sizing**: From extra small to extra large with custom scaling
/// - **Shape Options**: Rectangle and circle shapes with customizable borders
/// - **Rich Interactions**: Hover, focus, press, and long press support
/// - **Accessibility**: Full keyboard navigation and screen reader support
/// - **Theming**: Deep integration with the design system theme
/// - **Form Integration**: Works seamlessly with form validation and state management
///
/// ## Visual Variants
/// The button supports various visual styles through named constructors:
/// - [Button.primary]: Prominent primary actions with filled background
/// - [Button.secondary]: Secondary actions with muted background
/// - [Button.outline]: Actions with outline border and transparent background
/// - [Button.ghost]: Subtle actions with minimal visual weight
/// - [Button.link]: Text-only actions that appear as links
/// - [Button.text]: Plain text actions with hover effects
/// - [Button.destructive]: Dangerous actions with destructive styling
/// - [Button.card]: Card-like appearance for container buttons
///
/// ## Layout and Content
/// Buttons can contain text, icons, or a combination of both using [leading] and [trailing]
/// widgets. The [child] widget is automatically aligned and sized according to the button's
/// style and density settings.
///
/// ## Interaction Handling
/// The button provides comprehensive gesture support including tap, long press, secondary
/// clicks, and tertiary clicks. All interactions respect the [enabled] state and provide
/// appropriate visual and haptic feedback.
///
/// Example:
/// ```dart
/// Button.primary(
///   onPressed: () => print('Primary action'),
///   leading: Icon(Icons.add),
///   trailing: Icon(Icons.arrow_forward),
///   child: Text('Create New'),
/// );
/// ```
class Button extends StatefulWidget {
  /// Whether the button is interactive.
  ///
  /// If null, the button is enabled when [onPressed] is not null. When false,
  /// the button appears disabled and doesn't respond to user input or fire callbacks.
  final bool? enabled;

  /// Whether to disable visual state transition animations.
  ///
  /// When true, the button immediately snaps between visual states instead of
  /// smoothly animating. Useful for performance optimization in lists or when
  /// animations would be distracting.
  final bool disableTransition;

  /// Widget displayed to the left of the main child content.
  ///
  /// Commonly used for icons that provide additional context about the button's
  /// action. Automatically spaced from the [child] with appropriate gaps.
  final Widget? leading;

  /// Widget displayed to the right of the main child content.
  ///
  /// Often used for icons indicating direction (arrows) or additional actions.
  /// Automatically spaced from the [child] with appropriate gaps.
  final Widget? trailing;

  /// The primary content displayed in the button.
  ///
  /// Typically contains text, icons, or other widgets that describe the button's
  /// action. Automatically aligned according to [alignment] and styled according
  /// to the button's [style].
  final Widget child;

  /// Callback invoked when the button is pressed.
  ///
  /// The primary interaction callback for the button. When null, the button becomes
  /// disabled unless [enabled] is explicitly set to true. The button automatically
  /// handles loading states, disabled states, and provides haptic feedback.
  final VoidCallback? onPressed;

  /// Focus node for keyboard navigation and focus management.
  ///
  /// If null, a focus node is automatically created. Useful for controlling focus
  /// programmatically or integrating with form focus traversal.
  final FocusNode? focusNode;

  /// Alignment of the child content within the button.
  ///
  /// Controls how the [child] is positioned within the button's bounds. Defaults
  /// to center alignment for most button types. When [leading] or [trailing] are
  /// provided, defaults to start alignment.
  final AlignmentGeometry? alignment;

  /// Visual styling configuration for the button.
  ///
  /// Defines the button's appearance including colors, padding, borders, and text
  /// styles. The [AbstractButtonStyle] provides state-aware styling that responds
  /// to hover, press, focus, and disabled states.
  final AbstractButtonStyle style;

  /// Callback invoked when the button's hover state changes.
  ///
  /// Called with true when the pointer enters the button area and false when it
  /// leaves. Useful for implementing custom hover effects or updating external state.
  final ValueChanged<bool>? onHover;

  /// Callback invoked when the button's focus state changes.
  ///
  /// Called with true when the button gains focus and false when it loses focus.
  /// Useful for accessibility features or coordinating focus with other widgets.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic feedback on press.
  ///
  /// If null, haptic feedback is automatically enabled on mobile platforms.
  /// When true, provides tactile feedback when the button is pressed. When false,
  /// no haptic feedback is provided regardless of platform.
  final bool? enableFeedback;

  /// Callback invoked when a tap down gesture begins.
  ///
  /// Provides the position and details of the initial touch/click. Useful for
  /// implementing custom press animations or tracking interaction start points.
  final GestureTapDownCallback? onTapDown;

  /// Callback invoked when a tap up gesture completes.
  ///
  /// Called after a successful tap gesture, providing the position details.
  /// Note that [onPressed] is typically preferred for button actions.
  final GestureTapUpCallback? onTapUp;

  /// Callback invoked when a tap gesture is canceled.
  ///
  /// Called when a tap gesture starts but is interrupted before completion,
  /// such as when the pointer moves outside the button area.
  final GestureTapCancelCallback? onTapCancel;

  /// Callback invoked when a secondary button (right-click) tap down begins.
  ///
  /// Useful for implementing context menus or alternative actions.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Callback invoked when a secondary button tap up completes.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Callback invoked when a secondary button tap is canceled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Callback invoked when a tertiary button (middle-click) tap down begins.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Callback invoked when a tertiary button tap up completes.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Callback invoked when a tertiary button tap is canceled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Callback invoked when a long press gesture begins.
  ///
  /// Provides the position where the long press started. Useful for implementing
  /// press-and-hold actions or showing additional options.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Callback invoked when a long press gesture completes.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Callback invoked when a long press gesture moves.
  ///
  /// Provides position updates during an active long press. Useful for
  /// implementing drag-from-long-press behaviors.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Callback invoked when a long press gesture ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Callback invoked when a secondary button long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Callback invoked when a tertiary button long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Whether to disable hover visual effects.
  ///
  /// When true, the button doesn't show visual changes on hover, though [onHover]
  /// callbacks are still called. Useful for custom hover implementations.
  final bool disableHoverEffect;

  /// Controller for managing button widget states externally.
  ///
  /// Allows external control over hover, pressed, focused, and other widget states.
  /// Useful for implementing custom state logic or coordinating with other widgets.
  final WidgetStatesController? statesController;

  /// Alignment for the button's margin within its allocated space.
  ///
  /// Controls how the button positions itself within its parent's constraints
  /// when the button is smaller than the available space.
  final AlignmentGeometry? marginAlignment;

  /// Whether to disable the focus outline.
  ///
  /// When true, removes the visual focus indicator that appears when the button
  /// is focused via keyboard navigation. Use carefully as this affects accessibility.
  final bool disableFocusOutline;

  /// Creates a [Button] with custom styling.
  ///
  /// This is the base constructor that allows complete customization of the button's
  /// appearance and behavior through the [style] parameter. For common use cases,
  /// consider using the named constructors like [Button.primary] or [Button.secondary].
  ///
  /// Parameters:
  /// - [statesController] (WidgetStatesController?, optional): External state management.
  /// - [leading] (Widget?, optional): Widget displayed before the main content.
  /// - [trailing] (Widget?, optional): Widget displayed after the main content.
  /// - [child] (Widget, required): Main content of the button.
  /// - [onPressed] (VoidCallback?, optional): Primary action callback.
  /// - [focusNode] (FocusNode?, optional): Focus management node.
  /// - [alignment] (AlignmentGeometry?, optional): Content alignment within button.
  /// - [style] (AbstractButtonStyle, required): Visual styling configuration.
  /// - [enabled] (bool?, optional): Whether button responds to interactions.
  /// - [disableTransition] (bool, default: false): Whether to disable state animations.
  /// - [onFocus] (`ValueChanged<bool>?`, optional): Focus state change callback.
  /// - [onHover] (`ValueChanged<bool>?`, optional): Hover state change callback.
  /// - [disableHoverEffect] (bool, default: false): Whether to disable hover visuals.
  /// - [enableFeedback] (bool?, optional): Whether to provide haptic feedback.
  /// - [marginAlignment] (AlignmentGeometry?, optional): Margin positioning.
  /// - [disableFocusOutline] (bool, default: false): Whether to hide focus outline.
  ///
  /// Example:
  /// ```dart
  /// Button(
  ///   style: ButtonStyle.primary(),
  ///   leading: Icon(Icons.save),
  ///   onPressed: () => saveDocument(),
  ///   child: Text('Save Document'),
  /// );
  /// ```
  const Button({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    required this.style,
    this.enabled,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a primary button with prominent styling for main actions.
  ///
  /// Primary buttons use a filled background with high contrast text, making them
  /// suitable for the most important action on a screen or in a section. They have
  /// the highest visual weight and should be used sparingly.
  ///
  /// The button uses the primary color from the theme and provides clear visual
  /// feedback for hover, focus, and press states.
  ///
  /// Parameters: Same as [Button] constructor, with [style] preset to [ButtonVariance.primary].
  ///
  /// Example:
  /// ```dart
  /// Button.primary(
  ///   onPressed: () => submitForm(),
  ///   child: Text('Submit'),
  /// );
  /// ```
  const Button.primary({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.primary,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a secondary button with muted styling for supporting actions.
  ///
  /// Secondary buttons use a subtle background color with medium contrast text,
  /// making them suitable for actions that are important but not primary. They have
  /// less visual weight than primary buttons and can be used more frequently.
  ///
  /// Example:
  /// ```dart
  /// Button.secondary(
  ///   onPressed: () => cancelAction(),
  ///   child: Text('Cancel'),
  /// );
  /// ```
  const Button.secondary({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.secondary,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates an outline button with a border and transparent background.
  ///
  /// Outline buttons feature a visible border and transparent background, providing
  /// a minimal yet distinct appearance. They're ideal for secondary actions that need
  /// to stand out more than ghost buttons but less than filled buttons. The outline
  /// style works well in layouts where visual hierarchy matters.
  ///
  /// Example:
  /// ```dart
  /// Button.outline(
  ///   onPressed: () => showMore(),
  ///   child: Text('Learn More'),
  /// );
  /// ```
  const Button.outline({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.outline,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a ghost button with minimal styling for subtle actions.
  ///
  /// Ghost buttons have no background by default and only show subtle hover effects.
  /// They're perfect for actions that need to be available but shouldn't draw attention
  /// away from more important content.
  ///
  /// Example:
  /// ```dart
  /// Button.ghost(
  ///   onPressed: () => showHelp(),
  ///   leading: Icon(Icons.help_outline),
  ///   child: Text('Help'),
  /// );
  /// ```
  const Button.ghost({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.ghost,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a link-styled button with underline decoration.
  ///
  /// Link buttons appear as inline text links, typically underlined on hover,
  /// making them suitable for navigation or inline actions within text. They have
  /// minimal visual presence and work well for tertiary actions or embedded links.
  ///
  /// Example:
  /// ```dart
  /// Button.link(
  ///   onPressed: () => openUrl(),
  ///   child: Text('View Documentation'),
  /// );
  /// ```
  const Button.link({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.link,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a text-only button with no background or border.
  ///
  /// Text buttons display only their text content without any background fill or
  /// border decoration. They're the most minimal button style, useful for actions
  /// that should be accessible but not visually prominent, such as "Skip" or "Not now".
  ///
  /// Example:
  /// ```dart
  /// Button.text(
  ///   onPressed: () => skipStep(),
  ///   child: Text('Skip'),
  /// );
  /// ```
  const Button.text({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.text,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a destructive button for actions that delete or destroy data.
  ///
  /// Destructive buttons use red/warning colors to clearly indicate that the action
  /// will remove, delete, or otherwise negatively affect user data. They should be
  /// used sparingly and typically require confirmation dialogs.
  ///
  /// Example:
  /// ```dart
  /// Button.destructive(
  ///   onPressed: () => deleteItem(),
  ///   leading: Icon(Icons.delete),
  ///   child: Text('Delete'),
  /// );
  /// ```
  const Button.destructive({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.destructive,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a fixed-style button with consistent dimensions.
  ///
  /// Fixed buttons maintain specific dimensions regardless of content, making them
  /// ideal for grids, toolbars, or layouts where uniform button sizing is required.
  /// They're commonly used in icon-heavy interfaces or when precise spacing matters.
  ///
  /// Example:
  /// ```dart
  /// Button.fixed(
  ///   onPressed: () => performAction(),
  ///   child: Icon(Icons.add),
  /// );
  /// ```
  const Button.fixed({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.fixed,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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

  /// Creates a card-style button with elevated appearance.
  ///
  /// Card buttons feature subtle shadows and borders to create a card-like elevated
  /// appearance. They work well in content-heavy layouts where buttons need to stand
  /// out from surrounding content, such as feature cards or call-to-action sections.
  ///
  /// Example:
  /// ```dart
  /// Button.card(
  ///   onPressed: () => selectOption(),
  ///   child: Column(
  ///     children: [
  ///       Icon(Icons.star),
  ///       Text('Premium'),
  ///     ],
  ///   ),
  /// );
  /// ```
  const Button.card({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.card,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
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
  ButtonState createState() => ButtonState();
}

/// State class for [Button] widgets managing interactive state and rendering.
///
/// [ButtonState] handles the button's lifecycle, manages the [WidgetStatesController]
/// for tracking interactive states (pressed, hovered, focused, disabled), and
/// coordinates with the button's style system to apply appropriate visual changes
/// based on the current state.
///
/// This class is generic, allowing it to manage state for various button types
/// (primary, secondary, outline, etc.) through the type parameter [T].
///
/// The state class automatically:
/// - Creates or uses a provided [WidgetStatesController]
/// - Updates the disabled state based on [onPressed] availability
/// - Manages focus and hover interactions
/// - Applies style transitions and animations
class ButtonState<T extends Button> extends State<T> {
  bool get _shouldEnableFeedback {
    final platform = Theme.of(context).platform;
    return isMobile(platform);
  }

  AbstractButtonStyle? _style;
  ButtonStyleOverrideData? _overrideData;

  @override
  void initState() {
    super.initState();
    _style = widget.style;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var overrideData = Data.maybeOf<ButtonStyleOverrideData>(context);
    if (overrideData != _overrideData) {
      _overrideData = overrideData;
      if (overrideData != null) {
        _style = widget.style.copyWith(
          decoration: overrideData.decoration,
          mouseCursor: overrideData.mouseCursor,
          padding: overrideData.padding,
          textStyle: overrideData.textStyle,
          iconTheme: overrideData.iconTheme,
          margin: overrideData.margin,
        );
      } else {
        _style = widget.style;
      }
    }
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.style != oldWidget.style) {
      var overrideData = _overrideData;
      if (overrideData != null) {
        _style = widget.style.copyWith(
          decoration: overrideData.decoration,
          mouseCursor: overrideData.mouseCursor,
          padding: overrideData.padding,
          textStyle: overrideData.textStyle,
          iconTheme: overrideData.iconTheme,
          margin: overrideData.margin,
        );
      } else {
        _style = widget.style;
      }
    }
  }

  EdgeInsetsGeometry _resolveMargin(Set<WidgetState> states) {
    return _style!.margin(context, states);
  }

  Decoration _resolveDecoration(Set<WidgetState> states) {
    return _style!.decoration(context, states);
  }

  MouseCursor _resolveMouseCursor(Set<WidgetState> states) {
    return _style!.mouseCursor(context, states);
  }

  EdgeInsetsGeometry _resolvePadding(Set<WidgetState> states) {
    return _style!.padding(context, states);
  }

  TextStyle _resolveTextStyle(Set<WidgetState> states) {
    return _style!.textStyle(context, states);
  }

  IconThemeData _resolveIconTheme(Set<WidgetState> states) {
    return _style!.iconTheme(context, states);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    bool enableFeedback = widget.enableFeedback ?? _shouldEnableFeedback;
    return Clickable(
      disableFocusOutline: widget.disableFocusOutline,
      statesController: widget.statesController,
      focusNode: widget.focusNode,
      enabled: widget.enabled ?? widget.onPressed != null,
      marginAlignment: widget.marginAlignment,
      disableTransition: widget.disableTransition,
      onHover: widget.onHover,
      onFocus: widget.onFocus,
      disableHoverEffect: widget.disableHoverEffect,
      enableFeedback: enableFeedback,
      margin: WidgetStateProperty.resolveWith(_resolveMargin),
      decoration: WidgetStateProperty.resolveWith(_resolveDecoration),
      mouseCursor: WidgetStateProperty.resolveWith(_resolveMouseCursor),
      padding: WidgetStateProperty.resolveWith(_resolvePadding),
      textStyle: WidgetStateProperty.resolveWith(_resolveTextStyle),
      iconTheme: WidgetStateProperty.resolveWith(_resolveIconTheme),
      transform: enableFeedback
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                // scale down to 95% with alignment at center
                return Matrix4.identity()..scaleByDouble(0.95, 0.95, 0.95, 1);
              }
              return null;
            })
          : null,
      onPressed: widget.onPressed,
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
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
      child: widget.leading == null && widget.trailing == null
          ? Align(
              heightFactor: 1,
              widthFactor: 1,
              alignment: widget.alignment ?? Alignment.center,
              child: widget.child,
            )
          : IntrinsicWidth(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.leading != null) widget.leading!,
                    if (widget.leading != null) Gap(8 * scaling),
                    Expanded(
                      child: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        alignment: widget.alignment ??
                            AlignmentDirectional.centerStart,
                        child: widget.child,
                      ),
                    ),
                    if (widget.trailing != null) Gap(8 * scaling),
                    if (widget.trailing != null) widget.trailing!,
                  ],
                ),
              ),
            ),
    );
  }
}

/// Defines the relative size scaling for button components.
///
/// [ButtonSize] controls the overall scale of buttons, affecting text size,
/// icon size, and proportional padding. The scaling factor is applied to
/// all dimensional properties to maintain visual consistency.
///
/// Example:
/// ```dart
/// Button.primary(
///   style: ButtonStyle.primary().copyWith(size: ButtonSize.large),
///   child: Text('Large Button'),
/// );
/// ```
class ButtonSize {
  /// The scaling factor applied to button dimensions.
  ///
  /// A value of 1.0 represents normal size, values less than 1.0 create smaller
  /// buttons, and values greater than 1.0 create larger buttons.
  final double scale;

  /// Creates a [ButtonSize] with the specified scaling factor.
  const ButtonSize(this.scale);

  /// Standard button size (scale: 1.0).
  static const ButtonSize normal = ButtonSize(1);

  /// Extra small button size (scale: 0.5).
  static const ButtonSize xSmall = ButtonSize(1 / 2);

  /// Small button size (scale: 0.75).
  static const ButtonSize small = ButtonSize(3 / 4);

  /// Large button size (scale: 2.0).
  static const ButtonSize large = ButtonSize(2);

  /// Extra large button size (scale: 3.0).
  static const ButtonSize xLarge = ButtonSize(3);
}

/// A function that modifies button padding based on density requirements.
///
/// Takes the base padding and returns modified padding appropriate for the
/// desired button density level.
typedef DensityModifier = EdgeInsets Function(EdgeInsets padding);

/// Defines the padding density for button components.
///
/// [ButtonDensity] controls how much internal padding buttons have, affecting
/// their overall size and touch target area. Different density levels are
/// appropriate for different use cases and layout constraints.
///
/// Example:
/// ```dart
/// Button.primary(
///   style: ButtonStyle.primary().copyWith(density: ButtonDensity.compact),
///   child: Text('Compact Button'),
/// );
/// ```
class ButtonDensity {
  /// Function that modifies base padding to achieve the desired density.
  final DensityModifier modifier;

  /// Creates a [ButtonDensity] with the specified padding modifier.
  const ButtonDensity(this.modifier);

  /// Standard padding density (no modification).
  static const ButtonDensity normal = ButtonDensity(_densityNormal);

  /// Increased padding for more comfortable touch targets.
  static const ButtonDensity comfortable = ButtonDensity(_densityComfortable);

  /// Square padding suitable for icon-only buttons.
  static const ButtonDensity icon = ButtonDensity(_densityIcon);

  /// Comfortable square padding for icon-only buttons.
  static const ButtonDensity iconComfortable =
      ButtonDensity(_densityIconComfortable);

  /// Dense square padding for compact icon buttons.
  static const ButtonDensity iconDense = ButtonDensity(_densityIconDense);

  /// Reduced padding for tighter layouts (50% of normal).
  static const ButtonDensity dense = ButtonDensity(_densityDense);

  /// Minimal padding for very compact layouts (zero padding).
  static const ButtonDensity compact = ButtonDensity(_densityCompact);
}

EdgeInsets _densityNormal(EdgeInsets padding) {
  return padding;
}

EdgeInsets _densityDense(EdgeInsets padding) {
  return padding * 0.5;
}

EdgeInsets _densityCompact(EdgeInsets padding) {
  return EdgeInsets.zero;
}

EdgeInsets _densityIcon(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))));
}

EdgeInsets _densityIconComfortable(EdgeInsets padding) {
  return EdgeInsets.all(
      max(padding.top, max(padding.bottom, max(padding.left, padding.right))));
}

EdgeInsets _densityIconDense(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))) *
          0.5);
}

EdgeInsets _densityComfortable(EdgeInsets padding) {
  return padding * 2;
}

/// Defines the shape style for button components.
///
/// [ButtonShape] determines the border radius and overall shape of buttons,
/// allowing for rectangular buttons with rounded corners or fully circular buttons.
enum ButtonShape {
  /// Rectangular button with theme-appropriate rounded corners.
  rectangle,

  /// Circular button with equal width and height.
  circle,
}

/// Function signature for button state-dependent properties.
///
/// [ButtonStateProperty] is a function type that resolves a property value based
/// on the current widget states (hovered, pressed, focused, disabled, etc.) and
/// build context. This allows button styles to dynamically adapt their appearance
/// based on user interactions.
///
/// Parameters:
/// - [context]: The build context for accessing theme data
/// - [states]: Set of current widget states (e.g., `{WidgetState.hovered, WidgetState.pressed}`)
///
/// Returns the property value of type [T] appropriate for the current states.
///
/// Example:
/// ```dart
/// ButtonStateProperty<Color> backgroundColor = (context, states) {
///   if (states.contains(WidgetState.disabled)) return Colors.grey;
///   if (states.contains(WidgetState.pressed)) return Colors.blue.shade700;
///   if (states.contains(WidgetState.hovered)) return Colors.blue.shade400;
///   return Colors.blue;
/// };
/// ```
typedef ButtonStateProperty<T> = T Function(
    BuildContext context, Set<WidgetState> states);

/// Abstract interface defining the style properties for button components.
///
/// [AbstractButtonStyle] specifies the contract for button styling, requiring
/// implementations to provide state-dependent values for decoration, cursor,
/// padding, text style, icon theme, and margin. This abstraction allows for
/// flexible button theming while maintaining a consistent API.
///
/// All properties return [ButtonStateProperty] functions that resolve values
/// based on the button's current interactive state (hovered, pressed, focused, etc.).
///
/// Implementations include [ButtonStyle] and [ButtonVariance], which provide
/// concrete styling configurations for different button types.
abstract class AbstractButtonStyle {
  /// Returns the decoration (background, border, shadows) based on button state.
  ButtonStateProperty<Decoration> get decoration;

  /// Returns the mouse cursor appearance based on button state.
  ButtonStateProperty<MouseCursor> get mouseCursor;

  /// Returns the internal padding based on button state.
  ButtonStateProperty<EdgeInsetsGeometry> get padding;

  /// Returns the text style based on button state.
  ButtonStateProperty<TextStyle> get textStyle;

  /// Returns the icon theme based on button state.
  ButtonStateProperty<IconThemeData> get iconTheme;

  /// Returns the external margin based on button state.
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
}

/// Configurable button style combining variance, size, density, and shape.
///
/// [ButtonStyle] implements [AbstractButtonStyle] and provides a composable way
/// to create button styles by combining a base variance (primary, secondary, outline,
/// etc.) with size, density, and shape modifiers. This allows for flexible button
/// customization while maintaining consistency.
///
/// The class provides named constructors for common button variants (primary,
/// secondary, outline, etc.) and can be further customized with size and density options.
///
/// Example:
/// ```dart
/// // Create a large primary button
/// const ButtonStyle.primary(
///   size: ButtonSize.large,
///   density: ButtonDensity.comfortable,
/// )
///
/// // Create a small outline button with circular shape
/// const ButtonStyle.outline(
///   size: ButtonSize.small,
///   shape: ButtonShape.circle,
/// )
/// ```
class ButtonStyle implements AbstractButtonStyle {
  /// The base style variance (primary, secondary, outline, etc.).
  final AbstractButtonStyle variance;

  /// The size configuration affecting padding and minimum dimensions.
  final ButtonSize size;

  /// The density configuration affecting spacing and compactness.
  final ButtonDensity density;

  /// The shape configuration (rectangle or circle).
  final ButtonShape shape;

  /// Creates a custom [ButtonStyle] with the specified variance and modifiers.
  ///
  /// Parameters:
  /// - [variance] (required): The base button style variant
  /// - [size]: The button size. Defaults to [ButtonSize.normal]
  /// - [density]: The button density. Defaults to [ButtonDensity.normal]
  /// - [shape]: The button shape. Defaults to [ButtonShape.rectangle]
  const ButtonStyle({
    required this.variance,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates a primary button style with prominent filled appearance.
  ///
  /// Primary buttons use the theme's primary color with high contrast, making them
  /// ideal for the main action on a screen.
  const ButtonStyle.primary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  /// Creates a secondary button style with muted appearance.
  ///
  /// Secondary buttons have less visual prominence than primary buttons, suitable
  /// for supporting or alternative actions.
  const ButtonStyle.secondary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  /// Creates an outline button style with border and no background.
  ///
  /// Outline buttons feature a border with transparent background, providing a
  /// clear but subtle appearance for secondary actions.
  const ButtonStyle.outline({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  /// Creates a ghost button style with minimal visual presence.
  ///
  /// Ghost buttons have no background or border, only showing on hover, making
  /// them ideal for tertiary actions.
  const ButtonStyle.ghost({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  /// Creates a link button style resembling a text hyperlink.
  ///
  /// Link buttons appear as inline links with underline decoration, typically
  /// used for navigation or inline actions.
  const ButtonStyle.link({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  /// Creates a text-only button style with no background or border.
  ///
  /// Text buttons display only their text content, making them the most minimal
  /// button style for unobtrusive actions.
  const ButtonStyle.text({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  /// Creates a destructive button style for delete/remove actions.
  ///
  /// Destructive buttons use warning colors (typically red) to indicate actions
  /// that remove or delete data.
  const ButtonStyle.destructive({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  /// Creates a fixed-size button style with consistent dimensions.
  ///
  /// Fixed buttons maintain specific dimensions regardless of content, useful
  /// for icon buttons or grid layouts.
  const ButtonStyle.fixed({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  /// Creates a menu button style for dropdown menu triggers.
  ///
  /// Menu buttons are designed for triggering dropdown menus, with appropriate
  /// spacing and styling for menu contexts.
  const ButtonStyle.menu({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menu;

  /// Creates a menubar button style for menubar items.
  ///
  /// Menubar buttons are optimized for horizontal menu bars with appropriate
  /// padding and hover effects.
  const ButtonStyle.menubar({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menubar;

  /// Creates a muted button style with subdued appearance.
  ///
  /// Muted buttons use low-contrast colors for minimal visual impact while
  /// remaining functional.
  const ButtonStyle.muted({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.muted;

  /// Creates a primary icon button style with compact icon density.
  ///
  /// Icon buttons are optimized for displaying icons without text, using
  /// [ButtonDensity.icon] for appropriate spacing.
  const ButtonStyle.primaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  /// Creates a secondary icon button style with compact icon density.
  const ButtonStyle.secondaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  /// Creates an outline icon button style with compact icon density.
  const ButtonStyle.outlineIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  /// Creates a ghost icon button style with compact icon density.
  const ButtonStyle.ghostIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  /// Creates a link icon button style with compact icon density.
  const ButtonStyle.linkIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  /// Creates a text icon button style with compact icon density.
  const ButtonStyle.textIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  /// Creates a destructive icon button style with compact icon density.
  const ButtonStyle.destructiveIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  /// Creates a fixed icon button style with compact icon density.
  const ButtonStyle.fixedIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  /// Creates a card button style with elevated appearance.
  ///
  /// Card buttons feature subtle shadows and borders creating an elevated,
  /// card-like appearance suitable for content-heavy layouts.
  const ButtonStyle.card({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.card;

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (shape == ButtonShape.circle) {
      return _resolveCircleDecoration;
    }
    return variance.decoration;
  }

  Decoration _resolveCircleDecoration(
      BuildContext context, Set<WidgetState> states) {
    var decoration = variance.decoration(context, states);
    if (decoration is BoxDecoration) {
      return BoxDecoration(
        color: decoration.color,
        image: decoration.image,
        border: decoration.border,
        borderRadius: null,
        boxShadow: decoration.boxShadow,
        gradient: decoration.gradient,
        shape: BoxShape.circle,
        backgroundBlendMode: decoration.backgroundBlendMode,
      );
    } else if (decoration is ShapeDecoration) {
      return decoration.copyWith(
        shape: shape == ButtonShape.circle ? const CircleBorder() : null,
      );
    } else {
      throw Exception('Unsupported decoration type ${decoration.runtimeType}');
    }
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    return variance.mouseCursor;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (size == ButtonSize.normal && density == ButtonDensity.normal) {
      return variance.padding;
    }
    return _resolvePadding;
  }

  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    return density.modifier(
        variance.padding(context, states).optionallyResolve(context) *
            size.scale);
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (size == ButtonSize.normal) {
      return variance.textStyle;
    }
    return _resolveTextStyle;
  }

  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var fontSize = variance.textStyle(context, states).fontSize;
    if (fontSize == null) {
      final textStyle = DefaultTextStyle.of(context).style;
      fontSize = textStyle.fontSize ?? 14;
    }
    return variance.textStyle(context, states).copyWith(
          fontSize: fontSize * size.scale,
        );
  }

  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (size == ButtonSize.normal) {
      return variance.iconTheme;
    }
    return _resolveIconTheme;
  }

  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var iconSize = variance.iconTheme(context, states).size;
    iconSize ??= IconTheme.of(context).size ?? 24;
    return variance.iconTheme(context, states).copyWith(
          size: iconSize * size.scale,
        );
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    return variance.margin;
  }
}

/// Abstract base class for button theme customization.
///
/// [ButtonTheme] provides optional style property delegates that can override
/// or modify the default button styling. Subclasses implement specific button
/// variants (primary, secondary, outline, etc.) allowing theme-level customization
/// of button appearances throughout an application.
///
/// Each property is a [ButtonStatePropertyDelegate] that receives the context,
/// current states, and the default value, allowing for context-aware and
/// state-dependent style modifications.
///
/// Implementations include [PrimaryButtonTheme], [SecondaryButtonTheme],
/// [OutlineButtonTheme], and others for each button variant.
abstract class ButtonTheme {
  /// Optional decoration override (background, border, shadows).
  final ButtonStatePropertyDelegate<Decoration>? decoration;

  /// Optional mouse cursor override.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;

  /// Optional padding override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;

  /// Optional text style override.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;

  /// Optional icon theme override.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;

  /// Optional margin override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// Creates a [ButtonTheme] with optional style property delegates.
  ///
  /// All parameters are optional, allowing selective override of specific
  /// style properties while leaving others to use default values.
  const ButtonTheme(
      {this.decoration,
      this.mouseCursor,
      this.padding,
      this.textStyle,
      this.iconTheme,
      this.margin});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ButtonTheme &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode => Object.hash(
      decoration, mouseCursor, padding, textStyle, iconTheme, margin);

  @override
  String toString() =>
      '$runtimeType{decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin}';
}

/// Theme-aware button style that integrates with the component theme system.
///
/// [ComponentThemeButtonStyle] implements [AbstractButtonStyle] and provides
/// automatic theme integration by looking up theme overrides from the widget tree's
/// [ComponentTheme]. If a theme override is found, it's applied; otherwise, the
/// fallback style is used.
///
/// This enables global button style customization through the theme system while
/// maintaining type-safe access to specific button theme types.
///
/// Example:
/// ```dart
/// const ComponentThemeButtonStyle<PrimaryButtonTheme>(
///   fallback: ButtonVariance.primary,
/// )
/// ```
class ComponentThemeButtonStyle<T extends ButtonTheme>
    implements AbstractButtonStyle {
  /// The fallback style used when no theme override is found.
  final AbstractButtonStyle fallback;

  /// Creates a [ComponentThemeButtonStyle] with the specified fallback style.
  ///
  /// Parameters:
  /// - [fallback] (required): The default style used when theme override is not available.
  const ComponentThemeButtonStyle({required this.fallback});

  /// Looks up the button theme of type [T] from the component theme.
  ///
  /// Returns the theme instance if found in the widget tree, or `null` if not present.
  T? find(BuildContext context) {
    return ComponentTheme.maybeOf<T>(context);
  }

  @override
  ButtonStateProperty<Decoration> get decoration => _resolveDecoration;

  Decoration _resolveDecoration(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.decoration(context, states);
    return find(context)?.decoration?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<IconThemeData> get iconTheme => _resolveIconTheme;

  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.iconTheme(context, states);
    return find(context)?.iconTheme?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin => _resolveMargin;

  EdgeInsetsGeometry _resolveMargin(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.margin(context, states);
    return find(context)?.margin?.call(context, states, resolved) ?? resolved;
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor => _resolveMouseCursor;

  MouseCursor _resolveMouseCursor(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.mouseCursor(context, states);
    return find(context)?.mouseCursor?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding => _resolvePadding;

  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.padding(context, states);
    return find(context)?.padding?.call(context, states, resolved) ?? resolved;
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle => _resolveTextStyle;

  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.textStyle(context, states);
    return find(context)?.textStyle?.call(context, states, resolved) ??
        resolved;
  }
}

/// Extension methods for [ShapeDecoration] providing copyWith functionality.
///
/// Adds a `copyWith` method to [ShapeDecoration] for creating modified copies
/// with selectively updated properties, similar to the pattern used in Flutter
/// for other decoration types.
extension ShapeDecorationExtension on ShapeDecoration {
  /// Creates a copy of this [ShapeDecoration] with specified properties replaced.
  ///
  /// Parameters:
  /// - [shape]: Replacement shape border
  /// - [color]: Replacement fill color
  /// - [gradient]: Replacement gradient
  /// - [shadows]: Replacement shadow list
  /// - [image]: Replacement decoration image
  ///
  /// Returns a new [ShapeDecoration] with the specified properties updated
  /// and all other properties copied from the original.
  ShapeDecoration copyWith({
    ShapeBorder? shape,
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationImage? image,
  }) {
    return ShapeDecoration(
      color: color ?? this.color,
      image: image ?? this.image,
      shape: shape ?? this.shape,
      gradient: gradient ?? this.gradient,
      shadows: shadows ?? this.shadows,
    );
  }
}

/// Extension methods for [Decoration] providing type-safe copyWith operations.
///
/// Adds convenience methods to [Decoration] for creating modified copies when
/// the decoration is either a [BoxDecoration] or [ShapeDecoration]. These methods
/// handle type checking and provide appropriate defaults when the decoration
/// doesn't match the expected type.
extension DecorationExtension on Decoration {
  /// Creates a [BoxDecoration] copy with specified properties replaced.
  ///
  /// If this decoration is a [BoxDecoration], creates a modified copy.
  /// Otherwise, creates a new [BoxDecoration] with the provided properties.
  ///
  /// Parameters:
  /// - [color]: Replacement or new background color
  /// - [image]: Replacement or new decoration image
  /// - [border]: Replacement or new border
  /// - [borderRadius]: Replacement or new border radius
  /// - [boxShadow]: Replacement or new shadow list
  /// - [gradient]: Replacement or new gradient
  /// - [shape]: Replacement or new box shape
  /// - [backgroundBlendMode]: Replacement or new blend mode
  ///
  /// Returns a [BoxDecoration] with the specified properties.
  BoxDecoration copyWithIfBoxDecoration({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BoxShape? shape,
    BlendMode? backgroundBlendMode,
  }) {
    if (this is BoxDecoration) {
      var boxDecoration = this as BoxDecoration;
      return BoxDecoration(
        color: color ?? boxDecoration.color,
        image: image ?? boxDecoration.image,
        border: border ?? boxDecoration.border,
        borderRadius: borderRadius ?? boxDecoration.borderRadius,
        boxShadow: boxShadow ?? boxDecoration.boxShadow,
        gradient: gradient ?? boxDecoration.gradient,
        shape: shape ?? boxDecoration.shape,
        backgroundBlendMode:
            backgroundBlendMode ?? boxDecoration.backgroundBlendMode,
      );
    }
    return BoxDecoration(
      color: color,
      image: image,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      gradient: gradient,
      shape: shape ?? BoxShape.rectangle,
      backgroundBlendMode: backgroundBlendMode,
    );
  }

  /// Creates a [ShapeDecoration] copy with specified properties replaced.
  ///
  /// If this decoration is a [ShapeDecoration], creates a modified copy.
  /// Otherwise, creates a new [ShapeDecoration] with the provided properties.
  ///
  /// Parameters:
  /// - [shape]: Replacement or new shape border
  /// - [color]: Replacement or new fill color
  /// - [gradient]: Replacement or new gradient
  /// - [shadows]: Replacement or new shadow list
  /// - [image]: Replacement or new decoration image
  ///
  /// Returns a [ShapeDecoration] with the specified properties.
  ShapeDecoration copyWithIfShapeDecoration({
    ShapeBorder? shape,
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationImage? image,
  }) {
    if (this is ShapeDecoration) {
      var shapeDecoration = this as ShapeDecoration;
      return ShapeDecoration(
        color: color ?? shapeDecoration.color,
        image: image ?? shapeDecoration.image,
        shape: shape ?? shapeDecoration.shape,
        gradient: gradient ?? shapeDecoration.gradient,
        shadows: shadows ?? shapeDecoration.shadows,
      );
    }
    return ShapeDecoration(
      color: color,
      image: image,
      shape: shape ?? const RoundedRectangleBorder(),
      gradient: gradient,
      shadows: shadows,
    );
  }
}

/// Theme configuration for primary button styling.
///
/// [PrimaryButtonTheme] extends [ButtonTheme] to provide theme-level customization
/// for primary buttons. It can be registered in the component theme system to
/// override default primary button styles throughout the application.
///
/// Example:
/// ```dart
/// PrimaryButtonTheme(
///   decoration: (context, states, defaultValue) {
///     // Customize primary button decoration
///     return customDecoration;
///   },
/// )
/// ```
class PrimaryButtonTheme extends ButtonTheme {
  /// Creates a [PrimaryButtonTheme] with optional style property delegates.
  const PrimaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  PrimaryButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return PrimaryButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for secondary button styling.
///
/// Provides theme-level customization for secondary buttons through the component
/// theme system. Secondary buttons have muted styling suitable for supporting actions.
class SecondaryButtonTheme extends ButtonTheme {
  /// Creates a [SecondaryButtonTheme] with optional style property delegates.
  const SecondaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  SecondaryButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return SecondaryButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for outline button styling.
///
/// Provides theme-level customization for outline buttons through the component
/// theme system. Outline buttons feature borders with transparent backgrounds.
class OutlineButtonTheme extends ButtonTheme {
  /// Creates an [OutlineButtonTheme] with optional style property delegates.
  const OutlineButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  OutlineButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return OutlineButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for ghost button styling.
///
/// Provides theme-level customization for ghost buttons. Ghost buttons have minimal
/// visual presence with no background or border by default.
class GhostButtonTheme extends ButtonTheme {
  /// Creates a [GhostButtonTheme] with optional style property delegates.
  const GhostButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  GhostButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return GhostButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for link button styling.
///
/// Provides theme-level customization for link buttons. Link buttons appear as
/// inline hyperlinks with underline decoration.
class LinkButtonTheme extends ButtonTheme {
  /// Creates a [LinkButtonTheme] with optional style property delegates.
  const LinkButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  LinkButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return LinkButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for text button styling.
///
/// Provides theme-level customization for text buttons. Text buttons display only
/// their text content without background or border decoration.
class TextButtonTheme extends ButtonTheme {
  /// Creates a [TextButtonTheme] with optional style property delegates.
  const TextButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  TextButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return TextButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for destructive button styling.
///
/// Provides theme-level customization for destructive buttons. Destructive buttons
/// use warning colors (typically red) for actions that delete or remove data.
class DestructiveButtonTheme extends ButtonTheme {
  /// Creates a [DestructiveButtonTheme] with optional style property delegates.
  const DestructiveButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  DestructiveButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return DestructiveButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for fixed button styling.
///
/// Provides theme-level customization for fixed buttons. Fixed buttons maintain
/// consistent dimensions regardless of content.
class FixedButtonTheme extends ButtonTheme {
  /// Creates a [FixedButtonTheme] with optional style property delegates.
  const FixedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  FixedButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return FixedButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for menu button styling.
///
/// Provides theme-level customization for menu buttons. Menu buttons are designed
/// for triggering dropdown menus with appropriate spacing and styling.
class MenuButtonTheme extends ButtonTheme {
  /// Creates a [MenuButtonTheme] with optional style property delegates.
  const MenuButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  MenuButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return MenuButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for menubar button styling.
///
/// Provides theme-level customization for menubar buttons. Menubar buttons are
/// optimized for horizontal menu bars with appropriate padding and hover effects.
class MenubarButtonTheme extends ButtonTheme {
  /// Creates a [MenubarButtonTheme] with optional style property delegates.
  const MenubarButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  MenubarButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return MenubarButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for muted button styling.
///
/// Provides theme-level customization for muted buttons. Muted buttons use
/// low-contrast colors for minimal visual impact while remaining functional.
class MutedButtonTheme extends ButtonTheme {
  /// Creates a [MutedButtonTheme] with optional style property delegates.
  const MutedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  MutedButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return MutedButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for card button styling.
///
/// Provides theme-level customization for card buttons. Card buttons feature
/// subtle shadows and borders creating an elevated, card-like appearance.
class CardButtonTheme extends ButtonTheme {
  /// Creates a [CardButtonTheme] with optional style property delegates.
  const CardButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  CardButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return CardButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Implementation of [AbstractButtonStyle] providing concrete button style variants.
///
/// [ButtonVariance] implements [AbstractButtonStyle] with state property functions
/// and provides static constants for all standard button variants (primary, secondary,
/// outline, etc.). Each variant is wrapped in a [ComponentThemeButtonStyle] to enable
/// theme-level customization.
///
/// The static variance constants serve as the base styles used by [ButtonStyle]'s
/// named constructors and can be used directly when creating custom button styles.
///
/// Example:
/// ```dart
/// // Use a variant directly
/// Button(
///   style: ButtonVariance.primary,
///   child: Text('Click Me'),
/// )
/// ```
class ButtonVariance implements AbstractButtonStyle {
  /// Primary button variant with prominent filled appearance.
  ///
  /// Features high-contrast styling suitable for the main action on a screen.
  static const AbstractButtonStyle primary =
      ComponentThemeButtonStyle<PrimaryButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonPrimaryDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonPrimaryTextStyle,
      iconTheme: _buttonPrimaryIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Secondary button variant with muted appearance.
  ///
  /// Features subtle styling suitable for supporting or alternative actions.
  static const AbstractButtonStyle secondary =
      ComponentThemeButtonStyle<SecondaryButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonSecondaryDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonSecondaryTextStyle,
      iconTheme: _buttonSecondaryIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Outline button variant with border and transparent background.
  ///
  /// Features a visible border without filled background, suitable for secondary actions.
  static const AbstractButtonStyle outline =
      ComponentThemeButtonStyle<OutlineButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonOutlineDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonOutlineTextStyle,
      iconTheme: _buttonOutlineIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Ghost button variant with minimal visual presence.
  ///
  /// Features no background or border by default, only showing on hover.
  static const AbstractButtonStyle ghost =
      ComponentThemeButtonStyle<GhostButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonGhostDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonGhostTextStyle,
      iconTheme: _buttonGhostIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Link button variant resembling a text hyperlink.
  ///
  /// Features inline link styling with underline decoration.
  static const AbstractButtonStyle link =
      ComponentThemeButtonStyle<LinkButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonLinkDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonLinkTextStyle,
      iconTheme: _buttonLinkIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Text button variant with only text content.
  ///
  /// Features minimal styling with no background or border decoration.
  static const AbstractButtonStyle text =
      ComponentThemeButtonStyle<TextButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonTextTextStyle,
      iconTheme: _buttonTextIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Destructive button variant for delete/remove actions.
  ///
  /// Features warning colors (typically red) to indicate data-destructive actions.
  static const AbstractButtonStyle destructive =
      ComponentThemeButtonStyle<DestructiveButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonDestructiveDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonDestructiveTextStyle,
      iconTheme: _buttonDestructiveIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Fixed button variant with consistent dimensions.
  ///
  /// Features fixed sizing regardless of content, suitable for icon buttons.
  static const AbstractButtonStyle fixed =
      ComponentThemeButtonStyle<FixedButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonStaticTextStyle,
      iconTheme: _buttonStaticIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Menu button variant for dropdown menu triggers.
  ///
  /// Features appropriate spacing and styling for menu contexts.
  static const AbstractButtonStyle menu =
      ComponentThemeButtonStyle<MenuButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonMenuDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonMenuPadding,
      textStyle: _buttonMenuTextStyle,
      iconTheme: _buttonMenuIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Menubar button variant for horizontal menu bars.
  ///
  /// Features optimized padding and styling for menubar contexts.
  static const AbstractButtonStyle menubar =
      ComponentThemeButtonStyle<MenubarButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonMenuDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonMenubarPadding,
      textStyle: _buttonMenuTextStyle,
      iconTheme: _buttonMenuIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Muted button variant with subdued appearance.
  ///
  /// Features low-contrast styling for minimal visual impact.
  static const AbstractButtonStyle muted =
      ComponentThemeButtonStyle<MutedButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonMutedTextStyle,
      iconTheme: _buttonMutedIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Card button variant with elevated appearance.
  ///
  /// Features subtle shadows and borders creating a card-like elevated look.
  static const AbstractButtonStyle card =
      ComponentThemeButtonStyle<CardButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonCardDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonCardPadding,
      textStyle: _buttonCardTextStyle,
      iconTheme: _buttonCardIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  @override
  final ButtonStateProperty<Decoration> decoration;
  @override
  final ButtonStateProperty<MouseCursor> mouseCursor;
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> padding;
  @override
  final ButtonStateProperty<TextStyle> textStyle;
  @override
  final ButtonStateProperty<IconThemeData> iconTheme;
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> margin;

  /// Creates a custom [ButtonVariance] with the specified style properties.
  ///
  /// All parameters are required [ButtonStateProperty] functions that resolve
  /// values based on the button's current state.
  const ButtonVariance({
    required this.decoration,
    required this.mouseCursor,
    required this.padding,
    required this.textStyle,
    required this.iconTheme,
    required this.margin,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ButtonVariance &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode {
    return Object.hash(
        decoration, mouseCursor, padding, textStyle, iconTheme, margin);
  }

  @override
  String toString() {
    return 'ButtonVariance(decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin)';
  }
}

/// A button state property delegate that always returns the same value.
///
/// [ButtonStylePropertyAll] implements a [ButtonStatePropertyDelegate] that
/// ignores the context, states, and default value parameters, always returning
/// its stored [value]. This is useful for creating static style properties that
/// don't change based on button state.
///
/// Example:
/// ```dart
/// final alwaysRedDecoration = ButtonStylePropertyAll<Decoration>(
///   BoxDecoration(color: Colors.red),
/// );
/// ```
class ButtonStylePropertyAll<T> {
  /// The constant value to return regardless of state.
  final T value;

  /// Creates a [ButtonStylePropertyAll] with the specified constant value.
  const ButtonStylePropertyAll(this.value);

  /// Returns the stored [value], ignoring all parameters.
  ///
  /// This method signature matches [ButtonStatePropertyDelegate] for compatibility,
  /// but the [context], [states], and [value] parameters are unused.
  T call(BuildContext context, Set<WidgetState> states, T value) {
    return this.value;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ButtonStylePropertyAll<T> && other.value == value;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  String toString() => 'ButtonStylePropertyAll(value: $value)';
}

/// Extension methods on [AbstractButtonStyle] for convenient style modifications.
///
/// Provides utility methods to create modified copies of button styles with
/// selective property changes. These methods enable fluent style customization
/// without manually implementing [ButtonVariance] instances.
extension ButtonStyleExtension on AbstractButtonStyle {
  /// Creates a copy of this style with selectively replaced properties.
  ///
  /// Each parameter is a [ButtonStatePropertyDelegate] that can modify or
  /// replace the corresponding style property. If all parameters are `null`,
  /// returns the original style unchanged for efficiency.
  ///
  /// Example:
  /// ```dart
  /// final customStyle = ButtonVariance.primary.copyWith(
  ///   decoration: (context, states, defaultDecoration) {
  ///     // Custom decoration logic
  ///     return myCustomDecoration;
  ///   },
  /// );
  /// ```
  AbstractButtonStyle copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    if (decoration == null &&
        mouseCursor == null &&
        padding == null &&
        textStyle == null &&
        iconTheme == null &&
        margin == null) {
      return this;
    }
    return _CopyWithButtonStyle(
      this,
      decoration,
      mouseCursor,
      padding,
      textStyle,
      iconTheme,
      margin,
    );
  }

  /// Creates a copy with custom background colors for different states.
  ///
  /// Modifies the decoration to apply state-specific background colors.
  /// Only works with [BoxDecoration]; other decoration types are returned unchanged.
  ///
  /// Parameters:
  /// - [color]: Background color for normal state
  /// - [hoverColor]: Background color when hovered
  /// - [focusColor]: Background color when focused
  /// - [disabledColor]: Background color when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.primary.withBackgroundColor(
  ///   color: Colors.blue,
  ///   hoverColor: Colors.blue.shade700,
  /// );
  /// ```
  AbstractButtonStyle withBackgroundColor(
      {Color? color,
      Color? hoverColor,
      Color? focusColor,
      Color? disabledColor}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            color: states.disabled
                ? disabledColor ?? decoration.color
                : states.hovered
                    ? hoverColor ?? decoration.color
                    : states.focused
                        ? focusColor ?? decoration.color
                        : color,
          );
        }
        return decoration;
      },
    );
  }

  /// Creates a copy with custom foreground colors for different states.
  ///
  /// Modifies both text style and icon theme to apply state-specific foreground
  /// colors for text and icons.
  ///
  /// Parameters:
  /// - [color]: Foreground color for normal state
  /// - [hoverColor]: Foreground color when hovered
  /// - [focusColor]: Foreground color when focused
  /// - [disabledColor]: Foreground color when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.outline.withForegroundColor(
  ///   color: Colors.black,
  ///   disabledColor: Colors.grey,
  /// );
  /// ```
  AbstractButtonStyle withForegroundColor(
      {Color? color,
      Color? hoverColor,
      Color? focusColor,
      Color? disabledColor}) {
    return copyWith(
      textStyle: (context, states, textStyle) {
        return textStyle.copyWith(
          color: states.disabled
              ? disabledColor ?? textStyle.color
              : states.hovered
                  ? hoverColor ?? textStyle.color
                  : states.focused
                      ? focusColor ?? textStyle.color
                      : color,
        );
      },
      iconTheme: (context, states, iconTheme) {
        return iconTheme.copyWith(
          color: states.disabled
              ? disabledColor ?? iconTheme.color
              : states.hovered
                  ? hoverColor ?? iconTheme.color
                  : states.focused
                      ? focusColor ?? iconTheme.color
                      : color,
        );
      },
    );
  }

  /// Creates a copy with custom borders for different states.
  ///
  /// Modifies the decoration to apply state-specific borders.
  /// Only works with [BoxDecoration]; other decoration types are returned unchanged.
  ///
  /// Parameters:
  /// - [border]: Border for normal state
  /// - [hoverBorder]: Border when hovered
  /// - [focusBorder]: Border when focused
  /// - [disabledBorder]: Border when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.outline.withBorder(
  ///   border: Border.all(color: Colors.blue),
  ///   hoverBorder: Border.all(color: Colors.blue.shade700, width: 2),
  /// );
  /// ```
  AbstractButtonStyle withBorder(
      {Border? border,
      Border? hoverBorder,
      Border? focusBorder,
      Border? disabledBorder}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            border: states.disabled
                ? disabledBorder ?? decoration.border
                : states.hovered
                    ? hoverBorder ?? decoration.border
                    : states.focused
                        ? focusBorder ?? decoration.border
                        : border,
          );
        }
        return decoration;
      },
    );
  }

  /// Creates a copy with custom border radius for different states.
  ///
  /// Modifies the decoration to apply state-specific border radius.
  /// Only works with [BoxDecoration]; other decoration types are returned unchanged.
  ///
  /// Parameters:
  /// - [borderRadius]: Border radius for normal state
  /// - [hoverBorderRadius]: Border radius when hovered
  /// - [focusBorderRadius]: Border radius when focused
  /// - [disabledBorderRadius]: Border radius when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.primary.withBorderRadius(
  ///   borderRadius: BorderRadius.circular(8),
  ///   hoverBorderRadius: BorderRadius.circular(12),
  /// );
  /// ```
  AbstractButtonStyle withBorderRadius(
      {BorderRadiusGeometry? borderRadius,
      BorderRadiusGeometry? hoverBorderRadius,
      BorderRadiusGeometry? focusBorderRadius,
      BorderRadiusGeometry? disabledBorderRadius}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            borderRadius: states.disabled
                ? disabledBorderRadius ?? decoration.borderRadius
                : states.hovered
                    ? hoverBorderRadius ?? decoration.borderRadius
                    : states.focused
                        ? focusBorderRadius ?? decoration.borderRadius
                        : borderRadius,
          );
        }
        return decoration;
      },
    );
  }

  /// Creates a copy with custom padding for different states.
  ///
  /// Modifies the padding to apply state-specific values.
  ///
  /// Parameters:
  /// - [padding]: Padding for normal state
  /// - [hoverPadding]: Padding when hovered
  /// - [focusPadding]: Padding when focused
  /// - [disabledPadding]: Padding when disabled
  ///
  /// Note: The implementation currently doesn't change padding based on state
  /// due to a limitation in the state resolution logic, but the API is provided
  /// for consistency with other style properties.
  AbstractButtonStyle withPadding(
      {EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? hoverPadding,
      EdgeInsetsGeometry? focusPadding,
      EdgeInsetsGeometry? disabledPadding}) {
    return copyWith(
      padding: (context, states, padding) {
        return states.disabled
            ? disabledPadding ?? padding
            : states.hovered
                ? hoverPadding ?? padding
                : states.focused
                    ? focusPadding ?? padding
                    : padding;
      },
    );
  }
}

/// Function signature for button state property delegates with default value.
///
/// [ButtonStatePropertyDelegate] extends [ButtonStateProperty] by adding a
/// `value` parameter representing the default or base value. This allows delegates
/// to modify existing values rather than always creating them from scratch.
///
/// The delegate receives:
/// - [context]: Build context for accessing theme data
/// - [states]: Current widget states
/// - [value]: The default value from the base style
///
/// Returns the final property value of type [T], which may be the default value,
/// a modified version of it, or a completely new value.
///
/// Example:
/// ```dart
/// ButtonStatePropertyDelegate<Color> customColor = (context, states, defaultColor) {
///   if (states.contains(WidgetState.disabled)) {
///     return defaultColor.withOpacity(0.5); // Modify default
///   }
///   return defaultColor; // Use default
/// };
/// ```
typedef ButtonStatePropertyDelegate<T> = T Function(
    BuildContext context, Set<WidgetState> states, T value);

class _CopyWithButtonStyle implements AbstractButtonStyle {
  final ButtonStatePropertyDelegate<Decoration>? _decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? _mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? _padding;
  final ButtonStatePropertyDelegate<TextStyle>? _textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? _iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? _margin;
  final AbstractButtonStyle _delegate;

  const _CopyWithButtonStyle(
    this._delegate,
    this._decoration,
    this._mouseCursor,
    this._padding,
    this._textStyle,
    this._iconTheme,
    this._margin,
  );

  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (_iconTheme == null) {
      return _delegate.iconTheme;
    }
    return _buildIconTheme;
  }

  IconThemeData _buildIconTheme(BuildContext context, Set<WidgetState> states) {
    return _iconTheme!(context, states, _delegate.iconTheme(context, states));
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (_textStyle == null) {
      return _delegate.textStyle;
    }
    return _buildTextStyle;
  }

  TextStyle _buildTextStyle(BuildContext context, Set<WidgetState> states) {
    return _textStyle!(context, states, _delegate.textStyle(context, states));
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (_padding == null) {
      return _delegate.padding;
    }
    return _buildPadding;
  }

  EdgeInsetsGeometry _buildPadding(
      BuildContext context, Set<WidgetState> states) {
    return _padding!(context, states, _delegate.padding(context, states));
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    if (_mouseCursor == null) {
      return _delegate.mouseCursor;
    }
    return _buildMouseCursor;
  }

  MouseCursor _buildMouseCursor(BuildContext context, Set<WidgetState> states) {
    return _mouseCursor!(
        context, states, _delegate.mouseCursor(context, states));
  }

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (_decoration == null) {
      return _delegate.decoration;
    }
    return _buildDecoration;
  }

  Decoration _buildDecoration(BuildContext context, Set<WidgetState> states) {
    return _decoration!(context, states, _delegate.decoration(context, states));
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    if (_margin == null) {
      return _delegate.margin;
    }
    return _buildMargin;
  }

  EdgeInsetsGeometry _buildMargin(
      BuildContext context, Set<WidgetState> states) {
    return _margin!(context, states, _delegate.margin(context, states));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CopyWithButtonStyle &&
        other._delegate == _delegate &&
        other._decoration == _decoration &&
        other._mouseCursor == _mouseCursor &&
        other._padding == _padding &&
        other._textStyle == _textStyle &&
        other._iconTheme == _iconTheme &&
        other._margin == _margin;
  }

  @override
  int get hashCode {
    return Object.hash(_delegate, _decoration, _mouseCursor, _padding,
        _textStyle, _iconTheme, _margin);
  }

  @override
  String toString() {
    return '_CopyWithButtonStyle(_delegate: $_delegate, _decoration: $_decoration, _mouseCursor: $_mouseCursor, _padding: $_padding, _textStyle: $_textStyle, _iconTheme: $_iconTheme, _margin: $_margin)';
  }
}

EdgeInsets _buttonZeroMargin(BuildContext context, Set<WidgetState> states) {
  return EdgeInsets.zero;
}

MouseCursor _buttonMouseCursor(BuildContext context, Set<WidgetState> states) {
  return states.contains(WidgetState.disabled)
      ? SystemMouseCursors.basic
      : SystemMouseCursors.click;
}

EdgeInsets _buttonPadding(BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  return EdgeInsets.symmetric(
    horizontal: theme.scaling * 16,
    vertical: theme.scaling * 8,
  );
}

// CARD
TextStyle _buttonCardTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.copyWith(
    color: themeData.colorScheme.cardForeground,
  );
}

IconThemeData _buttonCardIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.cardForeground,
  );
}

Decoration _buttonCardDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted,
      borderRadius: BorderRadius.circular(themeData.radiusXl),
      border: Border.all(
        color: themeData.colorScheme.border,
        width: 1,
      ),
    );
  }
  if (states.contains(WidgetState.hovered) ||
      states.contains(WidgetState.selected)) {
    return BoxDecoration(
      color: themeData.colorScheme.border,
      borderRadius: BorderRadius.circular(themeData.radiusXl),
      border: Border.all(
        color: themeData.colorScheme.border,
        width: 1,
      ),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.card,
    borderRadius: BorderRadius.circular(themeData.radiusXl),
    border: Border.all(
      color: themeData.colorScheme.border,
      width: 1,
    ),
  );
}

EdgeInsets _buttonCardPadding(BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  return const EdgeInsets.all(16) * theme.scaling;
}

// MENUBUTTON
Decoration _buttonMenuDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return const BoxDecoration();
  }
  if (states.contains(WidgetState.focused) ||
      states.contains(WidgetState.hovered) ||
      states.contains(WidgetState.selected)) {
    return BoxDecoration(
      color: themeData.colorScheme.accent,
      borderRadius: BorderRadius.circular(themeData.radiusSm),
    );
  }
  return const BoxDecoration();
}

TextStyle _buttonMenuTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return themeData.typography.small.copyWith(
      color: themeData.colorScheme.accentForeground.scaleAlpha(0.5),
    );
  }
  return themeData.typography.small.copyWith(
    color: themeData.colorScheme.accentForeground,
  );
}

EdgeInsets _buttonMenuPadding(BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  final menuGroupData = Data.maybeOf<MenuGroupData>(context);
  if (menuGroupData != null && menuGroupData.direction == Axis.horizontal) {
    return const EdgeInsets.symmetric(horizontal: 18, vertical: 6) * scaling;
  }
  return const EdgeInsets.only(left: 8, top: 6, right: 6, bottom: 6) * scaling;
}

EdgeInsets _buttonMenubarPadding(
    BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  return const EdgeInsets.symmetric(horizontal: 12, vertical: 4) * scaling;
}

IconThemeData _buttonMenuIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.accentForeground,
  );
}

// PRIMARY
Decoration _buttonPrimaryDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.mutedForeground,
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.primary.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.primary,
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonPrimaryTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: themeData.colorScheme.primaryForeground,
      );
}

IconThemeData _buttonPrimaryIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.primaryForeground,
  );
}

// SECONDARY
Decoration _buttonSecondaryDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.primaryForeground,
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.secondary.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.secondary,
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonSecondaryTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.secondaryForeground,
      );
}

IconThemeData _buttonSecondaryIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.secondaryForeground,
  );
}

Decoration _buttonOutlineDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.border.withValues(
        alpha: 0,
      ),
      border: Border.all(
        color: themeData.colorScheme.border,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.input.scaleAlpha(0.5),
      border: Border.all(
        color: themeData.colorScheme.input,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.input.scaleAlpha(0.3),
    border: Border.all(
      color: themeData.colorScheme.input,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonOutlineTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.foreground,
      );
}

IconThemeData _buttonOutlineIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
  );
}

Decoration _buttonGhostDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted.withValues(alpha: 0),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.muted.withValues(alpha: 0),
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonGhostTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.foreground,
      );
}

IconThemeData _buttonGhostIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
  );
}

TextStyle _buttonMutedTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: themeData.colorScheme.mutedForeground,
      );
}

IconThemeData _buttonMutedIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.mutedForeground,
  );
}

Decoration _buttonLinkDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return BoxDecoration(
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonLinkTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.foreground,
        decoration: states.contains(WidgetState.hovered)
            ? TextDecoration.underline
            : TextDecoration.none,
      );
}

IconThemeData _buttonLinkIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
  );
}

Decoration _buttonTextDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return BoxDecoration(
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonTextTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.hovered)
            ? themeData.colorScheme.primary
            : themeData.colorScheme.mutedForeground,
      );
}

IconThemeData _buttonTextIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.hovered)
        ? themeData.colorScheme.primary
        : themeData.colorScheme.mutedForeground,
  );
}

Decoration _buttonDestructiveDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.primaryForeground,
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.destructive.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.destructive.scaleAlpha(0.5),
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonDestructiveTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : Colors
                .white, // yeah ik, its straight up white regardless light or dark mode
      );
}

IconThemeData _buttonDestructiveIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : Colors.white,
  );
}

// STATIC BUTTON
TextStyle _buttonStaticTextStyle(
    BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  return theme.typography.small.merge(theme.typography.medium).copyWith(
        color: theme.colorScheme.foreground,
      );
}

IconThemeData _buttonStaticIconTheme(
    BuildContext context, Set<WidgetState> states) {
  return const IconThemeData();
}

/// Convenience widget for creating a primary button.
///
/// [PrimaryButton] is a simplified wrapper around [Button] that automatically
/// applies the primary button style. It provides a cleaner API for the common
/// case of creating primary buttons without manually specifying the style.
///
/// This widget exposes all the same properties as [Button] but defaults to
/// [ButtonStyle.primary] for consistent styling.
///
/// Example:
/// ```dart
/// PrimaryButton(
///   onPressed: () => submitForm(),
///   leading: Icon(Icons.check),
///   child: Text('Submit'),
/// )
/// ```
// Backward compatibility
class PrimaryButton extends StatelessWidget {
  /// The widget displayed as the button's main content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a primary button with the specified properties.
  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.primary(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a secondary button.
///
/// A simplified wrapper around [Button.secondary] with the same properties
/// as [PrimaryButton] but using secondary button styling for supporting actions.
class SecondaryButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a secondary button with the specified properties.
  const SecondaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.secondary(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating an outline button.
///
/// A simplified wrapper around [Button.outline] with the same properties
/// as [PrimaryButton] but using outline button styling with a visible border.
class OutlineButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates an outline button with the specified properties.
  const OutlineButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.outline(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a ghost button.
///
/// A simplified wrapper around [Button.ghost] with the same properties
/// as [PrimaryButton] but using ghost button styling with minimal visual presence.
class GhostButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a ghost button with the specified properties.
  const GhostButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.ghost(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a link button.
///
/// A simplified wrapper around [Button.link] with the same properties
/// as [PrimaryButton] but using link button styling that resembles a hyperlink.
class LinkButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a link button with the specified properties.
  const LinkButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.link(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a text button.
///
/// A simplified wrapper around [Button.text] with the same properties
/// as [PrimaryButton] but using text button styling with minimal styling.
class TextButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a text button with the specified properties.
  const TextButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.text(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      child: child,
    );
  }
}

/// Convenience widget for creating a destructive button.
///
/// A simplified wrapper around [Button.destructive] with the same properties
/// as [PrimaryButton] but using destructive button styling for dangerous actions.
class DestructiveButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a destructive button with the specified properties.
  const DestructiveButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style:
          ButtonStyle.destructive(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a tab button.
///
/// A simplified wrapper around [Button] with the same properties
/// as [PrimaryButton] but using tab button styling for tabbed navigation.
class TabButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a tab button with the specified properties.
  const TabButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.fixed(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// A button styled as a card with elevated appearance and extensive gesture support.
///
/// Provides an alternative button presentation that resembles a card with
/// elevated styling, typically used for prominent actions or content sections
/// that need to stand out from the background. The card styling provides
/// visual depth and emphasis compared to standard button variants.
///
/// Supports the full range of button features including leading/trailing widgets,
/// focus management, gesture handling, and accessibility features. The card
/// appearance is defined by [ButtonStyle.card] with customizable size,
/// density, and shape properties.
///
/// The component handles complex gesture interactions including primary,
/// secondary, and tertiary taps, long presses, hover states, and focus
/// management, making it suitable for rich interactive experiences.
///
/// Example:
/// ```dart
/// CardButton(
///   leading: Icon(Icons.dashboard),
///   trailing: Icon(Icons.arrow_forward),
///   size: ButtonSize.large,
///   onPressed: () => Navigator.pushNamed(context, '/dashboard'),
///   child: Column(
///     children: [
///       Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
///       Text('View analytics and reports'),
///     ],
///   ),
/// )
/// ```
class CardButton extends StatelessWidget {
  /// The primary content displayed within the card button.
  ///
  /// Typically contains text, icons, or complex layouts that represent
  /// the button's purpose. The content is styled with card appearance
  /// and elevated visual treatment.
  final Widget child;

  /// Callback invoked when the button is pressed.
  ///
  /// Called when the user taps or clicks the button. If null,
  /// the button is disabled and does not respond to interactions.
  final VoidCallback? onPressed;

  /// Whether this button is enabled and accepts user input.
  ///
  /// When false, the button is displayed in a disabled state and
  /// ignores user interactions. When null, enabled state is determined
  /// by whether [onPressed] is provided.
  final bool? enabled;

  /// Optional widget displayed before the main content.
  ///
  /// Commonly used for icons that visually represent the button's action.
  /// Positioned to the left of the content in LTR layouts.
  final Widget? leading;

  /// Optional widget displayed after the main content.
  ///
  /// Often used for indicators, chevrons, or secondary actions.
  /// Positioned to the right of the content in LTR layouts.
  final Widget? trailing;

  /// Alignment of content within the button.
  ///
  /// Controls how the button's content is positioned within its bounds.
  /// Defaults to center alignment if not specified.
  final AlignmentGeometry? alignment;

  /// Size variant for the button appearance.
  ///
  /// Controls padding, font size, and overall dimensions. Available
  /// sizes include small, normal, large, and extra large variants.
  final ButtonSize size;

  /// Density setting affecting button compactness.
  ///
  /// Controls spacing and padding to create more or less compact
  /// appearance. Useful for dense interfaces or accessibility needs.
  final ButtonDensity density;

  /// Shape configuration for the button's appearance.
  ///
  /// Defines border radius and corner styling. Options include
  /// rectangle, rounded corners, and circular shapes.
  final ButtonShape shape;

  /// Focus node for keyboard navigation and accessibility.
  ///
  /// Manages focus state for the button. If not provided, a focus
  /// node is created automatically by the underlying button system.
  final FocusNode? focusNode;

  /// Whether to disable visual transition animations.
  ///
  /// When true, the button skips animation effects for state changes.
  /// Useful for performance optimization or accessibility preferences.
  final bool disableTransition;

  /// Callback invoked when hover state changes.
  ///
  /// Called with true when the mouse enters the button area,
  /// and false when it exits. Useful for custom hover effects.
  final ValueChanged<bool>? onHover;

  /// Callback invoked when focus state changes.
  ///
  /// Called with true when the button gains focus, and false
  /// when it loses focus. Supports keyboard navigation patterns.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a [CardButton] with card-styled appearance and comprehensive interaction support.
  ///
  /// The [child] parameter is required and provides the button's main content.
  /// The button uses card styling with elevated appearance for visual prominence.
  /// Extensive gesture support enables complex interactions beyond simple taps.
  ///
  /// Parameters include standard button properties (onPressed, enabled, leading,
  /// trailing) along with size, density, and shape customization options.
  /// Gesture callbacks support primary, secondary, tertiary taps and long presses.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The main content displayed in the button
  /// - [onPressed] (VoidCallback?, optional): Primary action when button is pressed
  /// - [enabled] (bool?, optional): Whether button accepts input (null uses onPressed)
  /// - [size] (ButtonSize, default: normal): Size variant for button dimensions
  /// - [density] (ButtonDensity, default: normal): Spacing density setting
  /// - [shape] (ButtonShape, default: rectangle): Border radius and corner styling
  ///
  /// Example:
  /// ```dart
  /// CardButton(
  ///   size: ButtonSize.large,
  ///   leading: Icon(Icons.star),
  ///   onPressed: () => _handleFavorite(),
  ///   child: Text('Add to Favorites'),
  /// )
  /// ```
  const CardButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.card(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Icon-only button widget with support for multiple visual styles.
///
/// [IconButton] is optimized for displaying buttons with icon content,
/// using icon-specific density and sizing by default. Supports various
/// button styles through named constructors or the [variance] parameter.
class IconButton extends StatelessWidget {
  /// The icon widget to display in the button.
  final Widget icon;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [icon].
  final Widget? leading;

  /// Widget displayed after the [icon].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.icon]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
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

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// The button style variant to apply.
  final AbstractButtonStyle variance;

  /// Creates an icon button with the specified style variance.
  const IconButton({
    super.key,
    required this.icon,
    required this.variance,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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

  /// Creates an icon button with primary styling.
  const IconButton.primary({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.variance = ButtonVariance.primary,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates an icon button with secondary styling.
  const IconButton.secondary({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.variance = ButtonVariance.secondary,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates an icon button with outline styling.
  const IconButton.outline({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.variance = ButtonVariance.outline,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates an icon button with ghost styling.
  const IconButton.ghost({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.variance = ButtonVariance.ghost,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates an icon button with link styling.
  const IconButton.link({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.variance = ButtonVariance.link,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates an icon button with text styling.
  const IconButton.text({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.variance = ButtonVariance.text,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates an icon button with destructive styling.
  const IconButton.destructive({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
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
    this.variance = ButtonVariance.destructive,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle(
        variance: variance,
        size: size,
        density: density,
        shape: shape,
      ),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: icon,
    );
  }
}

/// Widget for locally overriding button styles within a subtree.
///
/// [ButtonStyleOverride] allows selective customization of button style properties
/// for all descendant buttons without replacing the entire button style. It provides
/// style property delegates that can intercept and modify the default values.
///
/// The widget supports two modes:
/// - **Replace mode** (default): Applies overrides directly
/// - **Inherit mode**: Chains with parent overrides, allowing nested customization
///
/// Example:
/// ```dart
/// ButtonStyleOverride(
///   decoration: (context, states, defaultDecoration) {
///     // Customize decoration for all buttons in this subtree
///     return BoxDecoration(color: Colors.red);
///   },
///   child: Column(
///     children: [
///       PrimaryButton(child: Text('Red Button')),
///       SecondaryButton(child: Text('Also Red')),
///     ],
///   ),
/// )
/// ```
class ButtonStyleOverride extends StatelessWidget {
  /// Whether to inherit and chain with parent overrides.
  ///
  /// When `true`, this override's delegates receive the parent override's result
  /// as their default value, allowing nested style modifications. When `false`,
  /// parent overrides are ignored.
  final bool inherit;

  /// Optional decoration override delegate.
  final ButtonStatePropertyDelegate<Decoration>? decoration;

  /// Optional mouse cursor override delegate.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;

  /// Optional padding override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;

  /// Optional text style override delegate.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;

  /// Optional icon theme override delegate.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;

  /// Optional margin override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// The widget subtree where overrides apply.
  final Widget child;

  /// Creates a button style override in replace mode.
  ///
  /// Overrides apply to all descendant buttons, ignoring parent overrides.
  const ButtonStyleOverride({
    super.key,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
    required this.child,
  }) : inherit = false;

  /// Creates a button style override in inherit mode.
  ///
  /// Overrides chain with parent overrides, allowing nested customization where
  /// each level can modify the result of the previous level.
  const ButtonStyleOverride.inherit({
    super.key,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
    required this.child,
  }) : inherit = true;

  @override
  Widget build(BuildContext context) {
    var decoration = this.decoration;
    var mouseCursor = this.mouseCursor;
    var padding = this.padding;
    var textStyle = this.textStyle;
    var iconTheme = this.iconTheme;
    var margin = this.margin;
    if (inherit) {
      var data = Data.maybeOf<ButtonStyleOverrideData>(context);
      if (data != null) {
        decoration = (context, state, value) {
          return data.decoration?.call(context, state,
                  decoration?.call(context, state, value) ?? value) ??
              decoration?.call(context, state, value) ??
              value;
        };
        mouseCursor = (context, state, value) {
          return data.mouseCursor?.call(context, state,
                  mouseCursor?.call(context, state, value) ?? value) ??
              mouseCursor?.call(context, state, value) ??
              value;
        };
        padding = (context, state, value) {
          return data.padding?.call(context, state,
                  padding?.call(context, state, value) ?? value) ??
              padding?.call(context, state, value) ??
              value;
        };
        textStyle = (context, state, value) {
          return data.textStyle?.call(context, state,
                  textStyle?.call(context, state, value) ?? value) ??
              textStyle?.call(context, state, value) ??
              value;
        };
        iconTheme = (context, state, value) {
          return data.iconTheme?.call(context, state,
                  iconTheme?.call(context, state, value) ?? value) ??
              iconTheme?.call(context, state, value) ??
              value;
        };
        margin = (context, state, value) {
          return data.margin?.call(context, state,
                  margin?.call(context, state, value) ?? value) ??
              margin?.call(context, state, value) ??
              value;
        };
      }
    }
    return Data.inherit(
      data: ButtonStyleOverrideData(
        decoration: decoration,
        mouseCursor: mouseCursor,
        padding: padding,
        textStyle: textStyle,
        iconTheme: iconTheme,
        margin: margin,
      ),
      child: child,
    );
  }
}

/// Data class holding button style override delegates.
///
/// [ButtonStyleOverrideData] is used internally by [ButtonStyleOverride] to pass
/// style override delegates through the widget tree via the [Data] inherited widget
/// system. It stores optional delegates for each button style property.
///
/// This class is typically not used directly by application code; instead, use
/// [ButtonStyleOverride] widget to apply style overrides.
class ButtonStyleOverrideData {
  /// Optional decoration override delegate.
  final ButtonStatePropertyDelegate<Decoration>? decoration;

  /// Optional mouse cursor override delegate.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;

  /// Optional padding override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;

  /// Optional text style override delegate.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;

  /// Optional icon theme override delegate.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;

  /// Optional margin override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// Creates button style override data with the specified delegates.
  const ButtonStyleOverrideData({
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ButtonStyleOverrideData &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode {
    return Object.hash(
      decoration,
      mouseCursor,
      padding,
      textStyle,
      iconTheme,
      margin,
    );
  }

  @override
  String toString() {
    return 'ButtonStyleOverrideData(decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin)';
  }
}

/// A widget that groups multiple buttons together with connected borders.
///
/// [ButtonGroup] visually connects a series of related buttons by removing
/// the borders between adjacent buttons and maintaining consistent styling.
/// This creates a segmented appearance where the buttons appear as a single
/// cohesive unit.
///
/// The group can be oriented horizontally or vertically, and automatically
/// handles border radius adjustments so that only the first and last buttons
/// in the group have rounded corners on their outer edges.
///
/// Commonly used for:
/// - Toggle button groups (like text formatting options)
/// - Related action sets (like alignment controls)
/// - Pagination controls
/// - View switchers
///
/// Example:
/// ```dart
/// ButtonGroup(
///   direction: Axis.horizontal,
///   children: [
///     Button.secondary(
///       onPressed: () => align('left'),
///       child: Icon(Icons.format_align_left),
///     ),
///     Button.secondary(
///       onPressed: () => align('center'),
///       child: Icon(Icons.format_align_center),
///     ),
///     Button.secondary(
///       onPressed: () => align('right'),
///       child: Icon(Icons.format_align_right),
///     ),
///   ],
/// );
/// ```
class ButtonGroup extends StatelessWidget {
  /// The layout direction for the button group.
  ///
  /// [Axis.horizontal] arranges buttons in a row, removing vertical borders
  /// between adjacent buttons. [Axis.vertical] arranges buttons in a column,
  /// removing horizontal borders between adjacent buttons.
  final Axis direction;

  /// The list of button widgets to group together.
  ///
  /// Each widget should typically be a [Button] or similar interactive widget.
  /// The group automatically applies border modifications to create the
  /// connected appearance.
  final List<Widget> children;

  /// Whether the button group should be shrink-wrapped or expanded.
  ///
  /// When true, the group will expand to fill available space in the
  /// cross axis. When false, the group will size itself based on its
  /// children's intrinsic size.
  final bool expands;

  /// Creates a [ButtonGroup] that arranges buttons with connected borders.
  ///
  /// Parameters:
  /// - [direction] (Axis, default: Axis.horizontal): Layout direction for the buttons.
  /// - [children] (`List<Widget>`, required): The buttons to group together.
  ///
  /// The group automatically handles:
  /// - Border radius adjustments for first/middle/last buttons
  /// - Proper sizing with [IntrinsicHeight] or [IntrinsicWidth]
  /// - Stretch alignment for consistent button heights/widths
  ///
  /// Example:
  /// ```dart
  /// ButtonGroup(
  ///   direction: Axis.vertical,
  ///   children: [
  ///     Button.outline(child: Text('Option 1')),
  ///     Button.outline(child: Text('Option 2')),
  ///     Button.outline(child: Text('Option 3')),
  ///   ],
  /// );
  /// ```
  const ButtonGroup({
    super.key,
    this.direction = Axis.horizontal,
    this.expands = false,
    required this.children,
  });

  /// Creates a horizontal button group.
  ///
  /// A convenience constructor equivalent to `ButtonGroup(direction: Axis.horizontal)`.
  /// Arranges buttons in a row with connected borders.
  const ButtonGroup.horizontal({
    super.key,
    this.expands = false,
    required this.children,
  }) : direction = Axis.horizontal;

  /// Creates a vertical button group.
  ///
  /// A convenience constructor equivalent to `ButtonGroup(direction: Axis.vertical)`.
  /// Arranges buttons in a column with connected borders.
  const ButtonGroup.vertical({
    super.key,
    this.expands = false,
    required this.children,
  }) : direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final parentGroupData = Data.maybeOf<ButtonGroupData>(context);
    List<Widget> children = List.from(this.children);
    if (children.length > 1) {
      for (int i = 0; i < children.length; i++) {
        var groupData = direction == Axis.horizontal
            ? ButtonGroupData.horizontalIndex(i, children.length)
            : ButtonGroupData.verticalIndex(i, children.length);
        if (parentGroupData != null) {
          groupData = parentGroupData.applyToButtonGroupData(groupData);
        }
        children[i] = Data.inherit(
          data: groupData,
          child: ButtonStyleOverride(
            decoration: (context, states, value) {
              if (value is BoxDecoration) {
                final borderRadius = groupData.applyToBorderRadius(
                    value.borderRadius ?? BorderRadius.zero,
                    Directionality.of(context));
                return value.copyWith(borderRadius: borderRadius);
              }
              return value;
            },
            child: children[i],
          ),
        );
      }
    }
    Widget flex = Flex(
      clipBehavior: Clip.none,
      mainAxisSize: MainAxisSize.min,
      direction: direction,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
    if (!expands) {
      if (direction == Axis.horizontal) {
        flex = IntrinsicHeight(child: flex);
      } else {
        flex = IntrinsicWidth(child: flex);
      }
    }
    return flex;
  }
}

/// Data class defining border radius multipliers for grouped buttons.
///
/// [ButtonGroupData] specifies which corners of a button should have reduced
/// border radius when part of a [ButtonGroup]. Values of 0.0 remove the radius
/// entirely (for internal buttons), while 1.0 preserves the full radius (for
/// end buttons).
///
/// This class uses directional values (start/end) to support RTL layouts properly.
/// The static constants provide common configurations for different positions
/// within a button group.
///
/// Example:
/// ```dart
/// // First button in horizontal group - preserve left radius, remove right
/// ButtonGroupData.horizontal(end: 0.0)
///
/// // Middle button - remove all radius
/// ButtonGroupData.zero
///
/// // Last button in horizontal group - remove left radius, preserve right
/// ButtonGroupData.horizontal(start: 0.0)
/// ```
class ButtonGroupData {
  /// No modification - full border radius on all corners.
  static const ButtonGroupData none = ButtonGroupData.all(1.0);

  /// Zero radius - removes border radius from all corners.
  static const ButtonGroupData zero = ButtonGroupData.all(0.0);

  /// Horizontal start position - full start radius, no end radius.
  static const ButtonGroupData horizontalStart =
      ButtonGroupData.horizontal(end: 0.0);

  /// Horizontal end position - no start radius, full end radius.
  static const ButtonGroupData horizontalEnd =
      ButtonGroupData.horizontal(start: 0.0);

  /// Vertical top position - full top radius, no bottom radius.
  static const ButtonGroupData verticalTop =
      ButtonGroupData.vertical(bottom: 0.0);

  /// Vertical bottom position - no top radius, full bottom radius.
  static const ButtonGroupData verticalBottom =
      ButtonGroupData.vertical(top: 0.0);

  /// Border radius multiplier for top-start corner (0.0 to 1.0).
  final double topStartValue;

  /// Border radius multiplier for top-end corner (0.0 to 1.0).
  final double topEndValue;

  /// Border radius multiplier for bottom-start corner (0.0 to 1.0).
  final double bottomStartValue;

  /// Border radius multiplier for bottom-end corner (0.0 to 1.0).
  final double bottomEndValue;

  /// Creates button group data with individual corner multipliers.
  const ButtonGroupData({
    required this.topStartValue,
    required this.topEndValue,
    required this.bottomStartValue,
    required this.bottomEndValue,
  });

  /// Creates horizontal group data with start and end multipliers.
  ///
  /// Both top and bottom on each side use the same value.
  const ButtonGroupData.horizontal({
    double start = 1.0,
    double end = 1.0,
  })  : topStartValue = start,
        topEndValue = end,
        bottomStartValue = start,
        bottomEndValue = end;

  /// Creates vertical group data with top and bottom multipliers.
  ///
  /// Both start and end on each side use the same value.
  const ButtonGroupData.vertical({
    double top = 1.0,
    double bottom = 1.0,
  })  : topStartValue = top,
        topEndValue = top,
        bottomStartValue = bottom,
        bottomEndValue = bottom;

  /// Creates group data with the same multiplier for all corners.
  const ButtonGroupData.all(double value)
      : topStartValue = value,
        topEndValue = value,
        bottomStartValue = value,
        bottomEndValue = value;

  /// Creates group data for a button at [index] in a horizontal group of [length] buttons.
  ///
  /// Returns:
  /// - [horizontalStart] for the first button (index 0)
  /// - [zero] for middle buttons
  /// - [horizontalEnd] for the last button
  /// - [none] if group has only one button
  factory ButtonGroupData.horizontalIndex(int index, int length) {
    if (length <= 1) {
      return none;
    } else {
      if (index == 0) {
        return horizontalStart;
      } else if (index == length - 1) {
        return horizontalEnd;
      } else {
        return zero;
      }
    }
  }

  /// Creates group data for a button at [index] in a vertical group of [length] buttons.
  ///
  /// Returns:
  /// - [verticalTop] for the first button (index 0)
  /// - [zero] for middle buttons
  /// - [verticalBottom] for the last button
  /// - [none] if group has only one button
  factory ButtonGroupData.verticalIndex(int index, int length) {
    if (length <= 1) {
      return none;
    } else {
      if (index == 0) {
        return verticalTop;
      } else if (index == length - 1) {
        return verticalBottom;
      } else {
        return zero;
      }
    }
  }

  /// Applies corner multipliers to a border radius.
  ///
  /// Multiplies each corner's radius by the corresponding corner value,
  /// properly handling text direction for start/end mapping to left/right.
  ///
  /// Parameters:
  /// - [borderRadius]: The base border radius to modify
  /// - [textDirection]: Text direction for resolving start/end to left/right
  ///
  /// Returns a new [BorderRadiusGeometry] with modified corner radii.
  BorderRadiusGeometry applyToBorderRadius(
      BorderRadiusGeometry borderRadius, TextDirection textDirection) {
    final topLeftValue =
        textDirection == TextDirection.ltr ? topStartValue : topEndValue;
    final topRightValue =
        textDirection == TextDirection.ltr ? topEndValue : topStartValue;
    final bottomLeftValue =
        textDirection == TextDirection.ltr ? bottomStartValue : bottomEndValue;
    final bottomRightValue =
        textDirection == TextDirection.ltr ? bottomEndValue : bottomStartValue;
    final resolvedBorderRadius = borderRadius.resolve(textDirection);
    return BorderRadius.only(
      topLeft: Radius.elliptical(
        resolvedBorderRadius.topLeft.x * topLeftValue,
        resolvedBorderRadius.topLeft.y * topLeftValue,
      ),
      topRight: Radius.elliptical(
        resolvedBorderRadius.topRight.x * topRightValue,
        resolvedBorderRadius.topRight.y * topRightValue,
      ),
      bottomLeft: Radius.elliptical(
        resolvedBorderRadius.bottomLeft.x * bottomLeftValue,
        resolvedBorderRadius.bottomLeft.y * bottomLeftValue,
      ),
      bottomRight: Radius.elliptical(
        resolvedBorderRadius.bottomRight.x * bottomRightValue,
        resolvedBorderRadius.bottomRight.y * bottomRightValue,
      ),
    );
  }

  /// Combines this group data with another by multiplying corresponding corner values.
  ///
  /// Useful for nesting button groups or applying multiple grouping effects.
  /// Each corner value is multiplied: result = this.value * other.value.
  ///
  /// Example:
  /// ```dart
  /// final half = ButtonGroupData.all(0.5);
  /// final end = ButtonGroupData.horizontal(start: 0.0);
  /// final combined = half.applyToButtonGroupData(end);
  /// // combined has: topStart=0, bottomStart=0, topEnd=0.5, bottomEnd=0.5
  /// ```
  ButtonGroupData applyToButtonGroupData(ButtonGroupData other) {
    return ButtonGroupData(
      topStartValue: topStartValue * other.topStartValue,
      topEndValue: topEndValue * other.topEndValue,
      bottomStartValue: bottomStartValue * other.bottomStartValue,
      bottomEndValue: bottomEndValue * other.bottomEndValue,
    );
  }

  @override
  String toString() {
    return 'ButtonGroupData(topStartValue: $topStartValue, topEndValue: $topEndValue, bottomStartValue: $bottomStartValue, bottomEndValue: $bottomEndValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ButtonGroupData &&
        other.topStartValue == topStartValue &&
        other.topEndValue == topEndValue &&
        other.bottomStartValue == bottomStartValue &&
        other.bottomEndValue == bottomEndValue;
  }

  @override
  int get hashCode {
    return Object.hash(
      topStartValue,
      topEndValue,
      bottomStartValue,
      bottomEndValue,
    );
  }
}
