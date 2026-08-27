# shadcn_flutter_material

Material Design interop for
[shadcn_flutter](https://pub.dev/packages/shadcn_flutter).

`shadcn_flutter` is built on `package:flutter/widgets.dart` alone — it depends on
neither Material nor Cupertino, following Flutter's move of those libraries out
of the framework and into the `material_ui` and `cupertino_ui` packages. Add this
package when your app uses Material widgets alongside shadcn_flutter components.

## Install

```shell
flutter pub add shadcn_flutter_material
```

This pulls in `material_ui` transitively. Add it directly too if you import its
widgets in your own code, which you almost always will:

```shell
flutter pub add material_ui
```

## Use

`MaterialShadcnApp` is a drop-in replacement for `ShadcnApp`. It takes exactly
the same parameters, registers the Material localizations, and installs the
`Theme`, `Material` and `ScaffoldMessenger` ancestors that Material widgets need
in order to build.

```dart
import 'package:material_ui/material_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_material/shadcn_flutter_material.dart';

void main() {
  runApp(
    MaterialShadcnApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorSchemes.lightZinc(),
        radius: 0.5,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Hybrid app')),
        body: const Center(
          child: PrimaryButton(child: Text('A shadcn button')),
        ),
      ),
    ),
  );
}
```

The Material theme is derived from the shadcn theme, so it follows it
automatically — including `darkTheme` and `themeMode` switches. Pass
`materialTheme` to override it.

### One subtree only

If Material widgets appear in only part of the app, keep the plain `ShadcnApp`
and wrap that subtree in a `MaterialLayer`. Register the localizations delegates
at the app level: delegates have to sit above the `Localizations` widget, so a
layer alone cannot add them.

```dart
ShadcnApp(
  localizationsDelegates: kMaterialLocalizationsDelegates,
  home: Builder(
    builder: (context) {
      return MaterialLayer(
        child: Scaffold(
          appBar: AppBar(title: const Text('Only this screen')),
          body: const SizedBox.shrink(),
        ),
      );
    },
  ),
);
```

### The other direction

To use shadcn_flutter components inside an existing `MaterialApp`, you need
neither this package nor any special setup: wrap the subtree in `ShadcnLayer`,
or a single widget in `ShadcnUI`.

## What this package exports

| Symbol | What it does |
| --- | --- |
| `MaterialShadcnApp` | `ShadcnApp` plus Material theme, ancestors and localizations. |
| `MaterialLayer` | Installs `Theme`, `Material` and `ScaffoldMessenger` around a subtree. |
| `materialThemeFor(ThemeData)` | Derives a Material `ThemeData` from a shadcn `ThemeData`. |
| `kMaterialLocalizationsDelegates` | The delegates Material widgets require. |
| `buildAdaptiveEditableTextContextMenu` | Platform-native text selection toolbar, the old `TextField.nativeContextMenuBuilder()`. |
| `buildMaterialEditableTextContextMenu` | Material text selection toolbar on every platform. |
| `buildMaterialSpellCheckSuggestionsToolbar` | Android-style spell check toolbar. |
| `Icons`, `MaterialPage`, `MaterialPageRoute`, `SliverAppBar` | Re-exported from `material_ui`; these used to come from `shadcn_flutter`. |

Everything else comes from `package:material_ui/material_ui.dart` — import it
directly, with a prefix if its names collide with shadcn_flutter's.

## Links

- [Material/Cupertino guide](https://sunarya-thito.github.io/shadcn_flutter/#/external)
- [shadcn_flutter on pub.dev](https://pub.dev/packages/shadcn_flutter)
- [shadcn_flutter_cupertino](https://pub.dev/packages/shadcn_flutter_cupertino)
