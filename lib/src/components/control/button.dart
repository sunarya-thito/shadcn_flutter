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
  /// The current toggle state of the button.
  /// 
  /// When true, the button appears in its selected/active state. When false,
  /// it appears in its unselected/inactive state.
  final bool value;
  
  /// Callback invoked when the toggle state changes.
  /// 
  /// Called with the new boolean value when the user taps the toggle button.
  /// Set to null to disable user interaction.
  final ValueChanged<bool>? onChanged;
  
  /// The widget to display as the button's content.
  /// 
  /// Typically a [Text] widget, but can be any widget including rows with
  /// icons and text, custom graphics, or complex layouts.
  final Widget child;
  
  /// The visual styling configuration for the button.
  /// 
  /// Defines colors, borders, padding, and other visual properties. 
  /// Defaults to [ButtonStyle.ghost] for a subtle appearance.
  final ButtonStyle style;
  
  /// Whether the toggle button is enabled for user interaction.
  /// 
  /// When false, the button ignores touch events and appears in a disabled
  /// visual state. When null, inherits from nearest [Form] or defaults to enabled.
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
/// State class for [Toggle] widget that manages selection state and form integration.
///
/// Extends [State] and mixes in [FormValueSupplier] to provide reactive state
/// management for toggle buttons with form integration support. Maintains a
/// [WidgetStatesController] for managing visual states like selected, pressed, and focused.
class ToggleState extends State<Toggle> with FormValueSupplier<bool, Toggle> {
  /// Controller for managing widget visual states (selected, pressed, focused, etc.).
  ///
  /// Updates automatically when toggle value changes to reflect the current
  /// selection state in the button's visual appearance.
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

  /// Creates an outline button with border styling for secondary actions.
  ///
  /// Outline buttons use a transparent background with a visible border, making them
  /// suitable for secondary actions that need clear visibility but less emphasis than
  /// primary buttons. They provide good contrast against most backgrounds while
  /// maintaining visual hierarchy.
  ///
  /// The button shows hover and focus effects while maintaining the outline aesthetic.
  /// Border colors and text colors adapt to the current theme and interaction states.
  ///
  /// Parameters: Same as [Button] constructor, with [style] preset to [ButtonVariance.outline].
  ///
  /// Example:
  /// ```dart
  /// Button.outline(
  ///   onPressed: () => showMoreOptions(),
  ///   leading: Icon(Icons.more_horiz),
  ///   child: Text('More Options'),
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

  /// Creates a link button with hyperlink-style appearance for navigation actions.
  ///
  /// Link buttons appear as text links with underlines and color changes on hover,
  /// making them suitable for navigation actions, cross-references, or any action
  /// that conceptually "takes you somewhere." They have minimal visual weight and
  /// integrate seamlessly with text content.
  ///
  /// The styling mimics web links with appropriate hover and focus states, including
  /// underline effects and color transitions that follow accessibility guidelines.
  ///
  /// Parameters: Same as [Button] constructor, with [style] preset to [ButtonVariance.link].
  ///
  /// Example:
  /// ```dart
  /// Button.link(
  ///   onPressed: () => Navigator.pushNamed(context, '/profile'),
  ///   child: Text('View Profile'),
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

  /// Creates a text button with plain text appearance for minimal actions.
  ///
  /// Text buttons have no background or border by default, appearing as plain text
  /// with subtle hover effects. They're perfect for actions that should be available
  /// but not prominent, such as "Cancel" in dialog boxes or secondary navigation items.
  ///
  /// The text styling adapts to interaction states with appropriate color changes
  /// and opacity adjustments while maintaining minimal visual impact on the interface.
  ///
  /// Parameters: Same as [Button] constructor, with [style] preset to [ButtonVariance.text].
  ///
  /// Example:
  /// ```dart
  /// Button.text(
  ///   onPressed: () => Navigator.pop(context),
  ///   child: Text('Cancel'),
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

  /// Creates a fixed button with consistent styling for stable UI elements.
  ///
  /// Fixed buttons maintain consistent appearance regardless of interaction state changes,
  /// making them suitable for UI elements that need stable visual presentation such as
  /// tabs, navigation items, or status indicators that shouldn't show hover effects.
  ///
  /// While the button still responds to interactions, the visual styling remains more
  /// static compared to other button variants, providing predictable appearance for
  /// interface elements that need consistent visual weight.
  ///
  /// Parameters: Same as [Button] constructor, with [style] preset to [ButtonVariance.fixed].
  ///
  /// Example:
  /// ```dart
  /// Button.fixed(
  ///   onPressed: () => switchTab(0),
  ///   child: Text('Home'),
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

  /// Creates a card button with elevated card-like appearance for prominent content.
  ///
  /// Card buttons combine the interactive nature of buttons with the elevated appearance
  /// of cards, making them suitable for content sections that need both visual prominence
  /// and interaction capabilities. They provide depth through shadows and borders while
  /// maintaining full button functionality.
  ///
  /// The card styling includes appropriate elevation, border radius, and background
  /// colors that adapt to theme changes and interaction states, creating a cohesive
  /// card-like experience with button behaviors.
  ///
  /// Parameters: Same as [Button] constructor, with [style] preset to [ButtonVariance.card].
  ///
  /// Example:
  /// ```dart
  /// Button.card(
  ///   onPressed: () => openDashboard(),
  ///   leading: Icon(Icons.dashboard),
  ///   child: Column(
  ///     children: [
  ///       Text('Dashboard'),
  ///       Text('View analytics'),
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

/// A function that modifies button style properties based on context and state.
///
/// This typedef defines override functions used in [ButtonStyleOverride] to modify
/// button styling properties. The function receives the current [BuildContext],
/// a set of [WidgetState] values representing the button's interaction state,
/// and the base value of type [T] that would normally be used.
///
/// The function should return a modified version of the base value. This allows
/// for additive styling where overrides build upon the existing button style
/// rather than completely replacing it.
///
/// Example:
/// ```dart
/// ButtonStatePropertyDelegate<EdgeInsets> paddingOverride = 
///   (context, states, baseValue) {
///     // Add extra padding when button is pressed
///     if (states.contains(WidgetState.pressed)) {
///       return baseValue + EdgeInsets.all(2);
///     }
///     return baseValue;
///   };
/// ```
typedef ButtonStatePropertyDelegate<T> = T Function(
  BuildContext context,
  Set<WidgetState> states,
  T value,
);

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

