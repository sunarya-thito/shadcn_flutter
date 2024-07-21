import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef NumberTickerBuilder = Widget Function(
    BuildContext context, num number, Widget? child);
typedef NumberTickerFormatted = String Function(num number);

class NumberTicker extends StatelessWidget {
  final num? initialNumber;
  final num number;
  final NumberTickerBuilder? builder;
  final Widget? child;
  final NumberTickerFormatted? formatter;
  final Duration duration;
  final Curve curve;
  final TextStyle? style;

  const NumberTicker.builder({
    super.key,
    this.initialNumber,
    required this.number,
    required this.builder,
    this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
  })  : formatter = null,
        style = null;

  const NumberTicker({
    super.key,
    this.initialNumber,
    required this.number,
    required this.formatter,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.style,
  })  : builder = null,
        child = null;

  @override
  Widget build(BuildContext context) {
    if (formatter != null) {
      return AnimatedValueBuilder(
        value: number.toDouble(),
        duration: duration,
        curve: curve,
        initialValue: initialNumber?.toDouble(),
        builder: (context, value, child) {
          return Text(
            formatter!(value),
            style: style,
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
