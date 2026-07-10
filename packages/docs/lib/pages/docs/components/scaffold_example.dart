import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/scaffold/scaffold_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'scaffold',
      description: 'A scaffold is a top-level container for a page.',
      displayName: 'Scaffold',
      children: [
        WidgetUsageExample(
          title: 'Scaffold Example',
          path: 'lib/pages/docs/components/scaffold/scaffold_example_1.dart',
          child: OutlinedContainer(
            child: const ScaffoldExample1().sized(
              height: 400,
            ),
          ),
        ),
      ],
    );
  }
}
