import 'package:docs/pages/docs/components/swiper/swiper_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SwiperExample extends StatelessWidget {
  const SwiperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'swiper',
      description: 'Enable swiping gestures to open a drawer or a sheet.',
      displayName: 'Swiper',
      children: [
        WidgetUsageExample(
          title: 'Example 1',
          path: 'lib/pages/docs/components/swiper/swiper_example_1.dart',
          child: SwiperExample1(),
        ),
      ],
    );
  }
}
