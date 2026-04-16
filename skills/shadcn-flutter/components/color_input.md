# ColorInput

A color input widget that allows users to select and edit colors.

## Usage

No examples found for color_input.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `value` | `ColorDerivative` | The current color value. |
| `onChanging` | `ValueChanged<ColorDerivative>?` | Called when the color is being changed (while dragging sliders, etc.). |
| `onChanged` | `ValueChanged<ColorDerivative>?` | Called when the color change is complete (after releasing sliders, etc.). |
| `showAlpha` | `bool?` | Whether to show alpha (opacity) controls. |
| `initialMode` | `ColorPickerMode?` | The initial color picker mode (HSV, HSL, etc.). |
| `enableEyeDropper` | `bool?` | Whether to enable the eye dropper (screen color sampling) feature. |
| `popoverAlignment` | `AlignmentGeometry?` | The alignment of the popover relative to the anchor. |
| `popoverAnchorAlignment` | `AlignmentGeometry?` | The alignment point on the anchor widget for popover positioning. |
| `popoverPadding` | `EdgeInsetsGeometry?` | Internal padding for the popover content. |
| `placeholder` | `Widget?` | Widget displayed when no color is selected. |
| `promptMode` | `PromptMode?` | The mode for presenting the color picker (popover or modal). |
| `dialogTitle` | `Widget?` | Title widget for the dialog when using modal mode. |
| `showLabel` | `bool?` | Whether to show color value labels. |
| `enabled` | `bool?` | Whether the color input is enabled. |
| `orientation` | `Axis?` | The layout orientation of the color input. |
| `showHistory` | `bool` | Whether to show the color history button. |
