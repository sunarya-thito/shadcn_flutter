import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A callback that builds a widget based on an animated number value.
///
/// Used by [NumberTicker.builder] to construct custom presentations of the
/// animated number. The [number] parameter contains the current interpolated
/// numeric value, while [child] is an optional widget for optimization.
typedef NumberTickerBuilder = Widget Function(
    BuildContext context, num number, Widget? child);

/// A callback that formats a number into a string representation.
///
/// Used by [NumberTicker] with its default constructor to control how
/// numeric values are displayed as text. This allows for custom formatting
/// such as currency display, percentage formatting, or localized numbers.
typedef NumberTickerFormatted = String Function(num number);

/// Theme configuration for [NumberTicker] widgets.
///
/// Provides default styling values that can be overridden on individual
/// [NumberTicker] instances. This allows for consistent styling across
/// multiple number tickers in an application while still permitting
/// per-instance customization when needed.
///
/// Used with [ComponentTheme] to provide theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<NumberTickerTheme>(
///   data: NumberTickerTheme(
///     duration: Duration(milliseconds: 800),
///     curve: Curves.bounceOut,
///     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
///   ),
///   child: MyApp(),
/// );
/// ```
class NumberTickerTheme {
  /// The default animation duration for number transitions.
  ///
  /// If null, individual [NumberTicker] widgets will use their own duration
  /// or fall back to the default value of 500 milliseconds.
  final Duration? duration;

  /// The default animation curve for number transitions.
  ///
  /// If null, individual [NumberTicker] widgets will use their own curve
  /// or fall back to [Curves.easeInOut].
  final Curve? curve;

  /// The default text style for formatted number display.
  ///
  /// Only used when [NumberTicker] is constructed with a [formatter] function.
  /// If null, the default system text style is used.
  final TextStyle? style;

