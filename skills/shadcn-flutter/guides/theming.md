# Theming

A powerful, token-based design system that gives you complete control over every visual aspect of your application.

## ThemeData

`ThemeData` is the heart of the system. It contains the core design tokens:

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `colorScheme` | `ColorScheme` | `Slate` | The primary color palette. |
| `radius` | `double` | `0.5` | Multiplier for border radius. |
| `scaling` | `double` | `1.0` | Global size scaling factor. |
| `typography` | `Typography` | `Geist` | Font families and text styles. |
| `iconTheme` | `IconThemeProperties` | — | Sizes and colors for icons. |
| `density` | `Density` | — | Compactness of the UI. |

### Global Customization
```dart
ShadcnApp(
  theme: ThemeData(
    colorScheme: ColorSchemes.lightZinc,
    radius: 0.7, // Rounder corners
    scaling: 1.1, // Slightly larger UI
  ),
  darkTheme: ThemeData.dark(
    colorScheme: ColorSchemes.darkZinc,
  ),
)
```

## Component Themes

If you need to customize a specific component type globally without affecting others, use `ComponentTheme`.

Each component has a corresponding `[Component]Theme` class (e.g., `ButtonTheme`, `AccordionTheme`).

### Global Override
```dart
ShadcnApp(
  builder: (context, child) {
    return ComponentTheme<ButtonTheme>(
      data: const ButtonTheme(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: child!,
    );
  },
)
```

### Local Decoration
You can wrap any subtree with `ComponentTheme` to localize changes:
```dart
ComponentTheme<AccordionTheme>(
  data: const AccordionTheme(
    animationDuration: Duration(milliseconds: 500),
  ),
  child: const MyAccordion(),
)
```

## Dark Mode

`ShadcnApp` provides first-class support for dark mode via the `darkTheme` and `themeMode` properties.

- `ThemeMode.system`: Follow device settings (default).
- `ThemeMode.light`: Always use light theme.
- `ThemeMode.dark`: Always use dark theme.

You can toggle this dynamically using a `ThemeController` or by updating the `ShadcnApp` state.

## Adaptive Scaling

The system uses `AdaptiveScaling` to automatically adjust text and icon sizes based on the platform (e.g., larger on Mobile, standard on Desktop). See the [Layout Guide](./layout.md) for more details.
