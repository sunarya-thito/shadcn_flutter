---
title: "Class: NumberTicker"
description: "A widget that smoothly animates between numeric values with customizable display."
---

```dart
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
  const NumberTicker.builder({super.key, this.initialNumber, required this.number, required this.builder, this.child, this.duration, this.curve});
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
  const NumberTicker({super.key, this.initialNumber, required this.number, required this.formatter, this.duration, this.curve, this.style});
  Widget build(BuildContext context);
}
```
