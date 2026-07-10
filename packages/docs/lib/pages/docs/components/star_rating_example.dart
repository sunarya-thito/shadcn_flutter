import 'package:docs/pages/docs/components/star_rating/star_rating_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class StarRatingExample extends StatelessWidget {
  const StarRatingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'star_rating',
      displayName: 'Star Rating',
      description: 'A component for rating.',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/star_rating/star_rating_example_1.dart',
          child: StarRatingExample1(),
        ),
      ],
    );
  }
}
