---
title: "Class: ComponentTheme"
description: "An inherited widget that provides component-specific theme data.   Allows components to provide custom theme data that overrides or extends  the global theme. The type parameter `T` specifies the theme data type.   Example:  ```dart  ComponentTheme<ButtonTheme>(    data: ButtonTheme(backgroundColor: Colors.blue),    child: MyButton(),  )  ```"
---

```dart
/// An inherited widget that provides component-specific theme data.
///
/// Allows components to provide custom theme data that overrides or extends
/// the global theme. The type parameter `T` specifies the theme data type.
///
/// Example:
/// ```dart
/// ComponentTheme<ButtonTheme>(
///   data: ButtonTheme(backgroundColor: Colors.blue),
///   child: MyButton(),
/// )
/// ```
class ComponentTheme<T extends ComponentThemeData> extends InheritedTheme {
  /// The component theme data to provide to descendants.
  final T data;
  /// Creates a [ComponentTheme].
  ///
  /// Parameters:
  /// - [data] (`T`, required): Theme data for this component type.
  /// - [child] (`Widget`, required): Child widget.
  const ComponentTheme({super.key, required this.data, required super.child});
  Widget wrap(BuildContext context, Widget child);
  /// Gets the component theme data of type `T` from the closest ancestor.
  ///
  /// Throws if no [ComponentTheme] of type `T` is found.
  ///
  /// Returns: `T` — the component theme data.
  static T of<T extends ComponentThemeData>(BuildContext context);
  /// Gets the component theme data of type `T` from the closest ancestor.
  ///
  /// Returns `null` if no [ComponentTheme] of type `T` is found.
  ///
  /// Returns: `T?` — the component theme data, or null.
  static T? maybeOf<T extends ComponentThemeData>(BuildContext context);
  bool updateShouldNotify(covariant ComponentTheme<T> oldWidget);
}
```
