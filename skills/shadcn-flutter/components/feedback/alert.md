# Alert

A versatile alert component for displaying important messages or notifications.

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
| `leading` | `Widget?` | Optional leading widget, typically an icon.  Type: `Widget?`. Displayed at the start of the alert layout. In destructive mode, inherits the destructive color from the theme. |
| `title` | `Widget?` | Optional title widget for the alert header.  Type: `Widget?`. Usually contains the main alert message or heading. Positioned after the leading widget in the layout flow. |
| `content` | `Widget?` | Optional content widget for detailed alert information.  Type: `Widget?`. Provides additional context or description below the title. Can contain longer text or complex content layouts. |
| `trailing` | `Widget?` | Optional trailing widget, typically for actions or dismissal.  Type: `Widget?`. Displayed at the end of the alert layout. Common use cases include close buttons or action controls. |
| `destructive` | `bool` | Whether to apply destructive styling to the alert.  Type: `bool`, default: `false`. When true, applies destructive color scheme to text and icons for error or warning messages. |
