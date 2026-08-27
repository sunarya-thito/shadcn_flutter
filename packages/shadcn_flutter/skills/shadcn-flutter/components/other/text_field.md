# TextField

A highly customizable single-line text input widget with extensive feature support.

## Usage

### Basic Example
```dart
TextField(
  hintText: 'Enter your email',
  keyboardType: TextInputType.emailAddress,
  features: [
    InputClearFeature(),
    InputRevalidateFeature(),
  ],
  onChanged: (text) => _handleTextChange(text),
);
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `onDragSelectionStart` | `ValueChanged<TapDragStartDetails>?` | Called when a drag-to-select gesture starts inside this field.  Mirrors [TextSelectionGestureDetectorBuilder.onDragSelectionStart] so callers composing several [TextField]s together (e.g. [FormattedInput]) can track a drag that may continue outside this field's own bounds. This does not replace the field's own default drag-selection handling. |
| `onDragSelectionUpdate` | `ValueChanged<TapDragUpdateDetails>?` | Called on every update of a drag-to-select gesture started in this field.  See [onDragSelectionStart]. |
| `onDragSelectionEnd` | `ValueChanged<TapDragEndDetails>?` | Called when a drag-to-select gesture started in this field ends.  See [onDragSelectionStart]. |
