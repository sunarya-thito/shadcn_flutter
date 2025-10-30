import 'dart:async';
import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A function that tests a value of type [T] and returns a boolean.
typedef Predicate<T> = bool Function(T value);

/// A function that takes a value of type [T] and returns a value of type [T].
typedef UnaryOperator<T> = T Function(T value);

/// A function that takes two values of type [T] and returns a value of type [T].
typedef BinaryOperator<T> = T Function(T a, T b);

/// Default animation duration for UI transitions (150ms).
const kDefaultDuration = Duration(milliseconds: 150);

/// A callback that receives a [BuildContext].
typedef ContextedCallback = void Function(BuildContext context);

/// A callback that receives a [BuildContext] and a value of type [T].
typedef ContextedValueChanged<T> = void Function(BuildContext context, T value);

/// A function that scores how well a value matches a search query.
///
/// Returns a score where higher values indicate better matches.
typedef SearchPredicate<T> = double Function(T value, String query);

/// Converts degrees to radians.
///
/// Parameters:
/// - [deg] (double, required): Angle in degrees
///
/// Returns angle in radians.
double degToRad(double deg) => deg * (pi / 180);

/// Converts radians to degrees.
///
/// Parameters:
/// - [rad] (double, required): Angle in radians
///
/// Returns angle in degrees.
double radToDeg(double rad) => rad * (180 / pi);

/// The direction for sorting.
enum SortDirection {
  /// No sorting applied.
  none,

  /// Sort in ascending order (A to Z, 0 to 9).
  ascending,

  /// Sort in descending order (Z to A, 9 to 0).
  descending,
}

/// Callback signature for context actions.
///
/// Parameters:
/// - [intent] (Intent, required): The intent being invoked
/// - [context] (BuildContext?): Optional build context
///
/// Returns result of the action invocation.
typedef OnContextInvokeCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

/// A context action that executes a callback.
class CallbackContextAction<T extends Intent> extends ContextAction<T> {
  /// Callback to execute when action is invoked.
  final OnContextInvokeCallback onInvoke;

  /// Creates a [CallbackContextAction] with the given callback.
  /// Parameters:
  /// - [onInvoke] (OnContextInvokeCallback, required): Callback to execute
  CallbackContextAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}

/// A utility for safely interpolating between values of type [T].
class SafeLerp<T> {
  /// Nullable lerp function that can handle null values.
  final T? Function(T? a, T? b, double t) nullableLerp;

  /// Creates a SafeLerp with the given nullable lerp function.
  const SafeLerp(this.nullableLerp);

  /// Interpolates between non-null values.
  ///
  /// Asserts that the result is non-null.
  ///
  /// Parameters:
  /// - [a] (T, required): Start value
  /// - [b] (T, required): End value
  /// - [t] (double, required): Interpolation position (0.0 to 1.0)
  ///
  /// Returns interpolated value.
  T lerp(T a, T b, double t) {
    T? result = nullableLerp(a, b, t);
    assert(result != null, 'Unsafe lerp');
    return result!;
  }
}

/// Extension on nullable lerp functions to create non-null lerp helpers.
extension SafeLerpExtension<T> on T? Function(T? a, T? b, double t) {
  /// Wraps this nullable lerp function to work with non-null values.
  ///
  /// Asserts that the lerp result is non-null.
  ///
  /// Parameters:
  /// - [a] (T, required): Start value
  /// - [b] (T, required): End value
  /// - [t] (double, required): Interpolation position
  ///
  /// Returns interpolated non-null value.
  T nonNull(T a, T b, double t) {
    T? result = this(a, b, t);
    assert(result != null);
    return result!;
  }
}

/// Extension methods for List operations with null-safe variants.
extension ListExtension<T> on List<T> {
  /// Finds the first index of an element, returning null if not found.
  ///
  /// Parameters:
  /// - [obj] (T, required): Element to find
  /// - [start] (int): Index to start searching from, defaults to 0
  ///
  /// Returns index or null if not found.
  int? indexOfOrNull(T obj, [int start = 0]) {
    int index = indexOf(obj, start);
    return index == -1 ? null : index;
  }

  /// Finds the last index of an element, returning null if not found.
  ///
  /// Parameters:
  /// - [obj] (T, required): Element to find
  /// - [start] (int?): Index to search backwards from
  ///
  /// Returns last index or null if not found.
  int? lastIndexOfOrNull(T obj, [int? start]) {
    int index = lastIndexOf(obj, start);
    return index == -1 ? null : index;
  }

