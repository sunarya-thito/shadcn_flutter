# OverlayConfiguration

Describes *what* overlay to show and *how*, independent of the specific
mechanism (popover, drawer, sheet, dialog, menu, tooltip).

## Usage

### Basic Example
```dart
showOverlay(
  context,
  PopoverConfiguration(
    alignment: Alignment.topCenter,
  ),
  builder: (context) => const Text('Popover content'),
);
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |

