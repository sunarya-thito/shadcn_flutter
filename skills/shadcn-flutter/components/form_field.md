# ObjectFormField

A form field widget for complex object values.

## Usage

No examples found for form_field.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `value` | `T?` | The current value of the field. |
| `onChanged` | `ValueChanged<T?>?` | Called when the value changes. |
| `placeholder` | `Widget` | Widget displayed when no value is selected. |
| `builder` | `Widget Function(BuildContext context, T value)` | Builds the display for the selected value. |
| `leading` | `Widget?` | Optional leading widget (e.g., icon). |
| `trailing` | `Widget?` | Optional trailing widget (e.g., dropdown arrow). |
| `mode` | `PromptMode` | How the editor is presented (dialog or popover). |
| `editorBuilder` | `Widget Function(BuildContext context, ObjectFormHandler<T> handler)` | Builds the editor widget. |
| `popoverAlignment` | `AlignmentGeometry?` | Popover alignment relative to the trigger. |
| `popoverAnchorAlignment` | `AlignmentGeometry?` | Anchor alignment for popover positioning. |
| `popoverPadding` | `EdgeInsetsGeometry?` | Padding inside the popover. |
| `dialogTitle` | `Widget?` | Title for the dialog mode. |
| `size` | `ButtonSize?` | Button size for the trigger. |
| `density` | `ButtonDensity?` | Button density for the trigger. |
| `shape` | `ButtonShape?` | Button shape for the trigger. |
| `dialogActions` | `List<Widget> Function(BuildContext context, ObjectFormHandler<T> handler)?` | Custom dialog action buttons. |
| `enabled` | `bool?` | Whether the field is enabled. |
| `decorate` | `bool` | Whether to show the field decoration. |
| `immediateValueChange` | `bool?` | Whether to inform value change callback immediately upon user interaction with the editor. If null, defaults to true for popover mode and false for dialog mode. |
