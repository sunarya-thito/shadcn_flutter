import 'package:docs/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:flutter/widgets.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PaginationExample extends StatelessWidget {
  const PaginationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'pagination',
      description:
          'A pagination component is used to navigate through a series of pages.',
      displayName: 'Pagination',
      children: [
        WidgetUsageExample(
          title: 'Pagination Example',
          path:
              'lib/pages/docs/components/pagination/pagination_example_1.dart',
          child: PaginationExample1(),
        ),
      ],
    );
  }
}
