import '../../../shadcn_flutter.dart';

/// Theme configuration for [Checkbox] widget styling and visual appearance.
///
/// Defines the visual properties used by checkbox components including colors,
/// dimensions, spacing, and border styling. All properties are optional and
/// fall back to framework defaults when not specified.
///
/// Can be applied globally through [ComponentTheme] or used to override
/// specific checkbox instances with custom styling.
class CheckboxTheme {
  /// Color of the checkbox background when in unchecked state.
  ///
  /// Applied as the background color when the checkbox is unchecked.
  /// When null, uses a semi-transparent version of the theme's input background color.
  final Color? backgroundColor;

  /// Color of the checkbox background when in checked state.
  ///
  /// Applied as both background and border color when the checkbox is checked.
  /// When null, uses the theme's primary color.
  final Color? activeColor;

  /// Color of the checkbox border when in unchecked state.
  ///
  /// Only visible when the checkbox is unchecked or in indeterminate state.
  /// When null, uses the theme's border color.
  final Color? borderColor;

  /// Size of the checkbox square in logical pixels.
  ///
  /// Controls both width and height of the checkbox square. The checkmark
  /// and indeterminate indicator are scaled proportionally. When null,
  /// defaults to 16 logical pixels scaled by theme scaling factor.
  final double? size;

  /// Spacing between the checkbox and its leading/trailing widgets.
  ///
  /// Applied on both sides of the checkbox square when leading or trailing
  /// widgets are provided. When null, defaults to 8 logical pixels scaled
  /// by theme scaling factor.
  final double? gap;

