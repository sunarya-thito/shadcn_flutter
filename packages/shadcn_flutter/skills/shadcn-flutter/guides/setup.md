# Setup Guide

Install and configure `shadcn_flutter` in your project.

## Installation

### 1. Creating a new Flutter project
Create a new Flutter project using the following command:
```shell
flutter create my_app
cd my_app
```

### 2. Adding the dependency
Next, add the `shadcn_flutter` dependency to your project.
```shell
flutter pub add shadcn_flutter
```

### 3. Importing the package
Now, you can import the package in your Dart code.
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
```

### 4. Adding the ShadcnApp widget
Add the `ShadcnApp` widget to your main function. This widget replaces `MaterialApp` or `CupertinoApp`.
```dart
void main() {
  runApp(
    ShadcnApp(
      title: 'My App',
      home: MyHomePage(),
    ),
  );
}
```

### 5. Run the app
Run the app using the following command:
```shell
flutter run
```

## Experimental Version

Experimental versions are available on GitHub. To use an experimental version, use git instead of version number in your `pubspec.yaml` file:

```yaml
dependencies:
  shadcn_flutter:
    git:
      url: "https://github.com/sunarya-thito/shadcn_flutter.git"
```

> [!WARNING]
> Experimental versions may contain breaking changes and are not recommended for production use. This version is intended for testing and development purposes only.

## Features

- **84+ components** and growing!
- **Standalone ecosystem**: No Material or Cupertino requirement; optional interop when needed.
- **shadcn/ui design tokens** and ready-to-use New York theme.
- **Cross-platform**: First-class support across Android, iOS, Web, macOS, Windows, and Linux.
- **Typography extensions**: Various widget extensions for typography purposes.
- **WebAssembly support**: Optimized for performance on the web.

## Frequently Asked Questions

### Does this support GoRouter?
Yes, it does. You can use GoRouter with `shadcn_flutter`.

### Can I use this with Material/Cupertino Widgets?
Yes. If your app already uses Material or Cupertino, `shadcn_flutter` plays nicely with both. You can drop `shadcn_flutter` components into an existing `MaterialApp`/`CupertinoApp` and adopt incrementally.
