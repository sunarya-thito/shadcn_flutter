import 'package:flutter/services.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

import '../../../shadcn_flutter.dart';

/// Standard duration for switch state transitions and animations.
const kSwitchDuration = Duration(milliseconds: 100);

/// Theme configuration for [Switch] widget styling and visual appearance.
///
/// Defines the visual properties used by switch components including colors,
/// spacing, and border styling for different switch states. All properties are
/// optional and fall back to framework defaults when not specified.
///
/// Supports comprehensive customization of switch appearance including track
/// colors, thumb colors, and layout properties to match application design.
class SwitchTheme {
  /// Color of the switch track when in the active/on state.
  ///
  /// Applied as the background color of the switch track when toggled on.
  /// When null, uses the theme's primary color for visual consistency.
  final Color? activeColor;

  /// Color of the switch track when in the inactive/off state.
  ///
  /// Applied as the background color of the switch track when toggled off.
  /// When null, uses the theme's muted color for visual hierarchy.
  final Color? inactiveColor;

  /// Color of the switch thumb when in the active/on state.
  ///
  /// Applied to the circular thumb element when the switch is toggled on.
  /// When null, uses the theme's primary foreground color for contrast.
  final Color? activeThumbColor;

  /// Color of the switch thumb when in the inactive/off state.
  ///
  /// Applied to the circular thumb element when the switch is toggled off.
  /// When null, uses a contrasting color against the inactive track.
  final Color? inactiveThumbColor;

  /// Spacing between the switch and its leading/trailing widgets.
  ///
  /// Applied on both sides of the switch when leading or trailing widgets
  /// are provided. When null, defaults to framework spacing standards.
  final double? gap;

