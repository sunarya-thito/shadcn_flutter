import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing [StarRating] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [StarRating] widgets, including colors for filled and unfilled stars,
/// star sizing, and spacing between stars. These properties can be set
/// at the theme level to provide consistent styling across the application.
class StarRatingTheme {
  /// The color of the filled portion of the stars.
  final Color? activeColor;

  /// The color of the unfilled portion of the stars.
  final Color? backgroundColor;

  /// The size of each star.
  final double? starSize;

  /// The spacing between stars.
  final double? starSpacing;

  /// Creates a [StarRatingTheme].
  const StarRatingTheme({
    this.activeColor,
    this.backgroundColor,
    this.starSize,
    this.starSpacing,
  });

  /// Returns a copy of this theme with the given fields replaced.
  StarRatingTheme copyWith({
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<double?>? starSize,
    ValueGetter<double?>? starSpacing,
  }) {
    return StarRatingTheme(
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      starSize: starSize == null ? this.starSize : starSize(),
      starSpacing: starSpacing == null ? this.starSpacing : starSpacing(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StarRatingTheme &&
        other.activeColor == activeColor &&
        other.backgroundColor == backgroundColor &&
        other.starSize == starSize &&
        other.starSpacing == starSpacing;
  }

  @override
  int get hashCode => Object.hash(
        activeColor,
        backgroundColor,
        starSize,
        starSpacing,
      );
}

/// A controller for managing [StarRating] widget values programmatically.
///
/// This controller extends [ValueNotifier] and implements [ComponentController]
/// to provide a standardized way to control star rating values externally.
/// It allows programmatic manipulation of the rating value and provides
/// change notification capabilities.
///
/// The controller maintains a double value representing the current rating,
/// which is typically in the range of 0.0 to the maximum rating value.
///
/// Example:
/// ```dart
/// final controller = StarRatingController(3.5);
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Rating changed to: ${controller.value}');
/// });
///
/// // Update the rating
/// controller.value = 4.0;
/// ```
class StarRatingController extends ValueNotifier<double>
    with ComponentController<double> {
  /// Creates a [StarRatingController] with the given initial [value].
  ///
  /// The [value] parameter sets the initial rating value. Defaults to 0.0
  /// if not specified. The value should typically be within the range
  /// supported by the star rating widget (0.0 to max value).
  ///
  /// Parameters:
  /// - [value] (double, default: 0.0): Initial rating value
  StarRatingController([super.value = 0.0]);
}

/// Reactive star rating widget with automatic state management and controller support.
///
/// A high-level star rating widget that provides automatic state management through
/// the controlled component pattern. Supports both controller-based and callback-based
/// state management with comprehensive customization options for star appearance,
/// interaction behavior, and rating precision.
///
/// ## Features
///
/// - **Fractional ratings**: Support for decimal values (e.g., 3.5 stars)
/// - **Step control**: Configurable rating increments for precision
/// - **Visual customization**: Comprehensive star shape and appearance options
/// - **Interactive feedback**: Touch and drag support for rating selection
/// - **Form integration**: Automatic validation and form field registration
/// - **Accessibility**: Full screen reader and keyboard navigation support
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = StarRatingController(3.5);
///
/// ControlledStarRating(
///   controller: controller,
///   max: 5.0,
///   step: 0.5,
///   activeColor: Colors.amber,
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// double currentRating = 0.0;
///
/// ControlledStarRating(
///   initialValue: currentRating,
///   onChanged: (rating) => setState(() => currentRating = rating),
///   max: 5.0,
///   step: 1.0,
/// )
/// ```
class ControlledStarRating extends StatelessWidget
    with ControlledComponent<double> {
  @override
  final double initialValue;
  @override
  final ValueChanged<double>? onChanged;
  @override
  final bool enabled;
  @override
  final StarRatingController? controller;

  /// The minimum increment for rating changes.
  ///
  /// When a user interacts with the star rating, the value will snap to
  /// multiples of this step. For example, a step of `0.5` allows half-star
  /// ratings, while `1.0` allows only whole-star ratings.
  final double step;

  /// The layout direction of the stars.
  ///
  /// Stars can be arranged horizontally ([Axis.horizontal]) or vertically
  /// ([Axis.vertical]). Defaults to horizontal.
  final Axis direction;

  /// The maximum rating value.
  ///
  /// Determines how many stars are displayed. For example, `max: 5.0` shows
  /// 5 stars. Defaults to `5.0`.
  final double max;

  /// The color of filled star portions.
  ///
  /// If `null`, uses the theme's primary color.
  final Color? activeColor;

  /// The color of unfilled star portions.
  ///
  /// If `null`, uses a default background color from the theme.
  final Color? backgroundColor;

  /// The number of points per star.
  ///
  /// Controls the star shape. Defaults to `5` for traditional five-pointed
  /// stars. Higher values create stars with more points.
  final double starPoints;

  /// Override size of each star.
  ///
  /// If `null`, uses the default size from the theme.
  final double? starSize;

  /// Override spacing between stars.
  ///
  /// If `null`, uses the default spacing from the theme.
  final double? starSpacing;

  /// Rounding radius for star points.
  ///
  /// Controls how rounded the tips of the star points appear. If `null`,
  /// uses sharp points.
  final double? starPointRounding;

  /// Rounding radius for star valleys.
  ///
  /// Controls how rounded the inner valleys between star points appear.
  /// If `null`, uses sharp valleys.
  final double? starValleyRounding;

  /// Vertical compression factor for stars.
  ///
  /// Values less than `1.0` make stars appear squashed. If `null`, stars
  /// maintain their natural proportions.
  final double? starSquash;

  /// Inner to outer radius ratio for stars.
  ///
  /// Controls the depth of star valleys. Lower values create deeper valleys.
  /// If `null`, uses a default ratio.
  final double? starInnerRadiusRatio;

  /// Rotation angle for stars in radians.
  ///
  /// Rotates each star by this angle. If `null`, stars are not rotated.
  final double? starRotation;

  /// Creates a [ControlledStarRating].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with extensive star appearance customization options.
  ///
  /// Parameters:
  /// - [controller] (StarRatingController?, optional): external state controller
  /// - [initialValue] (double, default: 0.0): starting rating when no controller
  /// - [onChanged] (`ValueChanged<double>?`, optional): rating change callback
  /// - [enabled] (bool, default: true): whether star rating is interactive
  /// - [step] (double, default: 0.5): minimum increment for rating changes
  /// - [direction] (Axis, default: horizontal): layout direction of stars
  /// - [max] (double, default: 5.0): maximum rating value
  /// - [activeColor] (Color?, optional): color of filled star portions
  /// - [backgroundColor] (Color?, optional): color of unfilled star portions
  /// - [starPoints] (double, default: 5): number of points per star
  /// - [starSize] (double?, optional): override size of each star
  /// - [starSpacing] (double?, optional): override spacing between stars
  /// - [starPointRounding] (double?, optional): rounding radius for star points
  /// - [starValleyRounding] (double?, optional): rounding radius for star valleys
  /// - [starSquash] (double?, optional): vertical compression factor
  /// - [starInnerRadiusRatio] (double?, optional): inner to outer radius ratio
  /// - [starRotation] (double?, optional): rotation angle in radians
  ///
  /// Example:
  /// ```dart
  /// ControlledStarRating(
  ///   controller: controller,
  ///   max: 5.0,
  ///   step: 0.1,
  ///   activeColor: Colors.amber,
  ///   backgroundColor: Colors.grey[300],
  /// )
  /// ```
  const ControlledStarRating({
    super.key,
    this.controller,
    this.initialValue = 0.0,
    this.onChanged,
    this.enabled = true,
    this.step = 0.5,
    this.direction = Axis.horizontal,
    this.max = 5.0,
    this.activeColor,
    this.backgroundColor,
    this.starPoints = 5,
    this.starSize,
    this.starSpacing,
    this.starPointRounding,
    this.starValleyRounding,
    this.starSquash,
    this.starInnerRadiusRatio,
    this.starRotation,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return StarRating(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          step: step,
          direction: direction,
          max: max,
          activeColor: activeColor,
          backgroundColor: backgroundColor,
          starPoints: starPoints,
          starSize: starSize,
          starSpacing: starSpacing,
          starPointRounding: starPointRounding,
          starValleyRounding: starValleyRounding,
          starSquash: starSquash,
          starInnerRadiusRatio: starInnerRadiusRatio,
          starRotation: starRotation,
        );
      },
    );
  }
}

/// An interactive star rating widget for collecting user feedback and ratings.
///
/// [StarRating] provides a customizable rating interface using star-shaped
/// indicators that users can tap or drag to select a rating value. The widget
/// supports fractional ratings, customizable star appearance, and both horizontal
/// and vertical orientations.
///
/// Key features:
/// - Interactive star-based rating selection
/// - Support for fractional ratings (e.g., 3.5 stars)
/// - Customizable star shape with points, rounding, and squashing
/// - Horizontal and vertical layout orientations
/// - Configurable step increments for rating precision
/// - Visual feedback with filled/unfilled star indicators
/// - Touch and drag interaction support
/// - Accessibility integration
///
/// The widget displays a series of star shapes that fill based on the current
/// rating value. Users can interact with the stars to select new rating values,
/// with support for fine-grained control through the step parameter.
///
/// Star appearance can be extensively customized:
/// - Number of points per star
/// - Star size and spacing
/// - Point and valley rounding
/// - Star squashing and inner radius ratio
/// - Rotation angle
/// - Fill and background colors
///
/// Example:
/// ```dart
/// StarRating(
///   value: currentRating,
///   max: 5.0,
///   step: 0.5, // Allow half-star ratings
///   onChanged: (rating) => setState(() => currentRating = rating),
///   activeColor: Colors.amber,
///   backgroundColor: Colors.grey[300],
/// );
/// ```
class StarRating extends StatefulWidget {
  /// The current rating value.
  ///
  /// Should be between `0` and [max]. Fractional values are supported.
  final double value;

