import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'overflow_marquee/overflow_marquee_example_1.dart';

class OverflowMarqueeExample extends StatelessWidget {
  const OverflowMarqueeExample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'overflow_marquee',
      description:
          'A widget that displays a marquee text that overflows its container.',
      displayName: 'Overflow Marquee',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: OverflowMarqueeExample1(),
          path:
              'lib/pages/docs/components/overflow_marquee/overflow_marquee_example_1.dart',
        ),
      ],
    );
  }
}
