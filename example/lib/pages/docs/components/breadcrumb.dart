import 'package:example/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';

class BreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'breadcrumb',
      description:
          'Breadcrumbs are a secondary navigation scheme that reveals the user’s location in a website or web application.',
      displayName: 'Breadcrumb',
      children: [
        // Default breadcrumb
        WidgetUsageExample(
          builder: (context) {
            return Breadcrumb(
              separator: Breadcrumb.arrowSeparator,
              children: [
                TextButton(
                  child: Text('Home'),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                ),
                TextButton(
                  child: Text('Components'),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                ),
                Text('Breadcrumb'),
              ],
            );
          },
          code: '''
Breadcrumb(
  separator: Breadcrumb.arrowSeparator,
  children: [
    Text('Home'),
    Text('Components'),
    Text('Breadcrumb'),
  ],
)''',
        ),
      ],
    );
  }
}
