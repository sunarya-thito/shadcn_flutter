# Validated

A widget that displays validation feedback for form entries.

## Usage

### Basic Example
```dart
Validated<String>(
  validator: (value) => value.isEmpty ? ValidationResult.error('Required') : null,
  builder: (context, error, child) {
    return Column(
      children: [
        child!,
        if (error != null) Text(error.message, style: TextStyle(color: Colors.red)),
      ],
    );
  },
  child: TextField(),
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `builder` | `ValidatedBuilder` | Builder function that creates the widget based on validation state. |
| `validator` | `Validator<T>` | The validator to apply to the form entry. |
| `child` | `Widget?` | Optional child widget to display. |