  /// Finds the first index where test is true, returning null if not found.
  ///
  /// Parameters:
  /// - [test] (`Predicate<T>`, required): Test function
  /// - [start] (int): Index to start searching from, defaults to 0
  ///
  /// Returns index or null if no match found.
  int? indexWhereOrNull(Predicate<T> test, [int start = 0]) {
    int index = indexWhere(test, start);
    return index == -1 ? null : index;
  }

  /// Finds the last index where test is true, returning null if not found.
  ///
  /// Parameters:
  /// - [test] (`Predicate<T>`, required): Test function
  /// - [start] (int?): Index to search backwards from
  ///
  /// Returns last index or null if no match found.
  int? lastIndexWhereOrNull(Predicate<T> test, [int? start]) {
    int index = lastIndexWhere(test, start);
    return index == -1 ? null : index;
  }

  /// Moves an element to a target index in the list.
  ///
  /// If the element doesn't exist, inserts it at the target index.
  /// If targetIndex >= length, moves element to the end.
  ///
  /// Parameters:
  /// - [element] (T, required): Element to move
  /// - [targetIndex] (int, required): Destination index
  ///
  /// Returns true if operation succeeded.
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

  /// Moves the first element matching test to a target index.
  ///
  /// Returns false if no element matches the test.
  ///
  /// Parameters:
  /// - [test] (`Predicate<T>`, required): Test function to find element
  /// - [targetIndex] (int, required): Destination index
  ///
  /// Returns true if element was found and moved.
  bool swapItemWhere(Predicate<T> test, int targetIndex) {
    int currentIndex = indexWhere(test);
    if (currentIndex == -1) {
      return false;
    }
    T element = this[currentIndex];
    return swapItem(element, targetIndex);
  }

  /// Safely gets an element at index, returning null if out of bounds.
  ///
  /// Parameters:
  /// - [index] (int, required): Index to access
  ///
  /// Returns element at index or null if index is out of bounds.
  T? optGet(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }
}

/// Inverse lerp: finds the interpolation parameter given a value.
///
/// Given a value between min and max, returns the interpolation parameter t
/// (typically 0.0 to 1.0) that would produce that value.
///
/// Parameters:
/// - [value] (double, required): Value to unlerp
/// - [min] (double, required): Minimum bound
/// - [max] (double, required): Maximum bound
///
/// Returns interpolation parameter.
double unlerpDouble(double value, double min, double max) {
  return (value - min) / (max - min);
}

/// Swaps an element between multiple lists.
///
/// Removes the element from all lists except the target list, then moves it
/// to the specified index in the target list.
///
/// Parameters:
/// - [lists] (`List<List<T>>`, required): Lists to manage
/// - [element] (T, required): Element to swap
/// - [targetList] (`List<T>`, required): Destination list
/// - [targetIndex] (int, required): Destination index in target list
void swapItemInLists<T>(
    List<List<T>> lists, T element, List<T> targetList, int targetIndex) {
  for (var list in lists) {
    if (list != targetList) {
      list.remove(element);
    }
  }
  targetList.swapItem(element, targetIndex);
}

/// Resolves a BorderRadiusGeometry to BorderRadius if needed.
///
/// Returns null if radius is null, returns radius as-is if already BorderRadius,
/// otherwise resolves using text directionality from context.
///
/// Parameters:
/// - [context] (BuildContext, required): Build context for directionality
/// - [radius] (BorderRadiusGeometry?): Border radius to resolve
///
/// Returns resolved BorderRadius or null.
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
  FutureOr<R> map<R>(R Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

  /// Transforms the value using a function that returns FutureOr.
  ///
  /// Flattens nested FutureOr results. If this is a Future, chains the
  /// transformation. Otherwise applies it synchronously.
  ///
  /// Parameters:
  /// - [transform] (Function, required): Transformation function returning FutureOr
  ///
  /// Returns flattened transformed value as FutureOr.
  FutureOr<R> flatMap<R>(FutureOr<R> Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

  /// Alias for flatMap - transforms with FutureOr function.
  ///
  /// Parameters:
  /// - [transform] (Function, required): Transformation function
  ///
  /// Returns transformed value as FutureOr.
  FutureOr<R> then<R>(FutureOr<R> Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

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
  FutureOr<T> catchError(Function onError,
      {bool Function(Object error)? test}) {
    if (this is Future<T>) {
      return (this as Future<T>).catchError(onError, test: test);
    }
    return this;
  }
}

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
  BorderRadius optionallyResolve(BuildContext context) {
    if (this is BorderRadius) {
      return this as BorderRadius;
    }
    return resolve(Directionality.of(context));
  }
}

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
  EdgeInsets optionallyResolve(BuildContext context) {
    if (this is EdgeInsets) {
      return this as EdgeInsets;
    }
    return resolve(Directionality.of(context));
  }
}

