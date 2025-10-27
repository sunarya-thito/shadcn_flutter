---
title: "Class: KeyboardShortcutTheme"
description: "Theme for keyboard shortcut displays."
---

```dart
/// Theme for keyboard shortcut displays.
class KeyboardShortcutTheme {
  /// Spacing between keys.
  final double? spacing;
  /// Padding inside each key display.
  final EdgeInsetsGeometry? keyPadding;
  /// Shadow applied to key displays.
  final List<BoxShadow>? keyShadow;
  /// Creates a [KeyboardShortcutTheme].
  const KeyboardShortcutTheme({this.spacing, this.keyPadding, this.keyShadow});
  /// Creates a copy with the given values replaced.
  KeyboardShortcutTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<EdgeInsetsGeometry?>? keyPadding, ValueGetter<List<BoxShadow>?>? keyShadow});
  bool operator ==(Object other);
  int get hashCode;
}
```
