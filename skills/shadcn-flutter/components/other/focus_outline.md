# FocusOutline

A widget that displays a visual outline when focused.

## Usage

### Basic Example
```dart
FocusOutline(
  focused: hasFocus,
  borderRadius: BorderRadius.circular(8),
  child: TextButton(
    onPressed: () {},
    child: Text('Focused Button'),
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
| `child` | `Widget` | The child widget to wrap with the focus outline. |
| `focused` | `bool` | Whether to display the focus outline.  When `true`, the outline is visible. When `false`, it's hidden. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for the focus outline corners.  If `null`, uses the default from [FocusOutlineTheme]. |
| `align` | `double?` | Alignment offset for positioning the outline.  If `null`, uses the default from [FocusOutlineTheme]. |
| `border` | `Border?` | The border style for the outline.  If `null`, uses the default from [FocusOutlineTheme]. |
| `shape` | `BoxShape?` | The shape of the outline.  Can be [BoxShape.rectangle] or [BoxShape.circle]. |
