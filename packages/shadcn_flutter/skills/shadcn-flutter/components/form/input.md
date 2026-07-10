# InputHintFeature

Adds a hint/info button to the input field with a popover.

## Usage

### Input Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/input/input_example_3.dart';
import 'package:docs/pages/docs/components/input/input_example_4.dart';
import 'package:docs/pages/docs/components/input/input_example_5.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'input/input_example_1.dart';
import 'input/input_example_2.dart';

class InputExample extends StatelessWidget {
  const InputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'input',
      description:
          'A text input is a form field that allows users to enter text.',
      displayName: 'Text Input',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/input/input_example_1.dart',
          child: InputExample1(),
        ),
        WidgetUsageExample(
          title: 'Initial Value Example',
          path: 'lib/pages/docs/components/input/input_example_2.dart',
          child: InputExample2(),
        ),
        WidgetUsageExample(
          title: 'Features Example',
          path: 'lib/pages/docs/components/input/input_example_3.dart',
          child: InputExample3(),
        ),
        WidgetUsageExample(
          title: 'Revalidate Form Feature Example',
          path: 'lib/pages/docs/components/input/input_example_4.dart',
          child: InputExample4(),
        ),
        WidgetUsageExample(
          title: 'Grouped Inputs Example',
          path: 'lib/pages/docs/components/input/input_example_5.dart',
          child: InputExample5(),
        ),
      ],
    );
  }
}

```

### Input Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample1 extends StatelessWidget {
  const InputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic text input using shadcn_flutter's TextField.
    // placeholder is rendered inside the input when it's empty.
    return const TextField(
      placeholder: Text('Enter your name'),
    );
  }
}

```

### Input Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample2 extends StatefulWidget {
  const InputExample2({super.key});

  @override
  State<InputExample2> createState() => _InputExample2State();
}

class _InputExample2State extends State<InputExample2> {
  @override
  Widget build(BuildContext context) {
    // Demonstrates input features:
    // - A leading search icon that reacts to the hover state when the field is empty
    // - A clear button that appears when there's text and the field is focused or hovered
    return TextField(
        initialValue: 'Hello World!',
        placeholder: const Text('Search something...'),
        features: [
          // Leading icon only visible when the text is empty
          InputFeature.leading(StatedWidget.builder(
            builder: (context, states) {
              // Use a muted icon normally, switch to the full icon on hover
              if (states.hovered) {
                return const Icon(Icons.search);
              } else {
                return const Icon(Icons.search).iconMutedForeground();
              }
            },
          ), visibility: InputFeatureVisibility.textEmpty),
          // Clear button visible when there is text and the field is focused,
          // or whenever the field is hovered
          InputFeature.clear(
            visibility: (InputFeatureVisibility.textNotEmpty &
                    InputFeatureVisibility.focused) |
                InputFeatureVisibility.hovered,
          ),
        ]);
  }
}

```

### Input Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample3 extends StatelessWidget {
  const InputExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          placeholder: const Text('Enter your name'),
          features: [
            const InputFeature.clear(),
            // Hint shows a small tooltip-like popup for the input field.
            InputFeature.hint(
              popupBuilder: (context) {
                return const TooltipContainer(
                    child: Text('This is for your username'));
              },
            ),
            // Convenience actions for copying/pasting directly from the text field UI.
            const InputFeature.copy(),
            const InputFeature.paste(),
          ],
        ),
        const Gap(24),
        const TextField(
          placeholder: Text('Enter your password'),
          features: [
            InputFeature.clear(
              visibility: InputFeatureVisibility.textNotEmpty,
            ),
            // Password toggle configured with `hold` mode: press-and-hold to peek,
            // release to hide again.
            InputFeature.passwordToggle(mode: PasswordPeekMode.hold),
          ],
        ),
      ],
    );
  }
}

```

### Input Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample4 extends StatelessWidget {
  const InputExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: FormField(
        // Use a stable key for form state lookups and debugging.
        key: const InputKey(#test),
        label: const Text('Username'),
        // Async validator simulating server-side availability check.
        // Returns `false` (invalid) when the username is taken.
        validator: ConditionalValidator((value) async {
          // Simulate a network delay for demonstration purposes
          await Future.delayed(const Duration(seconds: 1));
          return !['sunarya-thito', 'septogeddon', 'admin'].contains(value);
        }, message: 'Username already taken'),
        child: const TextField(
          placeholder: Text('Enter your username'),
          initialValue: 'sunarya-thito',
          features: [
            // Manually triggers the validator again (useful after edits or on demand).
            InputFeature.revalidate(),
          ],
        ),
      ),
    );
  }
}

```

### Input Example 5
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// This example demonstrates grouping multiple input fields together
/// using the `ButtonGroup` component.

class InputExample5 extends StatelessWidget {
  const InputExample5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        ButtonGroup(children: [
          // Its important to set width constraints on the TextFields
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Red')),
          ),
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Green')),
          ),
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Blue')),
          ),
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Alpha')),
          ),
        ]),
        ButtonGroup.vertical(
          children: [
            // Its important to set width constraints on the TextFields
            SizedBox(
              width: 200,
              child: TextField(placeholder: Text('First Name')),
            ),
            ButtonGroup.horizontal(
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(placeholder: Text('Middle Name')),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(placeholder: Text('Last Name')),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

```

### Input Tile
```dart
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class InputTile extends StatelessWidget implements IComponentPage {
  const InputTile({super.key});

  @override
  String get title => 'Text Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'input',
      title: 'Text Input',
      scale: 2,
      example: Card(
        child: const TextField(
          initialValue: 'Hello World',
          features: [
            InputFeature.leading(Icon(material.Icons.edit)),
          ],
        ).sized(width: 250, height: 32),
      ).sized(height: 400),
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
| `popupBuilder` | `WidgetBuilder` | Builder for the hint popover content. |
| `icon` | `Widget?` | Custom icon to display (defaults to info icon). |
| `position` | `InputFeaturePosition` | Position of the hint button. |
| `enableShortcuts` | `bool` | Whether to enable keyboard shortcut (F1) to show the hint. |