  /// Creates a text icon button style optimized for icon-only buttons.
  ///
  /// Combines text styling with icon density for square buttons containing
  /// only icons, featuring minimal text-style visual feedback.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.textIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  /// Creates a destructive icon button style optimized for icon-only buttons.
  ///
  /// Combines destructive styling with icon density for square buttons containing
  /// only icons, using danger colors to indicate destructive actions.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.destructiveIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  /// Creates a fixed icon button style optimized for icon-only buttons.
  ///
  /// Combines fixed positioning styling with icon density for square buttons
  /// containing only icons, maintaining consistent placement without animations.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: icon): Icon-specific density
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.fixedIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  /// Creates a card button style for card-like interactive elements.
  ///
  /// Card buttons have elevated styling with card-like appearance,
  /// suitable for larger interactive areas or content cards.
  ///
  /// Parameters:
  /// - [size] (ButtonSize, default: normal): Size configuration
  /// - [density] (ButtonDensity, default: normal): Density configuration
  /// - [shape] (ButtonShape, default: rectangle): Shape configuration
  const ButtonStyle.card({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.card;

  /// Resolves button decoration, adapting for circular shape when needed.
  ///
  /// This method implements the decoration property from [AbstractButtonStyle],
  /// delegating to the variance's decoration but adapting it for circular
  /// buttons when [shape] is [ButtonShape.circle].
  @override
  ButtonStateProperty<Decoration> get decoration {
    if (shape == ButtonShape.circle) {
      return _resolveCircleDecoration;
    }
    return variance.decoration;
  }

  /// Adapts a decoration for circular button shape.
  ///
  /// Takes the base decoration from the variance and modifies it to work
  /// with circular buttons by setting appropriate shape properties.
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

  /// Delegates mouse cursor resolution to the underlying variance.
  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    return variance.mouseCursor;
  }

  /// Resolves button padding by applying size scaling and density modifications.
  ///
  /// If both size and density are normal, delegates directly to the variance.
  /// Otherwise, applies scaling and density transformations to achieve the
  /// desired button dimensions and spacing.
  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (size == ButtonSize.normal && density == ButtonDensity.normal) {
      return variance.padding;
    }
    return _resolvePadding;
  }

  /// Applies size and density transformations to base padding.
  ///
  /// First scales padding by the size factor, then applies the density
  /// modifier to achieve the final padding configuration.
  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    return density.modifier(
        variance.padding(context, states).optionallyResolve(context) *
            size.scale);
  }

  /// Resolves text style by applying size scaling to font size.
  ///
  /// If size is normal, delegates directly to the variance. Otherwise,
  /// scales the font size according to the size configuration.
  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (size == ButtonSize.normal) {
      return variance.textStyle;
    }
    return _resolveTextStyle;
  }

  /// Applies size scaling to the base text style font size.
  ///
  /// Preserves all other text style properties while scaling only the
  /// font size by the configured size factor.
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

  /// Resolves icon theme by applying size scaling to icon size.
  ///
  /// If size is normal, delegates directly to the variance. Otherwise,
  /// scales the icon size according to the size configuration.
  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (size == ButtonSize.normal) {
      return variance.iconTheme;
    }
    return _resolveIconTheme;
  }

  /// Applies size scaling to the base icon theme size.
  ///
  /// Preserves all other icon theme properties while scaling only the
  /// icon size by the configured size factor.
  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var iconSize = variance.iconTheme(context, states).size;
    iconSize ??= IconTheme.of(context).size ?? 24;
    return variance.iconTheme(context, states).copyWith(
          size: iconSize * size.scale,
        );
  }

  /// Delegates margin resolution to the underlying variance.
  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    return variance.margin;
  }
}

/// Abstract base class for button theme customization.
///
/// [ButtonTheme] allows components to provide theme overrides for button styling
/// by specifying delegates that can modify or replace the base button style properties.
/// 
/// Each property is optional and uses a [ButtonStatePropertyDelegate] which receives
/// the context, states, and base resolved value, allowing for sophisticated theme
/// customization that can build upon or completely replace base styling.
///
/// Example usage in a custom component theme:
/// ```dart
/// class MyButtonTheme extends ButtonTheme {
///   const MyButtonTheme() : super(
///     decoration: _customDecoration,
///     padding: _customPadding,
///   );
/// }
/// 
/// static Decoration _customDecoration(
///   BuildContext context, 
///   Set<WidgetState> states, 
///   Decoration base,
/// ) {
///   // Modify or replace base decoration
///   return base.copyWith(/* custom properties */);
/// }
/// ```
abstract class ButtonTheme {
  /// Optional decorator for button decoration (background, border, shadows).
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  
  /// Optional decorator for mouse cursor on hover.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  
  /// Optional decorator for internal button padding.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  
  /// Optional decorator for text styling within the button.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  
  /// Optional decorator for icon theme within the button.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  
  /// Optional decorator for external button margin.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// Creates a [ButtonTheme] with optional property decorators.
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

/// Button style implementation that integrates with the component theme system.
///
/// [ComponentThemeButtonStyle] wraps a fallback [AbstractButtonStyle] and allows
/// component-specific themes to override or modify button styling properties.
/// It searches for a matching theme type [T] in the component theme hierarchy
/// and applies any found theme decorators.
///
/// This enables components to provide their own button styling while maintaining
/// the base button style as a fallback when no component theme is available.
///
/// Type parameter [T] should extend [ButtonTheme] and represent the specific
/// component's button theme class.
class ComponentThemeButtonStyle<T extends ButtonTheme>
    implements AbstractButtonStyle {
  /// The fallback button style used when no component theme is found.
  final AbstractButtonStyle fallback;

  /// Creates a [ComponentThemeButtonStyle] with the specified fallback style.
  const ComponentThemeButtonStyle({required this.fallback});

  /// Searches for a component theme of type [T] in the current context.
  ///
  /// Returns the theme instance if found, or null if no matching theme
  /// is available in the current widget tree.
  T? find(BuildContext context) {
    return ComponentTheme.maybeOf<T>(context);
  }

  /// Resolves decoration by applying component theme overrides to the fallback.
  @override
  ButtonStateProperty<Decoration> get decoration => _resolveDecoration;

  /// Combines fallback decoration with component theme decoration overrides.
  ///
  /// First resolves the fallback decoration, then applies any decoration
  /// delegate from the component theme if available.
  Decoration _resolveDecoration(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.decoration(context, states);
    return find(context)?.decoration?.call(context, states, resolved) ??
        resolved;
  }

  /// Resolves icon theme by applying component theme overrides to the fallback.
  @override
  ButtonStateProperty<IconThemeData> get iconTheme => _resolveIconTheme;

  /// Combines fallback icon theme with component theme icon theme overrides.
  ///
  /// First resolves the fallback icon theme, then applies any icon theme
  /// delegate from the component theme if available.
  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.iconTheme(context, states);
    return find(context)?.iconTheme?.call(context, states, resolved) ??
        resolved;
  }

