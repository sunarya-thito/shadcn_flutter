---
title: "Extension: AlignmentExtension"
description: "Extension adding resolution optimization for [AlignmentGeometry]."
---

```dart
/// Extension adding resolution optimization for [AlignmentGeometry].
extension AlignmentExtension on AlignmentGeometry {
  /// Resolves to [Alignment], skipping resolution if already resolved.
  ///
  /// Optimizes by checking if this is already an [Alignment] before
  /// resolving based on text directionality. This avoids unnecessary
  /// directionality lookups when the alignment is already concrete.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Context for directionality.
  ///
  /// Returns: `Alignment` — the resolved alignment.
  Alignment optionallyResolve(BuildContext context);
}
```
