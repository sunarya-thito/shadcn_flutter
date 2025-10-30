---
title: "Class: NumberTickerTheme"
description: "Theme configuration for [NumberTicker] widgets."
---

```dart
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
  NumberTickerTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<TextStyle?>? style});
  bool operator ==(Object other);
  int get hashCode;
}
```
