# NavigationRail

A standard navigation rail component for sidebar-style navigation.

## Usage

No examples found for rail.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `backgroundColor` | `Color?` | Background color of the navigation rail. |
| `alignment` | `NavigationRailAlignment` | Alignment of navigation items along the main axis. |
| `direction` | `Axis` | Layout direction (horizontal or vertical). |
| `spacing` | `double?` | Spacing between navigation items. |
| `labelType` | `NavigationLabelType` | Type of label display behavior. |
| `labelPosition` | `NavigationLabelPosition` | Position of labels relative to icons. |
| `labelSize` | `NavigationLabelSize` | Size variant for labels. |
| `padding` | `EdgeInsetsGeometry?` | Internal padding of the navigation rail. |
| `constraints` | `BoxConstraints?` | Constraints for the navigation rail container. |
| `expandedSize` | `double?` | Cross-axis size when the rail is expanded. |
| `collapsedSize` | `double?` | Cross-axis size when the rail is collapsed. |
| `surfaceOpacity` | `double?` | Surface opacity effect for the background. |
| `surfaceBlur` | `double?` | Surface blur effect for the background. |
| `expanded` | `bool` | Whether the rail is in its expanded state. |
| `keepMainAxisSize` | `bool` | Whether to maintain intrinsic size along the main axis. |
| `keepCrossAxisSize` | `bool` | Whether to maintain intrinsic size along the cross axis. |
| `header` | `List<Widget>?` | Optional header widget displayed at the start of the rail. |
| `footer` | `List<Widget>?` | Optional footer widget displayed at the end of the rail. |
| `children` | `List<Widget>` | List of navigation items to display. |
| `selectedKey` | `Key?` | Currently selected item key. |
| `onSelected` | `ValueChanged<Key?>?` | Callback when an item is selected. |
