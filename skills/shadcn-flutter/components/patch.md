# ClickDetails

Details about a click event, including the click count.

## Usage

### Basic Example
```dart
ClickDetails(
  clickCount: null, // TODO: Provide clickCount
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `clickCount` | `int` | The number of consecutive clicks within the threshold period.  Increments for each click that occurs within [ClickDetector.threshold] duration of the previous click. Resets to 1 when threshold is exceeded. |