  /// Resolves margin by applying component theme overrides to the fallback.
  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin => _resolveMargin;

  /// Combines fallback margin with component theme margin overrides.
  ///
  /// First resolves the fallback margin, then applies any margin
  /// delegate from the component theme if available.
  EdgeInsetsGeometry _resolveMargin(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.margin(context, states);
    return find(context)?.margin?.call(context, states, resolved) ?? resolved;
  }

  /// Resolves mouse cursor by applying component theme overrides to the fallback.
  @override
  ButtonStateProperty<MouseCursor> get mouseCursor => _resolveMouseCursor;

  /// Combines fallback mouse cursor with component theme cursor overrides.
  ///
  /// First resolves the fallback mouse cursor, then applies any cursor
  /// delegate from the component theme if available.
  MouseCursor _resolveMouseCursor(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.mouseCursor(context, states);
    return find(context)?.mouseCursor?.call(context, states, resolved) ??
        resolved;
  }

  /// Resolves padding by applying component theme overrides to the fallback.
  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding => _resolvePadding;

  /// Combines fallback padding with component theme padding overrides.
  ///
  /// First resolves the fallback padding, then applies any padding
  /// delegate from the component theme if available.
  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.padding(context, states);
    return find(context)?.padding?.call(context, states, resolved) ?? resolved;
  }

  /// Resolves text style by applying component theme overrides to the fallback.
  @override
  ButtonStateProperty<TextStyle> get textStyle => _resolveTextStyle;

  /// Combines fallback text style with component theme text style overrides.
  ///
  /// First resolves the fallback text style, then applies any text style
  /// delegate from the component theme if available.
  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.textStyle(context, states);
    return find(context)?.textStyle?.call(context, states, resolved) ??
        resolved;
  }
}

/// Extension providing a copyWith method for [ShapeDecoration].
///
/// This extension adds convenient copying functionality to [ShapeDecoration],
/// allowing selective property updates similar to other Flutter decoration classes.
///
/// Each parameter is optional and preserves the original value when not specified.
extension ShapeDecorationExtension on ShapeDecoration {
  /// Creates a copy of this [ShapeDecoration] with specified properties overridden.
  ///
  /// Parameters:
  /// - [shape] (ShapeBorder?, optional): New shape border, or null to keep current
  /// - [color] (Color?, optional): New fill color, or null to keep current  
  /// - [gradient] (Gradient?, optional): New gradient, or null to keep current
  /// - [shadows] (List<BoxShadow>?, optional): New shadows, or null to keep current
  /// - [image] (DecorationImage?, optional): New background image, or null to keep current
  ///
  /// Returns a new [ShapeDecoration] with the specified modifications.
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

/// Theme configuration for primary button styling.
///
/// [PrimaryButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties specifically for primary buttons. Primary buttons represent the
/// most important actions in an interface with high visual emphasis through
/// filled backgrounds and contrasting colors.
///
/// This theme integrates with the shadcn theme system and can be customized
/// through [ShadcnTheme] or used directly to override specific button styling
/// properties while maintaining the primary button's visual hierarchy.
///
/// Each property accepts a [ButtonStatePropertyDelegate] function that can
/// modify the base styling based on context and widget states.
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

/// Theme configuration for secondary button styling.
///
/// [SecondaryButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for secondary buttons. Secondary buttons offer medium visual emphasis
/// with subtle background fills, supporting primary actions without competing for
/// visual attention.
///
/// Used for actions that complement primary buttons in forms, dialogs, and action
/// groups where visual hierarchy needs to be maintained through varied emphasis levels.
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

/// Theme configuration for outline button styling.
///
/// [OutlineButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for outline buttons. Outline buttons feature transparent backgrounds
/// with visible borders, offering clear action boundaries without heavy visual weight.
///
/// Ideal for alternative actions, cancel buttons, or interfaces requiring multiple
/// buttons with equal visual emphasis where filled backgrounds would be too dominant.
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

/// Theme configuration for ghost button styling.
///
/// [GhostButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for ghost buttons. Ghost buttons offer minimal visual presence
/// with subtle hover effects, ideal for tertiary actions and contexts where
/// visual noise should be minimized.
///
/// Perfect for toolbar buttons, table actions, or any interface elements that
/// need interactivity without drawing attention away from primary content.
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

/// Theme configuration for link button styling.
///
/// [LinkButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for link buttons. Link buttons are styled to resemble clickable
/// hyperlinks with underline decoration and link colors, making them feel like
/// text-based interactions rather than traditional buttons.
///
/// Suitable for navigation actions, external links, or any action that should
/// integrate seamlessly with text content while maintaining clear interactivity.
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

/// Theme configuration for text button styling.
///
/// [TextButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for text buttons. Text buttons appear as plain text with subtle
/// hover effects, offering minimal visual distraction while maintaining clear
/// interactivity.
///
/// Perfect for actions that should integrate seamlessly with text content or
/// provide minimal visual presence in content-heavy interfaces.
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

/// Theme configuration for destructive button styling.
///
/// [DestructiveButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for destructive buttons. Destructive buttons use warning colors
/// (typically red-based) to signal potentially harmful actions like deletion,
/// removal, or other destructive operations.
///
/// Provides clear visual warning while maintaining standard button interaction
/// patterns, helping users understand the consequences of their actions.
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

/// Theme configuration for fixed button styling.
///
/// [FixedButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for fixed buttons. Fixed buttons maintain consistent appearance
/// across interaction states, suitable for navigation tabs, status indicators,
/// or UI elements that need predictable styling.
///
/// Provides static visual appearance with minimal state-based changes, ideal
/// for interface elements that should maintain visual consistency regardless
/// of user interaction.
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

/// Theme configuration for menu button styling.
///
/// [MenuButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for menu buttons. Menu buttons are optimized for dropdown and
/// context menu items with compact padding, full-width hover effects, and
/// styling that integrates well with menu containers.
///
/// Designed specifically for menu contexts where buttons need consistent
/// appearance and appropriate spacing within popup overlays and menu lists.
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

/// Theme configuration for menu bar button styling.
///
/// [MenubarButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for menu bar buttons. This is a specialized variant of menu
/// styling with adjusted padding and spacing optimized for horizontal menu
/// bar layouts.
///
/// Provides consistent appearance across menu bar items while maintaining
/// clear hover feedback appropriate for menu bar contexts.
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

/// Theme configuration for muted button styling.
///
/// [MutedButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for muted buttons. Muted buttons offer reduced visual prominence
/// using subdued colors and subtle interactions, suitable for secondary actions
/// that should remain accessible without competing for attention.
///
/// Perfect for actions that need to be available but shouldn't distract from
/// primary interface elements or content.
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

/// Theme configuration for card button styling.
///
/// [CardButtonTheme] extends [ButtonTheme] to provide customizable styling
/// properties for card buttons. Card buttons feature elevation, rounded corners,
/// and styling that matches card components, suitable for button-like actions
/// that should appear as interactive cards.
///
/// Ideal for buttons that need to integrate with card-based layouts or when
/// buttons should have elevated, card-like presentation with appropriate shadows
/// and surface styling.
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

/// Concrete implementation providing predefined button styling variants.
///
/// [ButtonVariance] defines the core button styles used throughout the shadcn_flutter
/// framework, implementing [AbstractButtonStyle] with state-dependent properties
/// for consistent visual design. Each static variant provides a complete styling
/// definition including decoration, padding, text styles, and interaction states.
///
/// The class provides predefined variants matching the shadcn design system:
/// - [primary]: High-emphasis actions with filled background
/// - [secondary]: Medium-emphasis actions with subtle background  
/// - [outline]: Actions with border emphasis
/// - [ghost]: Minimal actions with hover states
/// - [link]: Text-like actions with underline
/// - [text]: Simple text-based actions
/// - [destructive]: Warning/danger actions with red theming
/// - [fixed]: Static appearance for stable UI elements
/// - [menu]: Specialized for dropdown and context menus
/// - [menubar]: Optimized for menu bar layouts
/// - [muted]: Subdued actions with reduced emphasis
/// - [card]: Card-style actions with elevation
///
/// Each variant integrates with the theme system through [ComponentThemeButtonStyle]
/// wrappers that allow customization while providing sensible fallbacks.
///
/// Example:
/// ```dart
/// Button(
///   style: ButtonVariance.primary,
///   onPressed: () => save(),
///   child: Text('Save'),
/// );
/// 
/// Button(
///   style: ButtonVariance.outline,
///   onPressed: () => cancel(),
///   child: Text('Cancel'),
/// );
/// ```
class ButtonVariance implements AbstractButtonStyle {
  /// Primary button style for the most important actions.
  ///
  /// Provides high visual emphasis with filled background and contrasting text,
  /// suitable for primary actions like "Save", "Submit", or "Continue". Uses
  /// the theme's primary color with appropriate hover and focus states.
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
  
