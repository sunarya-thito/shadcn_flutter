import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class AlertExample extends StatelessWidget {
  const AlertExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'alert',
      displayName: 'Alert',
      description:
          'Alerts are used to communicate a state that affects the system.',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return Alert(
              title: Text('Alert title'),
              content: Text('This is alert content.'),
              leading: Icon(Icons.info_outline),
            );
          },
          code: '''
Alert(
  title: Text('Alert title'),
  content: Text('This is alert content.'),
  leading: Icon(Icons.info_outline),
)''',
        ),
        // with destructive: true
        WidgetUsageExample(
          builder: (context) {
            return Alert(
              title: Text('Alert title'),
              content: Text('This is alert content.'),
              trailing: Icon(Icons.dangerous_outlined),
              destructive: true,
            );
          },
          code: '''
Alert(
  title: Text('Alert title'),
  content: Text('This is alert content.'),
  trailing: Icon(Icons.dangerous_outlined),
  destructive: true,
)''',
        ),
      ],
    );
  }
}
