# DrawerContainer

A drawer container that takes only a [child] and reads the rest of its
configuration from an ancestor [DrawerContainerData] (provided via a [Data]
widget, e.g. by a [PinnedSheet]). Delegates to [DrawerRawContainer].

## Usage

### Basic Example
```dart
DrawerContainer(
  child: null, // TODO: Provide child
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The sheet content. |
| `startPadding` | `double` | Cross-axis padding on the leading edge. |
| `endPadding` | `double` | Cross-axis padding on the trailing edge. |
| `size` | `AxisSize?` | Optional cross-axis size (so the sheet doesn't stretch edge-to-edge). |
| `alignment` | `double` | Cross-axis alignment in `[-1, 1]`. |
