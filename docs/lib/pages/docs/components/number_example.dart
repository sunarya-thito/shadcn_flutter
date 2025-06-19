import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'number_ticker/number_ticker_example_1.dart';

class NumberTickerExample extends StatelessWidget {
  const NumberTickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'number_ticker',
      description:
          'A widget that animates a number from an initial value to a final value.',
      displayName: 'Number Ticker',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/number_ticker/number_ticker_example_1.dart',
          child: NumberTickerExample1(),
        ),
      ],
    );
  }
}