  /// Secondary button style for supporting actions.
  ///
  /// Provides medium visual emphasis with subtle background fill, suitable
  /// for secondary actions that complement the primary action. Uses muted
  /// colors with gentle hover effects for balanced visual hierarchy.
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
  
  /// Outline button style with border emphasis.
  ///
  /// Features a transparent background with visible border, providing clear
  /// action boundaries without heavy visual weight. Suitable for alternative
  /// actions or when multiple buttons need equal visual emphasis.
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
  
  /// Ghost button style with minimal visual presence.
  ///
  /// Provides subtle hover effects without default background or border,
  /// ideal for tertiary actions, toolbar buttons, or contexts where visual
  /// noise should be minimized while maintaining interactivity.
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
  
  /// Link button style resembling clickable text links.
  ///
  /// Styled to appear as hyperlinks with underline decoration and link colors,
  /// suitable for navigation actions, external links, or actions that should
  /// feel like text-based interactions rather than traditional buttons.
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
  
  /// Text button style for minimal, text-only actions.
  ///
  /// Appears as plain text with subtle hover effects, suitable for actions
  /// that should integrate seamlessly with text content or provide minimal
  /// visual distraction while maintaining clear interactivity.
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
  
  /// Destructive button style for dangerous or irreversible actions.
  ///
  /// Uses warning colors (typically red-based) to signal potentially harmful
  /// actions like deletion, removal, or destructive operations. Provides clear
  /// visual warning while maintaining standard button interaction patterns.
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

  /// Fixed button style with consistent appearance across states.
  ///
  /// Maintains static visual appearance with minimal state-based changes,
  /// suitable for navigation tabs, status indicators, or UI elements that
  /// need predictable styling regardless of interaction state.
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

  /// Menu button style optimized for dropdown and context menu items.
  ///
  /// Provides styling appropriate for menu contexts with compact padding,
  /// full-width hover effects, and styling that integrates well with menu
  /// containers and popup overlays.
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

  /// Menu bar button style for horizontal menu bar layouts.
  ///
  /// Specialized variant of menu styling with adjusted padding and spacing
  /// optimized for menu bar contexts. Provides consistent appearance across
  /// menu bar items while maintaining clear hover feedback.
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

  /// Muted button style with subdued visual emphasis.
  ///
  /// Provides reduced visual prominence using muted colors and subtle
  /// interactions, suitable for secondary actions that should remain
  /// accessible but not compete for attention with primary interface elements.
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

  /// Card button style with elevated appearance and card-like presentation.
  ///
  /// Features elevation, rounded corners, and styling that matches card components,
  /// suitable for button-like actions that should appear as interactive cards
  /// or when buttons need to integrate with card-based layouts.
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

  /// The decoration (background, border, shadows) applied based on button state.
  @override
  final ButtonStateProperty<Decoration> decoration;
  
  /// The mouse cursor displayed when hovering over the button.
  @override
  final ButtonStateProperty<MouseCursor> mouseCursor;
  
  /// The internal padding between the button border and content.
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> padding;
  
  /// The text styling applied to text content within the button.
  @override
  final ButtonStateProperty<TextStyle> textStyle;
  
  /// The icon theme data applied to icons within the button.
  @override
  final ButtonStateProperty<IconThemeData> iconTheme;
  
  /// The external margin around the button.
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> margin;

  /// Creates a [ButtonVariance] with the specified state-dependent properties.
  ///
  /// All parameters are required [ButtonStateProperty] functions that return
  /// appropriate values based on the button's current widget states.
  ///
  /// Parameters:
  /// - [decoration]: Background, border, and shadow styling
  /// - [mouseCursor]: Cursor appearance on hover
  /// - [padding]: Internal spacing around content
  /// - [textStyle]: Text appearance and typography
  /// - [iconTheme]: Icon styling and colors
  /// - [margin]: External spacing around button
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

/// A button state property that returns the same value for all states.
///
/// [ButtonStylePropertyAll] is a utility class that implements a constant
/// [ButtonStateProperty], returning the same value regardless of the button's
/// widget states. This is useful when a property should remain consistent
/// across all interaction states (hover, pressed, focused, etc.).
///
/// The class is callable and can be used directly as a [ButtonStateProperty]
/// function while providing better debugging information than anonymous functions.
///
/// Example:
/// ```dart
/// // Create a constant red color for all button states
/// final redColor = ButtonStylePropertyAll(Colors.red);
/// 
/// // Use in button styling
/// ButtonStyle(
///   backgroundColor: redColor, // Always red, regardless of state
/// )
/// ```
class ButtonStylePropertyAll<T> {
  /// The constant value returned for all button states.
  final T value;

