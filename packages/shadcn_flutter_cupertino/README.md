# shadcn_flutter_cupertino

Cupertino interop for
[shadcn_flutter](https://pub.dev/packages/shadcn_flutter).

`shadcn_flutter` is built on `package:flutter/widgets.dart` alone — it depends on
neither Material nor Cupertino, following Flutter's move of those libraries out
of the framework and into the `material_ui` and `cupertino_ui` packages. Add this
package when your app uses Cupertino widgets alongside shadcn_flutter
components.

## Install

```shell
flutter pub add shadcn_flutter_cupertino
```

This pulls in `cupertino_ui` transitively. Add it directly too if you import its
widgets in your own code, which you almost always will:

```shell
flutter pub add cupertino_ui
```

## Use

`CupertinoShadcnApp` is a drop-in replacement for `ShadcnApp`. It takes exactly
the same parameters, registers the Cupertino localizations, and installs the
`CupertinoTheme` ancestor that Cupertino widgets read from.

```dart
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_cupertino/shadcn_flutter_cupertino.dart';

void main() {
  runApp(
    CupertinoShadcnApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorSchemes.lightZinc(),
        radius: 0.5,
      ),
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Hybrid app'),
        ),
        child: const Center(
          child: PrimaryButton(child: Text('A shadcn button')),
        ),
      ),
    ),
  );
}
```

The Cupertino theme is derived from the shadcn theme, so it follows it
automatically — including `darkTheme` and `themeMode` switches. Pass
`cupertinoTheme` to override it.

### One subtree only

If Cupertino widgets appear in only part of the app, keep the plain `ShadcnApp`
and wrap that subtree in a `CupertinoLayer`. Register the localizations
delegates at the app level: delegates have to sit above the `Localizations`
widget, so a layer alone cannot add them.

```dart
ShadcnApp(
  localizationsDelegates: kCupertinoLocalizationsDelegates,
  home: Builder(
    builder: (context) {
      return CupertinoLayer(
        child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Only this screen'),
          ),
          child: const SizedBox.shrink(),
        ),
      );
    },
  ),
);
```

### The other direction

To use shadcn_flutter components inside an existing `CupertinoApp`, you need
neither this package nor any special setup: wrap the subtree in `ShadcnLayer`,
or a single widget in `ShadcnUI`.

## What this package exports

| Symbol | What it does |
| --- | --- |
| `CupertinoShadcnApp` | `ShadcnApp` plus Cupertino theme and localizations. |
| `CupertinoLayer` | Installs `CupertinoTheme` around a subtree. |
| `cupertinoThemeFor(ThemeData)` | Derives a `CupertinoThemeData` from a shadcn `ThemeData`. |
| `kCupertinoLocalizationsDelegates` | The delegates Cupertino widgets require. |
| `buildCupertinoEditableTextContextMenu` | iOS-style text selection toolbar, the old `TextField.cupertinoContextMenuBuilder()`. |
| `buildCupertinoSpellCheckSuggestionsToolbar` | iOS-style spell check toolbar. |
| `CupertinoIcons`, `CupertinoPage`, `CupertinoPageRoute` | Re-exported from `cupertino_ui`. |
| `cupertinoDesktopTextSelectionControls` and friends | Re-exported; these used to come from `shadcn_flutter`. |

Everything else comes from `package:cupertino_ui/cupertino_ui.dart` — import it
directly, with a prefix if its names collide with shadcn_flutter's.

## Links

- [Material/Cupertino guide](https://sunarya-thito.github.io/shadcn_flutter/#/external)
- [shadcn_flutter on pub.dev](https://pub.dev/packages/shadcn_flutter)
- [shadcn_flutter_material](https://pub.dev/packages/shadcn_flutter_material)
