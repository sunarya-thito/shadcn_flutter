---
title: "Class: ShadcnMultiPreview"
description: "A [MultiPreview] that generates multiple [ShadcnPreview]s with different configurations."
---

```dart
/// A [MultiPreview] that generates multiple [ShadcnPreview]s with different configurations.
///
/// This is useful for testing shadcn widgets in different themes and brightness modes.
///
/// Example:
/// ```dart
/// @ShadcnMultiPreview()
/// class MyWidgetPreview extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MyWidget();
///   }
/// }
/// ```
class ShadcnMultiPreview extends MultiPreview {
  /// The name of the preview.
  final String? name;
  /// The group of the preview.
  final String? group;
  /// The size of the preview.
  final Size? size;
  /// The text scale factor of the preview.
  final double? textScaleFactor;
  /// The widget wrapper for the preview.
  final WidgetWrapper? wrapper;
  /// The brightness of the preview.
  final Brightness? brightness;
  /// The localizations for the preview.
  final PreviewLocalizationsData Function()? localizations;
  /// The dark color scheme for the preview.
  final ColorScheme? darkColorScheme;
  /// The light color scheme for the preview.
  final ColorScheme? lightColorScheme;
  /// Creates a [ShadcnMultiPreview].
  ///
  /// Parameters:
  /// - [name] (`String?`, optional): The name of the preview.
  /// - [group] (`String?`, optional): The group of the preview.
  /// - [size] (`Size?`, optional): The size of the preview.
  /// - [textScaleFactor] (`double?`, optional): The text scale factor of the preview.
  /// - [wrapper] (`WidgetWrapper?`, optional): The widget wrapper for the preview.
  /// - [brightness] (`Brightness?`, optional): The brightness of the preview.
  /// - [localizations] (`PreviewLocalizationsData Function()?`, optional): The localizations for the preview.
  /// - [darkColorScheme] (`ColorScheme?`, optional): The dark color scheme for the preview.
  /// - [lightColorScheme] (`ColorScheme?`, optional): The light color scheme for the preview.
  const ShadcnMultiPreview({this.name, this.group, this.size, this.textScaleFactor, this.wrapper, this.brightness, this.localizations, this.darkColorScheme, this.lightColorScheme});
  List<Preview> get previews;
}
```