  /// Creates a [ButtonStylePropertyAll] with the specified constant value.
  ///
  /// The [value] will be returned by [call] regardless of the button's
  /// current widget states.
  const ButtonStylePropertyAll(this.value);

  /// Returns the constant [value] for any context and widget states.
  ///
  /// This method implements the [ButtonStateProperty] function signature,
  /// ignoring the [context] and [states] parameters and always returning
  /// the stored [value].
  ///
  /// Parameters:
  /// - [context]: Build context (ignored)
  /// - [states]: Button widget states (ignored)  
  /// - [value]: Base value (ignored, replaced with stored value)
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

/// Extension methods for [AbstractButtonStyle] providing style modification capabilities.
///
/// [ButtonStyleExtension] adds convenient methods to button styles for creating
/// modified copies with selectively overridden properties. This enables
/// composition and customization of existing button styles without creating
/// entirely new style definitions.
///
/// The [copyWith] method accepts [ButtonStatePropertyDelegate] functions that
/// can modify existing property values based on context and state, allowing
/// for sophisticated style customizations that build upon base styles.
extension ButtonStyleExtension on AbstractButtonStyle {
  /// Creates a copy of this button style with selectively overridden properties.
  ///
  /// Each parameter is an optional [ButtonStatePropertyDelegate] that receives
  /// the current context, widget states, and the original property value,
  /// returning a modified value. This allows for additive modifications rather
  /// than complete replacement of styling properties.
  ///
  /// If no overrides are provided, returns the original style unchanged for
  /// performance optimization.
  ///
  /// Parameters:
  /// - [decoration]: Override function for background/border styling
  /// - [mouseCursor]: Override function for cursor appearance
  /// - [padding]: Override function for internal spacing
  /// - [textStyle]: Override function for text appearance
  /// - [iconTheme]: Override function for icon styling
  /// - [margin]: Override function for external spacing
  ///
  /// Example:
  /// ```dart
  /// final customStyle = ButtonVariance.primary.copyWith(
  ///   decoration: (context, states, baseDecoration) {
  ///     // Add extra border radius to primary style
  ///     if (baseDecoration is BoxDecoration) {
  ///       return baseDecoration.copyWith(
  ///         borderRadius: BorderRadius.circular(16),
  ///       );
  ///     }
  ///     return baseDecoration;
  ///   },
  ///   padding: (context, states, basePadding) {
  ///     // Add extra padding when pressed
  ///     if (states.contains(WidgetState.pressed)) {
  ///       return basePadding + EdgeInsets.all(2);
  ///     }
  ///     return basePadding;
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
/// A convenient primary button widget with preset styling and common parameters.
///
/// [PrimaryButton] provides a simplified API for creating primary action buttons
/// without the need to explicitly specify the button style. It wraps the base
/// [Button] widget with [ButtonStyle.primary] and exposes commonly-used parameters
/// as direct properties for ease of use.
///
/// This widget is ideal for developers who want the straightforward button creation
/// experience without dealing with style configuration. It automatically handles
/// primary button appearance while providing access to size, density, shape, and
/// all interaction callbacks.
///
/// ## Key Features
/// - **Preset Primary Styling**: Automatically uses primary button appearance
/// - **Simplified API**: Direct properties instead of style configuration
/// - **Full Feature Access**: All button features available through direct parameters
/// - **Size and Shape Options**: Configurable size, density, and shape properties
/// - **Complete Interaction Support**: All gesture callbacks and focus management
///
/// Example:
/// ```dart
/// PrimaryButton(
///   onPressed: () => submitForm(),
///   leading: Icon(Icons.send),
///   size: ButtonSize.large,
///   child: Text('Submit Form'),
/// );
/// ```
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

  /// Creates a [PrimaryButton] with primary styling and configurable properties.
  ///
  /// This constructor provides a convenient way to create primary action buttons
  /// without manually configuring button styles. The button automatically uses
  /// primary colors and styling from the current theme while allowing customization
  /// of size, density, shape, and all interaction behaviors.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The main content displayed in the button
  /// - [onPressed] (VoidCallback?, optional): Primary action callback
  /// - [enabled] (bool?, optional): Whether button accepts input
  /// - [leading] (Widget?, optional): Widget displayed before main content
  /// - [trailing] (Widget?, optional): Widget displayed after main content  
  /// - [alignment] (AlignmentGeometry?, optional): Content alignment within button
  /// - [size] (ButtonSize, default: normal): Size variant for button dimensions
  /// - [density] (ButtonDensity, default: normal): Spacing density setting
  /// - [shape] (ButtonShape, default: rectangle): Border radius configuration
  /// - [focusNode] (FocusNode?, optional): Focus management node
  /// - [disableTransition] (bool, default: false): Whether to skip animations
  ///
  /// Example:
  /// ```dart
  /// PrimaryButton(
  ///   onPressed: () => _handleSubmit(),
  ///   leading: Icon(Icons.check),
  ///   size: ButtonSize.large,
  ///   child: Text('Submit'),
  /// );
  /// ```
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

/// A convenient secondary button widget with muted styling for supporting actions.
///
/// [SecondaryButton] provides a simplified API for creating secondary action buttons
/// with preset secondary styling. It wraps the base [Button] widget with 
/// [ButtonStyle.secondary] and exposes all commonly-used parameters as direct 
/// properties for streamlined development.
///
/// Secondary buttons use muted background colors and medium contrast, making them
/// suitable for actions that are important but not primary. They provide clear
/// visual hierarchy while being less prominent than primary buttons.
///
/// ## Key Features
/// - **Preset Secondary Styling**: Automatically uses secondary button appearance
/// - **Muted Visual Weight**: Less prominent than primary buttons but still visible
/// - **Full Feature Support**: Access to all button features through direct properties
/// - **Theme Integration**: Adapts to theme changes and dark/light mode switches
/// - **Comprehensive Gestures**: Complete support for all interaction patterns
///
/// Example:
/// ```dart
/// SecondaryButton(
///   onPressed: () => showMoreOptions(),
///   leading: Icon(Icons.more_horiz),
///   size: ButtonSize.small,
///   child: Text('More Options'),
/// );
/// ```
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

