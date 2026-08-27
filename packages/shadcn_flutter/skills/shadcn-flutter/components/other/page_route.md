# ShadcnPageRoute

A modal route that displays a full-screen page with the shadcn transition.

## Usage

### Basic Example
```dart
Navigator.of(context).push(
  ShadcnPageRoute(builder: (context) => const SettingsPage()),
);
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `builder` | `WidgetBuilder` | Builds the primary content of the route. |
| `_opaque` | `bool` | Whether the route obscures routes behind it, see [opaque]. |
| `maintainState` | `bool` |  |
| `transitionDuration` | `Duration` |  |
| `barrierLabel` | `String?` |  |
