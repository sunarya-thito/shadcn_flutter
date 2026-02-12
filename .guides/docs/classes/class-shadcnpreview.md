---
title: "Class: ShadcnPreview"
description: "A [Preview] that wraps the previewed widget in a [ShadcnLayer].   This is useful for testing shadcn widgets in a preview."
---

```dart
/// A [Preview] that wraps the previewed widget in a [ShadcnLayer].
///
/// This is useful for testing shadcn widgets in a preview.
class ShadcnPreview extends Preview {
  /// The color scheme to use for the preview.
  final ColorScheme? colorScheme;
  /// Creates a [ShadcnPreview].
  ///
  /// Parameters:
  /// - [colorScheme] (`ColorScheme?`, optional): The color scheme to use for the preview.
  const ShadcnPreview({super.name, super.group, super.size, super.textScaleFactor, super.wrapper, super.brightness, super.localizations, this.colorScheme});
  /// The theme builder for the [ShadcnPreview].
  ///
  /// Returns:
  /// A [PreviewThemeData] instance.
  static PreviewThemeData themeBuilder();
  Preview transform();
}
```
