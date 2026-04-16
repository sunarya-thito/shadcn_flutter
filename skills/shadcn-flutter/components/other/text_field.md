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

