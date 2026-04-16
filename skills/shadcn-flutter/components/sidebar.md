# NavigationSidebar

A full-width navigation sidebar component for comprehensive navigation.

## Usage

No examples found for sidebar.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `backgroundColor` | `Color?` | Background color for the navigation sidebar surface.  Sets the sidebar's background color to provide visual separation from content areas. When null, uses the theme's default surface color. |
| `children` | `List<Widget>` | List of navigation items to display in the sidebar.  Each item should be a widget that defines the navigation destination. Items are arranged vertically with full-width presentation. |
| `header` | `List<Widget>?` | Optional fixed header items displayed before the scrollable content. |
| `footer` | `List<Widget>?` | Optional fixed footer items displayed after the scrollable content. |
| `spacing` | `double?` | Spacing between navigation items.  Controls the vertical gap between adjacent navigation items. Larger values create more breathing room in the navigation list. |
| `labelType` | `NavigationLabelType` | Label display behavior for navigation items.  Determines how labels are presented in the sidebar. Sidebars typically use expanded label types to show comprehensive navigation information. |
| `labelPosition` | `NavigationLabelPosition` | Position of labels relative to icons within items.  Controls label placement within each navigation item. Sidebars commonly position labels to the end (right in LTR layouts) of icons. |
| `labelSize` | `NavigationLabelSize` | Size variant for label text and item dimensions.  Affects text size and overall item scale. Larger sizes improve accessibility and visual prominence in sidebar contexts. |
| `padding` | `EdgeInsetsGeometry?` | Internal padding applied within the navigation sidebar.  Provides space around navigation items, preventing them from touching the sidebar's edges and creating visual comfort. |
| `constraints` | `BoxConstraints?` | Size constraints for the navigation sidebar container.  Defines width and height bounds for the sidebar. Useful for responsive layouts and consistent sidebar sizing. |
| `selectedKey` | `Key?` | Key of the currently selected navigation item.  Highlights the corresponding item with selected styling. When null, no item appears selected. |
| `onSelected` | `ValueChanged<Key?>?` | Callback invoked when a navigation item is selected.  Called with the key of the selected item. Use this to update the selection state and handle navigation actions. |
| `surfaceOpacity` | `double?` | Opacity level for surface background effects.  Controls transparency of background overlays and blur effects. Values range from 0.0 (transparent) to 1.0 (opaque). |
| `surfaceBlur` | `double?` | Blur intensity for surface background effects.  Controls backdrop blur effects behind the sidebar surface. Higher values create more pronounced blur effects. |
| `expanded` | `bool` | Whether the sidebar should expand to fill available width.  When true, the sidebar uses all available horizontal space. When false, the sidebar sizes itself to its content width. |
| `keepCrossAxisSize` | `bool` | Whether to maintain intrinsic size along the cross axis.  Controls width sizing behavior when the sidebar's width constraints are unconstrained. |
| `keepMainAxisSize` | `bool` | Whether to maintain intrinsic size along the main axis.  Controls height sizing behavior when the sidebar's height constraints are unconstrained. |
