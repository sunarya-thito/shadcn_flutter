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
  /// - [onChanged] (ValueChanged<bool>?, optional): State change callback.
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
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final ButtonStyle style;
  final bool? enabled;

  /// Creates a [Toggle].
  ///
  /// The toggle button maintains its own state and calls [onChanged] when
  /// the state changes. Uses ghost button styling by default.
  ///
  /// Parameters:
  /// - [value] (bool, required): current toggle state
  /// - [onChanged] (ValueChanged<bool>?, optional): callback when state changes
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
class ToggleState extends State<Toggle> with FormValueSupplier<bool, Toggle> {
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

/// A button widget that can be in a selected or unselected state.
///
/// Similar to a toggle button but with distinct visual styles for selected
/// and unselected states. Commonly used in button groups, tabs, or any interface
/// where users need to see which option is currently active.
///
/// The button switches between two styles based on its value and supports
/// all standard button interactions including tap, hover, focus, and long press.
///
/// Example:
/// ```dart
/// SelectedButton(
///   value: isSelected,
///   onChanged: (selected) => setState(() => isSelected = selected),
///   style: ButtonStyle.outline(),
///   selectedStyle: ButtonStyle.filled(),
///   child: Text('Option 1'),
/// )
/// ```
class SelectedButton extends StatefulWidget {
  /// The current selected state of the button.
  final bool value;

  /// Callback invoked when the selected state changes.
  final ValueChanged<bool>? onChanged;

  /// The widget displayed inside the button.
  final Widget child;

  /// The button style when unselected.
  final AbstractButtonStyle style;

  /// The button style when selected.
  final AbstractButtonStyle selectedStyle;

  /// Whether the button is enabled for interaction.
  final bool? enabled;

  /// The alignment of the button's child within the button area.
  final AlignmentGeometry? alignment;

  /// The alignment of the button within its margin area.
  final AlignmentGeometry? marginAlignment;

  /// Whether to disable visual transitions between states.
  final bool disableTransition;

  /// Callback invoked when the mouse hovers over the button.
  final ValueChanged<bool>? onHover;

  /// Callback invoked when the button gains or loses focus.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic and audio feedback.
  final bool? enableFeedback;

  /// Callback invoked when a tap down gesture is detected.
  final GestureTapDownCallback? onTapDown;

  /// Callback invoked when a tap up gesture is detected.
  final GestureTapUpCallback? onTapUp;

  /// Callback invoked when a tap gesture is canceled.
  final GestureTapCancelCallback? onTapCancel;

  /// Callback invoked when a secondary tap down gesture is detected.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Callback invoked when a secondary tap up gesture is detected.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Callback invoked when a secondary tap gesture is canceled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Callback invoked when a tertiary tap down gesture is detected.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Callback invoked when a tertiary tap up gesture is detected.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Callback invoked when a tertiary tap gesture is canceled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Callback invoked when a long press gesture starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Callback invoked when a long press gesture ends.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Callback invoked when a long press gesture moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Callback invoked when a long press gesture completes.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Callback invoked when a secondary long press gesture is detected.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Callback invoked when a tertiary long press gesture is detected.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Whether to disable visual hover effects.
  final bool disableHoverEffect;

  /// Controller for managing the button's interaction states.
  final WidgetStatesController? statesController;

  /// Callback invoked when the button is pressed.
  final VoidCallback? onPressed;

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
class SelectedButtonState extends State<SelectedButton> {
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
  /// - [onFocus] (ValueChanged<bool>?, optional): Focus state change callback.
  /// - [onHover] (ValueChanged<bool>?, optional): Hover state change callback.
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
                return Matrix4.identity()..scale(0.95);
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

/// Returns the padding unchanged for normal density buttons.
///
/// This is the default density modifier that preserves the original padding
/// values without any modification.
EdgeInsets _densityNormal(EdgeInsets padding) {
  return padding;
}

/// Reduces button padding to 50% of the original size for dense layouts.
///
/// This density modifier creates more compact buttons suitable for tighter
/// UI layouts where space is limited.
EdgeInsets _densityDense(EdgeInsets padding) {
  return padding * 0.5;
}

/// Eliminates all padding for extremely compact button layouts.
///
/// This density modifier removes all padding, creating the most space-efficient
/// button possible. Typically used in very constrained layouts or when custom
/// spacing is managed externally.
EdgeInsets _densityCompact(EdgeInsets padding) {
  return EdgeInsets.zero;
}

/// Creates square padding suitable for icon-only buttons.
///
/// This density modifier converts rectangular padding to square padding by using
/// the minimum value from all sides, ensuring icons are centered properly in
/// square button layouts.
EdgeInsets _densityIcon(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))));
}

