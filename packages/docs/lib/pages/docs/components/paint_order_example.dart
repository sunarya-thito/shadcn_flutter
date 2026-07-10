import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'paint_order/paint_order_example_1.dart';
import 'paint_order/paint_order_example_2.dart';
import 'paint_order/paint_order_example_3.dart';

class PaintOrderExample extends StatelessWidget {
  const PaintOrderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'paint_order',
      description:
          'A widget that controls the paint order of children in a Row, Column, or Flex without affecting layout.',
      displayName: 'Paint Order',
      children: [
        WidgetUsageExample(
          title: 'Basic Paint Order',
          path:
              'lib/pages/docs/components/paint_order/paint_order_example_1.dart',
          child: PaintOrderExample1(),
        ),
        WidgetUsageExample(
          title: 'Interactive Paint Order (Row)',
          path:
              'lib/pages/docs/components/paint_order/paint_order_example_2.dart',
          child: PaintOrderExample2(),
        ),
        WidgetUsageExample(
          title: 'Interactive Paint Order (Stack)',
          path:
              'lib/pages/docs/components/paint_order/paint_order_example_3.dart',
          child: PaintOrderExample3(),
        ),
      ],
    );
  }
}
