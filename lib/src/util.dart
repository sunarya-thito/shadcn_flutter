import 'dart:async';
import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A function type that tests whether a value satisfies a specific condition.
///
/// Used throughout the framework for filtering and validation operations.
/// Returns `true` if the value matches the predicate criteria, `false` otherwise.
///
/// Example:
/// ```dart
/// final isPositive = Predicate<int>((value) => value > 0);
/// ```
typedef Predicate<T> = bool Function(T value);

/// A function type that transforms a value of type T to another value of the same type.
///
/// Commonly used for value transformation operations where the input and output
/// types are identical, such as applying modifications or calculations.
///
/// Example:
/// ```dart
/// final doubleValue = UnaryOperator<int>((value) => value * 2);
/// ```
typedef UnaryOperator<T> = T Function(T value);

/// A function type that combines two values of type T into a single value of the same type.
///
/// Used for operations like reduction, merging, or mathematical combinations
/// where two operands produce one result of the same type.
///
/// Example:
/// ```dart
/// final addInts = BinaryOperator<int>((a, b) => a + b);
/// ```
typedef BinaryOperator<T> = T Function(T a, T b);

/// The default animation duration used throughout the shadcn_flutter framework.
///
/// Set to 150 milliseconds to provide smooth, responsive animations that feel
/// natural to users. This constant ensures consistent timing across all
/// framework animations.
const kDefaultDuration = Duration(milliseconds: 150);

/// A callback function that receives a BuildContext for context-aware operations.
///
/// Used when operations need access to the widget tree context but don't
/// need to return a value or handle additional parameters.
///
/// Example:
/// ```dart
/// final showSnackBar = ContextedCallback((context) {
///   ScaffoldMessenger.of(context).showSnackBar(snackBar);
/// });
/// ```
typedef ContextedCallback = void Function(BuildContext context);

/// A callback function that receives both a BuildContext and a value for context-aware operations.
///
/// Used when operations need access to the widget tree context and must handle
/// a specific value, such as form field changes or user interactions.
///
/// Example:
/// ```dart
/// final onTextChanged = ContextedValueChanged<String>((context, value) {
///   // Handle text change with context access
/// });
/// ```
typedef ContextedValueChanged<T> = void Function(BuildContext context, T value);

/// A function type that calculates the relevance score for search operations.
///
/// Takes a value and query string, returning a double where higher values
/// indicate better matches. Used for implementing custom search algorithms
/// in components like autocomplete and filterable lists.
///
/// Example:
/// ```dart
/// final textSearchPredicate = SearchPredicate<String>((value, query) =>
///   value.toLowerCase().contains(query.toLowerCase()) ? 1.0 : 0.0);
/// ```
typedef SearchPredicate<T> = double Function(T value, String query);

/// Converts degrees to radians.
///
/// Parameters:
/// - [deg] (double): The angle in degrees to convert.
///
/// Returns:
/// A `double` representing the equivalent angle in radians.
///
/// Example:
/// ```dart
/// final radians = degToRad(90); // Returns π/2 (≈ 1.57)
/// ```
double degToRad(double deg) => deg * (pi / 180);

/// Converts radians to degrees.
///
/// Parameters:
/// - [rad] (double): The angle in radians to convert.
///
/// Returns:
/// A `double` representing the equivalent angle in degrees.
///
/// Example:
/// ```dart
/// final degrees = radToDeg(pi); // Returns 180.0
/// ```
double radToDeg(double rad) => rad * (180 / pi);

/// Defines the possible sorting directions for data operations.
///
/// Used by sortable components and data tables to indicate how items
/// should be ordered. Supports three states: no sorting, ascending order,
/// and descending order.
enum SortDirection {
  /// No sorting applied - items maintain their original order.
  none,

  /// Items are sorted in ascending order (A-Z, 0-9, earliest to latest).
  ascending,

  /// Items are sorted in descending order (Z-A, 9-0, latest to earliest).
  descending,
}

/// A callback function type for handling context action invocations.
///
/// Used with [CallbackContextAction] to define custom behavior when an
/// Intent is invoked. Provides access to the intent and optional context.
///
/// Parameters:
/// - [intent] (T): The intent being invoked
/// - [context] (BuildContext?, optional): The build context if available
///
/// Returns:
/// An optional `Object?` result from the action invocation.
typedef OnContextInvokeCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

/// A custom ContextAction that delegates its invoke behavior to a callback function.
///
/// Provides a flexible way to create context actions without extending the
/// ContextAction class directly. Useful for inline action definitions and
/// dynamic behavior configuration.
///
/// Example:
/// ```dart
/// final customAction = CallbackContextAction<MyIntent>(
///   onInvoke: (intent, context) {
///     // Handle the intent
///     return someResult;
///   },
/// );
/// ```
class CallbackContextAction<T extends Intent> extends ContextAction<T> {
  /// The callback function to invoke when the action is triggered.
  final OnContextInvokeCallback onInvoke;

  /// Creates a [CallbackContextAction] with the specified callback.
  ///
  /// Parameters:
  /// - [onInvoke] (OnContextInvokeCallback, required): Function to call when invoked.
  CallbackContextAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}

/// A wrapper for nullable lerp functions that provides type-safe non-null interpolation.
///
/// Takes a nullable lerp function and provides a safe way to perform linear
/// interpolation while ensuring the result is non-null. Useful for animation
/// and transition calculations where null results are not acceptable.
///
/// Example:
/// ```dart
/// final colorLerp = SafeLerp(Color.lerp);
/// final result = colorLerp.lerp(Colors.red, Colors.blue, 0.5);
/// ```
class SafeLerp<T> {
  /// The underlying nullable lerp function.
  final T? Function(T? a, T? b, double t) nullableLerp;

  /// Creates a [SafeLerp] wrapper around a nullable lerp function.
  ///
  /// Parameters:
  /// - [nullableLerp] (function, required): The nullable lerp function to wrap.
  const SafeLerp(this.nullableLerp);

  /// Performs linear interpolation between two non-null values.
  ///
  /// Parameters:
  /// - [a] (T): The start value for interpolation.
  /// - [b] (T): The end value for interpolation.
  /// - [t] (double): The interpolation factor (0.0 to 1.0).
  ///
  /// Returns:
  /// A non-null `T` value representing the interpolated result.
  ///
  /// Throws:
  /// AssertionError if the underlying lerp function returns null.
  T lerp(T a, T b, double t) {
    T? result = nullableLerp(a, b, t);
    assert(result != null, 'Unsafe lerp');
    return result!;
  }
}

/// Extension methods for nullable lerp functions that provide type-safe interpolation.
///
/// Adds convenience methods to nullable lerp functions for guaranteed non-null
/// interpolation results, preventing runtime null errors during animations.
extension SafeLerpExtension<T> on T? Function(T? a, T? b, double t) {
  /// Performs linear interpolation with a guarantee of non-null result.
  ///
  /// Parameters:
  /// - [a] (T): The start value for interpolation.
  /// - [b] (T): The end value for interpolation.  
  /// - [t] (double): The interpolation factor (0.0 to 1.0).
  ///
  /// Returns:
  /// A non-null `T` value representing the interpolated result.
  ///
  /// Throws:
  /// AssertionError if the lerp function returns null.
  ///
  /// Example:
  /// ```dart
  /// final result = Color.lerp.nonNull(Colors.red, Colors.blue, 0.5);
  /// ```
  T nonNull(T a, T b, double t) {
    T? result = this(a, b, t);
    assert(result != null);
    return result!;
  }
}

