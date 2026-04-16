# Hover

A widget that manages hover state with configurable timing behavior.

## Usage

No examples found for hover.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The widget to track for hover events. |
| `onHover` | `void Function(bool hovered)` | Called with `true` when hover activates, `false` when it deactivates.  Activation respects [waitDuration] delay, and deactivation respects [minDuration]. |
| `waitDuration` | `Duration?` | Delay before activating hover after cursor enters.  Prevents accidental activation from quick cursor passes. Defaults to 500ms. |
| `minDuration` | `Duration?` | Minimum duration to keep hover active once triggered.  Prevents flickering when cursor quickly moves over the widget. Defaults to 0ms. |
| `showDuration` | `Duration?` | Total duration for hover state before auto-deactivation. |
| `hitTestBehavior` | `HitTestBehavior?` | Hit test behavior for pointer event handling. |
