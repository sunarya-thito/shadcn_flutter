import 'package:example/pages/docs/components/skeleton/skeleton_example_1.dart';
import 'package:example/pages/docs_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class SkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'skeleton',
      description:
          'Skeleton is a placeholder for content that hasn\'t loaded yet.',
      displayName: 'Skeleton',
      children: [
        Text('This component uses widget from ')
            .thenButton(
                child: Text('https://pub.dev/packages/skeletonizer'),
                onPressed: () {
                  openInNewTab('https://pub.dev/packages/skeletonizer');
                })
            .p(),
        WidgetUsageExample(
          title: 'Example',
          child: SkeletonExample1(),
          path: 'lib/pages/docs/components/skeleton/skeleton_example_1.dart',
        ),
      ],
    );
  }
}
