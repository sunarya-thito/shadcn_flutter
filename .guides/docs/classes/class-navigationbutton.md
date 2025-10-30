---
title: "Class: NavigationButton"
description: "Non-selectable navigation button for actions."
---

```dart
/// Non-selectable navigation button for actions.
///
/// Similar to [NavigationItem] but without selection state. Used for
/// action buttons in navigation (e.g., settings, logout) that trigger
/// callbacks rather than changing navigation state.
///
/// Example:
/// ```dart
/// NavigationButton(
///   label: Text('Settings'),
///   child: Icon(Icons.settings),
///   onPressed: () => _openSettings(),
/// )
/// ```
class NavigationButton extends AbstractNavigationButton {
  /// Callback when button is pressed.
  final VoidCallback? onPressed;
  /// Creates a navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [onPressed] (VoidCallback?): Press callback
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Button style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): Label overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationButton({super.key, this.onPressed, super.label, super.spacing, super.style, super.alignment, super.enabled, super.overflow, super.marginAlignment, required super.child});
  bool get selectable;
  State<AbstractNavigationButton> createState();
}
```
