# TabContainer

Container widget for managing multiple tabs.

## Usage

### Basic Example
```dart
TabContainer(
  selected: null, // TODO: Provide selected
  onSelect: null, // TODO: Provide onSelect
  children: null, // TODO: Provide children
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `selected` | `int` | Currently selected tab index. |
| `onSelect` | `ValueChanged<int>?` | Callback when tab selection changes. |
| `children` | `List<TabChild>` | List of tab children to display. |
| `builder` | `TabBuilder?` | Optional custom tab layout builder. |
| `childBuilder` | `TabChildBuilder?` | Optional custom child widget builder. |
