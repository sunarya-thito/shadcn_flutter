# MoreDots

A widget that displays multiple dots, commonly used for loading indicators or menus.

## Usage

### Basic Example
```dart
// Horizontal three-dot menu icon
MoreDots(
  count: 3,
  direction: Axis.horizontal,
  spacing: 4,
)

// Vertical loading indicator
MoreDots(
  count: 5,
  direction: Axis.vertical,
  color: Colors.blue,
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `direction` | `Axis` | The layout direction of the dots.  Can be [Axis.horizontal] for a row or [Axis.vertical] for a column. Defaults to horizontal. |
| `count` | `int` | The number of dots to display.  Defaults to `3`. |
| `size` | `double?` | The size (diameter) of each dot.  If `null`, calculates size based on the text style font size (20% of font size). |
| `color` | `Color?` | The color of the dots.  If `null`, uses the current text color from the theme. |
| `spacing` | `double` | The spacing between dots.  Defaults to `2`. |
| `padding` | `EdgeInsetsGeometry?` | Padding around the entire dots group.  If `null`, no padding is applied. |