  /// Creates a [NumberTickerTheme] with the specified styling options.
  ///
  /// Parameters:
  /// - [duration] (Duration?, optional): Default animation duration for transitions.
  /// - [curve] (Curve?, optional): Default easing curve for animations.
  /// - [style] (TextStyle?, optional): Default text style for formatted display.
  ///
  /// All parameters are optional and will fall back to widget-level defaults
  /// or system defaults when not specified.
  const NumberTickerTheme({this.duration, this.curve, this.style});

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Parameters:
  /// - [duration] (`ValueGetter<Duration?>?`, optional): New duration value.
  /// - [curve] (`ValueGetter<Curve?>?`, optional): New curve value.
  /// - [style] (`ValueGetter<TextStyle?>?`, optional): New text style value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   duration: () => Duration(seconds: 1),
  ///   style: () => TextStyle(color: Colors.blue),
  /// );
  /// ```
  NumberTickerTheme copyWith({
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<TextStyle?>? style,
  }) {
    return NumberTickerTheme(
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      style: style == null ? this.style : style(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NumberTickerTheme &&
        other.duration == duration &&
        other.curve == curve &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(duration, curve, style);
}

/// A widget that smoothly animates between numeric values with customizable display.
///
/// [NumberTicker] provides animated transitions when numeric values change,
/// making it ideal for displaying counters, statistics, prices, or any numeric
/// data that changes over time. It offers two construction modes:
///
/// - Default constructor: Uses a formatter function to display numbers as text
/// - [NumberTicker.builder]: Provides a custom builder for complete control
///
/// The animation automatically starts when the [number] value changes, smoothly
/// interpolating between the previous and new values. If [initialNumber] is
/// provided, the widget will animate from that value on first display.
///
/// Supports theming via [NumberTickerTheme] for consistent styling across
/// multiple instances while allowing per-widget customization.
///
/// Example:
/// ```dart
/// NumberTicker(
///   number: _counter,
///   formatter: (num value) => '\$${value.toStringAsFixed(2)}',
///   duration: Duration(milliseconds: 600),
///   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
/// );
/// ```
class NumberTicker extends StatelessWidget {
  /// The initial number value to start animation from.
  ///
  /// If null, no initial animation occurs and the widget starts directly
  /// with the [number] value. When provided, causes an animation from this
  /// initial value to [number] on first build.
  final num? initialNumber;

  /// The target number value to animate to and display.
  ///
  /// When this changes, triggers a smooth animation from the current displayed
  /// value to this new target value. Supports any numeric type (int, double).
  final num number;

  /// Custom builder function for complete display control.
  ///
  /// Used only with [NumberTicker.builder] constructor. Receives the current
  /// animated numeric value and optional child widget. Allows for complex
  /// custom presentations beyond simple text formatting.
  final NumberTickerBuilder? builder;

  /// Optional child widget passed to custom builders.
  ///
  /// Available only when using [NumberTicker.builder]. Passed through to
  /// the builder function for optimization when part of the display remains constant.
  final Widget? child;

  /// Function to format numbers into display strings.
  ///
  /// Used only with default constructor. Called with the current animated
  /// numeric value and must return a string representation for display.
  /// Enables custom formatting like currency, percentages, or localization.
  final NumberTickerFormatted? formatter;

  /// Override duration for this widget's animations.
  ///
  /// If null, uses the duration from [NumberTickerTheme] or defaults to
  /// 500 milliseconds. Controls how long transitions take when [number] changes.
  final Duration? duration;

  /// Override animation curve for this widget.
  ///
  /// If null, uses the curve from [NumberTickerTheme] or defaults to
  /// [Curves.easeInOut]. Controls the timing function of number transitions.
  final Curve? curve;

  /// Override text style for formatted number display.
  ///
  /// Only used with default constructor. If null, uses the style from
  /// [NumberTickerTheme] or system default. Has no effect when using builder.
  final TextStyle? style;

  /// Creates a [NumberTicker] with custom builder for complete display control.
  ///
  /// This constructor provides maximum flexibility by allowing you to define
  /// exactly how the animated number should be presented. The builder receives
  /// the current interpolated numeric value and can construct any widget tree.
  ///
  /// Parameters:
  /// - [initialNumber] (num?, optional): Starting value for first animation.
  /// - [number] (num, required): Target value to animate to and display.
  /// - [builder] (NumberTickerBuilder, required): Custom display builder function.
  /// - [child] (Widget?, optional): Optional child passed to builder for optimization.
  /// - [duration] (Duration?, optional): Override animation duration.
  /// - [curve] (Curve?, optional): Override animation curve.
  ///
  /// Example:
  /// ```dart
  /// NumberTicker.builder(
  ///   number: _score,
  ///   duration: Duration(milliseconds: 400),
  ///   builder: (context, value, child) {
  ///     return Container(
  ///       padding: EdgeInsets.all(8),
  ///       decoration: BoxDecoration(
  ///         color: Colors.green,
  ///         borderRadius: BorderRadius.circular(8),
  ///       ),
  ///       child: Text(
  ///         '${value.toInt()} points',
  ///         style: TextStyle(color: Colors.white, fontSize: 18),
  ///       ),
  ///     );
  ///   },
  /// );
  /// ```
  const NumberTicker.builder({
    super.key,
    this.initialNumber,
    required this.number,
    required this.builder,
    this.child,
    this.duration,
    this.curve,
  })  : formatter = null,
        style = null;

  /// Creates a [NumberTicker] with formatted text display.
  ///
  /// This is the standard constructor that displays animated numbers as text
  /// using a formatting function. The formatter receives the current numeric
  /// value and must return a string representation for display.
  ///
  /// Parameters:
  /// - [initialNumber] (num?, optional): Starting value for first animation.
  /// - [number] (num, required): Target value to animate to and display.
  /// - [formatter] (NumberTickerFormatted, required): Function to format numbers as strings.
  /// - [duration] (Duration?, optional): Override animation duration.
  /// - [curve] (Curve?, optional): Override animation curve.
  /// - [style] (TextStyle?, optional): Override text styling.
  ///
  /// Example:
  /// ```dart
  /// NumberTicker(
  ///   initialNumber: 0,
  ///   number: 1234.56,
  ///   formatter: (value) => NumberFormat.currency(
  ///     locale: 'en_US',
  ///     symbol: '\$',
  ///   ).format(value),
  ///   duration: Duration(milliseconds: 750),
  ///   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  /// );
  /// ```
  const NumberTicker({
    super.key,
    this.initialNumber,
    required this.number,
    required this.formatter,
    this.duration,
    this.curve,
    this.style,
  })  : builder = null,
        child = null;

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<NumberTickerTheme>(context);
    final duration = styleValue(
      widgetValue: this.duration,
      themeValue: compTheme?.duration,
      defaultValue: const Duration(milliseconds: 500),
    );
    final curve = styleValue(
      widgetValue: this.curve,
      themeValue: compTheme?.curve,
      defaultValue: Curves.easeInOut,
    );
    if (formatter != null) {
      final textStyle = styleValue(
        widgetValue: style,
        themeValue: compTheme?.style,
        defaultValue: null,
      );
      return AnimatedValueBuilder(
        value: number.toDouble(),
        duration: duration,
        curve: curve,
        initialValue: initialNumber?.toDouble(),
        builder: (context, value, child) {
          return Text(
            formatter!(value),
            style: textStyle,
          );
        },
      );
    }
    return AnimatedValueBuilder(
      value: number.toDouble(),
      duration: duration,
      curve: curve,
      initialValue: initialNumber?.toDouble(),
      builder: (context, value, child) {
        return builder!(context, value, child);
      },
      child: child,
    );
  }
}