/// Subtracts a border width from a border radius.
///
/// Reduces each corner's radius by the border width, ensuring the inner
/// radius accounts for the border thickness. Prevents negative radii.
///
/// Parameters:
/// - [radius] (`BorderRadius`, required): Original border radius.
/// - [borderWidth] (`double`, required): Border width to subtract.
///
/// Returns: `BorderRadius` — adjusted border radius.
BorderRadius subtractByBorder(BorderRadius radius, double borderWidth) {
  return BorderRadius.only(
    topLeft: _subtractSafe(radius.topLeft, Radius.circular(borderWidth)),
    topRight: _subtractSafe(radius.topRight, Radius.circular(borderWidth)),
    bottomLeft: _subtractSafe(radius.bottomLeft, Radius.circular(borderWidth)),
    bottomRight:
        _subtractSafe(radius.bottomRight, Radius.circular(borderWidth)),
  );
}

Radius _subtractSafe(Radius a, Radius b) {
  return Radius.elliptical(
    max(0, a.x - b.x),
    max(0, a.y - b.y),
  );
}

/// Determines if a platform is mobile.
///
/// Returns `true` for Android, iOS, and Fuchsia platforms.
///
/// Parameters:
/// - [platform] (`TargetPlatform`, required): Platform to check.
///
/// Returns: `bool` — `true` if mobile, `false` otherwise.
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
    // ignore: unreachable_switch_default
    default:
      return false;
  }
}

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

/// Linearly interpolates between two numeric values.
///
/// Uses the formula: `begin + (end - begin) * t`.
///
/// Parameters:
/// - [begin] (`T`, required): Start value.
/// - [end] (`T`, required): End value.
/// - [t] (`double`, required): Interpolation factor (0.0 to 1.0).
///
/// Returns: `T` — interpolated value.
T tweenValue<T>(T begin, T end, double t) {
  dynamic beginValue = begin;
  dynamic endValue = end;
  return (beginValue + (endValue - beginValue) * t) as T;
}

/// Wraps a value within a specified range.
///
/// If the value exceeds the range, it wraps around to the beginning.
/// Returns the minimum value if the range is zero.
///
/// Parameters:
/// - [value] (`double`, required): Value to wrap.
/// - [min] (`double`, required): Minimum value of range.
/// - [max] (`double`, required): Maximum value of range.
///
/// Returns: `double` — wrapped value within [min, max).
double wrapDouble(double value, double min, double max) {
  final range = max - min;
  if (range == 0) {
    return min;
  }
  return (value - min) % range + min;
}

/// A widget that detects changes in the widget tree.
class WidgetTreeChangeDetector extends StatefulWidget {
  /// The child widget to monitor.
  final Widget child;

  /// Callback invoked when the widget tree changes.
  final void Function() onWidgetTreeChange;

  /// Creates a [WidgetTreeChangeDetector].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Child widget.
  /// - [onWidgetTreeChange] (`VoidCallback`, required): Change callback.
  const WidgetTreeChangeDetector({
    super.key,
    required this.child,
    required this.onWidgetTreeChange,
  });

  @override
  WidgetTreeChangeDetectorState createState() =>
      WidgetTreeChangeDetectorState();
}

/// State for [WidgetTreeChangeDetector].
class WidgetTreeChangeDetectorState extends State<WidgetTreeChangeDetector> {
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

/// Creates a gap widget with specified spacing.
///
/// Parameters:
/// - [gap] (`double`, required): Main axis spacing.
/// - [crossGap] (`double?`, optional): Cross axis spacing.
///
/// Returns: `Widget` — a Gap widget.
Widget gap(double gap, {double? crossGap}) {
  return Gap(
    gap,
    crossAxisExtent: crossGap,
  );
}

/// Extension for joining lists of widgets with a separator.
extension Joinable<T extends Widget> on List<T> {
  /// Joins widgets with a separator between each item.
  ///
  /// Parameters:
  /// - [separator] (`T`, required): Widget to insert between items.
  ///
  /// Returns: `List<T>` — list with separators inserted.
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

/// Extension adding separator joining for iterables.
extension IterableExtension<T> on Iterable<T> {
  /// Joins iterable items with a separator between each.
  ///
  /// Parameters:
  /// - [separator] (`T`, required): Item to insert between elements.
  ///
  /// Returns: `Iterable<T>` — iterable with separators inserted.
  Iterable<T> joinSeparator(T separator) {
    return map((e) => [separator, e]).expand((element) => element).skip(1);
  }