/// Extension methods for Lists that provide null-safe operations and enhanced functionality.
///
/// Adds convenience methods for safe indexing, searching, and manipulation
/// operations that return null instead of throwing exceptions when elements
/// are not found.
extension ListExtension<T> on List<T> {
  /// Returns the index of the first occurrence of the object, or null if not found.
  ///
  /// Parameters:
  /// - [obj] (T): The object to search for.
  /// - [start] (int, default: 0): The index to start searching from.
  ///
  /// Returns:
  /// The index of the first occurrence, or `null` if not found.
  ///
  /// Example:
  /// ```dart
  /// final list = ['a', 'b', 'c'];
  /// final index = list.indexOfOrNull('b'); // Returns 1
  /// final notFound = list.indexOfOrNull('x'); // Returns null
  /// ```
  int? indexOfOrNull(T obj, [int start = 0]) {
    int index = indexOf(obj, start);
    return index == -1 ? null : index;
  }

  /// Returns the index of the last occurrence of the object, or null if not found.
  ///
  /// Parameters:
  /// - [obj] (T): The object to search for.
  /// - [start] (int?, optional): The index to start searching backwards from.
  ///
  /// Returns:
  /// The index of the last occurrence, or `null` if not found.
  ///
  /// Example:
  /// ```dart
  /// final list = ['a', 'b', 'a'];
  /// final index = list.lastIndexOfOrNull('a'); // Returns 2
  /// ```
  int? lastIndexOfOrNull(T obj, [int? start]) {
    int index = lastIndexOf(obj, start);
    return index == -1 ? null : index;
  }

  /// Returns the index of the first element that satisfies the test, or null if none found.
  ///
  /// Parameters:
  /// - [test] (Predicate<T>): The test function to apply to each element.
  /// - [start] (int, default: 0): The index to start searching from.
  ///
  /// Returns:
  /// The index of the first matching element, or `null` if none found.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4];
  /// final index = list.indexWhereOrNull((x) => x > 2); // Returns 2
  /// ```
  int? indexWhereOrNull(Predicate<T> test, [int start = 0]) {
    int index = indexWhere(test, start);
    return index == -1 ? null : index;
  }

  /// Returns the index of the last element that satisfies the test, or null if none found.
  ///
  /// Parameters:
  /// - [test] (Predicate<T>): The test function to apply to each element.
  /// - [start] (int?, optional): The index to start searching backwards from.
  ///
  /// Returns:
  /// The index of the last matching element, or `null` if none found.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 2];
  /// final index = list.lastIndexWhereOrNull((x) => x == 2); // Returns 3
  /// ```
  int? lastIndexWhereOrNull(Predicate<T> test, [int? start]) {
    int index = lastIndexWhere(test, start);
    return index == -1 ? null : index;
  }

  /// Moves an element to a new position in the list.
  ///
  /// If the element doesn't exist in the list, it will be inserted at the
  /// target index. The method handles bounds checking and adjusts indices
  /// as needed during the move operation.
  ///
  /// Parameters:
  /// - [element] (T): The element to move.
  /// - [targetIndex] (int): The index to move the element to.
  ///
  /// Returns:
  /// `true` if the operation completed successfully.
  ///
  /// Example:
  /// ```dart
  /// final list = ['a', 'b', 'c'];
  /// list.swapItem('b', 0); // Result: ['b', 'a', 'c']
  /// ```
  bool swapItem(T element, int targetIndex) {
    int currentIndex = indexOf(element);
    if (currentIndex == -1) {
      insert(targetIndex, element);
      return true;
    }
    if (currentIndex == targetIndex) {
      return true;
    }
    if (targetIndex >= length) {
      remove(element);
      add(element);
      return true;
    }
    removeAt(currentIndex);
    if (currentIndex < targetIndex) {
      insert(targetIndex - 1, element);
    } else {
      insert(targetIndex, element);
    }
    return true;
  }

  /// Moves the first element matching the test to a new position in the list.
  ///
  /// Parameters:
  /// - [test] (Predicate<T>): The test function to find the element.
  /// - [targetIndex] (int): The index to move the element to.
  ///
  /// Returns:
  /// `true` if an element was found and moved, `false` if no element matched the test.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final moved = list.swapItemWhere((x) => x == 2, 0); // Result: [2, 1, 3]
  /// ```
  bool swapItemWhere(Predicate<T> test, int targetIndex) {
    int currentIndex = indexWhere(test);
    if (currentIndex == -1) {
      return false;
    }
    T element = this[currentIndex];
    return swapItem(element, targetIndex);
  }

  /// Safely retrieves an element at the specified index without throwing an exception.
  ///
  /// Parameters:
  /// - [index] (int): The index of the element to retrieve.
  ///
  /// Returns:
  /// The element at the index, or `null` if the index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final list = ['a', 'b', 'c'];
  /// final element = list.optGet(1); // Returns 'b'
  /// final outOfBounds = list.optGet(10); // Returns null
  /// ```
  T? optGet(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }
}

/// Performs the inverse of linear interpolation (unlerp) on a double value.
///
/// Given a value and its min/max bounds, calculates the interpolation factor
/// that would produce that value. Useful for converting absolute values back
/// to normalized 0-1 range for animations and sliders.
///
/// Parameters:
/// - [value] (double): The value to unlerp.
/// - [min] (double): The minimum bound.
/// - [max] (double): The maximum bound.
///
/// Returns:
/// A `double` representing the interpolation factor (typically 0.0 to 1.0).
///
/// Example:
/// ```dart
/// final factor = unlerpDouble(50, 0, 100); // Returns 0.5
/// ```
double unlerpDouble(double value, double min, double max) {
  return (value - min) / (max - min);
}

/// Moves an element between multiple lists to a specific position.
///
/// Removes the element from all other lists and ensures it exists only
/// in the target list at the specified index. Useful for drag-and-drop
/// operations across multiple containers.
///
/// Parameters:
/// - [lists] (List<List<T>>): All lists that might contain the element.
/// - [element] (T): The element to move.
/// - [targetList] (List<T>): The list to move the element to.
/// - [targetIndex] (int): The index in the target list.
///
/// Example:
/// ```dart
/// final list1 = ['a', 'b'];
/// final list2 = ['c'];
/// swapItemInLists([list1, list2], 'b', list2, 0);
/// // Result: list1 = ['a'], list2 = ['b', 'c']
/// ```
void swapItemInLists<T>(
    List<List<T>> lists, T element, List<T> targetList, int targetIndex) {
  for (var list in lists) {
    if (list != targetList) {
      list.remove(element);
    }
  }
  targetList.swapItem(element, targetIndex);
}

/// Optionally resolves a BorderRadiusGeometry to a BorderRadius based on text direction.
///
/// If the radius is already a BorderRadius, returns it unchanged. Otherwise,
/// resolves it using the context's text direction. Returns null if input is null.
///
/// Parameters:
/// - [context] (BuildContext): The build context for directionality.
/// - [radius] (BorderRadiusGeometry?): The border radius to resolve.
///
/// Returns:
/// A resolved `BorderRadius?` or null if input was null.
///
/// Example:
/// ```dart
/// final resolved = optionallyResolveBorderRadius(context, borderRadius);
/// ```
BorderRadius? optionallyResolveBorderRadius(
    BuildContext context, BorderRadiusGeometry? radius) {
  if (radius == null) {
    return null;
  }
  if (radius is BorderRadius) {
    return radius;
  }
  return radius.resolve(Directionality.of(context));
}

/// A style helper function that returns the value from the widget, theme, or default value.
T styleValue<T>({T? widgetValue, T? themeValue, required T defaultValue}) {
  return widgetValue ?? themeValue ?? defaultValue;
}

