---
title: "Extension: FutureOrExtension"
description: "Extension methods for FutureOr transformation operations."
---

```dart
/// Extension methods for FutureOr transformation operations.
extension FutureOrExtension<T> on FutureOr<T> {
  /// Transforms the value using a synchronous function.
  ///
  /// If this is a Future, applies transform asynchronously.
  /// Otherwise applies it synchronously.
  ///
  /// Parameters:
  /// - [transform] (Function, required): Transformation function
  ///
  /// Returns transformed value as FutureOr.
  FutureOr<R> map<R>(R Function(T value) transform);
  /// Transforms the value using a function that returns FutureOr.
  ///
  /// Flattens nested FutureOr results. If this is a Future, chains the
  /// transformation. Otherwise applies it synchronously.
  ///
  /// Parameters:
  /// - [transform] (Function, required): Transformation function returning FutureOr
  ///
  /// Returns flattened transformed value as FutureOr.
  FutureOr<R> flatMap<R>(FutureOr<R> Function(T value) transform);
  /// Alias for flatMap - transforms with FutureOr function.
  ///
  /// Parameters:
  /// - [transform] (Function, required): Transformation function
  ///
  /// Returns transformed value as FutureOr.
  FutureOr<R> then<R>(FutureOr<R> Function(T value) transform);
  /// Catches errors in a [Future] or passes through non-Future values.
  ///
  /// If this [FutureOr] is a [Future], calls [catchError] on it.
  /// Otherwise, returns the value unchanged.
  ///
  /// Parameters:
  /// - [onError] (`Function`, required): Error handler callback.
  /// - [test] (`bool Function(Object)?`, optional): Predicate to filter errors.
  ///
  /// Returns: `FutureOr<T>` — the result with error handling applied.
  FutureOr<T> catchError(Function onError, {bool Function(Object error)? test});
}
```
