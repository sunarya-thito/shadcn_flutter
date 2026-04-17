# MultipleChoice

A widget for single-selection choice scenarios.

## Usage

### Basic Example
```dart
MultipleChoice<String>(
  value: selectedOption,
  onChanged: (value) => setState(() => selectedOption = value),
  child: Wrap(
    children: [
      ChoiceChip(value: 'A', child: Text('Option A')),
      ChoiceChip(value: 'B', child: Text('Option B')),
    ],
  ),
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The child widget tree containing choice items. |
| `value` | `T?` | The currently selected value. |
| `onChanged` | `ValueChanged<T?>?` | Callback when the selection changes. |
| `enabled` | `bool?` | Whether choices are enabled. |
| `allowUnselect` | `bool?` | Whether the current selection can be unselected. |
