# Installation

Install and configure `shadcn_flutter` in your project.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured.
- A basic understanding of Flutter development.

## Quick Start

1. **Add Dependency**
   ```bash
   flutter pub add shadcn_flutter
   ```

2. **Basic Setup**
   Update your `main.dart` to use `ShadcnApp`:
   ```dart
   import 'package:shadcn_flutter/shadcn_flutter.dart';

   void main() {
     runApp(
       ShadcnApp(
         title: 'My App',
         home: const MyHomePage(),
       ),
     );
   }
   ```

## Experimental Version (GitHub)

To use the latest features from the development branch, add the package via git in your `pubspec.yaml`:

```yaml
dependencies:
  shadcn_flutter:
    git:
      url: "https://github.com/sunarya-thito/shadcn_flutter.git"
```

> [!WARNING]
> Experimental versions may contain breaking changes and are intended for testing purposes only.

## Localization

`ShadcnApp` includes built-in support for multiple languages via `ShadcnLocalizations`. By default, it supports English (`en_US`).

To support additional locales, add the delegates to your `ShadcnApp`:

```dart
ShadcnApp(
  supportedLocales: [
    Locale('en'),
    Locale('es'),
  ],
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    // ShadcnLocalizations.delegate is included automatically
  ],
  // ...
)
```

## Fonts

`shadcn_flutter` comes bundled with high-quality fonts like **Geist** for a modern look. These are automatically configured when you use `ThemeData`.

If you wish to use your own fonts, you can override the typography in `ThemeData`:

```dart
ThemeData(
  typography: Typography.sans(family: 'MyCustomFont'),
)
```

## Platform Support

Shadcn Flutter is designed to be truly cross-platform:
- **Web**: Optimized for CanvasKit and HTML renderers.
- **Desktop**: Native scrollbars and window management support.
- **Mobile**: Adaptive scaling and physics.