  /// Joins iterable items with dynamically built separators.
  ///
  /// Each separator is created by calling the builder function.
  ///
  /// Parameters:
  /// - [separator] (`ValueGetter<T>`, required): Builder for separator items.
  ///
  /// Returns: `Iterable<T>` — iterable with separators inserted.
  Iterable<T> buildSeparator(ValueGetter<T> separator) {
    return map((e) => [separator(), e]).expand((element) => element).skip(1);
  }
}

/// Function signature for a widget builder that accepts any number of parameters.
///
/// This allows widgets to be used as builders with flexible parameters.
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

/// Extension adding layout and styling utilities to widgets.
extension WidgetExtension on Widget {
  /// Converts this widget to a builder function.
  ///
  /// Returns a [NeverWidgetBuilder] that ignores all parameters and returns this widget.
  NeverWidgetBuilder get asBuilder => ([a, b, c, d, e, f, g, h, i, j]) => this;

  /// Wraps this widget in a [SizedBox] with specified dimensions.
  ///
  /// If this widget is already a [SizedBox], merges the dimensions.
  ///
  /// Parameters:
  /// - [width] (`double?`, optional): Desired width.
  /// - [height] (`double?`, optional): Desired height.
  ///
  /// Returns: `Widget` — sized widget.
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

  /// Wraps this widget in a [ConstrainedBox] with specified constraints.
  ///
  /// If this widget is already a [ConstrainedBox], merges the constraints.
  ///
  /// Parameters:
  /// - [minWidth] (`double?`, optional): Minimum width.
  /// - [maxWidth] (`double?`, optional): Maximum width.
  /// - [minHeight] (`double?`, optional): Minimum height.
  /// - [maxHeight] (`double?`, optional): Maximum height.
  /// - [width] (`double?`, optional): Fixed width (sets both min and max).
  /// - [height] (`double?`, optional): Fixed height (sets both min and max).
  ///
  /// Returns: `Widget` — constrained widget.
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

  /// Wraps this widget in a [Padding] widget.
  ///
  /// Provides flexible padding specification via individual edges,
  /// combined directions, or uniform padding.
  ///
  /// Parameters:
  /// - [top] (`double?`, optional): Top padding.
  /// - [bottom] (`double?`, optional): Bottom padding.
  /// - [left] (`double?`, optional): Left padding.
  /// - [right] (`double?`, optional): Right padding.
  /// - [horizontal] (`double?`, optional): Left and right padding (cannot use with left/right).
  /// - [vertical] (`double?`, optional): Top and bottom padding (cannot use with top/bottom).
  /// - [all] (`double?`, optional): Uniform padding on all sides (cannot use with others).
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Direct padding value (overrides all other params).
  ///
  /// Returns: `Widget` — padded widget.
  ///
  /// Throws [FlutterError] if conflicting parameters are used.
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

  /// Centers this widget horizontally and vertically.
  ///
  /// Parameters:
  /// - [key] (`Key?`, optional): Widget key.
  ///
  /// Returns: `Widget` — centered widget.
  Widget center({Key? key}) {
    return Center(
      key: key,
      child: this,
    );
  }

