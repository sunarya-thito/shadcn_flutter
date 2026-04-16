# AlertTheme

Theme configuration for [Alert] components.

## Usage

### Alert Example
```dart
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

```

### Alert Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Basic Alert example.
///
/// This shows a non-destructive [Alert] with a title, content, and a
/// leading icon. Use alerts to communicate a status or message that
/// doesn't necessarily require immediate user action.
class AlertExample1 extends StatelessWidget {
  const AlertExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // `Alert` supports optional leading/trailing widgets for icons or actions.
    return const Alert(
      title: Text('Alert title'),
      content: Text('This is alert content.'),
      leading: Icon(Icons.info_outline),
    );
  }
}

```

### Alert Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Destructive Alert example.
///
/// Demonstrates using the `destructive` style via the named constructor
/// [Alert.destructive], which is suitable for critical or dangerous states.
class AlertExample2 extends StatelessWidget {
  const AlertExample2({super.key});

  @override
  Widget build(BuildContext context) {
    // Destructive styling typically emphasizes caution to the user.
    return const Alert.destructive(
      title: Text('Alert title'),
      content: Text('This is alert content.'),
      trailing: Icon(Icons.dangerous_outlined),
    );
  }
}

```

### Alert Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class AlertTile extends StatelessWidget implements IComponentPage {
  const AlertTile({super.key});

  @override
  String get title => 'Alert';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'alert',
      title: 'Alert',
      center: true,
      example: Alert(
        leading: Icon(Icons.info_outline),
        title: Text('Alert'),
        content: Text('This is an alert.'),
      ),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `padding` | `EdgeInsetsGeometry?` | The internal padding around the alert content.  Type: `EdgeInsetsGeometry?`. If null, uses default padding based on scaling. Controls the spacing between the alert border and its content elements. |
| `backgroundColor` | `Color?` | The background color of the alert container.  Type: `Color?`. If null, uses [ColorScheme.card] from the current theme. Applied to the [OutlinedContainer] that wraps the alert content. |
| `borderColor` | `Color?` | The border color of the alert outline.  Type: `Color?`. If null, uses the default border color from [OutlinedContainer]. Defines the visual boundary around the alert. |
