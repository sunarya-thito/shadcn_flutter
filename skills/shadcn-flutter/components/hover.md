# HoverTheme

Theme configuration for hover-related widgets and behaviors.

## Usage

// No examples found for hover

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `debounceDuration` | `Duration?` | Debounce duration for repeated hover events.  When set, hover callbacks are throttled to fire at most once per this duration. |
| `hitTestBehavior` | `HitTestBehavior?` | Hit test behavior for hover detection.  Determines how the widget participates in hit testing for mouse events. |
| `waitDuration` | `Duration?` | Wait duration before showing hover feedback (e.g., tooltips).  Delays the appearance of hover-triggered UI to avoid flashing on quick passes. |
| `minDuration` | `Duration?` | Minimum duration to keep hover feedback visible once shown.  Prevents hover UI from disappearing too quickly. |
| `showDuration` | `Duration?` | Duration for hover feedback show animations. |
