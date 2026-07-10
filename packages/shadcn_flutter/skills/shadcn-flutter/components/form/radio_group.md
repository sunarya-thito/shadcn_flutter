# RadioGroup

A group of radio buttons for single-selection input.

## Usage

### Radio Group Example
```dart
import 'package:docs/pages/docs/components/radio_group/radio_group_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class RadioGroupExample extends StatelessWidget {
  const RadioGroupExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'radio_group',
      description: 'A radio group is a group of radio buttons.',
      displayName: 'Radio Group',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/radio_group/radio_group_example_1.dart',
          child: RadioGroupExample1(),
        ),
      ],
    );
  }
}

```

### Radio Group Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RadioGroupExample1 extends StatefulWidget {
  const RadioGroupExample1({super.key});

  @override
  State<RadioGroupExample1> createState() => _RadioGroupExample1State();
}

class _RadioGroupExample1State extends State<RadioGroupExample1> {
  // Start with no selection (null). The UI reflects this until the user picks an option.
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // A generic RadioGroup for int values. It controls selection for its RadioItem children.
        RadioGroup<int>(
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              // Save the selected value emitted by the tapped RadioItem.
              selectedValue = value;
            });
          },
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Each RadioItem represents a single choice with an associated integer value.
              RadioItem(
                value: 1,
                trailing: Text('Option 1'),
              ),
              RadioItem(
                value: 2,
                trailing: Text('Option 2'),
              ),
              RadioItem(
                value: 3,
                trailing: Text('Option 3'),
              ),
            ],
          ),
        ),
        const Gap(16),
        // Echo the selection below for demonstration purposes.
        Text('Selected: $selectedValue'),
      ],
    );
  }
}

```

### Radio Group Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class RadioGroupTile extends StatelessWidget implements IComponentPage {
  const RadioGroupTile({super.key});

  @override
  String get title => 'Radio Group';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'radio_group',
      title: 'Radio Group',
      scale: 2,
      example: Card(
        child: RadioGroup<int>(
          value: 1,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioItem<int>(
                trailing: Text('Option 1'),
                value: 0,
              ),
              RadioItem<int>(
                trailing: Text('Option 2'),
                value: 1,
              ),
              RadioItem<int>(
                trailing: Text('Option 3'),
                value: 2,
              ),
            ],
          ).gap(4),
        ).sized(width: 300),
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
| `child` | `Widget` | The child widget containing radio items. |
| `value` | `T?` | The currently selected value. |
| `onChanged` | `ValueChanged<T>?` | Callback invoked when the selection changes. |
| `enabled` | `bool?` | Whether the radio group is enabled. |
