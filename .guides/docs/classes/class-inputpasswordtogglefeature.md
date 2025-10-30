---
title: "Class: InputPasswordToggleFeature"
description: "Adds a password visibility toggle feature to the input field."
---

```dart
/// Adds a password visibility toggle feature to the input field.
///
/// Provides a button that allows users to toggle between showing and hiding
/// password text. Supports both hold-to-reveal and toggle modes.
///
/// Example:
/// ```dart
/// TextField(
///   obscureText: true,
///   features: [
///     InputPasswordToggleFeature(
///       mode: PasswordPeekMode.toggle,
///     ),
///   ],
/// )
/// ```
class InputPasswordToggleFeature extends InputFeature {
  /// The mode for password peeking behavior.
  final PasswordPeekMode mode;
  /// Position of the toggle button.
  final InputFeaturePosition position;
  /// Icon to display when password is hidden.
  final Widget? icon;
  /// Icon to display when password is shown.
  final Widget? iconShow;
  /// Creates an [InputPasswordToggleFeature].
  ///
  /// Parameters:
  /// - [mode] (`PasswordPeekMode`, default: `PasswordPeekMode.toggle`):
  ///   Toggle or hold behavior.
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the toggle.
  /// - [icon] (`Widget?`, optional): Custom icon for hidden state.
  /// - [iconShow] (`Widget?`, optional): Custom icon for visible state.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputPasswordToggleFeature({super.visibility, this.icon, this.iconShow, this.mode = PasswordPeekMode.toggle, this.position = InputFeaturePosition.trailing, super.skipFocusTraversal});
  InputFeatureState createState();
}
```
