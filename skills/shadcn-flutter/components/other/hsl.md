# HSLColorSlider

A slider widget for adjusting HSL color components.

## Usage

### Basic Example
```dart
HSLColorSlider(
  color: HSLColor.fromColor(Colors.blue),
  sliderType: HSLColorSliderType.hue,
  onChanged: (newColor) {
    print('New hue: ${newColor.hue}');
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
| `color` | `HSLColor` | The current HSL color value. |
| `onChanging` | `ValueChanged<HSLColor>?` | Called while the slider is being dragged. |
| `onChanged` | `ValueChanged<HSLColor>?` | Called when the slider interaction is complete. |
| `sliderType` | `HSLColorSliderType` | The type of HSL component(s) this slider controls. |
| `reverse` | `bool` | Whether to reverse the slider direction. |
| `radius` | `Radius` | Corner radius for the slider. |
| `padding` | `EdgeInsets` | Padding around the slider. |
