// App example page: lists and renders ShadcnApp demos.
//
// This wrapper page composes ComponentPage with WidgetUsageExample entries that
// link to the actual app demo files under components/app/*. Comments only.
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/app/app_example_1.dart';
import 'package:docs/pages/docs/components/app/app_example_2.dart';
import 'package:docs/pages/docs/components/app/app_example_3.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppExample extends StatelessWidget {
  const AppExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'app',
      description:
          'The ShadcnApp is a customizable application widget that provides theming, '
          'localization, and other global configurations for your Flutter app.',
      displayName: 'App',
      children: [
        WidgetUsageExample(
          title: 'App Example',
          path: 'lib/pages/docs/components/app/app_example_1.dart',
          child: const AppExample1().sized(height: 300),
        ),
        WidgetUsageExample(
          title: 'App Example with Custom Theme',
          path: 'lib/pages/docs/components/app/app_example_2.dart',
          child: const AppExample2().sized(height: 300),
        ),
        WidgetUsageExample(
          title: 'App Example with GoRouter',
          path: 'lib/pages/docs/components/app/app_example_3.dart',
          child: const AppExample3().sized(height: 300),
        ),
      ],
    );
  }
}
