# ColorHistoryGrid

A grid widget that displays a history of previously used colors.

## Usage

### Basic Example
```dart
ColorHistoryGrid(
  storage: myColorHistory,
  onColorPicked: (color) {
    print('Selected from history: $color');
  },
  crossAxisCount: 8,
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `storage` | `ColorHistoryStorage` | The storage containing the color history. |
| `onColorPicked` | `ValueChanged<Color>?` | Called when a color from the history is picked. |
| `spacing` | `double?` | Spacing between grid items. |
| `crossAxisCount` | `int` | Number of columns in the grid. |
| `selectedColor` | `Color?` | The currently selected color to highlight. |
| `maxTotalColors` | `int?` | The amount of colors to display in the history. |
