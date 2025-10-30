---
title: "Class: ButtonStyleOverride"
description: "Widget for locally overriding button styles within a subtree."
---

```dart
/// Widget for locally overriding button styles within a subtree.
///
/// [ButtonStyleOverride] allows selective customization of button style properties
/// for all descendant buttons without replacing the entire button style. It provides
/// style property delegates that can intercept and modify the default values.
///
/// The widget supports two modes:
/// - **Replace mode** (default): Applies overrides directly
/// - **Inherit mode**: Chains with parent overrides, allowing nested customization
///
/// Example:
/// ```dart
/// ButtonStyleOverride(
///   decoration: (context, states, defaultDecoration) {
///     // Customize decoration for all buttons in this subtree
///     return BoxDecoration(color: Colors.red);
///   },
///   child: Column(
///     children: [
///       PrimaryButton(child: Text('Red Button')),
///       SecondaryButton(child: Text('Also Red')),
///     ],
///   ),
/// )
/// ```
class ButtonStyleOverride extends StatelessWidget {
  /// Whether to inherit and chain with parent overrides.
  ///
  /// When `true`, this override's delegates receive the parent override's result
  /// as their default value, allowing nested style modifications. When `false`,
  /// parent overrides are ignored.
  final bool inherit;
  /// Optional decoration override delegate.
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  /// Optional mouse cursor override delegate.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  /// Optional padding override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  /// Optional text style override delegate.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  /// Optional icon theme override delegate.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  /// Optional margin override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  /// The widget subtree where overrides apply.
  final Widget child;
  /// Creates a button style override in replace mode.
  ///
  /// Overrides apply to all descendant buttons, ignoring parent overrides.
  const ButtonStyleOverride({super.key, this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin, required this.child});
  /// Creates a button style override in inherit mode.
  ///
  /// Overrides chain with parent overrides, allowing nested customization where
  /// each level can modify the result of the previous level.
  const ButtonStyleOverride.inherit({super.key, this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin, required this.child});
  Widget build(BuildContext context);
}
```
