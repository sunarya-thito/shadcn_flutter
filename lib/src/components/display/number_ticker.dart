import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef NumberTickerBuilder = Widget Function(
    BuildContext context, num number, Widget? child);
typedef NumberTickerFormatted = String Function(num number);

/// Theme for [NumberTicker].
class NumberTickerTheme {
  /// The animation duration.
  final Duration? duration;

  /// The animation curve.
  final Curve? curve;

  /// The text style when [formatter] is used.
  final TextStyle? style;

  /// Creates a [NumberTickerTheme].
  const NumberTickerTheme({this.duration, this.curve, this.style});

  /// Creates a copy of this theme with the given values replaced.
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

class NumberTicker extends StatelessWidget {
  final num? initialNumber;
  final num number;
  final NumberTickerBuilder? builder;
  final Widget? child;
  final NumberTickerFormatted? formatter;
  final Duration? duration;
  final Curve? curve;
  final TextStyle? style;

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
