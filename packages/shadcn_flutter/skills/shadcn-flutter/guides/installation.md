# Installation

Install and configure `shadcn_flutter` in your project.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.47.0 or newer (Dart 3.13.0), installed and configured.
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

## Material and Cupertino

`shadcn_flutter` is built on `package:flutter/widgets.dart` alone and depends on
neither Material nor Cupertino. If your app also uses widgets from those
libraries, add the matching companion package:

```bash
flutter pub add shadcn_flutter_material
# or
flutter pub add shadcn_flutter_cupertino
```

Then swap `ShadcnApp` for `MaterialShadcnApp` (or `CupertinoShadcnApp`), which
accepts exactly the same parameters and additionally installs the Material theme,
ancestors and localizations:

```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_material/shadcn_flutter_material.dart';

void main() {
  runApp(
    MaterialShadcnApp(
      title: 'My App',
      home: const MyHomePage(),
    ),
  );
}
```

See [interop.md](./interop.md) for the full migration table.

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
    GlobalWidgetsLocalizations.delegate,
    // ShadcnLocalizations.delegate is included automatically
    // Add GlobalMaterialLocalizations.delegate only if you also use
    // Material widgets, via shadcn_flutter_material.
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