/// Creates comfortable square padding for larger icon-only buttons.
///
/// This density modifier converts rectangular padding to square padding by using
/// the maximum value from all sides, providing more generous spacing around icons
/// for improved touch targets and visual breathing room.
EdgeInsets _densityIconComfortable(EdgeInsets padding) {
  return EdgeInsets.all(
      max(padding.top, max(padding.bottom, max(padding.left, padding.right))));
}

/// Creates compact square padding for dense icon-only buttons.
///
/// This density modifier converts rectangular padding to square padding by using
/// the minimum value from all sides and further reduces it by 50%, creating very
/// compact icon buttons suitable for toolbars or tight UI spaces.
EdgeInsets _densityIconDense(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))) *
          0.5);
}

/// Doubles the padding for comfortable button layouts with larger touch targets.
///
/// This density modifier increases all padding values by 200%, creating buttons
/// with more generous spacing that are easier to tap and provide better visual
/// hierarchy in spacious UI designs.
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

/// A function that returns a widget state-dependent value for button styling.
///
/// This typedef defines a function signature that takes the current [BuildContext]
/// and a set of [WidgetState] values (such as hovered, pressed, focused, disabled)
/// and returns a value of type [T] appropriate for that state combination.
///
/// Used extensively in button theming to provide different styling properties
/// based on the button's current interaction state.
///
/// Example:
/// ```dart
/// ButtonStateProperty<Color> colorProperty = (context, states) {
///   if (states.contains(WidgetState.pressed)) {
///     return Theme.of(context).colorScheme.primary;
///   } else if (states.contains(WidgetState.hovered)) {
///     return Theme.of(context).colorScheme.primaryContainer;
///   }
///   return Theme.of(context).colorScheme.surface;
/// };
/// ```
typedef ButtonStateProperty<T> = T Function(
    BuildContext context, Set<WidgetState> states);

/// Abstract base class defining the styling interface for button components.
///
/// [AbstractButtonStyle] defines the contract that all button style implementations
/// must follow, providing state-dependent properties for visual appearance,
/// interaction behavior, and layout characteristics.
///
/// Each property is a [ButtonStateProperty] that can return different values
/// based on the button's current widget states (pressed, hovered, focused, etc.).
///
/// Implementations include [ButtonVariance] classes for different visual styles
/// and [ButtonStyle] for complete button styling configuration.
abstract class AbstractButtonStyle {
  /// The decoration (background, border, shadows) for different button states.
  ButtonStateProperty<Decoration> get decoration;
  
  /// The mouse cursor displayed when hovering over the button.
  ButtonStateProperty<MouseCursor> get mouseCursor;
  
  /// The internal padding between the button's border and content.
  ButtonStateProperty<EdgeInsetsGeometry> get padding;
  
  /// The text styling applied to text content within the button.
  ButtonStateProperty<TextStyle> get textStyle;
  
  /// The icon theme applied to icon content within the button.
  ButtonStateProperty<IconThemeData> get iconTheme;
  
  /// The external margin around the button.
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
}

