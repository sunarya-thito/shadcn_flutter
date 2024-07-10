import 'package:example/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:flutter/widgets.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PaginationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'pagination',
      description:
          'A pagination component is used to navigate through a series of pages.',
      displayName: 'Pagination',
      children: [
        WidgetUsageExample(
          title: 'Pagination Example',
          child: PaginationExample1(),
          path:
              'lib/pages/docs/components/pagination/pagination_example_1.dart',
        ),
      ],
    );
  }
}
