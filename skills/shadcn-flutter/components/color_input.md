# ColorInputTheme

Theme configuration for [ColorInput] widget styling and behavior.

## Usage

// No examples found for color_input

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `showAlpha` | `bool?` | Whether to display alpha (transparency) controls by default.  When true, color pickers include alpha/opacity sliders and inputs. When false, only RGB/HSV controls are shown. Individual components can override this theme setting. |
| `popoverAlignment` | `AlignmentGeometry?` | Alignment point on the popover for anchor attachment.  Determines where the color picker popover positions itself relative to the anchor widget. When null, uses framework default alignment. |
| `popoverAnchorAlignment` | `AlignmentGeometry?` | Alignment point on the anchor widget for popover positioning.  Specifies which part of the trigger widget the popover should align to. When null, uses framework default anchor alignment. |
| `popoverPadding` | `EdgeInsetsGeometry?` | Internal padding applied to the color picker popover content.  Controls spacing around the color picker interface within the popover container. When null, uses framework default padding. |
| `mode` | `PromptMode?` | Default interaction mode for color input triggers.  Determines whether color selection opens a popover or modal dialog. When null, uses framework default prompt mode behavior. |
| `pickerMode` | `ColorPickerMode?` | Default color picker interface type.  Specifies whether to use HSV, HSL, or other color picker implementations. When null, uses framework default picker mode. |
| `enableEyeDropper` | `bool?` | Whether to enable screen color sampling functionality.  When true, color pickers include tools to sample colors directly from the screen. Platform support varies. When null, uses framework default. |
| `showLabel` | `bool?` | Whether to display color value labels in picker interfaces.  When true, shows numeric color values (hex, RGB, HSV, etc.) alongside visual color pickers. When null, uses framework default label visibility. |
| `orientation` | `Axis?` | The orientation of the color input layout. |
| `showHistory` | `bool?` | Whether to show the color history panel. |