/// Complete button styling configuration combining visual variance, size, density and shape.
///
/// [ButtonStyle] is the primary way to customize button appearance in the shadcn_flutter
/// framework. It combines a visual style variance with size, density, and shape modifiers
/// to create comprehensive button styling.
///
/// The class provides convenient constructors for common button styles and allows for
/// detailed customization through its properties.
///
/// Example:
/// ```dart
/// // Using predefined styles
/// ButtonStyle.primary()
/// ButtonStyle.secondary()
/// ButtonStyle.outline()
/// 
/// // Custom configuration
/// ButtonStyle(
///   variance: ButtonVariance.primary,
///   size: ButtonSize.large,
///   density: ButtonDensity.comfortable,
///   shape: ButtonShape.circle,
/// )
/// ```
class ButtonStyle implements AbstractButtonStyle {
  /// The visual style variance (primary, secondary, outline, ghost, etc.).
  final AbstractButtonStyle variance;
  
  /// The size configuration affecting padding and text scaling.
  final ButtonSize size;
  
  /// The density configuration affecting padding compression/expansion.
  final ButtonDensity density;
  
  /// The shape configuration (rectangle or circle).
  final ButtonShape shape;

  /// Creates a [ButtonStyle] with custom configuration.
  ///
  /// Parameters:
  /// - [variance] (AbstractButtonStyle, required): The visual style variant
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration  
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle({
    required this.variance,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates a primary button style with high-contrast styling for main actions.
  ///
  /// Primary buttons use the theme's primary color with high contrast text,
  /// making them suitable for the most important actions in your interface.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.primary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  /// Creates a secondary button style with muted styling for supporting actions.
  ///
  /// Secondary buttons use a subtle background color with medium contrast,
  /// suitable for actions that are important but secondary to primary actions.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.secondary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  /// Creates an outline button style with border emphasis and transparent background.
  ///
  /// Outline buttons feature a prominent border with transparent background,
  /// suitable for secondary actions that need clear boundaries.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.outline({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  /// Creates a ghost button style with minimal styling for subtle actions.
  ///
  /// Ghost buttons have no background by default and only show subtle hover
  /// effects, perfect for actions that shouldn't draw attention from main content.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.ghost({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  /// Creates a link button style that appears as clickable text.
  ///
  /// Link buttons have no background or border, styled to look like hyperlinks
  /// with appropriate hover and focus states.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.link({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  /// Creates a text button style for minimal text-only actions.
  ///
  /// Text buttons have minimal styling with just text color changes on interaction,
  /// suitable for very subtle actions or inline controls.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.text({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  /// Creates a destructive button style for dangerous actions.
  ///
  /// Destructive buttons use error/danger colors to indicate actions that
  /// cannot be undone, such as deletion or permanent changes.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.destructive({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  /// Creates a fixed button style with consistent positioning and no animations.
  ///
  /// Fixed buttons maintain their position and don't respond to layout changes
  /// or animations, useful for overlay controls or persistent interface elements.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.fixed({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  /// Creates a menu button style optimized for dropdown menu triggers.
  ///
  /// Menu buttons have styling appropriate for triggering dropdown menus,
  /// with visual cues for expandable content.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.menu({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menu;

  /// Creates a menubar button style for horizontal menu bar items.
  ///
  /// Menubar buttons have minimal styling optimized for horizontal layout
  /// in menu bars, with appropriate spacing and hover effects.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.menubar({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menubar;

  /// Creates a muted button style with subdued appearance.
  ///
  /// Muted buttons have very subtle styling with low contrast,
  /// suitable for actions that should be barely noticeable until needed.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.muted({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.muted;

  /// Creates a primary icon button style optimized for icon-only buttons.
  ///
  /// Combines primary styling with icon density for square buttons containing
  /// only icons, with appropriate padding and touch targets.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.primaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  /// Creates a secondary icon button style optimized for icon-only buttons.
  ///
  /// Combines secondary styling with icon density for square buttons containing
  /// only icons, providing muted but clear interactive feedback.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.secondaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  /// Creates an outline icon button style optimized for icon-only buttons.
  ///
  /// Combines outline styling with icon density for square buttons containing
  /// only icons, featuring a clear border with transparent background.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.outlineIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  /// Creates a ghost icon button style optimized for icon-only buttons.
  ///
  /// Combines ghost styling with icon density for square buttons containing
  /// only icons, featuring minimal visual weight with subtle hover effects.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.ghostIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  /// Creates a link icon button style optimized for icon-only buttons.
  ///
  /// Combines link styling with icon density for square buttons containing
  /// only icons, appearing as clickable icon links with appropriate hover states.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.linkIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  const ButtonStyle.textIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  const ButtonStyle.destructiveIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  const ButtonStyle.fixedIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

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

abstract class ButtonTheme {
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

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

class ComponentThemeButtonStyle<T extends ButtonTheme>
    implements AbstractButtonStyle {
  final AbstractButtonStyle fallback;

  const ComponentThemeButtonStyle({required this.fallback});

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

extension ShapeDecorationExtension on ShapeDecoration {
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

extension DecorationExtension on Decoration {
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

class PrimaryButtonTheme extends ButtonTheme {
  const PrimaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class SecondaryButtonTheme extends ButtonTheme {
  const SecondaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class OutlineButtonTheme extends ButtonTheme {
  const OutlineButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class GhostButtonTheme extends ButtonTheme {
  const GhostButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class LinkButtonTheme extends ButtonTheme {
  const LinkButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class TextButtonTheme extends ButtonTheme {
  const TextButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class DestructiveButtonTheme extends ButtonTheme {
  const DestructiveButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class FixedButtonTheme extends ButtonTheme {
  const FixedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class MenuButtonTheme extends ButtonTheme {
  const MenuButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class MenubarButtonTheme extends ButtonTheme {
  const MenubarButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class MutedButtonTheme extends ButtonTheme {
  const MutedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class CardButtonTheme extends ButtonTheme {
  const CardButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

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

class ButtonVariance implements AbstractButtonStyle {
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

class ButtonStylePropertyAll<T> {
  final T value;

  const ButtonStylePropertyAll(this.value);

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

extension ButtonStyleExtension on AbstractButtonStyle {
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

// Backward compatibility
class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
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

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
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

class OutlineButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
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

class GhostButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
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

class LinkButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
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

class TextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
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

class DestructiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
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

class TabButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
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

  final bool? enableFeedback;
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

class IconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
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
  final AbstractButtonStyle variance;

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

class ButtonStyleOverride extends StatelessWidget {
  final bool inherit;
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  final Widget child;

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

class ButtonStyleOverrideData {
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

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

  /// Creates a [ButtonGroup] that arranges buttons with connected borders.
  ///
  /// Parameters:
  /// - [direction] (Axis, default: Axis.horizontal): Layout direction for the buttons.
  /// - [children] (List<Widget>, required): The buttons to group together.
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
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.from(this.children);
    if (children.length > 1) {
      for (int i = 0; i < children.length; i++) {
        children[i] = ButtonStyleOverride(
          decoration: (context, states, value) {
            if (value is BoxDecoration) {
              BorderRadius resolvedBorderRadius;
              BorderRadiusGeometry? borderRadius = value.borderRadius;
              if (borderRadius is BorderRadius) {
                resolvedBorderRadius = borderRadius;
              } else if (borderRadius == null) {
                resolvedBorderRadius = BorderRadius.zero;
              } else {
                resolvedBorderRadius =
                    borderRadius.resolve(Directionality.of(context));
              }
              if (direction == Axis.horizontal) {
                if (i == 0) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                } else if (i == children.length - 1) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      bottomLeft: Radius.zero,
                    ),
                  );
                } else {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                }
              } else {
                if (i == 0) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                } else if (i == children.length - 1) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                    ),
                  );
                } else {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                }
              }
            }
            return value;
          },
          child: children[i],
        );
      }
    }
    Widget flex = Flex(
      mainAxisSize: MainAxisSize.min,
      direction: direction,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
    if (direction == Axis.horizontal) {
      flex = IntrinsicHeight(child: flex);
    } else {
      flex = IntrinsicWidth(child: flex);
    }
    return flex;
  }
}
