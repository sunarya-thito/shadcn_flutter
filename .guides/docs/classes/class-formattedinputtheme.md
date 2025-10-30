---
title: "Class: FormattedInputTheme"
description: "Theme configuration for [FormattedInput] widget styling."
---

```dart
/// Theme configuration for [FormattedInput] widget styling.
///
/// Defines visual properties for formatted input components including
/// height and padding. Applied globally through [ComponentTheme] or per-instance.
class FormattedInputTheme {
  /// The height of the formatted input.
  final double? height;
  /// Internal padding for the formatted input.
  final EdgeInsetsGeometry? padding;
  /// Creates a [FormattedInputTheme].
  const FormattedInputTheme({this.height, this.padding});
  /// Creates a copy of this theme with specified properties overridden.
  FormattedInputTheme copyWith({ValueGetter<double?>? height, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
