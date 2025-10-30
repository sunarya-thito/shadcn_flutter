---
title: "Extension: BorderRadiusExtension"
description: "Extension adding resolution optimization for [BorderRadiusGeometry]."
---

```dart
/// Extension adding resolution optimization for [BorderRadiusGeometry].
extension BorderRadiusExtension on BorderRadiusGeometry {
  /// Resolves to [BorderRadius], skipping resolution if already resolved.
  ///
  /// Optimizes by checking if this is already a [BorderRadius] before
  /// resolving based on text directionality.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Context for directionality.
  ///
  /// Returns: `BorderRadius` — the resolved border radius.
  BorderRadius optionallyResolve(BuildContext context);
}
```
