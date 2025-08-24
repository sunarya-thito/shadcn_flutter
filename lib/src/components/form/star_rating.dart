import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [StarRating] widget appearance and behavior.
///
/// [StarRatingTheme] provides comprehensive styling options for star rating
/// components including colors for filled and unfilled states, star sizing,
/// and spacing between individual stars. It integrates with the shadcn_flutter
/// theming system to ensure consistent star rating styling across applications.
///
/// The theme supports customization of visual feedback, accessibility, and
/// responsive sizing to create star rating interfaces that match your
/// application's design system and user experience requirements.
///
/// Example:
/// ```dart
/// ComponentTheme<StarRatingTheme>(
///   data: StarRatingTheme(
///     activeColor: Colors.amber,
///     backgroundColor: Colors.grey.shade300,
///     starSize: 24.0,
///     starSpacing: 4.0,
///   ),
///   child: StarRating(
///     value: 4.5,
///     onChanged: (rating) => handleRatingChange(rating),
///   ),
/// )
/// ```
class StarRatingTheme {
  /// Color used for the filled portion of stars.
  ///
  /// This color represents the active rating value and should provide
  /// clear visual feedback for the user's rating selection. When null,
  /// uses the theme's primary or accent color for good visibility.
  final Color? activeColor;

  /// Color used for the unfilled portion of stars.
  ///
  /// This color represents the inactive or unselected portion of the rating
  /// scale. Should provide sufficient contrast with the active color while
  /// remaining subtle. When null, uses the theme's muted color.
  final Color? backgroundColor;

  /// Size of each individual star in logical pixels.
  ///
  /// Controls both the width and height of star icons. Consider touch target
  /// guidelines when setting star size - larger sizes improve accessibility
  /// on touch devices. When null, uses a default size appropriate for the
  /// current theme scaling.
  final double? starSize;

  /// Horizontal spacing between adjacent stars in logical pixels.
  ///
  /// Controls the gap between individual star icons in the rating display.
  /// Proper spacing improves visual clarity and makes individual stars easier
  /// to distinguish and tap. When null, uses a default spacing proportional
  /// to the star size.
  final double? starSpacing;

  /// Creates a [StarRatingTheme] with optional styling properties.
  ///
  /// All parameters are optional and fall back to theme defaults when null.
  /// Use this constructor to customize the appearance of star rating components
  /// to match your application's visual design.
  ///
  /// Parameters:
  /// - [activeColor]: Color for filled stars
  /// - [backgroundColor]: Color for unfilled stars  
  /// - [starSize]: Size of each star icon
  /// - [starSpacing]: Gap between stars
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

  final double step;
  final Axis direction;
  final double max;
  final Color? activeColor;
  final Color? backgroundColor;
  final double starPoints;
  final double? starSize;
  final double? starSpacing;
  final double? starPointRounding;
  final double? starValleyRounding;
  final double? starSquash;
  final double? starInnerRadiusRatio;
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
  /// - [onChanged] (ValueChanged<double>?, optional): rating change callback
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
  final double value;
  final ValueChanged<double>? onChanged;
  final double step;
  final Axis direction;
  final double max;
  final Color? activeColor;
  final Color? backgroundColor;
  final double starPoints;
  final double? starSize;
  final double? starSpacing;
  final double? starPointRounding;
  final double? starValleyRounding;
  final double? starSquash;
  final double? starInnerRadiusRatio;
  final double? starRotation;
  final bool? enabled;

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

class IncreaseStarIntent extends Intent {
  final double step;

  const IncreaseStarIntent(this.step);
}

class DecreaseStarIntent extends Intent {
  final double step;

  const DecreaseStarIntent(this.step);
}