/// Extension methods for FutureOr<T> that provide functional programming operations.
///
/// Adds methods to transform and chain FutureOr values, handling both
/// synchronous and asynchronous values uniformly. Useful for operations
/// that may or may not be asynchronous.
extension FutureOrExtension<T> on FutureOr<T> {
  /// Transforms the value using the provided function.
  ///
  /// If the FutureOr contains a Future, applies the transform after the
  /// Future completes. Otherwise applies it immediately to the synchronous value.
  ///
  /// Parameters:
  /// - [transform] (function): Function to transform the value.
  ///
  /// Returns:
  /// A `FutureOr<R>` containing the transformed value.
  ///
  /// Example:
  /// ```dart
  /// final result = futureOrValue.map((value) => value.toString());
  /// ```
  FutureOr<R> map<R>(R Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

  /// Transforms the value and flattens nested FutureOr results.
  ///
  /// Similar to map, but the transform function can return another FutureOr,
  /// and the result is flattened to avoid nested FutureOr types.
  ///
  /// Parameters:
  /// - [transform] (function): Function that returns a FutureOr<R>.
  ///
  /// Returns:
  /// A flattened `FutureOr<R>` result.
  ///
  /// Example:
  /// ```dart
  /// final result = futureOrValue.flatMap((value) => processAsync(value));
  /// ```
  FutureOr<R> flatMap<R>(FutureOr<R> Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

  /// Alias for flatMap - transforms and chains FutureOr operations.
  ///
  /// Parameters:
  /// - [transform] (function): Function that returns a FutureOr<R>.
  ///
  /// Returns:
  /// A `FutureOr<R>` result from the transform function.
  ///
  /// Example:
  /// ```dart
  /// final result = futureOrValue.then((value) => nextOperation(value));
  /// ```
  FutureOr<R> then<R>(FutureOr<R> Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }
}

/// Extension methods for AlignmentGeometry that provide efficient resolution.
///
/// Adds methods to resolve alignment geometry to concrete Alignment objects
/// while avoiding unnecessary resolution operations when the value is already
/// resolved.
extension AlignmentExtension on AlignmentGeometry {
  /// Resolves the alignment geometry to an Alignment, optimizing for already-resolved values.
  ///
  /// Checks if the geometry is already an Alignment before attempting resolution
  /// based on the context's directionality. This optimization avoids unnecessary
  /// work when the alignment is already in the desired form.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context for directionality.
  ///
  /// Returns:
  /// A resolved `Alignment` object.
  ///
  /// Example:
  /// ```dart
  /// final alignment = AlignmentDirectional.start.optionallyResolve(context);
  /// ```
  Alignment optionallyResolve(BuildContext context) {
    // Why?
    // Because this checks first if the alignment is already an Alignment
    // before resolving the alignment based on the directionality of the context.
    if (this is Alignment) {
      return this as Alignment;
    }
    // The code belows also ignores if the alignment is already resolved,
    // but the code below fetches the directionality of the context.
    return resolve(Directionality.of(context));
  }
}

/// Extension methods for BorderRadiusGeometry that provide efficient resolution.
///
/// Adds methods to resolve border radius geometry to concrete BorderRadius
/// objects while avoiding unnecessary resolution when already resolved.
extension BorderRadiusExtension on BorderRadiusGeometry {
  /// Resolves the border radius geometry to a BorderRadius, optimizing for already-resolved values.
  ///
  /// Checks if the geometry is already a BorderRadius before attempting resolution
  /// based on the context's directionality. This avoids unnecessary work when
  /// the border radius is already in the desired form.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context for directionality.
  ///
  /// Returns:
  /// A resolved `BorderRadius` object.
  ///
  /// Example:
  /// ```dart
  /// final radius = BorderRadiusDirectional.circular(8).optionallyResolve(context);
  /// ```
  BorderRadius optionallyResolve(BuildContext context) {
    if (this is BorderRadius) {
      return this as BorderRadius;
    }
    return resolve(Directionality.of(context));
  }
}

/// Extension methods for EdgeInsetsGeometry that provide efficient resolution.
///
/// Adds methods to resolve edge insets geometry to concrete EdgeInsets
/// objects while avoiding unnecessary resolution when already resolved.
extension EdgeInsetsExtension on EdgeInsetsGeometry {
  /// Resolves the edge insets geometry to EdgeInsets, optimizing for already-resolved values.
  ///
  /// Checks if the geometry is already EdgeInsets before attempting resolution
  /// based on the context's directionality. This avoids unnecessary work when
  /// the edge insets are already in the desired form.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context for directionality.
  ///
  /// Returns:
  /// A resolved `EdgeInsets` object.
  ///
  /// Example:
  /// ```dart
  /// final insets = EdgeInsetsDirectional.all(16).optionallyResolve(context);
  /// ```
  EdgeInsets optionallyResolve(BuildContext context) {
    if (this is EdgeInsets) {
      return this as EdgeInsets;
    }
    return resolve(Directionality.of(context));
  }
}

/// Reduces a border radius by subtracting the border width from each corner.
///
/// Calculates the inner border radius by subtracting the border width from
/// each corner radius. Ensures that no corner radius becomes negative by
/// clamping to zero. Useful for creating properly inset content areas.
///
/// Parameters:
/// - [radius] (BorderRadius): The original border radius.
/// - [borderWidth] (double): The width of the border to subtract.
///
/// Returns:
/// A `BorderRadius` with reduced corner radii.
///
/// Example:
/// ```dart
/// final innerRadius = subtractByBorder(BorderRadius.circular(12), 2);
/// // Results in corners with radius 10 (12 - 2)
/// ```
BorderRadius subtractByBorder(BorderRadius radius, double borderWidth) {
  return BorderRadius.only(
    topLeft: _subtractSafe(radius.topLeft, Radius.circular(borderWidth)),
    topRight: _subtractSafe(radius.topRight, Radius.circular(borderWidth)),
    bottomLeft: _subtractSafe(radius.bottomLeft, Radius.circular(borderWidth)),
    bottomRight:
        _subtractSafe(radius.bottomRight, Radius.circular(borderWidth)),
  );
}

/// Safely subtracts one radius from another, ensuring non-negative results.
///
/// Private helper function that performs radius subtraction while preventing
/// negative values by using max(0, result) on both x and y components.
Radius _subtractSafe(Radius a, Radius b) {
  return Radius.elliptical(
    max(0, a.x - b.x),
    max(0, a.y - b.y),
  );
}

/// Determines if the given platform is a mobile platform.
///
/// Checks if the target platform is one of the mobile platforms (Android, iOS,
/// or Fuchsia) versus desktop platforms (macOS, Linux, Windows). Useful for
/// platform-specific UI decisions.
///
/// Parameters:
/// - [platform] (TargetPlatform): The platform to check.
///
/// Returns:
/// `true` if the platform is mobile, `false` if desktop.
///
/// Example:
/// ```dart
/// final isOnMobile = isMobile(Theme.of(context).platform);
/// ```
bool isMobile(TargetPlatform platform) {
  switch (platform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
    case TargetPlatform.fuchsia:
      return true;
    case TargetPlatform.macOS:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return false;
  }
}

/// A widget that wraps a child with captured themes and inherited data.
///
/// Provides a way to apply previously captured themes and inherited widget
/// data to a child widget. This is particularly useful for preserving context
/// when widgets are rendered outside their original widget tree, such as in
/// overlays or dialogs.
///
/// Example:
/// ```dart
/// CapturedWrapper(
///   themes: capturedThemes,
///   data: capturedData,
///   child: MyWidget(),
/// )
/// ```
class CapturedWrapper extends StatefulWidget {
  /// The captured themes to apply to the child.
  final CapturedThemes? themes;

  /// The captured inherited data to apply to the child.
  final CapturedData? data;

  /// The child widget to wrap with captured context.
  final Widget child;

  /// Creates a [CapturedWrapper].
  ///
  /// Parameters:
  /// - [child] (Widget, required): The child widget to wrap.
  /// - [themes] (CapturedThemes?, optional): Captured themes to apply.
  /// - [data] (CapturedData?, optional): Captured inherited data to apply.
  const CapturedWrapper({
    super.key,
    this.themes,
    this.data,
    required this.child,
  });

  @override
  State<CapturedWrapper> createState() => _CapturedWrapperState();
}

class _CapturedWrapperState extends State<CapturedWrapper> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Widget child = KeyedSubtree(
      key: _key,
      child: widget.child,
    );
    if (widget.themes != null) {
      child = widget.themes!.wrap(child);
    }
    if (widget.data != null) {
      child = widget.data!.wrap(child);
    }
    return child;
  }
}

