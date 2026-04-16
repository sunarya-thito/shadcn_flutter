# LinearProgressIndicatorTheme

Theme configuration for [LinearProgressIndicator] components.

## Usage

// No examples found for linear_progress_indicator

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `color` | `Color?` | The primary color of the progress indicator fill.  Type: `Color?`. If null, uses theme's primary color. Applied to the filled portion that represents completion progress. |
| `backgroundColor` | `Color?` | The background color behind the progress indicator.  Type: `Color?`. If null, uses a semi-transparent version of the primary color. Visible in the unfilled portion of the progress track. |
| `minHeight` | `double?` | The minimum height of the progress indicator.  Type: `double?`. If null, defaults to 2.0 scaled by theme scaling factor. Ensures adequate visual presence while maintaining sleek appearance. |
| `borderRadius` | `BorderRadiusGeometry?` | The border radius of the progress indicator container.  Type: `BorderRadiusGeometry?`. If null, uses BorderRadius.zero for sharp edges. Applied to both the track and progress fill for consistent styling. |
| `showSparks` | `bool?` | Whether to display spark effects at the progress head.  Type: `bool?`. If null, defaults to false. When enabled, shows a radial gradient spark effect at the leading edge of the progress fill. |
| `disableAnimation` | `bool?` | Whether to disable smooth progress animations.  Type: `bool?`. If null, defaults to false. When true, progress changes instantly without transitions for performance optimization. |
