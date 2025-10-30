---
title: "Class: ChipInputTheme"
description: "Theme configuration for [ChipInput] widget styling and behavior."
---

```dart
/// Theme configuration for [ChipInput] widget styling and behavior.
///
/// Defines visual properties and default behaviors for chip input components
/// including popover constraints and chip rendering preferences. Applied globally
/// through [ComponentTheme] or per-instance for customization.
class ChipInputTheme {
  /// Whether to render selected items as interactive chip widgets by default.
  ///
  /// When true, selected items appear as dismissible chip widgets with close buttons.
  /// When false, items appear as simple text tokens. Individual [ChipInput] widgets
  /// can override this default behavior.
  final bool? useChips;
  /// The spacing between chips.
  final double? spacing;
  /// Creates a [ChipInputTheme].
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// The theme can be applied globally or to specific chip input instances.
  const ChipInputTheme({this.spacing, this.useChips});
  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  ChipInputTheme copyWith({ValueGetter<BoxConstraints?>? popoverConstraints, ValueGetter<bool?>? useChips, ValueGetter<double?>? spacing});
  bool operator ==(Object other);
  int get hashCode;
}
```
