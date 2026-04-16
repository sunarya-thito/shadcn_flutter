# TimePicker

A time picker widget for selecting time values.

## Usage

### Time Picker Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/time_picker/time_picker_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimePickerExample extends StatelessWidget {
  const TimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'time_picker',
      description:
          'Time picker is a component that allows users to pick a time.',
      displayName: 'Time Picker',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/time_picker/time_picker_example_1.dart',
          child: TimePickerExample1(),
        ),
      ],
    );
  }
}

```

### Time Picker Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates TimePicker in popover and dialog modes, updating state and
// handling cancel by falling back to current time.

class TimePickerExample1 extends StatefulWidget {
  const TimePickerExample1({super.key});

  @override
  State<TimePickerExample1> createState() => _TimePickerExample1State();
}

class _TimePickerExample1State extends State<TimePickerExample1> {
  TimeOfDay _value = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimePicker(
          value: _value,
          // Popover mode shows a compact inline picker anchored to the field.
          mode: PromptMode.popover,
          onChanged: (value) {
            setState(() {
              // If user cancels, keep time by falling back to now.
              _value = value ?? TimeOfDay.now();
            });
          },
        ),
        const Gap(16),
        TimePicker(
          value: _value,
          // Dialog mode opens a modal sheet/dialog for selection.
          mode: PromptMode.dialog,
          dialogTitle: const Text('Select Time'),
          onChanged: (value) {
            setState(() {
              _value = value ?? TimeOfDay.now();
            });
          },
        ),
      ],
    );
  }
}

```

### Time Picker Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class TimePickerTile extends StatelessWidget implements IComponentPage {
  const TimePickerTile({super.key});

  @override
  String get title => 'Time Picker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'time_picker',
      title: 'Time Picker',
      scale: 1.2,
      example: Card(
        child: TimePickerDialog(
          use24HourFormat: true,
          initialValue: TimeOfDay.now(),
        ).withAlign(Alignment.topLeft),
      ).sized(height: 300),
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
| `value` | `TimeOfDay?` | The currently selected time value. |
| `onChanged` | `ValueChanged<TimeOfDay?>?` | Callback invoked when the selected time changes. |
| `mode` | `PromptMode` | The display mode for the time picker (popover or dialog). |
| `placeholder` | `Widget?` | Placeholder widget shown when no time is selected. |
| `popoverAlignment` | `AlignmentGeometry?` | Alignment of the popover relative to the anchor. |
| `popoverAnchorAlignment` | `AlignmentGeometry?` | Anchor alignment for the popover. |
| `popoverPadding` | `EdgeInsetsGeometry?` | Padding inside the popover. |
| `use24HourFormat` | `bool?` | Whether to use 24-hour format. |
| `showSeconds` | `bool` | Whether to show seconds selection. |
| `dialogTitle` | `Widget?` | Title widget for the dialog mode. |
| `enabled` | `bool?` | Whether the time picker is enabled. |
