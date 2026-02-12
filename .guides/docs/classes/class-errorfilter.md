---
title: "Class: ErrorFilter"
description: "A widget that filters duplicate Flutter errors, logging each unique error only once.   Wrap your app or subtree with [ErrorFilter] to avoid repeated error logs for the same error.   Example:  ```dart  ErrorFilter(    child: MyApp(),  )  ```"
---

```dart
/// A widget that filters duplicate Flutter errors, logging each unique error only once.
///
/// Wrap your app or subtree with [ErrorFilter] to avoid repeated error logs for the same error.
///
/// Example:
/// ```dart
/// ErrorFilter(
///   child: MyApp(),
/// )
/// ```
class ErrorFilter extends StatefulWidget {
  /// Child widget to wrap with error filtering.
  final Widget child;
  /// Creates an [ErrorFilter].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Child widget to wrap.
  const ErrorFilter({super.key, required this.child});
  State<ErrorFilter> createState();
}
```
