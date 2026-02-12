---
title: "Class: NavigationWidget"
description: "Custom widget wrapper for navigation items.   Allows inserting custom widgets into navigation containers with optional  selection tracking. Can be used with a static child or a builder that  responds to selection state.   Example:  ```dart  NavigationWidget(    key: ValueKey('custom_builder'),    builder: (context, selected) => CustomItem(      highlighted: selected,    ),  )  ```"
---

```dart
/// Custom widget wrapper for navigation items.
///
/// Allows inserting custom widgets into navigation containers with optional
/// selection tracking. Can be used with a static child or a builder that
/// responds to selection state.
///
/// Example:
/// ```dart
/// NavigationWidget(
///   key: ValueKey('custom_builder'),
///   builder: (context, selected) => CustomItem(
///     highlighted: selected,
///   ),
/// )
/// ```
class NavigationWidget extends StatelessWidget {
  /// Builder function that receives selection state.
  final NavigationWidgetBuilder builder;
  /// Creates a navigation widget with a selection-aware builder.
  ///
  /// Parameters:
  /// - [builder] (NavigationWidgetBuilder, required): Builder receiving selection state
  const NavigationWidget({super.key, required this.builder});
  Widget build(BuildContext context);
}
```
