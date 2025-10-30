---
title: "Extension: EdgeInsetsExtension"
description: "Extension adding resolution optimization for [EdgeInsetsGeometry]."
---

```dart
/// Extension adding resolution optimization for [EdgeInsetsGeometry].
extension EdgeInsetsExtension on EdgeInsetsGeometry {
  /// Resolves to [EdgeInsets], skipping resolution if already resolved.
  ///
  /// Optimizes by checking if this is already an [EdgeInsets] before
  /// resolving based on text directionality.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Context for directionality.
  ///
  /// Returns: `EdgeInsets` — the resolved edge insets.
  EdgeInsets optionallyResolve(BuildContext context);
}
```
