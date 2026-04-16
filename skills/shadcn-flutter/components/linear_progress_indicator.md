# LinearProgressIndicator

A sophisticated linear progress indicator with advanced visual effects.

## Usage

No examples found for linear_progress_indicator.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `_line1Head` | `Curve` | Animation curve constants for indeterminate progress motion.  These curves define the precise timing and easing for the dual-line indeterminate animation pattern, creating smooth material design motion. |
| `_line1Tail` | `Curve` |  |
| `_line2Head` | `Curve` |  |
| `_line2Tail` | `Curve` |  |
| `value` | `double?` | The progress completion value between 0.0 and 1.0.  Type: `double?`. If null, displays indeterminate animation with dual moving progress segments. When provided, shows determinate progress. |
| `backgroundColor` | `Color?` | The background color of the progress track.  Type: `Color?`. If null, uses theme background color or semi-transparent version of progress color. Overrides theme configuration. |
| `minHeight` | `double?` | The minimum height of the progress indicator.  Type: `double?`. If null, uses theme minimum height or 2.0 scaled by theme scaling factor. Overrides theme configuration. |
| `color` | `Color?` | The primary color of the progress fill.  Type: `Color?`. If null, uses theme primary color. Applied to both progress segments in indeterminate mode. Overrides theme configuration. |
| `borderRadius` | `BorderRadiusGeometry?` | The border radius of the progress container.  Type: `BorderRadiusGeometry?`. If null, uses BorderRadius.zero. Applied via [ClipRRect] to both track and progress elements. |
| `showSparks` | `bool?` | Whether to display spark effects at the progress head.  Type: `bool?`. If null, defaults to false. Shows radial gradient spark effect at the leading edge for enhanced visual feedback. |
| `disableAnimation` | `bool?` | Whether to disable smooth progress animations.  Type: `bool?`. If null, defaults to false. When true, disables [AnimatedValueBuilder] for instant progress changes. |
