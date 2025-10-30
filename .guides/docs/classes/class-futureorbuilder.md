---
title: "Class: FutureOrBuilder"
description: "A widget that builds itself based on a [FutureOr] value."
---

```dart
/// A widget that builds itself based on a [FutureOr] value.
///
/// This widget handles both immediate values and futures uniformly, building
/// the appropriate widget based on whether the value is synchronous or asynchronous.
///
/// ## Type Parameters
///
/// * [T] - The type of value being awaited.
///
/// ## Overview
///
/// Use [FutureOrBuilder] when you have a value that might be either synchronous
/// (already available) or asynchronous (requires waiting). If the value is
/// synchronous, the widget is built immediately. If it's a [Future], the widget
/// uses [FutureBuilder] internally.
///
/// ## Example
///
/// ```dart
/// FutureOrBuilder<String>(
///   future: getData(), // Returns FutureOr<String>
///   builder: (context, snapshot) {
///     if (snapshot.hasError) {
///       return Text('Error: ${snapshot.error}');
///     }
///     if (!snapshot.hasData) {
///       return CircularProgressIndicator();
///     }
///     return Text(snapshot.data!);
///   },
/// )
/// ```
///
/// See also:
///
/// * [FutureBuilder] for handling only futures.
class FutureOrBuilder<T> extends StatelessWidget {
  /// The [FutureOr] value to track - can be either immediate or async.
  final FutureOr<T> future;
  /// The builder function called to construct the widget.
  final FutureOrWidgetBuilder<T> builder;
  /// An optional initial value to use before async completion.
  final T? initialValue;
  /// Creates a [FutureOrBuilder].
  ///
  /// ## Parameters
  ///
  /// * [future] - The [FutureOr] value to track.
  /// * [builder] - Function to build the widget based on the async state.
  /// * [initialValue] - Optional initial data to use before the future completes.
  ///
  /// ## Example
  ///
  /// ```dart
  /// FutureOrBuilder<int>(
  ///   future: fetchCount(),
  ///   initialValue: 0,
  ///   builder: (context, snapshot) => Text('Count: ${snapshot.data}'),
  /// )
  /// ```
  const FutureOrBuilder({super.key, required this.future, required this.builder, this.initialValue});
  Widget build(BuildContext context);
}
```
