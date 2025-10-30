---
title: "Class: BiDirectionalConvert"
description: "A bidirectional converter between types [A] and [B]."
---

```dart
/// A bidirectional converter between types [A] and [B].
///
/// Encapsulates conversion logic in both directions, allowing seamless
/// transformation between two types.
class BiDirectionalConvert<A, B> {
  /// Converter from type A to type B.
  final Convert<A, B> aToB;
  /// Converter from type B to type A.
  final Convert<B, A> bToA;
  /// Creates a [BiDirectionalConvert].
  ///
  /// Parameters:
  /// - [aToB] (`Convert<A, B>`, required): A to B converter.
  /// - [bToA] (`Convert<B, A>`, required): B to A converter.
  const BiDirectionalConvert(this.aToB, this.bToA);
  /// Converts a value from type A to type B.
  ///
  /// Parameters:
  /// - [value] (`A`, required): Value to convert.
  ///
  /// Returns: `B` — converted value.
  B convertA(A value);
  /// Converts a value from type B to type A.
  ///
  /// Parameters:
  /// - [value] (`B`, required): Value to convert.
  ///
  /// Returns: `A` — converted value.
  A convertB(B value);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
