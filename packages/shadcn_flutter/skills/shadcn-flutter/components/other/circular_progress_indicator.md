# CircularProgressIndicator

A circular progress indicator that displays task completion as a rotating arc.

## Usage

### Basic Example
```dart
CircularProgressIndicator(
  value: 0.75,
  size: 32.0,
  color: Colors.blue,
);
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `value` | `double?` | The progress completion value between 0.0 and 1.0.  Type: `double?`. If null, displays indeterminate spinning animation. When provided, shows progress as a filled arc from 0% to value*100%. |
| `size` | `double?` | The explicit diameter size of the progress indicator.  Type: `double?`. If null, derives size from current icon theme size minus theme scaling padding. Overrides theme and automatic sizing. |
| `color` | `Color?` | The primary color of the progress arc.  Type: `Color?`. If null, uses theme color or background color when [onSurface] is true. Overrides theme configuration. |
| `backgroundColor` | `Color?` | The background color of the progress track.  Type: `Color?`. If null, uses a semi-transparent version of the primary color. Overrides theme configuration. |
| `strokeWidth` | `double?` | The width of the progress stroke line.  Type: `double?`. If null, calculates proportionally as size/12. Controls the thickness of both progress and background arcs. |
| `duration` | `Duration` | The duration for smooth progress value transitions.  Type: `Duration`, default: [kDefaultDuration]. Only applied when [animated] is true and [value] is provided for determinate progress. |
| `animated` | `bool` | Whether to animate progress value changes.  Type: `bool`, default: `true`. When false, progress changes instantly. When true with determinate value, uses [AnimatedValueBuilder] for smooth transitions. |
| `onSurface` | `bool` | Whether the indicator is displayed on a colored surface.  Type: `bool`, default: `false`. When true, uses background color instead of primary color for better visibility on colored backgrounds. |