/// Interpolates between two values using linear interpolation.
///
/// Performs basic linear interpolation by calculating the intermediate value
/// between begin and end based on the interpolation factor t. Works with
/// numeric types that support arithmetic operations.
///
/// Parameters:
/// - [begin] (T): The starting value.
/// - [end] (T): The ending value.
/// - [t] (double): The interpolation factor (0.0 to 1.0).
///
/// Returns:
/// A value of type `T` representing the interpolated result.
///
/// Example:
/// ```dart
/// final result = tweenValue(0.0, 100.0, 0.5); // Returns 50.0
/// ```
T tweenValue<T>(T begin, T end, double t) {
  dynamic beginValue = begin;
  dynamic endValue = end;
  return (beginValue + (endValue - beginValue) * t) as T;
}

/// Wraps a double value within a specified range.
///
/// Constrains a value to stay within the given minimum and maximum bounds
/// using modulo arithmetic. If the value exceeds the maximum, it wraps around
/// to the minimum. Useful for cyclic values like angles or carousel indices.
///
/// Parameters:
/// - [value] (double): The value to wrap.
/// - [min] (double): The minimum bound.
/// - [max] (double): The maximum bound.
///
/// Returns:
/// A `double` value wrapped within the specified range.
///
/// Example:
/// ```dart
/// final wrapped = wrapDouble(370, 0, 360); // Returns 10.0
/// ```
double wrapDouble(double value, double min, double max) {
  final range = max - min;
  if (range == 0) {
    return min;
  }
  return (value - min) % range + min;
}

/// A widget that detects changes in the widget tree and triggers a callback.
///
/// Monitors the widget tree for changes by triggering the callback during
/// initState. This is useful for detecting when widgets are rebuilt or
/// when the widget tree structure changes.
///
/// Example:
/// ```dart
/// WidgetTreeChangeDetector(
///   onWidgetTreeChange: () => print('Tree changed'),
///   child: MyWidget(),
/// )
/// ```
class WidgetTreeChangeDetector extends StatefulWidget {
  /// The child widget to wrap.
  final Widget child;

  /// Callback invoked when the widget tree changes.
  final void Function() onWidgetTreeChange;

  /// Creates a [WidgetTreeChangeDetector].
  ///
  /// Parameters:
  /// - [child] (Widget, required): The child widget to monitor.
  /// - [onWidgetTreeChange] (function, required): Callback for tree changes.
  const WidgetTreeChangeDetector({
    super.key,
    required this.child,
    required this.onWidgetTreeChange,
  });

  @override
  _WidgetTreeChangeDetectorState createState() =>
      _WidgetTreeChangeDetectorState();
}