  /// Creates a [SecondaryButton] with secondary styling for supporting actions.
  ///
  /// Provides a streamlined interface for creating buttons with secondary visual
  /// treatment. The button uses muted colors and subtle backgrounds that provide
  /// clear functionality without competing with primary actions.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main button content
  /// - [onPressed] (VoidCallback?, optional): Action callback when pressed
  /// - [enabled] (bool?, optional): Whether button responds to interactions
  /// - [leading] (Widget?, optional): Content shown before main child
  /// - [trailing] (Widget?, optional): Content shown after main child
  /// - [alignment] (AlignmentGeometry?, optional): Content positioning
  /// - [size] (ButtonSize, default: normal): Button size variant
  /// - [density] (ButtonDensity, default: normal): Padding density setting
  /// - [shape] (ButtonShape, default: rectangle): Border radius styling
  ///
  /// Example:
  /// ```dart
  /// SecondaryButton(
  ///   onPressed: () => _handleCancel(),
  ///   child: Text('Cancel'),
  /// );
  /// ```
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

/// A convenient outline button widget with border styling for clear secondary actions.
///
/// [OutlineButton] provides a simplified interface for creating buttons with outline
/// styling - transparent backgrounds with visible borders. This creates clear visual
/// hierarchy while maintaining excellent contrast and accessibility across different
/// themes and backgrounds.
///
/// Outline buttons are perfect for secondary actions that need clear visibility but
/// shouldn't compete with primary actions. The border treatment provides definition
/// while the transparent interior keeps visual weight appropriate for supporting roles.
///
/// ## Key Features  
/// - **Preset Outline Styling**: Automatic outline appearance with theme colors
/// - **Excellent Contrast**: Clear visibility across light and dark themes
/// - **Secondary Action Design**: Appropriate visual weight for supporting actions
/// - **Border Animations**: Smooth transitions for hover and focus states
/// - **Accessibility Optimized**: High contrast borders meet accessibility guidelines
///
/// Example:
/// ```dart
/// OutlineButton(
///   onPressed: () => showDialog(context: context, builder: _buildDialog),
///   leading: Icon(Icons.info_outline),
///   child: Text('More Info'),
/// );
/// ```
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

/// A convenient ghost button widget with minimal styling for subtle interactions.
///
/// [GhostButton] provides an easy way to create buttons with ghost styling - minimal
/// visual treatment that becomes visible on interaction. These buttons have no background
/// by default and only show subtle effects on hover, focus, and press states.
///
/// Ghost buttons are ideal for actions that should be available but not prominent,
/// such as utility functions, navigation aids, or any interaction that shouldn't
/// draw attention away from primary content. They integrate seamlessly with text
/// and provide functionality without visual noise.
///
/// ## Key Features
/// - **Minimal Visual Impact**: Nearly invisible until interaction
/// - **Subtle State Feedback**: Gentle hover and focus effects  
/// - **Content Integration**: Blends naturally with surrounding text and content
/// - **Flexible Usage**: Perfect for toolbars, navigation, and utility functions
/// - **Theme Adaptive**: Respects theme colors while maintaining subtlety
///
/// Example:
/// ```dart
/// GhostButton(
///   onPressed: () => _toggleSettings(),
///   leading: Icon(Icons.settings, size: 16),
///   child: Text('Settings'),
/// );
/// ```
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

/// A convenient link button widget with hyperlink appearance for navigation actions.
///
/// [LinkButton] provides a streamlined way to create buttons that appear as hyperlinks
/// with underlines, color changes, and link-like behavior. These buttons integrate
/// seamlessly with text content and provide familiar web-like navigation patterns.
///
/// Link buttons are perfect for actions that conceptually "take you somewhere" such
/// as navigation, cross-references, external links, or any action that users would
/// expect to behave like a traditional web link. The styling includes appropriate
/// hover effects and accessibility features.
///
/// ## Key Features
/// - **Hyperlink Styling**: Familiar underlines and color changes
/// - **Text Integration**: Blends naturally within paragraphs and text content
/// - **Navigation Semantics**: Clear indication of navigation or reference actions
/// - **Accessibility Support**: Proper focus indicators and screen reader support
/// - **Responsive Effects**: Hover and focus states that match user expectations
///
/// Example:
/// ```dart
/// LinkButton(
///   onPressed: () => _navigateToProfile(),
///   child: Text('View Full Profile'),
/// );
/// ```
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

/// A convenient text button widget with plain text appearance for minimal actions.
///
/// [TextButton] offers a simple way to create buttons that appear as plain text
/// with subtle hover effects. These buttons provide the least visual weight while
/// still offering clear interactive feedback, making them perfect for Cancel actions,
/// secondary navigation, or any function that should be available but not prominent.
///
/// Text buttons maintain readability and accessibility while providing minimal
/// visual disruption to content flow. They're particularly useful in dialogs,
/// forms, and dense interfaces where visual simplicity is important.
///
/// ## Key Features
/// - **Minimal Appearance**: Plain text with subtle interaction effects
/// - **Low Visual Weight**: Doesn't compete with other interface elements
/// - **Readable Integration**: Works naturally within text and content layouts
/// - **Accessible Feedback**: Clear hover and focus states despite minimal styling
/// - **Space Efficient**: Takes minimal visual and layout space
///
/// Example:
/// ```dart
/// TextButton(
///   onPressed: () => Navigator.pop(context),
///   child: Text('Cancel'),
/// );
/// ```
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

/// A convenient destructive button widget with warning colors for dangerous actions.
///
/// [DestructiveButton] provides an easy interface for creating buttons that perform
/// destructive or irreversible actions. These buttons use warning colors (typically
/// red variants) to clearly communicate that the action will delete, remove, or
/// otherwise negatively affect user data.
///
/// Destructive buttons are essential for maintaining user trust and preventing
/// accidental data loss. They should be used sparingly and typically paired with
/// confirmation dialogs to ensure user intent before performing dangerous operations.
///
/// ## Key Features
/// - **Warning Color Scheme**: Red/destructive colors that signal danger
/// - **Clear Visual Communication**: Immediately recognizable as potentially harmful
/// - **High Contrast**: Ensures the warning nature is visible across themes
/// - **Confirmation Patterns**: Designed to work with confirmation dialogs
/// - **Accessibility Compliant**: Color choices meet accessibility contrast requirements
///
/// Example:
/// ```dart
/// DestructiveButton(
///   onPressed: () => _showDeleteConfirmation(),
///   leading: Icon(Icons.delete_outline),
///   child: Text('Delete Account'),
/// );
/// ```
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

/// A convenient tab button widget with fixed styling for navigation interfaces.
///
/// [TabButton] provides a simplified interface for creating buttons that function
/// as tab navigation elements. These buttons use fixed styling that maintains
/// consistent appearance regardless of interaction states, making them ideal for
/// tab bars, navigation segments, and other interface elements that need stable
/// visual presentation.
///
/// Tab buttons are designed for contexts where visual consistency is more important
/// than dynamic feedback. They still respond to interactions but with more subdued
/// state changes that don't disrupt the overall navigation interface flow.
///
/// ## Key Features
/// - **Fixed Visual Treatment**: Consistent appearance across interaction states
/// - **Navigation Optimized**: Designed specifically for tab and segment interfaces
/// - **Stable Presentation**: Minimal visual changes preserve layout consistency
/// - **Selection Ready**: Works well with selected/unselected state management
/// - **Interface Integration**: Seamless fit with navigation and segmented controls
///
/// Example:
/// ```dart
/// TabButton(
///   onPressed: () => _selectTab(0),
///   child: Text('Overview'),
/// );
/// ```
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

/// A specialized button widget optimized for icon-only content with multiple style variants.
///
/// [IconButton] provides a complete solution for icon-based interactions with automatic
/// square padding, appropriate sizing, and multiple visual styles. Unlike regular buttons
/// that are optimized for text content, icon buttons ensure icons are properly centered
/// and sized within square or rectangular touch targets.
///
/// The widget supports all major button style variants through named constructors,
/// each automatically configured with icon-appropriate density settings. The button
/// handles icon theming, sizing, and accessibility concerns specific to icon-only
/// interactions.
///
/// ## Key Features
/// - **Icon-Optimized Layout**: Square padding and proper icon centering
/// - **Multiple Style Variants**: Primary, secondary, outline, ghost, link, text, destructive
/// - **Automatic Density**: Uses [ButtonDensity.icon] by default for proper spacing
/// - **Theme Integration**: Icons automatically adapt to button state colors
/// - **Touch Target Compliance**: Maintains appropriate minimum touch target sizes
/// - **Accessibility Support**: Proper semantic labeling and focus management
///
/// ## Usage Patterns
/// Icon buttons are commonly used for:
/// - Toolbar actions and controls
/// - Floating action buttons and quick actions  
/// - Navigation elements and menu triggers
/// - Form controls like clear, visibility toggle
/// - Media controls like play, pause, skip
///
/// Example:
/// ```dart
/// IconButton.primary(
///   onPressed: () => _saveDocument(),
///   icon: Icon(Icons.save),
/// );
/// ```
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

