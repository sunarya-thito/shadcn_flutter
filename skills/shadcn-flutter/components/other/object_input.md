# DateInput

Reactive date input field with integrated date picker and text editing.

## Usage

### Basic Example
```dart
final controller = DatePickerController(DateTime.now());

DateInput(
  controller: controller,
  mode: PromptMode.popover,
  placeholder: Text('Select date'),
)
```



## Features
- **Dual input modes**: Text field editing with date picker integration
- **Multiple presentation modes**: Dialog or popover-based date selection
- **Flexible date formatting**: Customizable date part ordering and separators
- **Calendar integration**: Rich calendar interface with multiple view types
- **Form integration**: Automatic validation and form field registration
- **Accessibility**: Full screen reader and keyboard navigation support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `initialValue` | `DateTime?` |  |
| `onChanged` | `ValueChanged<DateTime?>?` |  |
| `enabled` | `bool` |  |
| `controller` | `DatePickerController?` |  |
| `placeholder` | `Widget?` | Placeholder widget shown when no date is selected. |
| `mode` | `PromptMode` | Presentation mode for date picker (dialog or popover). |
| `initialView` | `CalendarView?` | Initial calendar view to display. |
| `popoverAlignment` | `AlignmentGeometry?` | Alignment of popover relative to anchor. |
| `popoverAnchorAlignment` | `AlignmentGeometry?` | Alignment of anchor for popover positioning. |
| `popoverPadding` | `EdgeInsetsGeometry?` | Padding inside the popover. |
| `dialogTitle` | `Widget?` | Title widget for dialog mode. |
| `initialViewType` | `CalendarViewType?` | Initial view type (date, month, or year). |
| `stateBuilder` | `DateStateBuilder?` | Callback to determine date state (enabled/disabled). |
| `datePartsOrder` | `List<DatePart>?` | Order of date components in the input display. |
| `separator` | `InputPart?` | Separator widget between date parts. |
| `placeholders` | `Map<DatePart, Widget>?` | Custom placeholders for individual date parts. |