  /// Border radius applied to the checkbox square corners.
  ///
  /// Creates rounded corners on the checkbox container. When null, uses
  /// the theme's small border radius (typically 4 logical pixels).
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [CheckboxTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  /// The theme can be applied to individual checkboxes or globally through
  /// the component theme system.
  const CheckboxTheme({
    this.backgroundColor,
    this.activeColor,
    this.borderColor,
    this.size,
    this.gap,
    this.borderRadius,
  });

  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = theme.copyWith(
  ///   activeColor: () => Colors.green,
  ///   size: () => 20.0,
  /// );
  /// ```
  CheckboxTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? size,
    ValueGetter<double?>? gap,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return CheckboxTheme(
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      size: size == null ? this.size : size(),
      gap: gap == null ? this.gap : gap(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckboxTheme &&
        other.backgroundColor == backgroundColor &&
        other.activeColor == activeColor &&
        other.borderColor == borderColor &&
        other.size == size &&
        other.gap == gap &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        activeColor,
        borderColor,
        size,
        gap,
        borderRadius,
      );
}

/// Reactive controller for managing checkbox state with convenient methods.
///
/// Extends [ValueNotifier] to provide state management for checkbox widgets
/// with built-in methods for common state transitions. Supports all three
/// checkbox states: checked, unchecked, and indeterminate.
///
/// The controller can be used with [ControlledCheckbox] for reactive state
/// management or manually to coordinate checkbox behavior across widgets.
///
/// Example:
/// ```dart
/// final controller = CheckboxController(CheckboxState.unchecked);
///
/// // React to changes
/// controller.addListener(() {
///   print('Checkbox is now: ${controller.value}');
/// });
///
/// // Programmatic control
/// controller.toggle(); // unchecked -> checked
/// controller.indeterminate(); // -> indeterminate
/// ```
class CheckboxController extends ValueNotifier<CheckboxState>
    with ComponentController<CheckboxState> {
  /// Creates a [CheckboxController] with the specified initial [value].
  ///
  /// The controller will notify listeners whenever the checkbox state changes
  /// through any of the provided methods or direct value assignment.
  CheckboxController(super.value);

  /// Sets the checkbox state to checked.
  ///
  /// Notifies listeners of the state change. Equivalent to setting
  /// `value = CheckboxState.checked`.
  void check() {
    value = CheckboxState.checked;
  }

  /// Sets the checkbox state to unchecked.
  ///
  /// Notifies listeners of the state change. Equivalent to setting
  /// `value = CheckboxState.unchecked`.
  void uncheck() {
    value = CheckboxState.unchecked;
  }

  /// Sets the checkbox state to indeterminate.
  ///
  /// Notifies listeners of the state change. Used for tri-state checkboxes
  /// to indicate a partially selected or mixed state.
  void indeterminate() {
    value = CheckboxState.indeterminate;
  }

  /// Toggles between checked and unchecked states.
  ///
  /// If currently checked, becomes unchecked. If currently unchecked or
  /// indeterminate, becomes checked. Does not cycle through indeterminate state.
  void toggle() {
    value = value == CheckboxState.checked
        ? CheckboxState.unchecked
        : CheckboxState.checked;
  }

  /// Cycles through all three states in order: checked -> unchecked -> indeterminate.
  ///
  /// Provides complete tri-state cycling behavior. Use this instead of [toggle]
  /// when working with tri-state checkboxes that need to support indeterminate state.
  void toggleTristate() {
    value = value == CheckboxState.checked
        ? CheckboxState.unchecked
        : value == CheckboxState.unchecked
            ? CheckboxState.indeterminate
            : CheckboxState.checked;
  }

  /// Returns true if the checkbox is currently checked.
  bool get isChecked => value == CheckboxState.checked;

  /// Returns true if the checkbox is currently unchecked.
  bool get isUnchecked => value == CheckboxState.unchecked;

  /// Returns true if the checkbox is currently in indeterminate state.
  bool get isIndeterminate => value == CheckboxState.indeterminate;
}

/// Reactive checkbox with automatic state management and controller support.
///
/// A higher-level checkbox widget that provides automatic state management
/// through the controlled component pattern. Can be used with an external
/// [CheckboxController] for programmatic control or with callback-based
/// state management.
///
/// Supports all checkbox features including tri-state behavior, leading/trailing
/// widgets, and comprehensive theming. The widget automatically handles focus,
/// enabled states, and form integration.
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state management):**
/// ```dart
/// final controller = CheckboxController(CheckboxState.unchecked);
///
/// ControlledCheckbox(
///   controller: controller,
///   tristate: true,
///   leading: Text('Accept terms'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// bool checked = false;
///
/// ControlledCheckbox(
///   initialValue: checked ? CheckboxState.checked : CheckboxState.unchecked,
///   onChanged: (state) => setState(() {
///     checked = state == CheckboxState.checked;
///   }),
///   trailing: Text('Newsletter subscription'),
/// )
/// ```
class ControlledCheckbox extends StatelessWidget
    with ControlledComponent<CheckboxState> {
  /// External controller for programmatic state management.
  ///
  /// When provided, takes precedence over [initialValue] and [onChanged].
  /// The controller's state changes are automatically reflected in the widget.
  @override
  final CheckboxController? controller;

  /// Initial checkbox state when no controller is provided.
  ///
  /// Used only when [controller] is null. Defaults to [CheckboxState.unchecked].
  @override
  final CheckboxState initialValue;

  /// Callback fired when the checkbox state changes.
  ///
  /// Called with the new [CheckboxState] when user interaction occurs.
  /// If both [controller] and [onChanged] are provided, both will receive updates.
  @override
  final ValueChanged<CheckboxState>? onChanged;

  /// Whether the checkbox is interactive.
  ///
  /// When false, the checkbox becomes read-only and visually disabled.
  /// When null, automatically determines enabled state based on [onChanged] or [controller].
  @override
  final bool enabled;

  /// Optional widget displayed before the checkbox square.
  ///
  /// Commonly used for labels or icons. Automatically styled with small and
  /// medium text styles for consistency.
  final Widget? leading;

  /// Optional widget displayed after the checkbox square.
  ///
  /// Commonly used for labels, descriptions, or additional controls.
  /// Automatically styled with small and medium text styles for consistency.
  final Widget? trailing;

  /// Whether the checkbox supports three states including indeterminate.
  ///
  /// When true, clicking cycles through: checked -> unchecked -> indeterminate -> checked.
  /// When false, only toggles between checked and unchecked. Defaults to false.
  final bool tristate;

  /// Override size of the checkbox square in logical pixels.
  ///
  /// When null, uses the theme size or framework default (16px scaled).
  final double? size;

  /// Override spacing between checkbox and leading/trailing widgets.
  ///
  /// When null, uses the theme gap or framework default (8px scaled).
  final double? gap;

  /// Override color of the checkbox background when in unchecked state.
  ///
  /// When null, uses a semi-transparent version of the theme's input background color.
  final Color? backgroundColor;

  /// Override color of the checkbox when checked.
  ///
  /// When null, uses the theme active color or primary color.
  final Color? activeColor;

  /// Override color of the checkbox border when unchecked.
  ///
  /// When null, uses the theme border color or framework border color.
  final Color? borderColor;

  /// Override border radius of the checkbox square.
  ///
  /// When null, uses the theme border radius or small radius (4px).
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [ControlledCheckbox].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns depending on application architecture needs.
  ///
  /// Parameters:
  /// - [controller] (CheckboxController?, optional): external state controller
  /// - [initialValue] (CheckboxState, default: unchecked): starting state when no controller
  /// - [onChanged] (`ValueChanged<CheckboxState>?`, optional): state change callback
  /// - [enabled] (bool, default: true): whether checkbox is interactive
  /// - [leading] (Widget?, optional): widget displayed before checkbox
  /// - [trailing] (Widget?, optional): widget displayed after checkbox
  /// - [tristate] (bool, default: false): whether to support indeterminate state
  /// - [size] (double?, optional): override checkbox square size
  /// - [gap] (double?, optional): override spacing around checkbox
  /// - [backgroundColor] (Color?, optional): override unchecked state color
  /// - [activeColor] (Color?, optional): override checked state color
  /// - [borderColor] (Color?, optional): override border color
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override corner radius
  ///
  /// Example:
  /// ```dart
  /// ControlledCheckbox(
  ///   controller: controller,
  ///   tristate: true,
  ///   leading: Icon(Icons.star),
  ///   trailing: Text('Favorite'),
  /// )
  /// ```
  const ControlledCheckbox({
    super.key,
    this.controller,
    this.initialValue = CheckboxState.unchecked,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.tristate = false,
    this.size,
    this.gap,
    this.backgroundColor,
    this.activeColor,
    this.borderColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<CheckboxState>(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Checkbox(
          state: data.value,
          onChanged: data.onChanged,
          leading: leading,
          trailing: trailing,
          enabled: data.enabled,
          tristate: tristate,
          size: size,
          gap: gap,
          backgroundColor: backgroundColor,
          activeColor: activeColor,
          borderColor: borderColor,
          borderRadius: borderRadius,
        );
      },
    );
  }
}

/// Represents the possible states of a checkbox widget.
///
/// Supports the standard checked/unchecked binary states as well as an
/// indeterminate state commonly used to represent partial selection in
/// hierarchical or grouped checkbox scenarios.
///
/// The enum implements [Comparable] to provide consistent ordering:
/// checked < unchecked < indeterminate (based on declaration order).
enum CheckboxState implements Comparable<CheckboxState> {
  /// The checkbox is selected/checked state.
  ///
  /// Visually represented with a checkmark icon inside the checkbox square.
  /// Indicates the associated option or value is selected/enabled.
  checked,

  /// The checkbox is unselected/unchecked state.
  ///
  /// Visually represented as an empty checkbox square with border.
  /// Indicates the associated option or value is not selected/disabled.
  unchecked,

  /// The checkbox is in a partially selected/indeterminate state.
  ///
  /// Visually represented with a small square inside the checkbox.
  /// Typically used in hierarchical structures to indicate some but not
  /// all child items are selected, or when the state is unknown/mixed.
  indeterminate;

  /// Compares checkbox states based on their declaration order.
  ///
  /// Returns negative if this state comes before [other], zero if equal,
  /// positive if this state comes after [other] in the enum declaration.
  @override
  int compareTo(CheckboxState other) {
    return index.compareTo(other.index);
  }
}

/// Core checkbox widget with comprehensive theming and interaction support.
///
/// A low-level checkbox implementation that provides direct state control
/// and extensive customization options. Supports all three checkbox states,
/// smooth animations, accessibility features, and form integration.
///
/// ## Features
///
/// - **Tri-state support**: checked, unchecked, and indeterminate states
/// - **Smooth animations**: animated checkmark drawing and state transitions
/// - **Comprehensive theming**: colors, sizing, spacing, and border customization
/// - **Accessibility**: proper semantics, focus management, and keyboard support
/// - **Form integration**: automatic form field registration and validation support
/// - **Layout flexibility**: leading/trailing widgets with automatic styling
///
/// For most use cases, consider [ControlledCheckbox] which provides higher-level
/// state management. Use this widget directly when you need fine-grained control
/// over the checkbox behavior and lifecycle.
///
/// Example:
/// ```dart
/// Checkbox(
///   state: CheckboxState.checked,
///   onChanged: (newState) {
///     setState(() => currentState = newState);
///   },
///   tristate: true,
///   leading: Icon(Icons.security),
///   trailing: Text('Enable security features'),
/// )
/// ```
class Checkbox extends StatefulWidget {
  /// Current state of the checkbox.
  ///
  /// Must be one of [CheckboxState.checked], [CheckboxState.unchecked], or
  /// [CheckboxState.indeterminate]. The widget rebuilds when this changes
  /// to reflect the new visual state with appropriate animations.
  final CheckboxState state;

  /// Callback fired when the user interacts with the checkbox.
  ///
  /// Called with the new [CheckboxState] that should be applied. When null,
  /// the checkbox becomes non-interactive and visually disabled.
  ///
  /// The callback is responsible for updating the parent widget's state
  /// to reflect the change - this widget does not manage its own state.
  final ValueChanged<CheckboxState>? onChanged;

  /// Optional widget displayed before the checkbox square.
  ///
  /// Commonly used for icons or primary labels. The widget is automatically
  /// styled with small and medium text styles for visual consistency.
  /// Spacing between leading widget and checkbox is controlled by [gap].
  final Widget? leading;

  /// Optional widget displayed after the checkbox square.
  ///
  /// Commonly used for labels, descriptions, or secondary information.
  /// The widget is automatically styled with small and medium text styles
  /// for visual consistency. Spacing is controlled by [gap].
  final Widget? trailing;

  /// Whether the checkbox supports indeterminate state cycling.
  ///
  /// When true, user interaction cycles through: checked -> unchecked -> indeterminate.
  /// When false, only toggles between checked and unchecked states.
  /// The indeterminate state can still be set programmatically regardless of this setting.
  final bool tristate;

  /// Whether the checkbox is interactive and enabled.
  ///
  /// When false, the checkbox becomes visually disabled and non-interactive.
  /// When null, the enabled state is automatically determined from the presence
  /// of an [onChanged] callback.
  final bool? enabled;

  /// Size of the checkbox square in logical pixels.
  ///
  /// Overrides the theme default. When null, uses [CheckboxTheme.size] or
  /// framework default (16 logical pixels scaled by theme scaling factor).
  final double? size;

  /// Spacing between the checkbox and its leading/trailing widgets.
  ///
  /// Overrides the theme default. Applied on both sides when leading or trailing
  /// widgets are present. When null, uses [CheckboxTheme.gap] or framework default.
  final double? gap;

  /// Color of the checkbox background when in unchecked state.
  ///
  /// Overrides the theme default. Applied as the background color when unchecked.
  /// When null, uses a semi-transparent version of the theme's input background color.
  final Color? backgroundColor;

  /// Color used for the checkbox when in checked state.
  ///
  /// Overrides the theme default. Applied as both background and border color
  /// when checked. When null, uses [CheckboxTheme.activeColor] or theme primary color.
  final Color? activeColor;

  /// Color used for the checkbox border when unchecked or indeterminate.
  ///
  /// Overrides the theme default. Only visible in unchecked state as checked
  /// state uses [activeColor]. When null, uses [CheckboxTheme.borderColor] or theme border color.
  final Color? borderColor;

  /// Border radius applied to the checkbox square.
  ///
  /// Overrides the theme default. Creates rounded corners on the checkbox container.
  /// When null, uses [CheckboxTheme.borderRadius] or theme small radius.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [Checkbox] widget.
  ///
  /// The [state] and [onChanged] parameters work together to provide controlled
  /// component behavior - the widget displays the provided state and notifies
  /// of user interactions through the callback.
  ///
  /// Parameters:
  /// - [state] (CheckboxState, required): current checkbox state to display
  /// - [onChanged] (`ValueChanged<CheckboxState>?`, required): interaction callback
  /// - [leading] (Widget?, optional): widget displayed before checkbox
  /// - [trailing] (Widget?, optional): widget displayed after checkbox
  /// - [tristate] (bool, default: false): enable indeterminate state cycling
  /// - [enabled] (bool?, optional): override interactivity (null = auto-detect)
  /// - [size] (double?, optional): override checkbox square size
  /// - [gap] (double?, optional): override spacing around checkbox
  /// - [backgroundColor] (Color?, optional): override unchecked state color
  /// - [activeColor] (Color?, optional): override checked state color
  /// - [borderColor] (Color?, optional): override border color
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override corner radius
  ///
  /// Example:
  /// ```dart
  /// Checkbox(
  ///   state: isAccepted ? CheckboxState.checked : CheckboxState.unchecked,
  ///   onChanged: (state) => setState(() {
  ///     isAccepted = state == CheckboxState.checked;
  ///   }),
  ///   trailing: Text('I accept the terms and conditions'),
  /// )
  /// ```
  const Checkbox({
    super.key,
    required this.state,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.tristate = false,
    this.enabled,
    this.size,
    this.gap,
    this.backgroundColor,
    this.activeColor,
    this.borderColor,
    this.borderRadius,
  });

  @override
  State<Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox>
    with FormValueSupplier<CheckboxState, Checkbox> {
  final bool _focusing = false;
  bool _shouldAnimate = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.state;
  }

  void _changeTo(CheckboxState state) {
    if (widget.onChanged != null) {
      widget.onChanged!(state);
    }
  }

  void _tap() {
    if (widget.tristate) {
      switch (widget.state) {
        case CheckboxState.checked:
          _changeTo(CheckboxState.unchecked);
          break;
        case CheckboxState.unchecked:
          _changeTo(CheckboxState.indeterminate);
          break;
        case CheckboxState.indeterminate:
          _changeTo(CheckboxState.checked);
          break;
      }
    } else {
      _changeTo(
        widget.state == CheckboxState.checked
            ? CheckboxState.unchecked
            : CheckboxState.checked,
      );
    }
  }

  @override
  void didReplaceFormValue(CheckboxState value) {
    _changeTo(value);
  }

  @override
  void didUpdateWidget(covariant Checkbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      formValue = widget.state;
      _shouldAnimate = true;
    }
  }

  bool get enabled => widget.enabled ?? widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<CheckboxTheme>(context);
    final size = styleValue(
        widgetValue: widget.size,
        themeValue: compTheme?.size,
        defaultValue: 16 * scaling);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 8 * scaling);
    final backgroundColor = styleValue(
        widgetValue: widget.backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: theme.colorScheme.input.scaleAlpha(0.3));
    final activeColor = styleValue(
        widgetValue: widget.activeColor,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final borderColor = styleValue(
        widgetValue: widget.borderColor,
        themeValue: compTheme?.borderColor,
        defaultValue: theme.colorScheme.border);
    final borderRadius = styleValue<BorderRadiusGeometry>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusSm));
    return Clickable(
      enabled: widget.onChanged != null,
      mouseCursor: enabled
          ? const WidgetStatePropertyAll(SystemMouseCursors.click)
          : const WidgetStatePropertyAll(SystemMouseCursors.forbidden),
      onPressed: enabled ? _tap : null,
      enableFeedback: enabled,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) widget.leading!.small().medium(),
          SizedBox(width: gap),
          AnimatedContainer(
            duration: kDefaultDuration,
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: widget.state == CheckboxState.checked
                  ? activeColor
                  : backgroundColor,
              borderRadius:
                  optionallyResolveBorderRadius(context, borderRadius) ??
                      BorderRadius.circular(theme.radiusSm),
              border: Border.all(
                color: !enabled
                    ? theme.colorScheme.muted
                    : widget.state == CheckboxState.checked
                        ? activeColor
                        : borderColor,
                width: (_focusing ? 2 : 1) * scaling,
              ),
            ),
            child: widget.state == CheckboxState.checked
                ? Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      child: SizedBox(
                        width: scaling * 9,
                        height: scaling * 6.5,
                        child: AnimatedValueBuilder(
                          value: 1.0,
                          initialValue: _shouldAnimate ? 0.0 : null,
                          duration: const Duration(milliseconds: 300),
                          curve: const IntervalDuration(
                            start: Duration(milliseconds: 175),
                            duration: Duration(milliseconds: 300),
                          ),
                          builder: (context, value, child) {
                            return CustomPaint(
                              painter: AnimatedCheckPainter(
                                progress: value,
                                color: theme.colorScheme.primaryForeground,
                                strokeWidth: scaling * 1,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: widget.state == CheckboxState.indeterminate
                          ? scaling * 8
                          : 0,
                      height: widget.state == CheckboxState.indeterminate
                          ? scaling * 8
                          : 0,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(theme.radiusXs),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: gap),
          if (widget.trailing != null) widget.trailing!.small().medium(),
        ],
      ),
    );
  }
}