  /// Border radius applied to the switch track corners.
  ///
  /// Creates rounded corners on the switch track container. When null,
  /// uses a fully rounded appearance typical of toggle switches.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [SwitchTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  /// The theme can be applied to individual switches or globally through
  /// the component theme system.
  const SwitchTheme({
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.gap,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  SwitchTheme copyWith({
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? inactiveColor,
    ValueGetter<Color?>? activeThumbColor,
    ValueGetter<Color?>? inactiveThumbColor,
    ValueGetter<double?>? gap,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return SwitchTheme(
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      inactiveColor:
          inactiveColor == null ? this.inactiveColor : inactiveColor(),
      activeThumbColor:
          activeThumbColor == null ? this.activeThumbColor : activeThumbColor(),
      inactiveThumbColor: inactiveThumbColor == null
          ? this.inactiveThumbColor
          : inactiveThumbColor(),
      gap: gap == null ? this.gap : gap(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwitchTheme &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.activeThumbColor == activeThumbColor &&
        other.inactiveThumbColor == inactiveThumbColor &&
        other.gap == gap &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        activeColor,
        inactiveColor,
        activeThumbColor,
        inactiveThumbColor,
        gap,
        borderRadius,
      );
}

/// Reactive controller for managing switch state with convenient methods.
///
/// Extends [ValueNotifier] to provide state management for switch widgets
/// with built-in toggle functionality. Supports programmatic control and
/// reactive updates to switch state.
///
/// The controller can be used with [ControlledSwitch] for reactive state
/// management or manually to coordinate switch behavior across widgets.
///
/// Example:
/// ```dart
/// final controller = SwitchController(false);
/// 
/// // React to changes
/// controller.addListener(() {
///   print('Switch is now: ${controller.value ? "on" : "off"}');
/// });
/// 
/// // Programmatic control
/// controller.toggle(); // false -> true
/// controller.value = false; // Direct assignment
/// ```
class SwitchController extends ValueNotifier<bool>
    with ComponentController<bool> {
  /// Creates a [SwitchController] with the specified initial [value].
  ///
  /// The controller will notify listeners whenever the switch state changes
  /// through toggle operations or direct value assignment. Defaults to `false`
  /// (off state) if no initial value is provided.
  SwitchController([super.value = false]);

  /// Toggles the switch state between on and off.
  ///
  /// If currently true (on), becomes false (off). If currently false (off),
  /// becomes true (on). Notifies listeners of the state change.
  void toggle() {
    value = !value;
  }
}

/// Reactive switch with automatic state management and controller support.
///
/// A higher-level switch widget that provides automatic state management
/// through the controlled component pattern. Can be used with an external
/// [SwitchController] for programmatic control or with callback-based
/// state management.
///
/// Supports all switch features including leading/trailing widgets, custom
/// colors, and comprehensive theming. The widget automatically handles form
/// integration and accessibility features.
///
/// ## Usage Patterns
///
/// **Controlled mode** with external state:
/// ```dart
/// final controller = SwitchController(true);
/// 
/// ControlledSwitch(
///   controller: controller,
///   leading: Text('Enable notifications'),
///   onChanged: (value) => print('Toggled to $value'),
/// );
/// ```
///
/// **Callback mode** with local state management:
/// ```dart
/// bool isEnabled = false;
/// 
/// ControlledSwitch(
///   initialValue: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
///   trailing: Icon(isEnabled ? Icons.check : Icons.close),
/// );
/// ```
///
/// **Form integration** with automatic validation:
/// ```dart
/// ControlledSwitch(
///   initialValue: false,
///   leading: Text('Accept terms'),
///   onChanged: (value) {
///     // Automatically integrates with parent Form widgets
///     // for validation and state management
///   },
/// );
/// ```
class ControlledSwitch extends StatelessWidget with ControlledComponent<bool> {
  /// The controller for managing switch state programmatically.
  ///
  /// When provided, the controller's value takes precedence over [initialValue].
  /// The controller will be notified of state changes and can be used to
  /// programmatically update the switch state.
  @override
  final SwitchController? controller;

  /// The initial value when no controller is provided.
  ///
  /// Used as the starting state for callback-based state management.
  /// Ignored when [controller] is provided. Defaults to `false` (off state).
  @override
  final bool initialValue;

  /// Callback invoked when the switch state changes.
  ///
  /// Called with the new boolean value whenever the user toggles the switch.
  /// Required for the switch to be interactive; when null, the switch becomes
  /// read-only.
  @override
  final ValueChanged<bool>? onChanged;

  /// Whether the switch is enabled for user interaction.
  ///
  /// When false, the switch becomes non-interactive and appears visually
  /// disabled. When true or when [onChanged] is provided, the switch is
  /// interactive. Defaults to true.
  @override
  final bool enabled;

  /// Widget displayed before the switch control.
  ///
  /// Typically used for labels, icons, or other descriptive content.
  /// Positioned to the start of the switch based on text direction.
  final Widget? leading;

  /// Widget displayed after the switch control.
  ///
  /// Often used for additional context, status indicators, or secondary actions.
  /// Positioned to the end of the switch based on text direction.
  final Widget? trailing;

  /// Spacing between switch and leading/trailing widgets.
  ///
  /// Applied on both sides when leading or trailing widgets are present.
  /// When null, uses the gap from [SwitchTheme] or framework defaults.
  final double? gap;

  /// Color of the switch track when in the active/on state.
  ///
  /// When null, uses the activeColor from [SwitchTheme] or theme primary color.
  final Color? activeColor;

  /// Color of the switch track when in the inactive/off state.
  ///
  /// When null, uses the inactiveColor from [SwitchTheme] or theme muted color.
  final Color? inactiveColor;

  /// Color of the switch thumb when in the active/on state.
  ///
  /// When null, uses the activeThumbColor from [SwitchTheme] or contrasting color.
  final Color? activeThumbColor;

  /// Color of the switch thumb when in the inactive/off state.
  ///
  /// When null, uses the inactiveThumbColor from [SwitchTheme] or contrasting color.
  final Color? inactiveThumbColor;

  /// Border radius applied to the switch track corners.
  ///
  /// When null, uses the borderRadius from [SwitchTheme] or fully rounded corners.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [ControlledSwitch].
  ///
  /// Either [controller] or [onChanged] should be provided for the switch to
  /// be interactive. When using [controller], the [initialValue] is ignored.
  ///
  /// Example:
  /// ```dart
  /// ControlledSwitch(
  ///   initialValue: false,
  ///   onChanged: (value) => handleToggle(value),
  ///   leading: Text('Dark mode'),
  ///   activeColor: Colors.indigo,
  /// );
  /// ```
  const ControlledSwitch({
    super.key,
    this.controller,
    this.initialValue = false,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Switch(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          leading: leading,
          trailing: trailing,
          gap: gap,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          activeThumbColor: activeThumbColor,
          inactiveThumbColor: inactiveThumbColor,
          borderRadius: borderRadius,
        );
      },
    );
  }
}

/// A toggle switch widget with smooth animations and comprehensive styling options.
///
/// [Switch] provides a classic toggle control with smooth thumb animations,
/// customizable colors, and support for leading/trailing widgets. The switch
/// animates between on and off states with configurable track and thumb colors.
///
/// ## Visual Design
/// The switch consists of two main elements:
/// - **Track**: The background rail that contains the thumb
/// - **Thumb**: The circular indicator that slides between positions
///
/// Both elements support independent color customization for active and inactive
/// states, allowing for rich visual themes and accessibility compliance.
///
/// ## Interaction Patterns
/// The switch responds to:
/// - **Tap gestures**: Toggle state on track or thumb tap
/// - **Keyboard navigation**: Space/Enter key activation when focused
/// - **Accessibility**: Full screen reader support with semantic labels
///
/// ## State Management
/// Unlike [ControlledSwitch], this widget requires explicit state management
/// through the [onChanged] callback. It integrates automatically with form
/// systems for validation and data collection.
///
/// Example:
/// ```dart
/// bool _darkMode = false;
/// 
/// Switch(
///   value: _darkMode,
///   onChanged: (value) => setState(() => _darkMode = value),
///   leading: Icon(Icons.dark_mode),
///   trailing: Text(_darkMode ? 'On' : 'Off'),
///   activeColor: Colors.indigo,
///   inactiveColor: Colors.grey[300],
/// );
/// ```
///
/// ## Accessibility Features
/// - Semantic role announcement for switch purpose
/// - State change announcements for screen readers
/// - Keyboard focus indication with visual outline
/// - High contrast support through color customization
class Switch extends StatefulWidget {
  /// The current value of the switch.
  ///
  /// When true, the switch is in the "on" position with active styling.
  /// When false, the switch is in the "off" position with inactive styling.
  final bool value;

  /// Callback invoked when the switch state changes.
  ///
  /// Called with the new boolean value when the user toggles the switch.
  /// Required for the switch to be interactive; when null, the switch becomes
  /// read-only and appears disabled.
  final ValueChanged<bool>? onChanged;

  /// Widget displayed before the switch control.
  ///
  /// Typically used for labels, icons, or descriptive content. The leading
  /// widget is positioned according to text direction (start side).
  final Widget? leading;

  /// Widget displayed after the switch control.
  ///
  /// Often used for status indicators, additional context, or secondary actions.
  /// The trailing widget is positioned according to text direction (end side).
  final Widget? trailing;

  /// Whether the switch is enabled for user interaction.
  ///
  /// When false, the switch becomes non-interactive and appears visually disabled
  /// with reduced opacity. When null, enablement is determined by the presence
  /// of [onChanged]. Defaults to true when [onChanged] is provided.
  final bool? enabled;

  /// Spacing between the switch and leading/trailing widgets.
  ///
  /// Applied as horizontal spacing on both sides when leading or trailing widgets
  /// are present. When null, uses [SwitchTheme.gap] or framework defaults.
  final double? gap;

  /// Color of the switch track when in the active/on state.
  ///
  /// Applied as the background color of the switch track when [value] is true.
  /// When null, uses [SwitchTheme.activeColor] or theme primary color.
  final Color? activeColor;

  /// Color of the switch track when in the inactive/off state.
  ///
  /// Applied as the background color of the switch track when [value] is false.
  /// When null, uses [SwitchTheme.inactiveColor] or theme muted color.
  final Color? inactiveColor;

  /// Color of the switch thumb when in the active/on state.
  ///
  /// Applied to the circular thumb element when [value] is true. Should provide
  /// sufficient contrast against [activeColor] for accessibility.
  /// When null, uses [SwitchTheme.activeThumbColor] or contrasting color.
  final Color? activeThumbColor;

  /// Color of the switch thumb when in the inactive/off state.
  ///
  /// Applied to the circular thumb element when [value] is false. Should provide
  /// sufficient contrast against [inactiveColor] for accessibility.
  /// When null, uses [SwitchTheme.inactiveThumbColor] or contrasting color.
  final Color? inactiveThumbColor;

  /// Border radius applied to the switch track corners.
  ///
  /// Creates rounded corners on the switch track background. When null, uses
  /// [SwitchTheme.borderRadius] or fully rounded appearance typical of switches.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [Switch].
  ///
  /// The [value] parameter is required and represents the current switch state.
  /// The [onChanged] callback should be provided for interactive switches.
  ///
  /// Example with basic configuration:
  /// ```dart
  /// Switch(
  ///   value: isEnabled,
  ///   onChanged: (newValue) => setState(() => isEnabled = newValue),
  /// );
  /// ```
  ///
  /// Example with full customization:
  /// ```dart
  /// Switch(
  ///   value: _notifications,
  ///   onChanged: _handleNotificationToggle,
  ///   leading: Icon(Icons.notifications),
  ///   trailing: Text(_notifications ? 'On' : 'Off'),
  ///   activeColor: Colors.green,
  ///   inactiveColor: Colors.red[100],
  ///   activeThumbColor: Colors.white,
  ///   inactiveThumbColor: Colors.grey[600],
  ///   gap: 12.0,
  /// );
  /// ```
  const Switch({
    super.key,
    required this.value,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.borderRadius,
  });

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> with FormValueSupplier<bool, Switch> {
  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void didUpdateWidget(covariant Switch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(bool value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<SwitchTheme>(context);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 8 * scaling);
    final activeColor = styleValue(
        widgetValue: widget.activeColor,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final inactiveColor = styleValue(
        widgetValue: widget.inactiveColor,
        themeValue: compTheme?.inactiveColor,
        defaultValue: theme.colorScheme.input);
    final activeThumbColor = styleValue(
        widgetValue: widget.activeThumbColor,
        themeValue: compTheme?.activeThumbColor,
        defaultValue: theme.colorScheme.background);
    final inactiveThumbColor = styleValue(
        widgetValue: widget.inactiveThumbColor,
        themeValue: compTheme?.inactiveThumbColor,
        defaultValue: theme.colorScheme.foreground);
    final borderRadius = styleValue<BorderRadiusGeometry>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusXl));
    return FocusOutline(
      focused: _focusing && _enabled,
      borderRadius: optionallyResolveBorderRadius(context, borderRadius) ??
          BorderRadius.circular(theme.radiusXl),
      child: GestureDetector(
        onTap: _enabled
            ? () {
                widget.onChanged?.call(!widget.value);
              }
            : null,
        child: FocusableActionDetector(
          enabled: _enabled,
          onShowFocusHighlight: (value) {
            setState(() {
              _focusing = value;
            });
          },
          actions: {
            ActivateIntent: CallbackAction(
              onInvoke: (Intent intent) {
                widget.onChanged?.call(!widget.value);
                return true;
              },
            ),
          },
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          },
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leading != null) widget.leading!,
              if (widget.leading != null) SizedBox(width: gap),
              AnimatedContainer(
                duration: kSwitchDuration,
                width: (32 + 4) * scaling,
                height: (16 + 4) * scaling,
                padding: EdgeInsets.all(2 * scaling),
                decoration: BoxDecoration(
                  borderRadius:
                      optionallyResolveBorderRadius(context, borderRadius) ??
                          BorderRadius.circular(theme.radiusXl),
                  color: !_enabled
                      ? theme.colorScheme.muted
                      : widget.value
                          ? activeColor
                          : inactiveColor,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: kSwitchDuration,
                      curve: Curves.easeInOut,
                      left: widget.value ? 16 * scaling : 0,
                      top: 0,
                      bottom: 0,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(theme.radiusLg),
                            color: !_enabled
                                ? theme.colorScheme.mutedForeground
                                : widget.value
                                    ? activeThumbColor
                                    : inactiveThumbColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null) SizedBox(width: gap),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
