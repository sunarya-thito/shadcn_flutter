# OutlinedContainer

A container widget with customizable border and surface effects.

## Usage

### Basic Example
```dart
OutlinedContainer(
  borderRadius: BorderRadius.circular(12),
  borderColor: Colors.blue,
  backgroundColor: Colors.white,
  padding: EdgeInsets.all(16),
  child: Text('Outlined content'),
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The child widget to display inside the container. |
| `backgroundColor` | `Color?` | Background color of the container.  If `null`, uses theme default. |
| `borderColor` | `Color?` | Color of the container's border.  If `null`, uses theme default. |
| `clipBehavior` | `Clip` | How to clip the container's content.  Defaults to [Clip.antiAlias]. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for rounded corners.  If `null`, uses theme default. |
| `borderStyle` | `BorderStyle?` | Style of the border.  If `null`, uses [BorderStyle.solid]. |
| `borderWidth` | `double?` | Width of the border in logical pixels.  If `null`, uses theme default. |
| `boxShadow` | `List<BoxShadow>?` | Box shadows for elevation effects.  If `null`, no shadows are applied. |
| `padding` | `EdgeInsetsGeometry?` | Padding inside the container.  If `null`, uses theme default. |
| `surfaceOpacity` | `double?` | Opacity for surface overlay effects.  If provided, modulates the background color's alpha. |
| `surfaceBlur` | `double?` | Blur amount for surface backdrop effects.  If `null` or `<= 0`, no blur is applied. |
| `width` | `double?` | Explicit width of the container.  If `null`, size is determined by child and padding. |
| `height` | `double?` | Explicit height of the container.  If `null`, size is determined by child and padding. |
| `duration` | `Duration?` | Duration for animating property changes.  If `null`, changes are applied immediately without animation. |
