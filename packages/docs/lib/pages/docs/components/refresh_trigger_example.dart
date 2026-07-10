import 'dart:ui';

import 'package:docs/pages/docs/components/refresh_trigger/refresh_trigger_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class RefreshTriggerExample extends StatelessWidget {
  const RefreshTriggerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'refresh_trigger',
      description: 'A trigger that can be used to refresh a list.',
      displayName: 'Refresh Trigger',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/refresh_trigger/refresh_trigger_example_1.dart',
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            }),
            child: OutlinedContainer(
              child: const RefreshTriggerExample1().sized(
                height: 400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
