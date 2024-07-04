import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'breadcrumb/breadcrumb_example_1.dart';

class BreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'breadcrumb',
      description:
          'Breadcrumbs are a secondary navigation scheme that reveals the user’s location in a website or web application.',
      displayName: 'Breadcrumb',
      children: [
        WidgetUsageExample(
          title: 'Breadcrumb Example',
          child: BreadcrumbExample1(),
          path:
              'lib/pages/docs/components/breadcrumb/breadcrumb_example_1.dart',
        ),
      ],
    );
  }
}
