import 'package:docs/pages/docs/components/skeleton/skeleton_example_1.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class SkeletonExample extends StatelessWidget {
  const SkeletonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'skeleton',
      description:
          'Skeleton is a placeholder for content that hasn\'t loaded yet.',
      displayName: 'Skeleton',
      children: [
        const Text('This component uses widget from ')
            .thenButton(
                child: const Text('https://pub.dev/packages/skeletonizer'),
                onPressed: () {
                  openInNewTab('https://pub.dev/packages/skeletonizer');
                })
            .p(),
        const WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/skeleton/skeleton_example_1.dart',
          child: SkeletonExample1(),
        ),
      ],
    );
  }
}