  /// Aligns this widget within its parent.
  ///
  /// Parameters:
  /// - [alignment] (`AlignmentGeometry`, required): Alignment position.
  ///
  /// Returns: `Widget` — aligned widget.
  Widget withAlign(AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  /// Positions this widget absolutely within a [Stack].
  ///
  /// Parameters:
  /// - [key] (`Key?`, optional): Widget key.
  /// - [left] (`double?`, optional): Left offset.
  /// - [top] (`double?`, optional): Top offset.
  /// - [right] (`double?`, optional): Right offset.
  /// - [bottom] (`double?`, optional): Bottom offset.
  ///
  /// Returns: `Widget` — positioned widget.
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

  /// Makes this widget expanded within a [Flex] parent (Row/Column).
  ///
  /// Parameters:
  /// - [flex] (`int`, default: 1): Flex factor for space distribution.
  ///
  /// Returns: `Widget` — expanded widget.
  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  /// Applies opacity to this widget.
  ///
  /// Parameters:
  /// - [opacity] (`double`, required): Opacity value (0.0 to 1.0).
  ///
  /// Returns: `Widget` — widget with opacity.
  Widget withOpacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  /// Clips this widget to a rectangle.
  ///
  /// Parameters:
  /// - [clipBehavior] (`Clip`, default: `Clip.hardEdge`): Clipping behavior.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clip({Clip clipBehavior = Clip.hardEdge}) {
    return ClipRect(
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  /// Clips this widget to a rounded rectangle.
  ///
  /// Parameters:
  /// - [borderRadius] (`BorderRadiusGeometry`, default: `BorderRadius.zero`): Corner radii.
  /// - [clipBehavior] (`Clip`, default: `Clip.antiAlias`): Clipping behavior.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clipRRect(
      {BorderRadiusGeometry borderRadius = BorderRadius.zero,
      Clip clipBehavior = Clip.antiAlias}) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  /// Clips this widget to an oval shape.
  ///
  /// Parameters:
  /// - [clipBehavior] (`Clip`, default: `Clip.antiAlias`): Clipping behavior.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clipOval({Clip clipBehavior = Clip.antiAlias}) {
    return ClipOval(
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  /// Clips this widget to a custom path.
  ///
  /// Parameters:
  /// - [clipBehavior] (`Clip`, default: `Clip.antiAlias`): Clipping behavior.
  /// - [clipper] (`CustomClipper<Path>`, required): Custom clipper for the path.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clipPath(
      {Clip clipBehavior = Clip.antiAlias,
      required CustomClipper<Path> clipper}) {
    return ClipPath(
      clipBehavior: clipBehavior,
      clipper: clipper,
      child: this,
    );
  }

  /// Applies a transformation matrix to this widget.
  ///
  /// Parameters:
  /// - [key] (`Key?`, optional): Widget key.
  /// - [transform] (`Matrix4`, required): Transformation matrix.
  ///
  /// Returns: `Widget` — transformed widget.
  Widget transform({Key? key, required Matrix4 transform}) {
    return Transform(
      key: key,
      transform: transform,
      child: this,
    );
  }

  /// Sizes this widget to its intrinsic width.
  ///
  /// Parameters:
  /// - [stepWidth] (`double?`, optional): Stepping for width.
  /// - [stepHeight] (`double?`, optional): Stepping for height.
  ///
  /// Returns: `Widget` — intrinsically sized widget.
  Widget intrinsicWidth({double? stepWidth, double? stepHeight}) {
    return IntrinsicWidth(
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: this,
    );
  }

  /// Sizes this widget to its intrinsic height.
  ///
  /// Returns: `Widget` — intrinsically sized widget.
  Widget intrinsicHeight() {
    return IntrinsicHeight(
      child: this,
    );
  }

  /// Sizes this widget to both intrinsic width and height.
  ///
  /// Parameters:
  /// - [stepWidth] (`double?`, optional): Stepping for width.
  /// - [stepHeight] (`double?`, optional): Stepping for height.
  ///
  /// Returns: `Widget` — intrinsically sized widget.
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

/// Extension adding gap and separator utilities to [Column].
extension ColumnExtension on Column {
  /// Adds gaps between column children.
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Vertical spacing between children.
  ///
  /// Returns: `Widget` — column with gaps.
  Widget gap(double gap) {
    return separator(SizedBox(height: gap));
  }

  /// Adds separators between column children.
  ///
  /// Parameters:
  /// - [separator] (`Widget`, required): Widget to insert between children.
  ///
  /// Returns: `Widget` — column with separators.
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

/// Extension adding gap and separator utilities to [Row].
extension RowExtension on Row {
  /// Adds gaps between row children.
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Horizontal spacing between children.
  ///
  /// Returns: `Widget` — row with gaps.
  Widget gap(double gap) {
    return separator(SizedBox(width: gap));
  }

  /// Adds separators between row children.
  ///
  /// Parameters:
  /// - [separator] (`Widget`, required): Widget to insert between children.
  ///
  /// Returns: `Widget` — row with separators.
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

/// A flex widget that adds separators between children.
///
/// Used internally by [ColumnExtension] and [RowExtension] to insert
/// separators between flex children while maintaining flex properties.
class SeparatedFlex extends StatefulWidget {
  /// Main axis alignment for flex children.
  final MainAxisAlignment mainAxisAlignment;

  /// Main axis size constraint for the flex.
  final MainAxisSize mainAxisSize;

  /// Cross axis alignment for flex children.
  final CrossAxisAlignment crossAxisAlignment;

  /// Text direction for the flex.
  final TextDirection? textDirection;

  /// Vertical direction for laying out children.
  final VerticalDirection verticalDirection;

  /// Text baseline for aligning text children.
  final TextBaseline? textBaseline;

  /// Children widgets to display with separators.
  final List<Widget> children;

  /// Flex direction (horizontal or vertical).
  final Axis direction;

  /// Separator widget to insert between children.
  final Widget separator;

  /// Clipping behavior for the flex.
  final Clip clipBehavior;

  /// Creates a [SeparatedFlex].
  ///
  /// All flex-related parameters match [Flex] widget parameters.
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

/// Extension adding gap and separator utilities to [Flex].
extension FlexExtension on Flex {
  /// Adds gaps between flex children.
  ///
  /// The gap direction depends on the flex direction (vertical or horizontal).
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Spacing between children.
  ///
  /// Returns: `Widget` — flex with gaps.
  Widget gap(double gap) {
    return separator(direction == Axis.vertical
        ? SizedBox(height: gap)
        : SizedBox(width: gap));
  }

  /// Adds separators between flex children.
  ///
  /// Parameters:
  /// - [separator] (`Widget`, required): Widget to insert between children.
  ///
  /// Returns: `Widget` — flex with separators.
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

/// An iterable that inserts a separator between each widget.
///
/// Parameters:
/// - [widgets] (`Iterable<Widget>`, required): Original widgets.
/// - [separator] (`Widget`, required): Widget to insert between items.
Iterable<Widget> join(Iterable<Widget> widgets, Widget separator) {
  return SeparatedIterable(widgets, separator);
}

/// Extension adding min/max utilities to [double].
extension DoubleExtension on double {
  /// Returns the minimum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`double`, required): Value to compare.
  ///
  /// Returns: `double` — the smaller value.
  double min(double other) => this < other ? this : other;

  /// Returns the maximum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`double`, required): Value to compare.
  ///
  /// Returns: `double` — the larger value.
  double max(double other) => this > other ? this : other;
}

/// Extension adding min/max utilities to [int].
extension IntExtension on int {
  /// Returns the minimum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`int`, required): Value to compare.
  ///
  /// Returns: `int` — the smaller value.
  int min(int other) => this < other ? this : other;

  /// Returns the maximum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`int`, required): Value to compare.
  ///
  /// Returns: `int` — the larger value.
  int max(int other) => this > other ? this : other;
}

/// A tween for animating between two [IconThemeData] values.
class IconThemeDataTween extends Tween<IconThemeData> {
  /// Creates an [IconThemeDataTween].
  ///
  /// Parameters:
  /// - [begin] (`IconThemeData?`, optional): Starting icon theme.
  /// - [end] (`IconThemeData?`, optional): Ending icon theme.
  IconThemeDataTween({super.begin, super.end});

  @override
  IconThemeData lerp(double t) => IconThemeData.lerp(begin, end, t);
}

/// Extension adding color manipulation utilities to [Color].
extension ColorExtension on Color {
  /// Scales the alpha channel by a factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Multiplier for alpha (0.0 to 1.0+).
  ///
  /// Returns: `Color` — color with scaled alpha.
  Color scaleAlpha(double factor) {
    return withValues(
      alpha: a * factor,
    );
  }

  /// Gets a contrasting color based on luminance.
  ///
  /// Adjusts luminance to create contrast. If current lightness >= 0.5,
  /// reduces it; otherwise increases it.
  ///
  /// Parameters:
  /// - [luminanceContrast] (`double`, default: 1): Contrast factor (0.0 to 1.0).
  ///
  /// Returns: `Color` — contrasting color.
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

  /// Sets the luminance (lightness) of this color.
  ///
  /// Parameters:
  /// - [luminance] (`double`, required): Target luminance (0.0 to 1.0).
  ///
  /// Returns: `Color` — color with specified luminance.
  Color withLuminance(double luminance) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness(luminance).toColor();
  }

  /// Converts this color to hexadecimal string.
  ///
  /// Parameters:
  /// - [includeHashSign] (`bool`, default: false): Whether to prefix with '#'.
  /// - [includeAlpha] (`bool`, default: true): Whether to include alpha channel.
  ///
  /// Returns: `String` — hexadecimal color representation.
  ///
  /// Example:
  /// ```dart
  /// Color.fromARGB(255, 255, 0, 0).toHex() // 'ffff0000'
  /// Color.fromARGB(255, 255, 0, 0).toHex(includeHashSign: true) // '#ffff0000'
  /// Color.fromARGB(255, 255, 0, 0).toHex(includeAlpha: false) // 'ff0000'
  /// ```
  String toHex({bool includeHashSign = false, bool includeAlpha = true}) {
    String hex = toARGB32().toRadixString(16).padLeft(8, '0');
    if (!includeAlpha) {
      hex = hex.substring(2);
    }
    if (includeHashSign) {
      hex = '#$hex';
    }
    return hex;
  }

  /// Converts this color to HSL color space.
  ///
  /// Returns: `HSLColor` — HSL representation.
  HSLColor toHSL() {
    return HSLColor.fromColor(this);
  }

  /// Converts this color to HSV color space.
  ///
  /// Returns: `HSVColor` — HSV representation.
  HSVColor toHSV() {
    return HSVColor.fromColor(this);
  }
}

/// Extension for converting [HSLColor] to other color spaces.
extension HSLColorExtension on HSLColor {
  /// Converts this HSL color to HSV color space.
  ///
  /// Returns: `HSVColor` — HSV representation.
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

/// Extension for converting [HSVColor] to other color spaces.
extension HSVColorExtension on HSVColor {
  /// Converts this HSV color to HSL color space.
  ///
  /// Returns: `HSLColor` — HSL representation.
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

/// Represents a time of day with hour, minute, and second.
///
/// Provides constructors for various time representations including
/// AM/PM notation, DateTime conversion, and Duration conversion.
class TimeOfDay {
  /// Hour component (0-23).
  final int hour;

  /// Minute component (0-59).
  final int minute;

  /// Second component (0-59).
  final int second;

  /// Creates a [TimeOfDay] with specified components.
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour (0-23).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  /// Creates a PM time (adds 12 to the hour).
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour in 12-hour format (1-12).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay.pm({
    required int hour,
    required this.minute,
    this.second = 0,
  }) : hour = hour + 12;

  /// Creates an AM time.
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour in 12-hour format (0-11).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay.am({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  /// Creates a [TimeOfDay] from a [DateTime].
  ///
  /// Parameters:
  /// - [dateTime] (`DateTime`, required): DateTime to extract time from.
  TimeOfDay.fromDateTime(DateTime dateTime)
      : hour = dateTime.hour,
        minute = dateTime.minute,
        second = dateTime.second;

  /// Creates a [TimeOfDay] from a [Duration].
  ///
  /// Parameters:
  /// - [duration] (`Duration`, required): Duration to convert.
  TimeOfDay.fromDuration(Duration duration)
      : hour = duration.inHours,
        minute = duration.inMinutes % 60,
        second = duration.inSeconds % 60;

  /// Creates a [TimeOfDay] representing the current time.
  TimeOfDay.now() : this.fromDateTime(DateTime.now());

  /// Creates a copy with specified fields replaced.
  ///
  /// Parameters:
  /// - [hour] (`ValueGetter<int>?`, optional): New hour value.
  /// - [minute] (`ValueGetter<int>?`, optional): New minute value.
  /// - [second] (`ValueGetter<int>?`, optional): New second value.
  ///
  /// Returns: `TimeOfDay` — copy with updated values.
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

/// Invokes an action on the currently focused widget.
///
/// Attempts to find and invoke an action associated with the given intent
/// on the widget that currently has focus. This is useful for triggering
/// actions programmatically.
///
/// Parameters:
/// - [intent] (`Intent`, required): The intent to invoke.
///
/// Returns: `(bool enabled, Object? invokeResult)` — a record containing
/// whether the action was enabled and the result of invoking it.
///
/// Example:
/// ```dart
/// final (enabled, result) = invokeActionOnFocusedWidget(
///   ActivateIntent(),
/// );
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

/// Extension adding word-related utilities to [TextEditingController].
extension TextEditingControllerExtension on TextEditingController {
  /// Gets the word at the current cursor position.
  ///
  /// Returns `null` if the text is empty or the selection is not collapsed.
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

/// Record type for word information: (start index, word string).
typedef WordInfo = (int start, String word);

/// Record type for replacement information: (start index, new text).
typedef ReplacementInfo = (int start, String newText);

/// Gets the word at the caret position in a text string.
///
/// Finds the word boundaries around the caret position using the specified
/// separator characters.
///
/// Parameters:
/// - [text] (`String`, required): The text to search in.
/// - [caret] (`int`, required): The caret position (0 to text.length).
/// - [separator] (`String`, default: ' '): Characters that separate words.
///
/// Returns: `WordInfo` — a record `(int start, String word)` containing
/// the start index and the word at the caret.
///
/// Throws [RangeError] if caret is out of bounds.
///
/// Example:
/// ```dart
/// final (start, word) = getWordAtCaret('Hello world', 7);
/// // Returns (6, 'world')
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

/// Replaces the word at the caret position with a new string.
///
/// Finds the word boundaries around the caret using the separator predicate
/// and replaces that word with the provided replacement string.
///
/// Parameters:
/// - [text] (`String`, required): The text to modify.
/// - [caret] (`int`, required): The caret position (0 to text.length).
/// - [replacement] (`String`, required): The replacement text.
/// - [isSeparator] (`bool Function(String)`, required): Predicate to identify separator characters.
///
/// Returns: `ReplacementInfo` — a record `(int start, String newText)` containing
/// the start index of the replacement and the new text.
///
/// Throws [RangeError] if caret is out of bounds.
///
/// Example:
/// ```dart
/// final (start, newText) = replaceWordAtCaret(
///   'Hello world',
///   7,
///   'universe',
///   (ch) => ch == ' ',
/// );
/// // Returns (6, 'Hello universe')
/// ```
ReplacementInfo replaceWordAtCaret(String text, int caret, String replacement,
    bool Function(String char) isSeparator) {
  if (caret < 0 || caret > text.length) {
    throw RangeError('Caret position is out of bounds.');
  }

  // Get the start and end of the word
  int start = caret;
  while (start > 0 && !isSeparator(text[start - 1])) {
    start--;
  }

  int end = caret;
  while (end < text.length && !isSeparator(text[end])) {
    end++;
  }

  // Replace the word with the replacement
  String newText = text.replaceRange(start, end, replacement);
  return (start, newText);
}

/// Clears the currently active text input field.
///
/// Invokes a [TextFieldClearIntent] on the focused widget to clear its content.
/// This is useful for programmatically clearing text fields that have focus.
///
/// Example:
/// ```dart
/// clearActiveTextInput(); // Clears the focused text field
/// ```
void clearActiveTextInput() {
  TextFieldClearIntent intent = const TextFieldClearIntent();
  invokeActionOnFocusedWidget(intent);
}

/// Mixin for values that need custom rebuild logic.
///
/// Implement this mixin to control when a [CachedValueWidget] should rebuild
/// based on custom comparison logic.
mixin CachedValue {
  /// Determines if the widget should rebuild when value changes.
  ///
  /// Parameters:
  /// - [oldValue] (`CachedValue`, required): Previous value to compare against.
  ///
  /// Returns: `bool` — `true` if rebuild is needed.
  bool shouldRebuild(covariant CachedValue oldValue);
}

/// A widget that caches a computed value.
///
/// Caches the result of [builder] and only rebuilds when [value] changes.
/// If [value] implements [CachedValue], uses custom rebuild logic.
class CachedValueWidget<T> extends StatefulWidget {
  /// The value to cache and pass to builder.
  final T value;

  /// Builder function that creates the widget from the value.
  final Widget Function(BuildContext context, T value) builder;

  /// Creates a [CachedValueWidget].
  ///
  /// Parameters:
  /// - [value] (`T`, required): Value to cache.
  /// - [builder] (`Widget Function(BuildContext, T)`, required): Widget builder.
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

/// Function type for converting from type `F` to type `T`.
typedef Convert<F, T> = T Function(F value);

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
  B convertA(A value) => aToB(value);

  /// Converts a value from type B to type A.
  ///
  /// Parameters:
  /// - [value] (`B`, required): Value to convert.
  ///
  /// Returns: `A` — converted value.
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

  @override
  int get hashCode => Object.hash(aToB, bToA);
}

/// A controller that converts between types [F] and [T].
///
/// Maintains bidirectional synchronization between two value notifiers
/// with different types using a [BiDirectionalConvert].
class ConvertedController<F, T> extends ChangeNotifier
    implements ComponentController<T> {
  final ValueNotifier<F> _other;
  final BiDirectionalConvert<F, T> _convert;

  T _value;
  bool _isUpdating = false;

  /// Creates a [ConvertedController].
  ///
  /// Parameters:
  /// - [other] (`ValueNotifier<F>`, required): Source value notifier.
  /// - [convert] (`BiDirectionalConvert<F, T>`, required): Bidirectional converter.
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

/// Extension adding text replacement utilities to [TextEditingValue].
extension TextEditingValueExtension on TextEditingValue {
  /// Replaces the text while preserving selection within bounds.
  ///
  /// Adjusts the selection to stay within the new text length.
  ///
  /// Parameters:
  /// - [newText] (`String`, required): Replacement text.
  ///
  /// Returns: `TextEditingValue` — value with new text and adjusted selection.
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

/// Callback type for context actions with optional context parameter.
typedef OnContextedCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

/// A context action that executes a callback with context.
class ContextCallbackAction<T extends Intent> extends ContextAction<T> {
  /// The callback to execute when the action is invoked.
  final OnContextedCallback<T> onInvoke;

  /// Creates a [ContextCallbackAction].
  ///
  /// Parameters:
  /// - [onInvoke] (`OnContextedCallback<T>`, required): Callback function.
  ContextCallbackAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}