  /// Callback invoked when the rating changes.
  ///
  /// If `null`, the widget is in read-only mode.
  final ValueChanged<double>? onChanged;

  /// The minimum increment for rating changes.
  ///
  /// When a user interacts with the stars, the value will snap to multiples
  /// of this step. Defaults to `0.5` for half-star precision.
  final double step;

  /// The layout direction of the stars.
  ///
  /// Can be [Axis.horizontal] or [Axis.vertical]. Defaults to horizontal.
  final Axis direction;

  /// The maximum rating value.
  ///
  /// Determines how many stars are displayed. Defaults to `5.0`.
  final double max;

  /// The color of filled star portions.
  ///
  /// If `null`, uses the theme's primary color.
  final Color? activeColor;

  /// The color of unfilled star portions.
  ///
  /// If `null`, uses a default background color from the theme.
  final Color? backgroundColor;

  /// The number of points per star.
  ///
  /// Defaults to `5` for traditional five-pointed stars.
  final double starPoints;

  /// Override size of each star.
  ///
  /// If `null`, uses the default size from the theme.
  final double? starSize;

  /// Override spacing between stars.
  ///
  /// If `null`, uses the default spacing from the theme.
  final double? starSpacing;

  /// Rounding radius for star points.
  ///
  /// Controls how rounded the tips of the star points appear. If `null`,
  /// uses sharp points.
  final double? starPointRounding;

