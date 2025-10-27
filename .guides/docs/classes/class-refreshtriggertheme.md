---
title: "Class: RefreshTriggerTheme"
description: "Theme configuration for [RefreshTrigger]."
---

```dart
/// Theme configuration for [RefreshTrigger].
///
/// Example usage:
/// ```dart
/// ComponentTheme(
///   data: RefreshTriggerTheme(
///     minExtent: 100.0,
///     maxExtent: 200.0,
///     curve: Curves.easeInOut,
///     completeDuration: Duration(milliseconds: 800),
///   ),
///   child: RefreshTrigger(
///     onRefresh: () async {
///       // Refresh logic here
///     },
///     child: ListView(
///       children: [
///         // List items
///       ],
///     ),
///   ),
/// )
/// ```
class RefreshTriggerTheme {
  /// Minimum pull extent required to trigger refresh.
  final double? minExtent;
  /// Maximum pull extent allowed.
  final double? maxExtent;
  /// Builder for the refresh indicator.
  final RefreshIndicatorBuilder? indicatorBuilder;
  /// Animation curve for the refresh trigger.
  final Curve? curve;
  /// Duration for the completion animation.
  final Duration? completeDuration;
  /// Creates a [RefreshTriggerTheme].
  const RefreshTriggerTheme({this.minExtent, this.maxExtent, this.indicatorBuilder, this.curve, this.completeDuration});
  /// Creates a copy of this theme but with the given fields replaced.
  RefreshTriggerTheme copyWith({ValueGetter<double?>? minExtent, ValueGetter<double?>? maxExtent, ValueGetter<RefreshIndicatorBuilder?>? indicatorBuilder, ValueGetter<Curve?>? curve, ValueGetter<Duration?>? completeDuration});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
