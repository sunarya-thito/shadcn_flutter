# ModalBackdropTheme

Theme configuration for modal backdrop appearance and behavior.

## Usage

### Dialog Example
```dart
import 'package:docs/pages/docs/components/dialog/dialog_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'dialog',
      description:
          'A window overlaid on either the primary window or another dialog window, rendering the content underneath inert.',
      displayName: 'Dialog',
      children: [
        WidgetUsageExample(
          title: 'Dialog Example',
          path: 'lib/pages/docs/components/dialog/dialog_example_1.dart',
          child: DialogExample1(),
        ),
      ],
    );
  }
}

```

### Dialog Example 1
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
                ),
              ],
            );
          },
        );
      },
      child: const Text('Edit Profile'),
    );
  }
}

```

### Dialog Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DialogTile extends StatelessWidget implements IComponentPage {
  const DialogTile({super.key});

  @override
  String get title => 'Dialog';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Dialog',
      name: 'dialog',
      example: AlertDialog(
        barrierColor: material.Colors.transparent,
        title: const Text('Edit profile'),
        content: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                  'Make changes to your profile here. Click save when you\'re done'),
              const Gap(16),
              const Form(
                child: FormTableLayout(rows: [
                  FormField<String>(
                    key: FormKey(#name),
                    label: Text('Name'),
                    child: TextField(
                      initialValue: 'Thito Yalasatria Sunarya',
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
            ],
          ),
        ),
        actions: [
          PrimaryButton(
            child: const Text('Save changes'),
            onPressed: () {},
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
| `borderRadius` | `BorderRadiusGeometry?` | Border radius applied to the modal surface. |
| `padding` | `EdgeInsetsGeometry?` | Padding around the modal content area. |
| `barrierColor` | `Color?` | Color of the barrier that appears behind the modal. |
| `modal` | `bool?` | Whether the backdrop behaves as a modal (blocking interaction). |
| `surfaceClip` | `bool?` | Whether to clip the surface for visual effects. |
