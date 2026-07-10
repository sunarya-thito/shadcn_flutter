import 'package:docs/pages/docs/components/alert/alert_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class AlertExample extends StatelessWidget {
  const AlertExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'alert',
      displayName: 'Alert',
      description:
          'Alerts are used to communicate a state that affects the system.',
      children: [
        WidgetUsageExample(
          title: 'Alert Example',
          path: 'lib/pages/docs/components/alert/alert_example_1.dart',
          child: AlertExample1(),
        ),
        // with destructive: true
        WidgetUsageExample(
          title: 'Alert Example with destructive',
          path: 'lib/pages/docs/components/alert/alert_example_2.dart',
          child: Alert(
            title: Text('Alert title'),
            content: Text('This is alert content.'),
            trailing: Icon(Icons.dangerous_outlined),
            destructive: true,
          ),
        ),
      ],
    );
  }
}
