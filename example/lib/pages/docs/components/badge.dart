import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
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
              return PrimaryButton(
                padding: Button.badgePadding,
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
              return SecondaryButton(
                padding: Button.badgePadding,
                child: Text('Secondary'),
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
              return OutlineButton(
                padding: Button.badgePadding,
                child: Text('Outlined'),
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
              return DestructiveButton(
                padding: Button.badgePadding,
                child: Text('Destructive'),
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
