# AlertDialog

A modal dialog component for displaying important alerts and confirmations.

## Usage

### Alert Dialog Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'alert_dialog/alert_dialog_example_1.dart';

class AlertDialogExample extends StatelessWidget {
  const AlertDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'alert_dialog',
      description:
          'An alert dialog informs the user about situations that require acknowledgement.',
      displayName: 'Alert Dialog',
      children: [
        WidgetUsageExample(
          title: 'Alert Dialog Example',
          path:
              'lib/pages/docs/components/alert_dialog/alert_dialog_example_1.dart',
          child: AlertDialogExample1(),
        ),
      ],
    );
  }
}

```

### Alert Dialog Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// AlertDialog demo with a trigger button.
///
/// Tapping the [PrimaryButton] opens a Material [showDialog] that
/// contains an [AlertDialog] with a title, content, and action buttons.
/// The actions simply dismiss the dialog using [Navigator.pop].
class AlertDialogExample1 extends StatelessWidget {
  const AlertDialogExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      child: const Text('Click Here'),
      onPressed: () {
        // Standard Flutter API to present a dialog above the current route.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Alert title'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              actions: [
                // Secondary action to cancel/dismiss.
                OutlineButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    // Close the dialog.
                    Navigator.pop(context);
                  },
                ),
                // Primary action to accept/confirm.
                PrimaryButton(
                  child: const Text('OK'),
                  onPressed: () {
                    // Close the dialog. In real apps, perform work before closing.
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

```

### Alert Dialog Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class AlertDialogTile extends StatelessWidget implements IComponentPage {
  const AlertDialogTile({super.key});

  @override
  String get title => 'Alert Dialog';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'alert_dialog',
      title: 'Alert Dialog',
      center: true,
      example: AlertDialog(
        title: const Text('Alert Dialog'),
        content: const Text('This is an alert dialog.'),
        actions: [
          SecondaryButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
          PrimaryButton(
            onPressed: () {},
            child: const Text('OK'),
          ),
        ],
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
| `leading` | `Widget?` | Optional leading widget, typically an icon or graphic.  Type: `Widget?`. Displayed at the start of the dialog header with automatic icon styling (XL size, muted foreground color). |
| `trailing` | `Widget?` | Optional trailing widget for additional dialog controls.  Type: `Widget?`. Positioned at the end of the dialog header with similar styling to the leading widget. |
| `title` | `Widget?` | Optional title widget for the dialog header.  Type: `Widget?`. Displayed prominently with large, semi-bold text styling. Should contain the primary message or question for the user. |
| `content` | `Widget?` | Optional content widget for detailed dialog information.  Type: `Widget?`. Provides additional context or description with small, muted text styling. Positioned below the title. |
| `actions` | `List<Widget>?` | Optional list of action buttons for user interaction.  Type: `List<Widget>?`. Buttons are arranged horizontally at the bottom of the dialog with consistent spacing. Typically includes cancel and confirmation options. |
| `surfaceBlur` | `double?` | Surface blur intensity for the modal backdrop.  Type: `double?`. If null, uses theme default blur value. Higher values create more pronounced background blur effects. |
| `surfaceOpacity` | `double?` | Surface opacity for the modal backdrop.  Type: `double?`. If null, uses theme default opacity value. Controls the transparency level of the backdrop overlay. |
| `barrierColor` | `Color?` | Barrier color for the modal backdrop.  Type: `Color?`. If null, defaults to black with 80% opacity. The color overlay applied behind the dialog content. |
| `padding` | `EdgeInsetsGeometry?` | Internal padding for the dialog content.  Type: `EdgeInsetsGeometry?`. If null, uses responsive padding based on theme scaling (24 * scaling). Controls spacing around all dialog content. |
