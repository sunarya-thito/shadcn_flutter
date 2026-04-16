# StageContainer

A responsive container that adapts to screen size using breakpoints.

## Usage

### Basic Example
```dart
StageContainer(
  breakpoint: StageBreakpoint.defaultBreakpoints,
  padding: EdgeInsets.symmetric(horizontal: 24),
  builder: (context, padding) {
    return Container(
      padding: padding,
      child: Text('Responsive content'),
    );
  },
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `breakpoint` | `StageBreakpoint` | The breakpoint strategy for determining container width.  Defaults to [StageBreakpoint.defaultBreakpoints]. |
| `builder` | `Widget Function(BuildContext context, EdgeInsets padding)` | Builder function that receives context and calculated padding.  The padding parameter accounts for responsive adjustments. |
| `padding` | `EdgeInsets` | Base padding for the container.  Defaults to `EdgeInsets.symmetric(horizontal: 72)`. |
