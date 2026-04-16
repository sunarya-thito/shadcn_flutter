# WrappedIcon

A widget that wraps an icon with custom theme data.

## Usage

### Basic Example
```dart
WrappedIcon(
  data: (context, theme) => IconThemeData(
    size: 24,
    color: theme.colorScheme.primary,
  ),
  child: Icon(Icons.star),
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `data` | `WrappedIconDataBuilder<IconThemeData>` | Builder function that creates the icon theme data. |
| `child` | `Widget` | The child icon widget to apply the theme to. |
