import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class NumberTickerTile extends StatelessWidget implements IComponentPage {
  const NumberTickerTile({super.key});

  @override
  String get title => 'Number Ticker';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'number_ticker',
      title: 'Number Ticker',
      scale: 1.2,
      example: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RepeatedAnimationBuilder(
            start: 0.0,
            end: 1234567.0,
            mode: RepeatMode.pingPong,
            duration: const Duration(seconds: 5),
            builder: (context, value, child) {
              return Text(
                NumberFormat.compact().format(value),
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          Transform.translate(
            offset: const Offset(0, -16),
            child: RepeatedAnimationBuilder(
              start: 1234567.0,
              end: 0.0,
              mode: RepeatMode.pingPong,
              duration: const Duration(seconds: 5),
              builder: (context, value, child) {
                return Text(
                  NumberFormat.compact().format(value),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.mutedForeground,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
