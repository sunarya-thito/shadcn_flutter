# NavigationControlData

Data class containing navigation control configuration and state.

## Usage

No examples found for data.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `containerType` | `NavigationContainerType` | Type of navigation container (bar, rail, etc.). |
| `parentLabelType` | `NavigationLabelType` | Label display type from parent container. |
| `parentLabelPosition` | `NavigationLabelPosition` | Label position relative to icon from parent. |
| `parentLabelSize` | `NavigationLabelSize` | Label size variant from parent. |
| `parentPadding` | `EdgeInsets` | Padding applied by parent container. |
| `direction` | `Axis` | Layout direction (horizontal or vertical). |
| `selectedKey` | `Key?` | Currently selected item key (null if none selected). |
| `childCount` | `int` | Total number of child items. |
| `onSelected` | `ValueChanged<Key?>?` | Callback when an item is selected. |
| `expanded` | `bool` | Whether the navigation is expanded to fill available space. |
| `spacing` | `double` | Spacing between navigation items. |
| `keepCrossAxisSize` | `bool` | Whether to maintain cross-axis size constraints. |
| `keepMainAxisSize` | `bool` | Whether to maintain main-axis size constraints. |
