# NavigationBar

A flexible navigation container widget for organizing navigation items.

## Usage

### Basic Example
```dart
NavigationBar(
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
| `children` | `List<Widget>` | The list of navigation items, dividers, or gaps to display. |
| `alignment` | `NavigationBarAlignment` | The alignment of items within the navigation bar. |
| `direction` | `Axis?` | The layout orientation of the navigation bar.  If null, defaults to [Axis.horizontal]. |
| `labelType` | `NavigationLabelType` | When labels should be displayed for the items. |
| `labelPosition` | `NavigationLabelPosition` | The relative position of labels to their corresponding icons. |
| `labelSize` | `NavigationLabelSize` | The size variant for label text. |
| `backgroundColor` | `Color?` | The background color of the navigation bar. |
| `padding` | `EdgeInsetsGeometry?` | Internal padding for the navigation bar content. |
| `surfaceOpacity` | `double?` | Opacity of the background surface (0.0 to 1.0). |
| `surfaceBlur` | `double?` | Blur intensity for glassmorphic surface effects. |
| `selectedKey` | `Key?` | The key of the currently selected navigation item. |
| `onSelected` | `ValueChanged<Key?>?` | Callback invoked when a navigation item selection changes. |
| `expanded` | `bool` | Whether the navigation bar should expand to fill available space. |
| `keepCrossAxisSize` | `bool?` | Whether to maintain the cross-axis size based on intrinsic content size. |
| `keepMainAxisSize` | `bool?` | Whether to maintain the main-axis size based on intrinsic content size. |
| `expandedSize` | `double?` | Cross-axis size when the bar is in an expanded state. |
| `collapsedSize` | `double?` | Cross-axis size when the bar is in a collapsed state. |
| `spacing` | `double?` | The spacing between navigation items. |
