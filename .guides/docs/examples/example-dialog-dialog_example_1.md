---
title: "Example: components/dialog/dialog_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog with a simple profile edit form.
///
/// Opens an [AlertDialog] containing a small form. When the user taps
/// "Save changes", the dialog closes and returns the form values via
/// [Navigator.pop].
class DialogExample1 extends StatelessWidget {
  const DialogExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        // Present a Material dialog on top of the current route.
        showDialog(
          context: context,
          builder: (context) {
            final FormController controller = FormController();
            return AlertDialog(
              title: const Text('Edit profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Make changes to your profile here. Click save when you\'re done'),
                  const Gap(16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Form(
                      controller: controller,
                      child: const FormTableLayout(rows: [
                        FormField<String>(
                          key: FormKey(#name),
                          label: Text('Name'),
                          child: TextField(
                            initialValue: 'Thito Yalasatria Sunarya',
                            autofocus: true,
                          ),
                        ),
                        FormField<String>(
                          key: FormKey(#username),
                          label: Text('Username'),
                          child: TextField(
                            initialValue: '@sunaryathito',
                          ),
                        ),
                      ]),
                    ).withPadding(vertical: 16),
                  ),
                ],
              ),
              actions: [
                PrimaryButton(
                  child: const Text('Save changes'),
                  onPressed: () {
                    // Return the form values and close the dialog.
                    Navigator.of(context).pop(controller.values);
                  },
```