/// Custom painter for drawing animated checkmarks in checkboxes.
///
/// Renders a smooth checkmark animation that draws progressively from left to right
/// in two stroke segments. The animation provides visual feedback when transitioning
/// to the checked state, creating a satisfying user experience.
///
/// The checkmark is drawn as two connected line segments: a shorter diagonal line
/// from bottom-left toward center, and a longer diagonal line from center to top-right.
/// The [progress] parameter controls how much of the checkmark is visible.
///
/// Used internally by [Checkbox] - not typically instantiated directly by consumers.
class AnimatedCheckPainter extends CustomPainter {
  /// Animation progress from 0.0 to 1.0 controlling checkmark visibility.
  ///
  /// At 0.0, no checkmark is visible. At 1.0, the complete checkmark is drawn.
  /// Values between 0.0 and 1.0 show partial drawing progress with smooth transitions.
  final double progress;

  /// Color used to draw the checkmark strokes.
  ///
  /// Typically the primary foreground color to provide contrast against
  /// the checkbox's active background color.
  final Color color;

  /// Width of the checkmark stroke lines in logical pixels.
  ///
  /// Controls the thickness of the drawn checkmark. Usually scaled with
  /// the theme's scaling factor for consistent appearance across screen densities.
  final double strokeWidth;

  /// Creates an [AnimatedCheckPainter].
  ///
  /// All parameters are required as they directly control the checkmark appearance
  /// and animation state. The painter should be recreated when any parameter changes.
  ///
  /// Parameters:
  /// - [progress] (double, required): animation progress 0.0-1.0
  /// - [color] (Color, required): checkmark stroke color
  /// - [strokeWidth] (double, required): stroke thickness in logical pixels
  ///
  /// Example usage within CustomPaint:
  /// ```dart
  /// CustomPaint(
  ///   painter: AnimatedCheckPainter(
  ///     progress: animationValue,
  ///     color: theme.primaryForeground,
  ///     strokeWidth: 2.0,
  ///   ),
  /// )
  /// ```
  AnimatedCheckPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path();
    Offset firstStrokeStart = Offset(0, size.height * 0.5);
    Offset firstStrokeEnd = Offset(size.width * 0.35, size.height);
    Offset secondStrokeStart = firstStrokeEnd;
    Offset secondStrokeEnd = Offset(size.width, 0);
    double firstStrokeLength =
        (firstStrokeEnd - firstStrokeStart).distanceSquared;
    double secondStrokeLength =
        (secondStrokeEnd - secondStrokeStart).distanceSquared;
    double totalLength = firstStrokeLength + secondStrokeLength;

    double normalizedFirstStrokeLength = firstStrokeLength / totalLength;
    double normalizedSecondStrokeLength = secondStrokeLength / totalLength;

    double firstStrokeProgress =
        progress.clamp(0.0, normalizedFirstStrokeLength) /
            normalizedFirstStrokeLength;
    double secondStrokeProgress = (progress - normalizedFirstStrokeLength)
            .clamp(0.0, normalizedSecondStrokeLength) /
        normalizedSecondStrokeLength;
    if (firstStrokeProgress <= 0) {
      return;
    }
    Offset currentPoint =
        Offset.lerp(firstStrokeStart, firstStrokeEnd, firstStrokeProgress)!;
    path.moveTo(firstStrokeStart.dx, firstStrokeStart.dy);
    path.lineTo(currentPoint.dx, currentPoint.dy);
    if (secondStrokeProgress <= 0) {
      canvas.drawPath(path, paint);
      return;
    }
    Offset secondPoint = Offset.lerp(
      secondStrokeStart,
      secondStrokeEnd,
      secondStrokeProgress,
    )!;
    path.lineTo(secondPoint.dx, secondPoint.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedCheckPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
