# SelectableTextTheme

{@template selectable_text_theme}
Theme data for [SelectableText] to customize cursor and selection behavior.
{@endtemplate}

## Usage

// No examples found for selectable

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `cursorWidth` | `double?` | Width of the text cursor in logical pixels.  If `null`, uses the default cursor width from the platform or theme. |
| `cursorHeight` | `double?` | Height of the text cursor in logical pixels.  If `null`, the cursor height matches the line height of the text. |
| `cursorRadius` | `Radius?` | Corner radius of the text cursor.  If `null`, the cursor has square corners (no rounding). |
| `cursorColor` | `Color?` | Color of the text cursor.  If `null`, uses the theme's primary color or platform default. |
| `selectionHeightStyle` | `ui.BoxHeightStyle?` | How tall the selection highlight boxes should be.  Determines vertical sizing behavior for text selection highlights. If `null`, uses platform or theme defaults. |
| `selectionWidthStyle` | `ui.BoxWidthStyle?` | How wide the selection highlight boxes should be.  Determines horizontal sizing behavior for text selection highlights. If `null`, uses platform or theme defaults. |
| `enableInteractiveSelection` | `bool?` | Whether to enable interactive text selection (e.g., selecting with mouse/touch).  When `true`, users can select text by dragging. When `false`, text selection gestures are disabled. If `null`, uses platform defaults. |