  /// Creates an [IconButton] with custom style variance.
  ///
  /// This base constructor allows complete customization of the icon button's
  /// appearance through the [variance] parameter. It provides access to all
  /// button functionality while optimizing layout and spacing for icon content.
  ///
  /// The button automatically uses [ButtonDensity.icon] to create square padding
  /// that properly centers icon content within the touch target area.
  ///
  /// Parameters:
  /// - [icon] (Widget, required): The icon widget to display
  /// - [variance] (AbstractButtonStyle, required): The button style variant
  /// - [onPressed] (VoidCallback?, optional): Action callback when pressed
  /// - [enabled] (bool?, optional): Whether button accepts interactions
  /// - [size] (ButtonSize, default: normal): Size variant for button dimensions
  /// - [density] (ButtonDensity, default: icon): Padding density (icon optimized)
  /// - [shape] (ButtonShape, default: rectangle): Border radius configuration
  ///
  /// Example:
  /// ```dart
  /// IconButton(
  ///   icon: Icon(Icons.star),
  ///   variance: ButtonVariance.primary,
  ///   onPressed: () => _toggleFavorite(),
  /// );
  /// ```
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

  /// Creates a primary icon button with prominent styling for main actions.
  ///
  /// Primary icon buttons use filled backgrounds with high contrast, making them
  /// suitable for the most important icon-based actions in your interface. They
  /// automatically use [ButtonVariance.primary] with icon-optimized spacing.
  ///
  /// Example:
  /// ```dart
  /// IconButton.primary(
  ///   icon: Icon(Icons.add),
  ///   onPressed: () => _createNew(),
  /// );
  /// ```
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

  /// Creates a secondary icon button with muted styling for supporting actions.
  ///
  /// Secondary icon buttons use subtle backgrounds and medium contrast, making them
  /// suitable for supporting icon actions that should be visible but not compete
  /// with primary actions. Perfect for toolbars and secondary controls.
  ///
  /// Example:
  /// ```dart
  /// IconButton.secondary(
  ///   icon: Icon(Icons.more_vert),
  ///   onPressed: () => _showMenu(),
  /// );
  /// ```
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

  /// Creates an outline icon button with border styling for clear secondary actions.
  ///
  /// Outline icon buttons feature transparent backgrounds with visible borders,
  /// providing excellent contrast and clear definition for secondary icon actions.
  /// Ideal for toolbars where secondary actions need clear visibility.
  ///
  /// Example:
  /// ```dart
  /// IconButton.outline(
  ///   icon: Icon(Icons.edit),
  ///   onPressed: () => _editItem(),
  /// );
  /// ```
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

  /// Creates a ghost icon button with minimal styling for subtle icon interactions.
  ///
  /// Ghost icon buttons have no visible background until interaction, making them
  /// perfect for utility actions, navigation icons, or any icon-based functionality
  /// that should be available but not visually prominent.
  ///
  /// Example:
  /// ```dart
  /// IconButton.ghost(
  ///   icon: Icon(Icons.close),
  ///   onPressed: () => Navigator.pop(context),
  /// );
  /// ```
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

  /// Creates a link icon button with hyperlink styling for navigation actions.
  ///
  /// Link icon buttons appear with link-like styling including hover effects and
  /// appropriate colors. Perfect for navigation icons, external link indicators,
  /// or any icon that represents a navigation or reference action.
  ///
  /// Example:
  /// ```dart
  /// IconButton.link(
  ///   icon: Icon(Icons.open_in_new),
  ///   onPressed: () => _openExternalLink(),
  /// );
  /// ```
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

  /// Creates a text icon button with plain styling for minimal icon interactions.
  ///
  /// Text icon buttons provide the most minimal styling while maintaining clear
  /// interactive feedback. Perfect for icons that should blend into text content
  /// or interfaces where minimal visual impact is desired.
  ///
  /// Example:
  /// ```dart
  /// IconButton.text(
  ///   icon: Icon(Icons.info_outline, size: 16),
  ///   onPressed: () => _showTooltip(),
  /// );
  /// ```
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

