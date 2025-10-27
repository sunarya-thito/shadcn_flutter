---
title: "Example: components/sheet/sheet_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SheetExample1 extends StatefulWidget {
  const SheetExample1({super.key});

  @override
  State<SheetExample1> createState() => _SheetExample1State();
}

class _SheetExample1State extends State<SheetExample1> {
  // A form controller to read values and validation state inside the sheet.
  final FormController controller = FormController();

  void saveProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profile updated'),
          // For demo, show raw form values.
          content: Text('Content: ${controller.values}'),
          actions: [
            PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget buildSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 400),
      child: Form(
        controller: controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: const Text('Edit profile').large().medium(),
                ),
                TextButton(
                  density: ButtonDensity.icon,
                  child: const Icon(Icons.close),
                  onPressed: () {
                    // Close the sheet without saving.
                    closeSheet(context);
                  },
                ),
              ],
            ),
```
