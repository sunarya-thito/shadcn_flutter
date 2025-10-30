---
title: "Class: CachedValueWidget"
description: "A widget that caches a computed value."
---

```dart
/// A widget that caches a computed value.
///
/// Caches the result of [builder] and only rebuilds when [value] changes.
/// If [value] implements [CachedValue], uses custom rebuild logic.
class CachedValueWidget<T> extends StatefulWidget {
  /// The value to cache and pass to builder.
  final T value;
  /// Builder function that creates the widget from the value.
  final Widget Function(BuildContext context, T value) builder;
  /// Creates a [CachedValueWidget].
  ///
  /// Parameters:
  /// - [value] (`T`, required): Value to cache.
  /// - [builder] (`Widget Function(BuildContext, T)`, required): Widget builder.
  const CachedValueWidget({super.key, required this.value, required this.builder});
  State<StatefulWidget> createState();
}
```
