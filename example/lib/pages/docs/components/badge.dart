import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BadgeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'badge',
      description: 'Badges are small status descriptors for UI elements.',
      displayName: 'Badge',
      children: [
        // Primary badge
        WidgetUsageExample(
            builder: (context) {
              return Badge(
                child: Text('Primary'),
              );
            },
            code: '''
Badge(
  child: Text('Primary'),
)'''),
        // Secondary badge
        WidgetUsageExample(
            builder: (context) {
              return Badge(
                child: Text('Secondary'),
                type: ButtonType.secondary,
              );
            },
            code: '''
Badge(
  child: Text('Secondary'),
  type: ButtonType.secondary,
)'''),
        // Outlined Badge
        WidgetUsageExample(
            builder: (context) {
              return Badge(
                child: Text('Outlined'),
                type: ButtonType.outline,
              );
            },
            code: '''
Badge(
  child: Text('Outlined'),
  type: ButtonType.outlined,
)'''),
        // Destructive Badge
        WidgetUsageExample(
            builder: (context) {
              return Badge(
                child: Text('Destructive'),
                type: ButtonType.destructive,
              );
            },
            code: '''
Badge(
  child: Text('Destructive'),
  type: ButtonType.destructive,
)'''),
      ],
    );
  }
}
