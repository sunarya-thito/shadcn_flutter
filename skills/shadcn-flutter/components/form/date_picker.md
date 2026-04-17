# DatePicker

A date picker widget for selecting dates.

## Usage

### Date Picker Example
```dart
import 'package:docs/pages/docs/components/date_picker/date_picker_example_1.dart';
import 'package:docs/pages/docs/components/date_picker/date_picker_example_2.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class DatePickerExample extends StatelessWidget {
  const DatePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'date_picker',
      description: 'A widget that lets users select dates and date ranges.',
      displayName: 'Date Picker',
      children: [
        WidgetUsageExample(
          title: 'Date Picker Example',
          path:
              'lib/pages/docs/components/date_picker/date_picker_example_1.dart',
          child: DatePickerExample1(),
        ),
        WidgetUsageExample(
          title: 'Date Range Picker Example',
          path:
              'lib/pages/docs/components/date_picker/date_picker_example_2.dart',
          child: DatePickerExample2(),
        ),
      ],
    );
  }
}

```

### Date Picker Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// DatePicker in popover and dialog modes with disabled future dates.
///
/// Demonstrates single-date selection with two different prompt UIs:
/// - [PromptMode.popover]: inline, anchored overlay.
/// - [PromptMode.dialog]: modal dialog with a custom [dialogTitle].
class DatePickerExample1 extends StatefulWidget {
  const DatePickerExample1({super.key});

  @override
  State<DatePickerExample1> createState() => _DatePickerExample1State();
}

class _DatePickerExample1State extends State<DatePickerExample1> {
  DateTime? _value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          value: _value,
          mode: PromptMode.popover,
          // Disable selecting dates after "today".
          stateBuilder: (date) {
            if (date.isAfter(DateTime.now())) {
              return DateState.disabled;
            }
            return DateState.enabled;
          },
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        const Gap(16),
        DatePicker(
          value: _value,
          mode: PromptMode.dialog,
          // Title shown at the top of the dialog variant.
          dialogTitle: const Text('Select Date'),
          stateBuilder: (date) {
            if (date.isAfter(DateTime.now())) {
              return DateState.disabled;
            }
            return DateState.enabled;
          },
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}

```

### Date Picker Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// DateRangePicker in popover and dialog modes.
///
/// Similar to the single-date picker, but selects a [DateTimeRange].
class DatePickerExample2 extends StatefulWidget {
  const DatePickerExample2({super.key});

  @override
  State<DatePickerExample2> createState() => _DatePickerExample2State();
}

class _DatePickerExample2State extends State<DatePickerExample2> {
  DateTimeRange? _value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateRangePicker(
          value: _value,
          mode: PromptMode.popover,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        const Gap(16),
        DateRangePicker(
          value: _value,
          mode: PromptMode.dialog,
          // Title for the dialog variant.
          dialogTitle: const Text('Select Date Range'),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}

```

### Date Picker Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../calendar/calendar_example_2.dart';

class DatePickerTile extends StatelessWidget implements IComponentPage {
  const DatePickerTile({super.key});

  @override
  String get title => 'Date Picker';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'date_picker',
      title: 'Date Picker',
      horizontalOffset: 70,
      example: CalendarExample2(),
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
| `value` | `DateTime?` | The currently selected date value. |
| `onChanged` | `ValueChanged<DateTime?>?` | Callback invoked when the selected date changes. |
| `placeholder` | `Widget?` | Placeholder widget shown when no date is selected. |
| `mode` | `PromptMode?` | The display mode for the date picker (popover or dialog). |
| `initialView` | `CalendarView?` | The initial calendar view to display. |
| `popoverAlignment` | `AlignmentGeometry?` | Alignment of the popover relative to the anchor. |
| `popoverAnchorAlignment` | `AlignmentGeometry?` | Anchor alignment for the popover. |
| `popoverPadding` | `EdgeInsetsGeometry?` | Padding inside the popover. |
| `dialogTitle` | `Widget?` | Title widget for the dialog mode. |
| `initialViewType` | `CalendarViewType?` | The initial calendar view type (date, month, or year). |
| `stateBuilder` | `DateStateBuilder?` | Builder function to determine the state of each date. |
| `enabled` | `bool?` | Whether the date picker is enabled. |