  /// Creates a destructive icon button with warning colors for dangerous actions.
  ///
  /// Destructive icon buttons use warning colors (typically red variants) to clearly
  /// indicate that the icon action will delete, remove, or otherwise negatively
  /// affect user data. Essential for maintaining clear communication about risky actions.
  ///
  /// Example:
  /// ```dart
  /// IconButton.destructive(
  ///   icon: Icon(Icons.delete),
  ///   onPressed: () => _confirmDelete(),
  /// );
  /// ```
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

/// A widget that provides button style overrides to descendant button widgets.
///
/// [ButtonStyleOverride] allows you to customize the appearance of multiple buttons
/// within a widget subtree by providing style overrides that are automatically applied
/// to all descendant button widgets. This is particularly useful for theming sections
/// of your UI or applying consistent styling modifications across button groups.
///
/// The widget works by providing a [ButtonStyleOverrideData] through the widget tree
/// that button widgets automatically detect and apply. Style overrides are applied
/// on top of the button's base style, allowing for fine-tuned customization without
/// completely replacing the button's style.
///
/// ## Key Features
/// - **Cascading Overrides**: Styles automatically apply to all descendant buttons
/// - **Additive Styling**: Overrides are applied on top of existing button styles  
/// - **Inheritance Support**: Can inherit and combine with parent overrides
/// - **Selective Overrides**: Override only specific properties (padding, colors, etc.)
/// - **State-Aware**: Support for different styles based on button states
///
/// ## Use Cases
/// - Theming button sections in dark mode overlays
/// - Applying consistent padding modifications to button groups
/// - Customizing button colors for specific interface sections
/// - Implementing design system variants across components
///
/// Example:
/// ```dart
/// ButtonStyleOverride(
///   padding: (context, states, value) => value + EdgeInsets.all(4),
///   textStyle: (context, states, value) => value.copyWith(
///     fontWeight: FontWeight.bold,
///   ),
///   child: Column(
///     children: [
///       Button.primary(child: Text('Bold Primary')),
///       Button.secondary(child: Text('Bold Secondary')), 
///     ],
///   ),
/// );
/// ```
class ButtonStyleOverride extends StatelessWidget {
  /// Whether to inherit overrides from parent ButtonStyleOverride widgets.
  ///
  /// When true, the overrides from this widget are combined with any overrides
  /// from ancestor ButtonStyleOverride widgets. When false, this widget's
  /// overrides completely replace any parent overrides.
  final bool inherit;

  /// Override function for button decoration (background, borders, shadows).
  ///
  /// Takes the context, current states, and base decoration value, allowing
  /// modification of background colors, borders, shadows, and border radius.
  /// Return the modified decoration or the original value unchanged.
  final ButtonStatePropertyDelegate<Decoration>? decoration;

  /// Override function for mouse cursor styling.
  ///
  /// Controls what cursor appears when hovering over buttons. Can be used to
  /// enforce specific cursor types across button groups or disable cursor
  /// changes entirely by returning a fixed cursor type.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;

  /// Override function for button padding.
  ///
  /// Modifies the internal padding between button borders and content. Common
  /// use cases include adding extra padding for touch targets, creating more
  /// compact button groups, or adjusting spacing for specific design requirements.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;

  /// Override function for text styling within buttons.
  ///
  /// Controls font properties, colors, sizes, and text decorations. Can be used
  /// to enforce consistent typography, apply color schemes, or modify text
  /// properties based on button states.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;

  /// Override function for icon theme styling within buttons.
  ///
  /// Controls icon colors, sizes, and opacity within button content. Useful for
  /// ensuring icons match text colors, enforcing consistent icon sizing, or
  /// applying icon-specific styling rules.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;

  /// Override function for button margin.
  ///
  /// Modifies the external spacing around buttons. Can be used to create
  /// consistent spacing in button groups, adjust alignment within layouts,
  /// or apply layout-specific margin adjustments.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// The child widget tree that will receive the button style overrides.
  ///
  /// All button widgets within this subtree will automatically apply the
  /// style overrides provided by this widget. The overrides work additively
  /// with the button's base styling.
  final Widget child;

  /// Creates a [ButtonStyleOverride] that replaces parent overrides.
  ///
  /// This constructor creates style overrides that completely replace any
  /// overrides from parent ButtonStyleOverride widgets. Use when you need
  /// complete control over button styling within a specific subtree.
  ///
  /// Parameters:
  /// - [decoration] (optional): Function to override button decoration
  /// - [mouseCursor] (optional): Function to override mouse cursor
  /// - [padding] (optional): Function to override button padding  
  /// - [textStyle] (optional): Function to override text styling
  /// - [iconTheme] (optional): Function to override icon theme
  /// - [margin] (optional): Function to override button margin
  /// - [child] (required): The widget subtree to apply overrides to
  ///
  /// Example:
  /// ```dart
  /// ButtonStyleOverride(
  ///   textStyle: (context, states, value) => value.copyWith(
  ///     color: Colors.blue,
  ///     fontWeight: FontWeight.w600,
  ///   ),
  ///   child: buttonGroup,
  /// );
  /// ```
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

  /// Creates a [ButtonStyleOverride] that inherits from parent overrides.
  ///
  /// This constructor creates style overrides that combine with any existing
  /// overrides from ancestor ButtonStyleOverride widgets. The combination
  /// allows for layered styling where parent overrides are applied first,
  /// followed by the overrides from this widget.
  ///
  /// Use this when you want to add additional styling on top of existing
  /// theme overrides rather than replacing them entirely.
  ///
  /// Parameters: Same as the main constructor.
  ///
  /// Example:
  /// ```dart
  /// ButtonStyleOverride.inherit(
  ///   padding: (context, states, value) => value + EdgeInsets.all(2),
  ///   child: specificButtonGroup,
  /// );
  /// ```
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

/// Data class containing button style override functions.
///
/// [ButtonStyleOverrideData] encapsulates the style override functions that can
/// be applied to button widgets. Each property is a function that takes the current
/// context, widget states, and base value, then returns a modified value.
///
/// This class is used internally by [ButtonStyleOverride] to pass override
/// functions through the widget tree via the Data inheritance system. Button
/// widgets automatically detect and apply these overrides when present.
///
/// The override functions work additively with the button's base style - they
/// receive the computed base value and can modify it as needed rather than
/// replacing it entirely.
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
