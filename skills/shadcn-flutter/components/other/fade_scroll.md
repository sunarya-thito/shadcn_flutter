# FadeScroll

A widget that applies fade effects at the edges of scrollable content.

## Usage

### Basic Example
```dart
FadeScroll(
  child: null, // TODO: Provide child
  controller: null, // TODO: Provide controller
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `startOffset` | `double?` | The offset from the start where the fade begins. |
| `endOffset` | `double?` | The offset from the end where the fade begins. |
| `startCrossOffset` | `double` | The cross-axis offset for the start fade. |
| `endCrossOffset` | `double` | The cross-axis offset for the end fade. |
| `child` | `Widget` | The scrollable child widget. |
| `controller` | `ScrollController` | The scroll controller to monitor for scroll position. |
| `gradient` | `List<Color>?` | The gradient colors for the fade effect. |
