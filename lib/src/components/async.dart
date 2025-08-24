import 'dart:async';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Function signature for building widgets based on FutureOr values.
///
/// This typedef defines the callback used by [FutureOrBuilder] to construct
/// child widgets based on the current state of a [FutureOr<T>] value.
/// It receives the build context and an [AsyncSnapshot] containing the
/// current value and connection state.
///
/// The snapshot provides access to:
/// - `hasData`: Whether a value is available
/// - `data`: The actual value (when available)
/// - `hasError`: Whether an error occurred  
/// - `error`: The error object (when an error occurred)
/// - `connectionState`: The current state (waiting, active, done)
///
/// Type parameter [T] represents the type of data being handled.
typedef FutureOrWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);

/// A widget that builds content based on FutureOr<T> values with unified handling.
///
/// [FutureOrBuilder] provides a convenient way to handle both synchronous values
/// and asynchronous [Future] values through a single interface. It automatically
/// determines whether the provided value is immediate or requires async handling,
/// then builds appropriate UI using either direct value display or [FutureBuilder].
///
/// This widget is particularly useful in scenarios where data might be available
/// immediately (from cache) or require async loading (from network/database),
/// allowing the same widget code to handle both cases seamlessly.
///
/// Key features:
/// - Unified handling of synchronous and asynchronous values
/// - Automatic detection of value type ([Future<T>] vs direct [T])
/// - Integration with [FutureBuilder] for async values
/// - Support for initial/placeholder values
/// - Consistent [AsyncSnapshot] interface for all cases
/// - Type-safe value handling
///
/// When the [future] parameter contains a direct value, the builder receives
/// an [AsyncSnapshot] in done state with the value immediately available.
/// When it contains a [Future], standard [FutureBuilder] behavior applies.
///
/// Example:
/// ```dart
/// FutureOrBuilder<String>(
///   future: getCachedOrLoadData(), // Returns String or Future<String>
///   initialValue: 'Loading...',
///   builder: (context, snapshot) {
///     if (snapshot.hasError) {
///       return Text('Error: ${snapshot.error}');
///     }
///     if (!snapshot.hasData) {
///       return CircularProgressIndicator();
///     }
///     return Text('Data: ${snapshot.data}');
///   },
/// );
/// ```
class FutureOrBuilder<T> extends StatelessWidget {
  /// The FutureOr<T> value to build UI from.
  ///
  /// This can be either a direct value of type [T] or a [Future<T>] that will
  /// resolve to a value. The widget automatically detects the type and handles
  /// it appropriately using immediate value display or [FutureBuilder].
  final FutureOr<T> future;

  /// Builder function that creates the widget tree based on the current state.
  ///
  /// Receives the build context and an [AsyncSnapshot<T>] containing the current
  /// value state. The snapshot provides access to data, error, and connection
  /// state information regardless of whether the source was sync or async.
  final FutureOrWidgetBuilder<T> builder;

  /// Optional initial value to use while async operations are pending.
  ///
  /// When the [future] is actually a [Future<T>], this value is used as the
  /// initial data for the underlying [FutureBuilder]. Has no effect when
  /// [future] contains a direct value.
  final T? initialValue;

  /// Creates a [FutureOrBuilder].
  ///
  /// The [future] parameter is required and contains the value or async operation
  /// to build UI from. The [builder] function is required to construct the widget
  /// tree. The [initialValue] is optional and only applies to async cases.
  ///
  /// Example:
  /// ```dart
  /// FutureOrBuilder<User>(
  ///   future: repository.getCurrentUser(), // Could return User or Future<User>
  ///   initialValue: User.guest(),
  ///   builder: (context, snapshot) => UserProfile(user: snapshot.data),
  /// );
  /// ```
  const FutureOrBuilder({
    super.key,
    required this.future,
    required this.builder,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    if (future is Future<T>) {
      return FutureBuilder<T>(
        future: future as Future<T>,
        initialData: initialValue,
        builder: builder,
      );
    }
    return builder(
        context, AsyncSnapshot.withData(ConnectionState.done, future as T));
  }
}
