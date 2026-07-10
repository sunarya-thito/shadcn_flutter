# NavigationItem

Selectable navigation item with selection state management.

## Usage

### Basic Example
```dart
NavigationItem(
  key: ValueKey('home'),
  label: Text('Home'),
  child: Icon(Icons.home),
  selected: selectedKey == ValueKey('home'),
  onChanged: (selected) => setState(() => selectedKey = ValueKey('home')),
)
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `selectedStyle` | `AbstractButtonStyle?` | Custom style when item is selected. |
| `selected` | `bool?` | Whether this item is currently selected. |
| `onChanged` | `ValueChanged<bool>?` | Callback when selection state changes. |
