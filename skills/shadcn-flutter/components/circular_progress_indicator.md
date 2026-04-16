# CircularProgressIndicatorTheme

Theme configuration for [CircularProgressIndicator] components.

## Usage

// No examples found for circular_progress_indicator

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `color` | `Color?` | The primary color of the progress indicator arc.  Type: `Color?`. If null, uses theme's primary color or background color when [onSurface] is true. Applied to the filled portion of the circular track. |
| `backgroundColor` | `Color?` | The background color of the progress indicator track.  Type: `Color?`. If null, uses a semi-transparent version of the primary color. Visible in the unfilled portion of the circular track. |
| `size` | `double?` | The diameter size of the circular progress indicator.  Type: `double?`. If null, derives size from current icon theme size minus padding. Determines the overall dimensions of the circular progress display. |
| `strokeWidth` | `double?` | The width of the progress indicator stroke.  Type: `double?`. If null, calculates as size/12 for proportional appearance. Controls the thickness of both the progress arc and background track. |
