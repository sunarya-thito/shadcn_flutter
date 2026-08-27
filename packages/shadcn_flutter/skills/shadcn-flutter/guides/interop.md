# Material & Cupertino Interop

`shadcn_flutter` is a standalone ecosystem built on `package:flutter/widgets.dart`
alone. It depends on **neither Material nor Cupertino**, following Flutter's move
of those libraries out of the framework and into the `material_ui` and
`cupertino_ui` packages.

Interop is opt-in, through two companion packages.

| Package | Add it when |
| --- | --- |
| `shadcn_flutter` | Always. Built on `package:flutter/widgets.dart` alone. |
| `shadcn_flutter_material` | You also use Material widgets — `Scaffold`, `AppBar`, `showDialog`, `ScaffoldMessenger`, `Icons`. |
| `shadcn_flutter_cupertino` | You also use Cupertino widgets — `CupertinoPageScaffold`, `CupertinoNavigationBar`, `showCupertinoDialog`, `CupertinoIcons`. |

> [!IMPORTANT]
> A bare `ShadcnApp` no longer installs `Theme`, `Material`, `ScaffoldMessenger`
> or `CupertinoTheme`, and no longer registers the Material and Cupertino
> localizations delegates. Material or Cupertino widgets placed under a bare
> `ShadcnApp` will assert at build time. Use `MaterialShadcnApp` /
> `CupertinoShadcnApp`, or wrap the subtree in `MaterialLayer` / `CupertinoLayer`.

## Material or Cupertino inside Shadcn

### At the root of the app

`MaterialShadcnApp` is a drop-in replacement for `ShadcnApp`. It takes exactly the
same parameters, registers the Material localizations, and installs the Material
`Theme`, `Material` and `ScaffoldMessenger` ancestors.

```dart
import 'package:material_ui/material_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_material/shadcn_flutter_material.dart';

void main() {
  runApp(
    MaterialShadcnApp(
      title: 'My App',
      theme: ThemeData(colorScheme: ColorSchemes.lightZinc(), radius: 0.5),
      home: Scaffold(
        appBar: AppBar(title: const Text('Hybrid app')),
        body: const Center(child: PrimaryButton(child: Text('shadcn'))),
      ),
    ),
  );
}
```

`CupertinoShadcnApp` works the same way for Cupertino widgets.

### In one subtree only

Keep the plain `ShadcnApp` and wrap only the subtree that needs Material.
Localizations delegates must be registered at the app level — they have to sit
above the `Localizations` widget, so a layer alone cannot add them.

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

## Theme Synchronization

The Material and Cupertino themes are **derived from the shadcn theme**, so they
follow it automatically — including `darkTheme` and `themeMode` switches. No
extra wiring is needed.

To override, pass `materialTheme` / `cupertinoTheme` to the app widget, or
`theme:` to the layer. `materialThemeFor(ThemeData)` and
`cupertinoThemeFor(ThemeData)` expose the derivation if you want to start from it
and tweak:

```dart
MaterialShadcnApp(
  materialTheme: materialThemeFor(myShadcnTheme).copyWith(
    splashFactory: NoSplash.splashFactory,
  ),
  // ...
);
```

## Shadcn inside Material or Cupertino

This direction needs **neither companion package**. Wrap a subtree in
`ShadcnLayer` (full theme, toasts, overlays), or a single widget in `ShadcnUI`
(inherited text and icon styling only).

```dart
// Inside a Material Scaffold
shadcn.ShadcnUI(
  child: shadcn.Card(
    child: Text('Shadcn Card inside Material!'),
  ),
)
```

> [!IMPORTANT]
> Without the `ShadcnUI` (or `ShadcnLayer`) wrapper, components may not inherit
> the correct styling tokens (like radius or surface colors).

## What moved out of `shadcn_flutter`

| Before | Now |
| --- | --- |
| `Icons.add` | `LucideIcons.plus` (core), or `Icons` from `shadcn_flutter_material` |
| `MaterialPageRoute`, `MaterialPage` | `ShadcnPageRoute`, `ShadcnPage` (core) |
| `SliverAppBar` | `SliverPersistentHeader` (core), or `SliverAppBar` from `shadcn_flutter_material` |
| `cupertinoDesktopTextSelectionHandleControls` | `shadcnTextSelectionHandleControls` (core) |
| `TextField.nativeContextMenuBuilder()` | `buildAdaptiveEditableTextContextMenu` (material package) |
| `TextField.materialContextMenuBuilder()` | `buildMaterialEditableTextContextMenu` (material package) |
| `TextField.cupertinoContextMenuBuilder()` | `buildCupertinoEditableTextContextMenu` (cupertino package) |
| `CupertinoSpellCheckSuggestionsToolbar` | `SpellCheckSuggestionsToolbar` (core) |
| `ShadcnApp.materialTheme` / `.cupertinoTheme` | `MaterialShadcnApp.materialTheme` / `CupertinoShadcnApp.cupertinoTheme` |
| `ShadcnApp.debugShowMaterialGrid` | `ShadcnApp.debugShowGrid` (core) |
| `SelectableText.useNativeContextMenu` | Pass `contextMenuBuilder` directly |

`FlutterLogo` was never Material-only; it still comes from
`package:flutter/widgets.dart`, which `shadcn_flutter` re-exports.

## Best Practices

- **Prefer the core replacements.** `LucideIcons`, `ShadcnPageRoute` and
  `SpellCheckSuggestionsToolbar` keep the dependency graph free of `material_ui`.
- **Avoid Theme Conflicts**: if you are using `MaterialApp`, ensure you don't have
  conflicting global styles that override the tokens intended for
  `shadcn_flutter` components.
- **Incremental Migration**: start by replacing complex UI sections (data tables,
  forms) with `shadcn_flutter` components while leaving the navigation shell as
  Material/Cupertino.
- **Go All-In**: once the main components are migrated, switch the root widget to
  `ShadcnApp` and drop the companion package entirely.
