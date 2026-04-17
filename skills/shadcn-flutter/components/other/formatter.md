# TextInputFormatters

Provides factory methods for common text input formatters.

## Usage

### Basic Example
```dart
TextField(
  inputFormatters: [
    TextInputFormatters.toUpperCase,
    TextInputFormatters.integerOnly(min: 0, max: 100),
  ],
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `toUpperCase` | `TextInputFormatter` | Converts all input text to uppercase. |
| `toLowerCase` | `TextInputFormatter` | Converts all input text to lowercase. |