class _WidgetTreeChangeDetectorState extends State<WidgetTreeChangeDetector> {
  @override
  void initState() {
    super.initState();
    widget.onWidgetTreeChange();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Creates a Gap widget for spacing in layouts.
///
/// Provides a convenient function to create Gap widgets with optional
/// cross-axis spacing. The Gap widget creates space along the main axis
/// of Flex widgets (Rows, Columns, etc.).
///
/// Parameters:
/// - [gap] (double): The main axis gap size.
/// - [crossGap] (double?, optional): The cross axis gap size.
///
/// Returns:
/// A `Widget` that represents the spacing gap.
///
/// Example:
/// ```dart
/// Column(
///   children: [
///     Text('First'),
///     gap(16), // 16px vertical gap
///     Text('Second'),
///   ],
/// )
/// ```
Widget gap(double gap, {double? crossGap}) {
  return Gap(
    gap,
    crossAxisExtent: crossGap,
  );
}

/// Extension methods for Lists of Widgets that provide separator joining functionality.
///
/// Adds methods to insert separator widgets between list items, commonly
/// used for creating lists with dividers, spacing, or other visual separations.
extension Joinable<T extends Widget> on List<T> {
  /// Inserts a separator widget between each item in the list.
  ///
  /// Creates a new list where the separator is placed between each pair of
  /// adjacent items. The first and last items don't get separators before
  /// or after them respectively.
  ///
  /// Parameters:
  /// - [separator] (T): The widget to use as a separator.
  ///
  /// Returns:
  /// A new `List<T>` with separators inserted between items.
  ///
  /// Example:
  /// ```dart
  /// final widgets = [Text('A'), Text('B'), Text('C')];
  /// final withDividers = widgets.joinSeparator(Divider());
  /// // Result: [Text('A'), Divider(), Text('B'), Divider(), Text('C')]
  /// ```
  List<T> joinSeparator(T separator) {
    List<T> result = [];
    for (int i = 0; i < length; i++) {
      if (i > 0) {
        result.add(separator);
      }
      result.add(this[i]);
    }
    return result;
  }
}

/// Extension methods for Iterables that provide separator joining functionality.
///
/// Adds methods to insert separators between iterable items and build
/// dynamic separators based on position or content.
extension IterableExtension<T> on Iterable<T> {
  /// Inserts a separator between each item in the iterable.
  ///
  /// Creates a new iterable where the separator is placed between each pair
  /// of adjacent items. Uses lazy evaluation for better performance with
  /// large iterables.
  ///
  /// Parameters:
  /// - [separator] (T): The item to use as a separator.
  ///
  /// Returns:
  /// An `Iterable<T>` with separators inserted between items.
  ///
  /// Example:
  /// ```dart
  /// final items = ['A', 'B', 'C'];
  /// final joined = items.joinSeparator('-').toList();
  /// // Result: ['A', '-', 'B', '-', 'C']
  /// ```
  Iterable<T> joinSeparator(T separator) {
    return map((e) => [separator, e]).expand((element) => element).skip(1);
  }

  /// Inserts dynamically generated separators between each item.
  ///
  /// Similar to joinSeparator, but the separator is generated on-demand
  /// using the provided function. This allows for dynamic separators that
  /// can vary based on position or other factors.
  ///
  /// Parameters:
  /// - [separator] (ValueGetter<T>): Function that generates separator items.
  ///
  /// Returns:
  /// An `Iterable<T>` with dynamically generated separators.
  ///
  /// Example:
  /// ```dart
  /// final items = [1, 2, 3];
  /// final withSeparators = items.buildSeparator(() => Random().nextInt(10));
  /// ```
  Iterable<T> buildSeparator(ValueGetter<T> separator) {
    return map((e) => [separator(), e]).expand((element) => element).skip(1);
  }
}

typedef NeverWidgetBuilder = Widget Function(
    [dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic]);

extension WidgetExtension on Widget {
  NeverWidgetBuilder get asBuilder => ([a, b, c, d, e, f, g, h, i, j]) => this;
  Widget sized({double? width, double? height}) {
    if (this is SizedBox) {
      return SizedBox(
        width: width ?? (this as SizedBox).width,
        height: height ?? (this as SizedBox).height,
        child: (this as SizedBox).child,
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  Widget constrained(
      {double? minWidth,
      double? maxWidth,
      double? minHeight,
      double? maxHeight,
      double? width,
      double? height}) {
    if (this is ConstrainedBox) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width ??
              minWidth ??
              (this as ConstrainedBox).constraints.minWidth,
          maxWidth: width ??
              maxWidth ??
              (this as ConstrainedBox).constraints.maxWidth,
          minHeight: height ??
              minHeight ??
              (this as ConstrainedBox).constraints.minHeight,
          maxHeight: height ??
              maxHeight ??
              (this as ConstrainedBox).constraints.maxHeight,
        ),
        child: (this as ConstrainedBox).child,
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width ?? minWidth ?? 0,
        maxWidth: width ?? maxWidth ?? double.infinity,
        minHeight: height ?? minHeight ?? 0,
        maxHeight: height ?? maxHeight ?? double.infinity,
      ),
      child: this,
    );
  }

  // Widget padding({EdgeInsetsGeometry padding = EdgeInsets.zero}) {
  //   return Padding(
  //     padding: padding,
  //     child: this,
  //   );
  // }

  Widget withPadding(
      {double? top,
      double? bottom,
      double? left,
      double? right,
      double? horizontal,
      double? vertical,
      double? all,
      EdgeInsetsGeometry? padding}) {
    assert(() {
      if (all != null) {
        if (top != null ||
            bottom != null ||
            left != null ||
            right != null ||
            horizontal != null ||
            vertical != null) {
          throw FlutterError(
              'All padding properties cannot be used with other padding properties.');
        }
      } else if (horizontal != null) {
        if (left != null || right != null) {
          throw FlutterError(
              'Horizontal padding cannot be used with left or right padding.');
        }
      } else if (vertical != null) {
        if (top != null || bottom != null) {
          throw FlutterError(
              'Vertical padding cannot be used with top or bottom padding.');
        }
      }
      return true;
    }());
    var edgeInsets = EdgeInsets.only(
      top: top ?? vertical ?? all ?? 0,
      bottom: bottom ?? vertical ?? all ?? 0,
      left: left ?? horizontal ?? all ?? 0,
      right: right ?? horizontal ?? all ?? 0,
    );
    return Padding(
      padding: padding ?? edgeInsets,
      child: this,
    );
  }

  Widget withMargin(
      {double? top,
      double? bottom,
      double? left,
      double? right,
      double? horizontal,
      double? vertical,
      double? all}) {
    assert(() {
      if (all != null) {
        if (top != null ||
            bottom != null ||
            left != null ||
            right != null ||
            horizontal != null ||
            vertical != null) {
          throw FlutterError(
              'All margin properties cannot be used with other margin properties.');
        }
      } else if (horizontal != null) {
        if (left != null || right != null) {
          throw FlutterError(
              'Horizontal margin cannot be used with left or right margin.');
        }
      } else if (vertical != null) {
        if (top != null || bottom != null) {
          throw FlutterError(
              'Vertical margin cannot be used with top or bottom margin.');
        }
      }
      return true;
    }());
    return Container(
      margin: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  Widget center({Key? key}) {
    return Center(
      key: key,
      child: this,
    );
  }

  Widget withAlign(AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget positioned(
      {Key? key, double? left, double? top, double? right, double? bottom}) {
    return Positioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget withOpacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  Widget clip({Clip clipBehavior = Clip.hardEdge}) {
    return ClipRect(
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Widget clipRRect(
      {BorderRadiusGeometry borderRadius = BorderRadius.zero,
      Clip clipBehavior = Clip.antiAlias}) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Widget clipOval({Clip clipBehavior = Clip.antiAlias}) {
    return ClipOval(
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Widget clipPath(
      {Clip clipBehavior = Clip.antiAlias,
      required CustomClipper<Path> clipper}) {
    return ClipPath(
      clipBehavior: clipBehavior,
      clipper: clipper,
      child: this,
    );
  }

  Widget transform({Key? key, required Matrix4 transform}) {
    return Transform(
      key: key,
      transform: transform,
      child: this,
    );
  }

  Widget intrinsicWidth({double? stepWidth, double? stepHeight}) {
    return IntrinsicWidth(
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: this,
    );
  }

  Widget intrinsicHeight() {
    return IntrinsicHeight(
      child: this,
    );
  }

  Widget intrinsic({double? stepWidth, double? stepHeight}) {
    return IntrinsicWidth(
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: IntrinsicHeight(
        child: this,
      ),
    );
  }
}

extension ColumnExtension on Column {
  Widget gap(double gap) {
    return separator(SizedBox(height: gap));
  }

  Widget separator(Widget separator) {
    return SeparatedFlex(
      key: key,
      direction: Axis.vertical,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      separator: separator,
      children: children,
    );
  }
}

extension RowExtension on Row {
  Widget gap(double gap) {
    return separator(SizedBox(width: gap));
  }

  Widget separator(Widget separator) {
    return SeparatedFlex(
      key: key,
      direction: Axis.horizontal,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      separator: separator,
      children: children,
    );
  }
}

class SeparatedFlex extends StatefulWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final Axis direction;
  final Widget separator;
  final Clip clipBehavior;

  const SeparatedFlex({
    super.key,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    this.textDirection,
    required this.verticalDirection,
    this.textBaseline,
    required this.children,
    required this.separator,
    required this.direction,
    this.clipBehavior = Clip.none,
  });

  @override
  State<SeparatedFlex> createState() => _SeparatedFlexState();
}

class _SeparatedFlexState extends State<SeparatedFlex> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = join(widget.children, widget.separator).toList();
  }

  @override
  void didUpdateWidget(covariant SeparatedFlex oldWidget) {
    super.didUpdateWidget(oldWidget);
    mutateSeparated(widget.children, _children, widget.separator);
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      key: widget.key,
      direction: widget.direction,
      mainAxisAlignment: widget.mainAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      crossAxisAlignment: widget.crossAxisAlignment,
      textDirection: widget.textDirection,
      verticalDirection: widget.verticalDirection,
      textBaseline: widget.textBaseline,
      clipBehavior: widget.clipBehavior,
      children: _children,
    );
  }
}

extension FlexExtension on Flex {
  Widget gap(double gap) {
    return separator(direction == Axis.vertical
        ? SizedBox(height: gap)
        : SizedBox(width: gap));
  }

  Widget separator(Widget separator) {
    return SeparatedFlex(
      key: key,
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      separator: separator,
      children: children,
    );
  }
}

Iterable<Widget> join(Iterable<Widget> widgets, Widget separator) {
  return SeparatedIterable(widgets, separator);
}

extension DoubleExtension on double {
  double min(double other) => this < other ? this : other;
  double max(double other) => this > other ? this : other;
}

extension IntExtension on int {
  int min(int other) => this < other ? this : other;
  int max(int other) => this > other ? this : other;
}

class IconThemeDataTween extends Tween<IconThemeData> {
  IconThemeDataTween({super.begin, super.end});

  @override
  IconThemeData lerp(double t) => IconThemeData.lerp(begin, end, t);
}

extension ColorExtension on Color {
  Color scaleAlpha(double factor) {
    return withValues(
      alpha: a * factor,
    );
  }

  Color getContrastColor([double luminanceContrast = 1]) {
    // luminance contrast is between 0..1
    assert(luminanceContrast >= 0 && luminanceContrast <= 1,
        'luminanceContrast should be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    double currentLuminance = hsl.lightness;
    double targetLuminance;
    if (currentLuminance >= 0.5) {
      targetLuminance =
          currentLuminance - (currentLuminance * luminanceContrast);
    } else {
      targetLuminance =
          currentLuminance + ((1 - currentLuminance) * luminanceContrast);
    }
    return hsl.withLightness(targetLuminance).toColor();
  }

  Color withLuminance(double luminance) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness(luminance).toColor();
  }

  String toHex({bool includeHashSign = false, bool includeAlpha = true}) {
    String hex = value.toRadixString(16).padLeft(8, '0');
    if (!includeAlpha) {
      hex = hex.substring(2);
    }
    if (includeHashSign) {
      hex = '#$hex';
    }
    return hex;
  }

  HSLColor toHSL() {
    return HSLColor.fromColor(this);
  }

  HSVColor toHSV() {
    return HSVColor.fromColor(this);
  }
}

extension HSLColorExtension on HSLColor {
  HSVColor toHSV() {
    final double l = lightness;
    final double s = saturation;
    final double h = hue;
    final double a = alpha;
    final double v = l + s * min(l, 1 - l);
    double newH;
    double newS;
    if (v == 0) {
      newH = 0;
      newS = 0;
    } else {
      newS = 2 * (1 - l / v);
      newH = h;
    }
    return HSVColor.fromAHSV(a, newH, newS, v);
  }
}

extension HSVColorExtension on HSVColor {
  HSLColor toHSL() {
    final double v = value;
    final double s = saturation;
    final double h = hue;
    final double a = alpha;
    final double l = v * (1 - s / 2);
    double newH;
    double newS;
    if (l == 0 || l == 1) {
      newH = 0;
      newS = 0;
    } else {
      newS = (v - l) / min(l, 1 - l);
      newH = h;
    }
    return HSLColor.fromAHSL(a, newH, newS, l);
  }
}

/// A representation of a time during a 24-hour day, independent of date and timezone.
///
/// [TimeOfDay] stores hour, minute, and optional second values to represent 
/// a specific moment within a day. It provides convenient constructors for
/// common time creation scenarios and methods for time manipulation.
///
/// Key features:
/// - 24-hour format representation (0-23 hours)
/// - Optional second precision (defaults to 0)
/// - Convenient AM/PM constructors
/// - Creation from DateTime and Duration objects
/// - Immutable design with copyWith functionality
///
/// Common use cases:
/// - Time picker components
/// - Schedule and calendar applications
/// - Time-based calculations and comparisons
/// - User interface time displays
///
/// Example:
/// ```dart
/// // Create specific times
/// final morning = TimeOfDay(hour: 9, minute: 30);
/// final afternoon = TimeOfDay.pm(hour: 3, minute: 15); // 15:15
/// final now = TimeOfDay.now();
/// 
/// // Create from existing objects
/// final fromDateTime = TimeOfDay.fromDateTime(DateTime.now());
/// final fromDuration = TimeOfDay.fromDuration(Duration(hours: 2, minutes: 30));
/// 
/// // Modify existing times
/// final modified = morning.copyWith(hour: () => 10);
/// ```
class TimeOfDay {
  /// The hour component in 24-hour format (0-23).
  final int hour;
  
  /// The minute component (0-59).
  final int minute;
  
  /// The second component (0-59), defaults to 0.
  final int second;

  /// Creates a [TimeOfDay] with the specified hour, minute, and optional second.
  ///
  /// Parameters:
  /// - [hour] (int, required): Hour in 24-hour format (0-23)
  /// - [minute] (int, required): Minute value (0-59)
  /// - [second] (int, optional): Second value (0-59), defaults to 0
  const TimeOfDay({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  /// Creates a [TimeOfDay] for PM hours (12:00-23:59).
  ///
  /// Automatically converts 12-hour PM format to 24-hour format by adding 12
  /// to the provided hour value.
  ///
  /// Parameters:
  /// - [hour] (int, required): Hour in 12-hour format (1-11, where 12 becomes 24)
  /// - [minute] (int, required): Minute value (0-59)
  /// - [second] (int, optional): Second value (0-59), defaults to 0
  const TimeOfDay.pm({
    required int hour,
    required this.minute,
    this.second = 0,
  }) : hour = hour + 12;

  /// Creates a [TimeOfDay] for AM hours (00:00-11:59).
  ///
  /// Preserves the hour value as-is for morning times.
  ///
  /// Parameters:
  /// - [hour] (int, required): Hour in 24-hour format (0-11)
  /// - [minute] (int, required): Minute value (0-59)
  /// - [second] (int, optional): Second value (0-59), defaults to 0
  const TimeOfDay.am({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  /// Creates a [TimeOfDay] from a [DateTime] object.
  ///
  /// Extracts the hour, minute, and second components from the provided
  /// [DateTime], discarding date and timezone information.
  ///
  /// Parameters:
  /// - [dateTime] (DateTime, required): Source DateTime to extract time from
  TimeOfDay.fromDateTime(DateTime dateTime)
      : hour = dateTime.hour,
        minute = dateTime.minute,
        second = dateTime.second;

  /// Creates a [TimeOfDay] from a [Duration] object.
  ///
  /// Converts the total duration into hours, minutes, and seconds,
  /// wrapping values appropriately (e.g., 90 minutes becomes 1 hour 30 minutes).
  ///
  /// Parameters:
  /// - [duration] (Duration, required): Source Duration to convert
  TimeOfDay.fromDuration(Duration duration)
      : hour = duration.inHours,
        minute = duration.inMinutes % 60,
        second = duration.inSeconds % 60;

  /// Creates a [TimeOfDay] representing the current time.
  ///
  /// Convenience constructor that creates a TimeOfDay from the current
  /// DateTime.now() value.
  TimeOfDay.now() : this.fromDateTime(DateTime.now());

  /// Creates a copy of this [TimeOfDay] with specified fields replaced.
  ///
  /// Uses ValueGetter functions to allow for computed replacements.
  /// Any field not specified retains its current value.
  ///
  /// Parameters:
  /// - [hour] (ValueGetter<int>?, optional): New hour value provider
  /// - [minute] (ValueGetter<int>?, optional): New minute value provider  
  /// - [second] (ValueGetter<int>?, optional): New second value provider
  ///
  /// Returns:
  /// A new [TimeOfDay] instance with updated values.
  TimeOfDay copyWith({
    ValueGetter<int>? hour,
    ValueGetter<int>? minute,
    ValueGetter<int>? second,
  }) {
    return TimeOfDay(
      hour: hour == null ? this.hour : hour(),
      minute: minute == null ? this.minute : minute(),
      second: second == null ? this.second : second(),
    );
  }

  /// Creates a copy of this [TimeOfDay] with specified fields replaced.
  ///
  /// For backward compatibility. Provides direct value replacement
  /// instead of ValueGetter functions.
  ///
  /// Parameters:
  /// - [hour] (int?, optional): New hour value (0-23)
  /// - [minute] (int?, optional): New minute value (0-59)
  /// - [second] (int?, optional): New second value (0-59)
  ///
  /// Returns:
  /// A new [TimeOfDay] instance with updated values.
  /// For backward compatibility
  TimeOfDay replacing({
    int? hour,
    int? minute,
    int? second,
  }) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TimeOfDay &&
        other.hour == hour &&
        other.minute == minute &&
        other.second == second;
  }

  @override
  int get hashCode => Object.hash(hour, minute, second);

  @override
  String toString() {
    return 'TimeOfDay{hour: $hour, minute: $minute, second: $second}';
  }
}

/// Invokes an action on the currently focused widget if available.
///
/// Attempts to find and invoke the specified [Intent] on the widget that
/// currently has focus. This is useful for triggering keyboard shortcuts
/// or programmatic actions that should apply to the focused element.
///
/// The function searches for an appropriate action handler in the focused
/// widget's context and invokes it if found and enabled.
///
/// Parameters:
/// - [intent] (Intent, required): The intent/action to invoke
///
/// Returns:
/// A tuple containing:
/// - `bool`: Whether the action was found and enabled
/// - `Object?`: The result returned by the invoked action (if any)
///
/// Example:
/// ```dart
/// final (enabled, result) = invokeActionOnFocusedWidget(
///   const ActivateIntent(),
/// );
/// if (enabled) {
///   print('Action was invoked with result: $result');
/// }
/// ```
(bool enabled, Object? invokeResult) invokeActionOnFocusedWidget(
    Intent intent) {
  final context = primaryFocus?.context;
  if (context != null) {
    Action<Intent>? action = Actions.maybeFind<Intent>(context, intent: intent);
    if (action != null) {
      final (bool enabled, Object? invokeResult) =
          Actions.of(context).invokeActionIfEnabled(action, intent);
      return (enabled, invokeResult);
    }
  }
  return (false, null);
}

/// Extension methods for [TextEditingController] to provide additional text editing functionality.
///
/// Adds utility methods for working with text selection, word manipulation,
/// and caret positioning to enhance text editing capabilities.
extension TextEditingControllerExtension on TextEditingController {
  /// Gets the word at the current cursor position.
  ///
  /// Returns the complete word where the cursor is currently positioned,
  /// or null if no word is at the cursor or the text is empty.
  /// Only works when the cursor is collapsed (no text selection).
  ///
  /// Returns:
  /// The word at cursor position, or null if not applicable.
  ///
  /// Example:
  /// ```dart
  /// final controller = TextEditingController(text: 'Hello world');
  /// controller.selection = TextSelection.collapsed(offset: 2);
  /// print(controller.currentWord); // Output: 'Hello'
  /// ```
  String? get currentWord {
    final value = this.value;
    final text = value.text;
    final selection = value.selection;
    if (text.isEmpty) {
      return null;
    }
    if (selection.isCollapsed) {
      return getWordAtCaret(text, selection.baseOffset).$2;
    }
    return null;
  }
}

/// A record type representing word information with its position and content.
///
/// Contains the starting index and the actual word string, used by text
/// manipulation functions to track word boundaries and content.
///
/// Fields:
/// - `int start`: The starting index of the word in the text
/// - `String word`: The actual word content
typedef WordInfo = (int start, String word);

/// A record type representing replacement information for text operations.
///
/// Contains the starting position and new text content for text replacement
/// operations, providing a structured way to specify text modifications.
///
/// Fields:
/// - `int start`: The starting index where replacement should occur
/// - `String newText`: The new text to insert at the position
typedef ReplacementInfo = (int start, String newText);

/// Gets information about the word at the specified caret position.
///
/// Analyzes the text around the given caret position to identify word
/// boundaries and extract the complete word. Uses the provided separator
/// to determine word breaks (defaults to space character).
///
/// Parameters:
/// - [text] (String, required): The text to analyze
/// - [caret] (int, required): The caret position within the text
/// - [separator] (String, optional): Word separator character, defaults to ' '
///
/// Returns:
/// A [WordInfo] record containing the word's start position and content.
///
/// Throws:
/// [RangeError] if caret position is outside the text bounds.
///
/// Example:
/// ```dart
/// final info = getWordAtCaret('Hello world', 7);
/// print('Word: ${info.word}, starts at: ${info.start}');
/// // Output: Word: world, starts at: 6
/// ```
WordInfo getWordAtCaret(String text, int caret, [String separator = ' ']) {
  if (caret < 0 || caret > text.length) {
    throw RangeError('Caret position is out of bounds.');
  }

  // Find the start of the word
  int start = caret;
  while (start > 0 && !separator.contains(text[start - 1])) {
    start--;
  }

  // Find the end of the word
  int end = caret;
  while (end < text.length && !separator.contains(text[end])) {
    end++;
  }

  // Return the start index and the word at the caret position
  String word = text.substring(start, end);
  return (start, word);
}

/// Replaces the word at the specified caret position with a new replacement text.
///
/// Identifies the word boundaries around the caret position and replaces
/// the entire word with the provided replacement text. Returns information
/// about the replacement operation including the start position and the
/// resulting text.
///
/// Parameters:
/// - [text] (String, required): The original text to modify
/// - [caret] (int, required): The caret position within the word to replace
/// - [replacement] (String, required): The new text to replace the word with
/// - [separator] (String, optional): Word separator character, defaults to ' '
///
/// Returns:
/// A [ReplacementInfo] record containing the start position and the new text.
///
/// Throws:
/// [RangeError] if caret position is outside the text bounds.
///
/// Example:
/// ```dart
/// final info = replaceWordAtCaret('Hello world', 7, 'universe');
/// print('New text: ${info.newText}'); 
/// // Output: New text: Hello universe
/// ```
ReplacementInfo replaceWordAtCaret(String text, int caret, String replacement,
    [String separator = ' ']) {
  if (caret < 0 || caret > text.length) {
    throw RangeError('Caret position is out of bounds.');
  }

  // Get the start and end of the word
  int start = caret;
  while (start > 0 && !separator.contains(text[start - 1])) {
    start--;
  }

  int end = caret;
  while (end < text.length && !separator.contains(text[end])) {
    end++;
  }

  // Replace the word with the replacement
  String newText = text.replaceRange(start, end, replacement);
  return (start, newText);
}

/// Clears the active text input field by invoking a clear intent.
///
/// Attempts to clear the content of the currently focused text input field
/// by sending a [TextFieldClearIntent] to the focused widget. This is useful
/// for programmatically clearing text fields without direct reference to
/// the specific controller.
///
/// The function will only work if there is a currently focused text input
/// that supports the clear intent action.
///
/// Example:
/// ```dart
/// // Clear the currently focused text field
/// clearActiveTextInput();
/// ```
void clearActiveTextInput() {
  TextFieldClearIntent intent = const TextFieldClearIntent();
  invokeActionOnFocusedWidget(intent);
}

/// A mixin that enables intelligent widget caching based on value comparison.
///
/// Classes that implement [CachedValue] can determine when their associated
/// widgets should be rebuilt by providing custom rebuild logic. This is useful
/// for optimizing performance in scenarios where expensive widgets should only
/// be rebuilt when specific conditions are met.
///
/// The mixin works in conjunction with [CachedValueWidget] to provide efficient
/// widget caching and selective rebuilding.
mixin CachedValue {
  /// Determines whether the widget should be rebuilt based on value comparison.
  ///
  /// Compare the current value with the old value to decide if a rebuild
  /// is necessary. Return true to trigger a rebuild, false to use cached widget.
  ///
  /// Parameters:
  /// - [oldValue] (CachedValue, required): The previous value to compare against
  ///
  /// Returns:
  /// True if the widget should rebuild, false to use cached version.
  bool shouldRebuild(covariant CachedValue oldValue);
}

/// A widget that caches its built content based on value changes.
///
/// [CachedValueWidget] builds its child widget only when necessary, caching
/// the result for performance optimization. It works with [CachedValue] objects
/// to determine when rebuilding is required, or falls back to equality comparison
/// for non-CachedValue types.
///
/// This is particularly useful for expensive widgets that don't need frequent
/// rebuilds, such as complex charts, heavy computations, or large lists.
///
/// Example:
/// ```dart
/// CachedValueWidget<String>(
///   value: expensiveData,
///   builder: (context, value) => ExpensiveWidget(data: value),
/// )
/// ```
class CachedValueWidget<T> extends StatefulWidget {
  /// The value to monitor for changes and pass to the builder.
  final T value;
  
  /// Builder function that creates the widget using the provided value.
  final Widget Function(BuildContext context, T value) builder;

  /// Creates a [CachedValueWidget] with the specified value and builder.
  ///
  /// Parameters:
  /// - [key] (Key?, optional): Widget key for identification
  /// - [value] (T, required): The value to cache and monitor for changes  
  /// - [builder] (Function, required): Builder function that creates the child widget
  const CachedValueWidget({
    super.key,
    required this.value,
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() => _CachedValueWidgetState<T>();
}

class _CachedValueWidgetState<T> extends State<CachedValueWidget<T>> {
  Widget? _cachedWidget;

  @override
  void didUpdateWidget(covariant CachedValueWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (T is CachedValue) {
      if ((widget.value as CachedValue)
          .shouldRebuild(oldWidget.value as CachedValue)) {
        _cachedWidget = null;
      }
    } else {
      if (widget.value != oldWidget.value) {
        _cachedWidget = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _cachedWidget ??= widget.builder(context, widget.value);
    return _cachedWidget!;
  }
}

/// A function type for converting values from one type to another.
///
/// Represents a conversion function that takes a value of type [F] (from)
/// and returns a value of type [T] (to). Used in bidirectional conversion
/// scenarios and data transformation operations.
///
/// Type parameters:
/// - [F]: The source type to convert from
/// - [T]: The target type to convert to
///
/// Example:
/// ```dart
/// final stringToInt = Convert<String, int>((s) => int.parse(s));
/// final result = stringToInt('42'); // Returns 42
/// ```
typedef Convert<F, T> = T Function(F value);

/// A class that provides bidirectional conversion between two types.
///
/// [BiDirectionalConvert] encapsulates conversion functions for transforming
/// values from type [A] to type [B] and vice versa. This is useful for
/// scenarios where you need to convert data back and forth between different
/// representations, such as model objects and their serialized forms.
///
/// The class provides convenience methods for performing conversions in both
/// directions while maintaining type safety.
///
/// Example:
/// ```dart
/// final converter = BiDirectionalConvert<String, int>(
///   (str) => int.parse(str),
///   (num) => num.toString(),
/// );
/// 
/// final number = converter.convertA('42');    // Returns 42
/// final string = converter.convertB(42);      // Returns '42'
/// ```
class BiDirectionalConvert<A, B> {
  /// Conversion function from type A to type B.
  final Convert<A, B> aToB;
  
  /// Conversion function from type B to type A.
  final Convert<B, A> bToA;

  /// Creates a [BiDirectionalConvert] with the specified conversion functions.
  ///
  /// Parameters:
  /// - [aToB] (Convert<A, B>, required): Function to convert from A to B
  /// - [bToA] (Convert<B, A>, required): Function to convert from B to A
  const BiDirectionalConvert(this.aToB, this.bToA);

  /// Converts a value from type A to type B.
  ///
  /// Parameters:
  /// - [value] (A, required): The value of type A to convert
  ///
  /// Returns:
  /// The converted value of type B.
  B convertA(A value) => aToB(value);

  /// Converts a value from type B to type A.
  ///
  /// Parameters:
  /// - [value] (B, required): The value of type B to convert
  ///
  /// Returns:
  /// The converted value of type A.
  A convertB(B value) => bToA(value);

  @override
  String toString() {
    return 'BiDirectionalConvert($aToB, $bToA)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BiDirectionalConvert<A, B> &&
        other.aToB == aToB &&
        other.bToA == bToA;
  }
}

/// A controller that provides bidirectional conversion between two value types.
///
/// [ConvertedController] acts as an adapter between a [ValueNotifier] of type [F]
/// and a [ComponentController] interface of type [T]. It automatically converts
/// values in both directions using a [BiDirectionalConvert] instance, keeping
/// both sides synchronized.
///
/// This is useful when you need to connect components that work with different
/// data types but represent the same logical value, such as connecting a string
/// input field to a numeric controller.
///
/// The controller handles:
/// - Automatic conversion when the source value changes
/// - Bidirectional updates without infinite loops
/// - Change notification to listeners
/// - Proper cleanup when disposed
///
/// Example:
/// ```dart
/// final sourceController = ValueNotifier<String>('42');
/// final converter = BiDirectionalConvert<String, int>(
///   int.parse,
///   (num) => num.toString(),
/// );
/// final convertedController = ConvertedController(sourceController, converter);
/// 
/// print(convertedController.value); // 42 (int)
/// convertedController.value = 100;
/// print(sourceController.value);    // '100' (String)
/// ```
class ConvertedController<F, T> extends ChangeNotifier
    implements ComponentController<T> {
  /// The source ValueNotifier that provides the original values.
  final ValueNotifier<F> _other;
  
  /// The bidirectional converter for transforming between F and T types.
  final BiDirectionalConvert<F, T> _convert;

  /// The current converted value of type T.
  T _value;
  
  /// Flag to prevent infinite update loops during bidirectional conversion.
  bool _isUpdating = false;

  /// Creates a [ConvertedController] with the specified source and converter.
  ///
  /// Parameters:
  /// - [other] (ValueNotifier<F>, required): Source notifier to convert from
  /// - [convert] (BiDirectionalConvert<F, T>, required): Conversion functions
  ConvertedController(
      ValueNotifier<F> other, BiDirectionalConvert<F, T> convert)
      : _other = other,
        _convert = convert,
        _value = convert.convertA(other.value) {
    _other.addListener(_onOtherValueChanged);
  }

  void _onOtherValueChanged() {
    if (_isUpdating) {
      return;
    }
    _isUpdating = true;
    try {
      _value = _convert.convertA(_other.value);
      notifyListeners();
    } finally {
      _isUpdating = false;
    }
  }

  void _onValueChanged() {
    if (_isUpdating) {
      return;
    }
    _isUpdating = true;
    try {
      _other.value = _convert.convertB(_value);
    } finally {
      _isUpdating = false;
    }
  }

  @override
  T get value => _value;

  @override
  set value(T newValue) {
    if (newValue == _value) {
      return;
    }
    _value = newValue;
    notifyListeners();
    _onValueChanged();
  }

  @override
  void dispose() {
    _other.removeListener(_onOtherValueChanged);
    super.dispose();
  }
}

/// Extension methods for [TextEditingValue] to provide additional text manipulation functionality.
///
/// Adds utility methods for text replacement operations while preserving
/// text selection state and handling edge cases automatically.
extension TextEditingValueExtension on TextEditingValue {
  /// Replaces the text content while preserving and adjusting the selection.
  ///
  /// Creates a new [TextEditingValue] with the specified text, automatically
  /// adjusting the selection to stay within valid bounds. If the new text is
  /// shorter than the current selection, the selection is clamped to fit.
  ///
  /// Parameters:
  /// - [newText] (String, required): The new text content to set
  ///
  /// Returns:
  /// A new [TextEditingValue] with updated text and adjusted selection.
  ///
  /// Example:
  /// ```dart
  /// final value = TextEditingValue(
  ///   text: 'Hello world',
  ///   selection: TextSelection(baseOffset: 6, extentOffset: 11),
  /// );
  /// final updated = value.replaceText('Hi');
  /// // Result: text='Hi', selection collapsed at offset 2
  /// ```
  TextEditingValue replaceText(String newText) {
    var selection = this.selection;
    selection = selection.copyWith(
      baseOffset: selection.baseOffset.clamp(0, newText.length),
      extentOffset: selection.extentOffset.clamp(0, newText.length),
    );
    return TextEditingValue(
      text: newText,
      selection: selection,
    );
  }
}

/// A callback function type for handling context-aware Intent actions.
///
/// Represents a function that processes an Intent with optional BuildContext,
/// returning an optional result. Used by [ContextCallbackAction] to provide
/// custom action handling logic that can access the widget tree context.
///
/// Type parameters:
/// - [T]: The specific Intent type this callback handles
///
/// Parameters:
/// - [intent] (T, required): The intent to process
/// - [context] (BuildContext?, optional): The build context for widget tree access
///
/// Returns:
/// An optional result object from processing the intent.
///
/// Example:
/// ```dart
/// final callback = OnContextedCallback<MyIntent>((intent, context) {
///   // Handle the intent with optional context
///   return someResult;
/// });
/// ```
typedef OnContextedCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

/// A context action that delegates intent handling to a callback function.
///
/// [ContextCallbackAction] provides a simple way to create context-aware actions
/// by wrapping a callback function. This allows for flexible action handling
/// without creating custom action classes for simple operations.
///
/// The action passes both the intent and optional context to the callback,
/// enabling context-aware processing and returning any result produced by
/// the callback function.
///
/// Example:
/// ```dart
/// final action = ContextCallbackAction<MyIntent>(
///   onInvoke: (intent, context) {
///     // Custom handling logic
///     ScaffoldMessenger.of(context)?.showSnackBar(snackBar);
///     return 'Action completed';
///   },
/// );
/// ```
class ContextCallbackAction<T extends Intent> extends ContextAction<T> {
  /// The callback function to invoke when this action is triggered.
  final OnContextedCallback<T> onInvoke;

  /// Creates a [ContextCallbackAction] with the specified callback.
  ///
  /// Parameters:
  /// - [onInvoke] (OnContextedCallback<T>, required): Function to handle intents
  ContextCallbackAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}
