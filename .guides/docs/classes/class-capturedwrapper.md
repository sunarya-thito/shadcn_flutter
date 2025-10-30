---
title: "Class: CapturedWrapper"
description: "A widget that wraps a child with captured themes and data."
---

```dart
/// A widget that wraps a child with captured themes and data.
///
/// Applies previously captured inherited themes and data to the widget tree.
/// This is useful for maintaining theme and data context when moving widgets
/// across different parts of the tree.
class CapturedWrapper extends StatefulWidget {
  /// Captured theme data to apply.
  final CapturedThemes? themes;
  /// Captured inherited data to apply.
  final CapturedData? data;
  /// The child widget to wrap.
  final Widget child;
  /// Creates a [CapturedWrapper].
  ///
  /// Parameters:
  /// - [themes] (`CapturedThemes?`, optional): Themes to apply.
  /// - [data] (`CapturedData?`, optional): Data to apply.
  /// - [child] (`Widget`, required): Child widget.
  const CapturedWrapper({super.key, this.themes, this.data, required this.child});
  State<CapturedWrapper> createState();
}
```
