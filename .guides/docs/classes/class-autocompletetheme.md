---
title: "Class: AutoCompleteTheme"
description: "Theme configuration for [AutoComplete] widget styling and behavior.   Defines the visual appearance and positioning of the autocomplete popover  that displays suggestions. All properties are optional and will fall back  to sensible defaults when not specified.   This theme can be applied globally through [ComponentTheme] or passed  directly to individual [AutoComplete] widgets for per-instance customization."
---

```dart
/// Theme configuration for [AutoComplete] widget styling and behavior.
///
/// Defines the visual appearance and positioning of the autocomplete popover
/// that displays suggestions. All properties are optional and will fall back
/// to sensible defaults when not specified.
///
/// This theme can be applied globally through [ComponentTheme] or passed
/// directly to individual [AutoComplete] widgets for per-instance customization.
class AutoCompleteTheme extends ComponentThemeData {
  /// Constraints applied to the autocomplete popover container.
  ///
  /// Controls the maximum/minimum dimensions of the suggestion list popover.
  /// Defaults to a maximum height of 300 logical pixels when null.
  final BoxConstraints? popoverConstraints;
  /// Overrides the [OverlayConfiguration] used to present the suggestion
  /// popover, when not overridden per-instance by [AutoComplete.overlayConfiguration].
  final OverlayConfiguration? overlayConfiguration;
  /// Whether the suggestion popover may adapt to a different presentation on
  /// mobile platforms (see [showOverlay]'s `adaptive` parameter), when not
  /// overridden per-instance by [AutoComplete.adaptiveOverlay].
  final bool? adaptiveOverlay;
  /// Default mode for how suggestions are applied to text fields.
  ///
  /// Controls the text replacement strategy when a suggestion is selected.
  /// Defaults to [AutoCompleteMode.replaceWord] when null.
  final AutoCompleteMode? mode;
  /// Creates an [AutoCompleteTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  const AutoCompleteTheme({this.popoverConstraints, this.overlayConfiguration, this.adaptiveOverlay, this.mode});
  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  AutoCompleteTheme copyWith({ValueGetter<BoxConstraints?>? popoverConstraints, ValueGetter<OverlayConfiguration?>? overlayConfiguration, ValueGetter<bool?>? adaptiveOverlay, ValueGetter<AutoCompleteMode?>? mode});
  bool operator ==(Object other);
  int get hashCode;
}
```
