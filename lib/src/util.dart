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
  /// - [test] (Predicate<T>, required): Test function
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
  /// - [test] (Predicate<T>, required): Test function
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
  /// - [test] (Predicate<T>, required): Test function to find element
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

  FutureOr<T> catchError(Function onError,
      {bool Function(Object error)? test}) {
    if (this is Future<T>) {
      return (this as Future<T>).catchError(onError, test: test);
    }
    return this;
  }
}

extension AlignmentExtension on AlignmentGeometry {
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

extension BorderRadiusExtension on BorderRadiusGeometry {
  BorderRadius optionallyResolve(BuildContext context) {
    if (this is BorderRadius) {
      return this as BorderRadius;
    }
    return resolve(Directionality.of(context));
  }
}

extension EdgeInsetsExtension on EdgeInsetsGeometry {
  EdgeInsets optionallyResolve(BuildContext context) {
    if (this is EdgeInsets) {
      return this as EdgeInsets;
    }
    return resolve(Directionality.of(context));
  }
}

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

/// A widget that captures its render object for later use.
class CapturedWrapper extends StatefulWidget {
  final CapturedThemes? themes;
  final CapturedData? data;
  final Widget child;

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

T tweenValue<T>(T begin, T end, double t) {
  dynamic beginValue = begin;
  dynamic endValue = end;
  return (beginValue + (endValue - beginValue) * t) as T;
}

double wrapDouble(double value, double min, double max) {
  final range = max - min;
  if (range == 0) {
    return min;
  }
  return (value - min) % range + min;
}

/// A widget that detects changes in the widget tree.
class WidgetTreeChangeDetector extends StatefulWidget {
  final Widget child;
  final void Function() onWidgetTreeChange;

  const WidgetTreeChangeDetector({
    super.key,
    required this.child,
    required this.onWidgetTreeChange,
  });

  @override
  WidgetTreeChangeDetectorState createState() =>
      WidgetTreeChangeDetectorState();
}

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

Widget gap(double gap, {double? crossGap}) {
  return Gap(
    gap,
    crossAxisExtent: crossGap,
  );
}

extension Joinable<T extends Widget> on List<T> {
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

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> joinSeparator(T separator) {
    return map((e) => [separator, e]).expand((element) => element).skip(1);
  }

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

/// A flex widget that adds separators between children.
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

/// A tween for animating between two [IconThemeData] values.
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
    String hex = toARGB32().toRadixString(16).padLeft(8, '0');
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

/// Represents a time of day with hour and minute.
class TimeOfDay {
  final int hour;
  final int minute;
  final int second;

  const TimeOfDay({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  const TimeOfDay.pm({
    required int hour,
    required this.minute,
    this.second = 0,
  }) : hour = hour + 12;

  const TimeOfDay.am({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  TimeOfDay.fromDateTime(DateTime dateTime)
      : hour = dateTime.hour,
        minute = dateTime.minute,
        second = dateTime.second;

  TimeOfDay.fromDuration(Duration duration)
      : hour = duration.inHours,
        minute = duration.inMinutes % 60,
        second = duration.inSeconds % 60;

  TimeOfDay.now() : this.fromDateTime(DateTime.now());

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

extension TextEditingControllerExtension on TextEditingController {
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

typedef WordInfo = (int start, String word);
typedef ReplacementInfo = (int start, String newText);

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

void clearActiveTextInput() {
  TextFieldClearIntent intent = const TextFieldClearIntent();
  invokeActionOnFocusedWidget(intent);
}

mixin CachedValue {
  bool shouldRebuild(covariant CachedValue oldValue);
}

/// A widget that caches a computed value.
class CachedValueWidget<T> extends StatefulWidget {
  final T value;
  final Widget Function(BuildContext context, T value) builder;

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

typedef Convert<F, T> = T Function(F value);

/// A bidirectional converter between types [A] and [B].
class BiDirectionalConvert<A, B> {
  final Convert<A, B> aToB;
  final Convert<B, A> bToA;

  const BiDirectionalConvert(this.aToB, this.bToA);

  B convertA(A value) => aToB(value);

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
class ConvertedController<F, T> extends ChangeNotifier
    implements ComponentController<T> {
  final ValueNotifier<F> _other;
  final BiDirectionalConvert<F, T> _convert;

  T _value;
  bool _isUpdating = false;

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

extension TextEditingValueExtension on TextEditingValue {
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

typedef OnContextedCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

/// A context action that executes a callback with context.
class ContextCallbackAction<T extends Intent> extends ContextAction<T> {
  final OnContextedCallback<T> onInvoke;

  ContextCallbackAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}
