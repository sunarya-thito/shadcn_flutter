# FormattedInputTheme

Theme configuration for [FormattedInput] widget styling.

## Usage

### Formatted Input Example
```dart
import 'package:docs/pages/docs/components/formatted_input/formatted_input_example_2.dart';
import 'package:docs/pages/docs/components/formatted_input/formatted_input_example_3.dart';
import 'package:docs/pages/docs/components/formatted_input/formatted_input_example_4.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'formatted_input/formatted_input_example_1.dart';

class FormattedInputExample extends StatelessWidget {
  const FormattedInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'formatted_input',
      description: 'Text input with formatted parts.',
      displayName: 'Formatted Input',
      children: [
        WidgetUsageExample(
          title: 'Formatted Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_1.dart',
          child: FormattedInputExample1(),
        ),
        WidgetUsageExample(
          title: 'Date Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_2.dart',
          child: FormattedInputExample2(),
        ),
        WidgetUsageExample(
          title: 'Time Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_3.dart',
          child: FormattedInputExample3(),
        ),
        WidgetUsageExample(
          title: 'Duration Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_4.dart',
          child: FormattedInputExample4(),
        ),
      ],
    );
  }
}

```

### Formatted Input Example 1
```dart
import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample1 extends StatelessWidget {
  const FormattedInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      // Demonstrates a date-like formatted input built from editable and static parts.
      onChanged: (value) {
        List<String> parts = [];
        for (FormattedValuePart part in value.values) {
          parts.add(part.value ?? '');
        }
        if (kDebugMode) {
          print(parts.join('/'));
        }
      },
      initialValue: FormattedValue([
        const InputPart.editable(length: 2, width: 40, placeholder: Text('MM'))
            .withValue('01'),
        const InputPart.static('/'),
        const InputPart.editable(length: 2, width: 40, placeholder: Text('DD'))
            .withValue('02'),
        const InputPart.static('/'),
        const InputPart.editable(
                length: 4, width: 60, placeholder: Text('YYYY'))
            .withValue('2021'),
      ]),
    );
  }
}

```

### Formatted Input Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample2 extends StatefulWidget {
  const FormattedInputExample2({super.key});

  @override
  State<FormattedInputExample2> createState() => _FormattedInputExample2State();
}

class _FormattedInputExample2State extends State<FormattedInputExample2> {
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateInput(
          onChanged: (value) => setState(() => _selectedDate = value),
        ),
        const Gap(16),
        if (_selectedDate != null) Text('Selected date: $_selectedDate'),
      ],
    );
  }
}

```

### Formatted Input Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample3 extends StatefulWidget {
  const FormattedInputExample3({super.key});

  @override
  State<FormattedInputExample3> createState() => _FormattedInputExample3State();
}

class _FormattedInputExample3State extends State<FormattedInputExample3> {
  TimeOfDay? _selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimeInput(
          // Built-in formatted control for time-of-day values.
          onChanged: (value) => setState(() => _selected = value),
        ),
        const Gap(16),
        if (_selected != null) Text('Selected time: $_selected'),
      ],
    );
  }
}

```

### Formatted Input Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample4 extends StatefulWidget {
  const FormattedInputExample4({super.key});

  @override
  State<FormattedInputExample4> createState() => _FormattedInputExample4State();
}

class _FormattedInputExample4State extends State<FormattedInputExample4> {
  Duration? _selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DurationInput(
          // Built-in formatted control for durations; shows HH:MM and (optionally) SS.
          onChanged: (value) => setState(() => _selected = value),
          showSeconds: true,
        ),
        const Gap(16),
        if (_selected != null) Text('Selected duration: $_selected'),
      ],
    );
  }
}

```

### Formatted Input Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputTile extends StatelessWidget implements IComponentPage {
  const FormattedInputTile({super.key});

  @override
  String get title => 'Formatted Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'formatted_input',
      title: 'Formatted Input',
      scale: 1.2,
      example: Card(
        child: const Column(
          children: [
            TextField(
              placeholder: Text('(123) 456-7890'),
              initialValue: '1234567890',
            ),
            Gap(16),
            TextField(
              placeholder: Text('1234 5678 9012 3456'),
              initialValue: '1234567890123456',
            ),
            Gap(16),
            TextField(
              placeholder: Text('MM/DD/YYYY'),
              initialValue: '12/25/2024',
            ),
          ],
        ).withPadding(all: 16),
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
| `height` | `double?` | The height of the formatted input. |
| `padding` | `EdgeInsetsGeometry?` | Internal padding for the formatted input. |
