import 'package:example/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';

class ButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'button',
      description:
          'Buttons allow users to take actions, and make choices, with a single tap.',
      displayName: 'Button',
      children: [
        // Primary button
        WidgetUsageExample(
          builder: (context) {
            return PrimaryButton(
              onPressed: () {},
              child: Text('Primary'),
            );
          },
          code: '''
Button(
  onPressed: () {},
  child: Text('Primary'),
)''',
        ),
        // Secondary button
        WidgetUsageExample(
          builder: (context) {
            return SecondaryButton(
              onPressed: () {},
              child: Text('Secondary'),
            );
          },
          code: '''
Button(
  onPressed: () {},
  child: Text('Secondary'),
  type: ButtonType.secondary,
)''',
        ),
        // Outlined button
        WidgetUsageExample(
          builder: (context) {
            return OutlineButton(
              onPressed: () {},
              child: Text('Outlined'),
            );
          },
          code: '''
Button(
  onPressed: () {},
  child: Text('Outlined'),
  type: ButtonType.outline,
)''',
        ),
        WidgetUsageExample(
          builder: (context) {
            return GhostButton(
              onPressed: () {},
              child: Text('Ghost'),
            );
          },
          code: '''
Button(
  onPressed: () {},
  child: Text('Ghost'),
  type: ButtonType.ghost,
)''',
        ),
        // Destructive button
        WidgetUsageExample(
          builder: (context) {
            return DestructiveButton(
              onPressed: () {},
              child: Text('Destructive'),
            );
          },
          code: '''
Button(
  onPressed: () {},
  child: Text('Destructive'),
  type: ButtonType.destructive,
)''',
        ),
        // Link button
        WidgetUsageExample(
          builder: (context) {
            return LinkButton(
              onPressed: () {},
              child: Text('Link'),
            );
          },
          code: '''
Button(
  onPressed: () {},
  child: Text('Link'),
  type: ButtonType.link,
)''',
        ),
        // Disabled button
        WidgetUsageExample(
          builder: (context) {
            return PrimaryButton(
              child: Text('Disabled'),
            );
          },
          code: '''
Button(
  child: Text('Disabled'),
)''',
        ),
        // Icon button
        WidgetUsageExample(
          builder: (context) {
            return PrimaryButton(
              onPressed: () {},
              padding: Button.iconPadding,
              child: Icon(Icons.add),
            );
          },
          code: '''
Button(
  onPressed: () {},
  size: ButtonSize.icon,
  child: Icon(Icons.add),
)''',
        ),
        // Icon button with text
        WidgetUsageExample(
          builder: (context) {
            return PrimaryButton(
              onPressed: () {},
              trailing: Icon(Icons.add),
              child: Text('Add'),
            );
          },
          code: '''
Button(
  onPressed: () {},
  trailing: Icon(Icons.add),
  child: Text('Add'),
)''',
        ),
        // Loading button
        WidgetUsageExample(
          builder: (context) {
            return PrimaryButton(
              trailing: CircularProgressIndicator(),
              child: Text('Loading'),
            );
          },
          code: '''
Button(
  trailing: CircularProgressIndicator(),
  child: Text('Loading'),
)''',
        ),
      ],
    );
  }
}
