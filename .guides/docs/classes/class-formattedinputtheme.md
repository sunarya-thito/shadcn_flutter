---
title: "Class: FormattedInputTheme"
description: "Theme configuration for [FormattedInput] widget styling.   Defines visual properties for formatted input components including  height and padding. Applied globally through [ComponentTheme] or per-instance."
---

```dart
/// Theme configuration for [FormattedInput] widget styling.
///
/// Defines visual properties for formatted input components including
/// height and padding. Applied globally through [ComponentTheme] or per-instance.
class FormattedInputTheme extends ComponentThemeData {
  /// The height of the formatted input.
  final double? height;
  /// Internal padding for the formatted input.
  final EdgeInsetsGeometry? padding;
  /// Overrides the [OverlayConfiguration] used to present the popup, when
  /// not overridden per-instance by [FormattedObjectInput.overlayConfiguration].
  final OverlayConfiguration? overlayConfiguration;
  /// Whether the popup may adapt to a different presentation on mobile
  /// platforms (see [showOverlay]'s `adaptive` parameter), when not
  /// overridden per-instance by [FormattedObjectInput.adaptiveOverlay].
  final bool? adaptiveOverlay;
  /// Creates a [FormattedInputTheme].
  const FormattedInputTheme({this.height, this.padding, this.overlayConfiguration, this.adaptiveOverlay});
  /// Creates a copy of this theme with specified properties overridden.
  FormattedInputTheme copyWith({ValueGetter<double?>? height, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<OverlayConfiguration?>? overlayConfiguration, ValueGetter<bool?>? adaptiveOverlay});
  bool operator ==(Object other);
  int get hashCode;
}
```