  /// Rounding radius for star valleys.
  ///
  /// Controls how rounded the inner valleys between star points appear.
  /// If `null`, uses sharp valleys.
  final double? starValleyRounding;

  /// Vertical compression factor for stars.
  ///
  /// Values less than `1.0` make stars appear squashed. If `null`, stars
  /// maintain their natural proportions.
  final double? starSquash;

  /// Inner to outer radius ratio for stars.
  ///
  /// Controls the depth of star valleys. Lower values create deeper valleys.
  /// If `null`, uses a default ratio.
  final double? starInnerRadiusRatio;

  /// Rotation angle for stars in radians.
  ///
  /// Rotates each star by this angle. If `null`, stars are not rotated.
  final double? starRotation;

  /// Whether the star rating is interactive.
  ///
  /// When `false`, the widget is in read-only mode. Defaults to `true` if
  /// [onChanged] is provided.
  final bool? enabled;

  /// Creates a [StarRating].
  const StarRating({
    super.key,
    required this.value,
    this.onChanged,
    this.step = 0.5,
    this.direction = Axis.horizontal,
    this.max = 5.0,
    this.activeColor,
    this.backgroundColor,
    this.starPoints = 5,
    this.starSize,
    this.starSpacing,
    this.starPointRounding,
    this.starValleyRounding,
    this.starSquash,
    this.starInnerRadiusRatio,
    this.starRotation,
    this.enabled,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating>
    with FormValueSupplier<double, StarRating> {
  double? _changingValue;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant StarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(double value) {
    widget.onChanged?.call(value);
  }

  Widget _buildStar(BuildContext context, [bool focusBorder = false]) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<StarRatingTheme>(context);
    var starValleyRounding = widget.starValleyRounding ?? 0.0;
    var starSquash = widget.starSquash ?? 0.0;
    var starInnerRadiusRatio = widget.starInnerRadiusRatio ?? 0.4;
    var starRotation = widget.starRotation ?? 0.0;
    var starSize = styleValue(
            widgetValue: widget.starSize,
            themeValue: compTheme?.starSize,
            defaultValue: 24.0) *
        scaling;
    return Container(
      width: starSize,
      height: starSize,
      decoration: ShapeDecoration(
        color: !focusBorder ? Colors.white : null,
        shape: StarBorder(
          points: widget.starPoints,
          pointRounding: widget.starPointRounding ?? (theme.radius / 2),
          valleyRounding: starValleyRounding * theme.radius,
          squash: starSquash,
          innerRadiusRatio: starInnerRadiusRatio,
          rotation: starRotation,
          side: focusBorder && _focused
              ? BorderSide(
                  color: theme.colorScheme.ring,
                  width: 2.0 * scaling,
                  strokeAlign: BorderSide.strokeAlignOutside)
              : BorderSide.none,
        ),
      ),
    );
  }

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    double roundedValue =
        ((_changingValue ?? widget.value) / widget.step).round() * widget.step;
    return AnimatedValueBuilder(
      value: roundedValue,
      duration: kDefaultDuration,
      builder: (context, roundedValue, child) {
        final theme = Theme.of(context);
        final scaling = theme.scaling;
        final compTheme = ComponentTheme.maybeOf<StarRatingTheme>(context);
        var starSize = styleValue(
            widgetValue: widget.starSize,
            themeValue: compTheme?.starSize,
            defaultValue: 24.0 * scaling);
        var starSpacing = styleValue(
            widgetValue: widget.starSpacing,
            themeValue: compTheme?.starSpacing,
            defaultValue: 5.0 * scaling);
        var activeColor = styleValue(
            widgetValue: widget.activeColor,
            themeValue: compTheme?.activeColor,
            defaultValue: _enabled
                ? theme.colorScheme.primary
                : theme.colorScheme.mutedForeground);
        var backgroundColor = styleValue(
            widgetValue: widget.backgroundColor,
            themeValue: compTheme?.backgroundColor,
            defaultValue: theme.colorScheme.muted);
        return FocusableActionDetector(
          enabled: _enabled,
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          onShowFocusHighlight: (showFocus) {
            setState(() {
              _focused = showFocus;
            });
          },
          onShowHoverHighlight: (showHover) {
            if (!showHover) {
              setState(() {
                _changingValue = null;
              });
            }
          },
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.arrowRight):
                IncreaseStarIntent(widget.step),
            LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                DecreaseStarIntent(widget.step),
          },
          actions: {
            IncreaseStarIntent: CallbackAction<IncreaseStarIntent>(
              onInvoke: (intent) {
                if (widget.onChanged != null) {
                  widget.onChanged!(
                      (roundedValue + intent.step).clamp(0.0, widget.max));
                }
                return;
              },
            ),
            DecreaseStarIntent: CallbackAction<DecreaseStarIntent>(
              onInvoke: (intent) {
                if (widget.onChanged != null) {
                  widget.onChanged!(
                      (roundedValue - intent.step).clamp(0.0, widget.max));
                }
                return;
              },
            ),
          },
          child: MouseRegion(
            onHover: (event) {
              if (!_enabled) return;
              if (widget.onChanged == null) return;
              double size = context.size!.width;
              double progress = (event.localPosition.dx / size).clamp(0.0, 1.0);
              double newValue = (progress * widget.max).clamp(0.0, widget.max);
              setState(() {
                _changingValue = newValue;
              });
            },
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (widget.onChanged != null && roundedValue != widget.value) {
                  widget.onChanged!(roundedValue);
                }
              },
              onTapDown: (details) {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                double totalStarSize =
                    starSize + (starSpacing * (widget.max.ceil() - 1));
                double progress =
                    (details.localPosition.dx / totalStarSize).clamp(0.0, 1.0);
                double newValue =
                    (progress * widget.max).clamp(0.0, widget.max);
                widget.onChanged!(newValue);
              },
              onPanUpdate: (details) {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                int totalStars = widget.max.ceil();
                double totalStarSize =
                    starSize * totalStars + (starSpacing * (totalStars - 1));
                double progress =
                    (details.localPosition.dx / totalStarSize).clamp(0.0, 1.0);
                double newValue =
                    (progress * widget.max).clamp(0.0, widget.max);
                setState(() {
                  _changingValue = newValue;
                });
              },
              onPanEnd: (details) {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                widget.onChanged!(_changingValue ?? roundedValue);
                setState(() {
                  _changingValue = null;
                });
              },
              onPanCancel: () {
                if (!_enabled) return;
                if (widget.onChanged == null) return;
                widget.onChanged!(_changingValue ?? roundedValue);
                setState(() {
                  _changingValue = null;
                });
              },
              child: Flex(
                direction: widget.direction,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.max.ceil(); i++)
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [
                                activeColor,
                                backgroundColor,
                              ],
                              stops: [
                                (roundedValue - i).clamp(0.0, 1.0),
                                (roundedValue - i).clamp(0.0, 1.0),
                              ],
                              begin: widget.direction == Axis.horizontal
                                  ? Alignment.centerLeft
                                  : Alignment.bottomCenter,
                              end: widget.direction == Axis.horizontal
                                  ? Alignment.centerRight
                                  : Alignment.topCenter,
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcIn,
                          child: _buildStar(context),
                        ),
                        _buildStar(context, true),
                      ],
                    ),
                ],
              ).gap(starSpacing),
            ),
          ),
        );
      },
    );
  }
}

/// Intent for increasing the star rating value via keyboard shortcuts.
///
/// Used with Flutter's shortcuts and actions system to handle keyboard
/// input for incrementing the rating. Typically bound to right arrow key.
class IncreaseStarIntent extends Intent {
  /// The step size to increase the rating by.
  final double step;

  /// Creates an [IncreaseStarIntent].
  const IncreaseStarIntent(this.step);
}

/// Intent for decreasing the star rating value via keyboard shortcuts.
///
/// Used with Flutter's shortcuts and actions system to handle keyboard
/// input for decrementing the rating. Typically bound to left arrow key.
class DecreaseStarIntent extends Intent {
  /// The step size to decrease the rating by.
  final double step;

  /// Creates a [DecreaseStarIntent].
  const DecreaseStarIntent(this.step);
}
