import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'card/card_example_1.dart';

class CardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'card',
      description:
          'Cards are surfaces that display content and actions on a single topic.',
      displayName: 'Card',
      children: [
        WidgetUsageExample(
          child: CardExample1(),
          path: 'lib/pages/docs/components/card/card_example_1.dart',
        ),
      ],
    );
  }
}
