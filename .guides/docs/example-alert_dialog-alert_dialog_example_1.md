---
title: "Example: components/alert_dialog/alert_dialog_example_1.dart"
description: "Component example"
---

Source preview
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
