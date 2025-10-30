---
title: "Class: RefreshTrigger"
description: "A widget that provides pull-to-refresh functionality."
---

```dart
/// A widget that provides pull-to-refresh functionality.
///
/// The [RefreshTrigger] wraps a scrollable widget and provides pull-to-refresh
/// functionality. When the user pulls the content beyond the [minExtent],
/// the [onRefresh] callback is triggered.
///
/// You can customize the appearance and behavior using [RefreshTriggerTheme]:
/// ```dart
/// ComponentTheme(
///   data: RefreshTriggerTheme(
///     minExtent: 100.0,
///     maxExtent: 200.0,
///     curve: Curves.bounceOut,
///   ),
///   child: RefreshTrigger(...),
/// )
/// ```
/// Pull-to-refresh gesture handler with customizable visual indicators.
///
/// Wraps scrollable content to provide pull-to-refresh functionality similar to
/// native mobile applications. Supports both vertical and horizontal refresh
/// gestures with fully customizable visual indicators and animation behavior.
///
/// Key Features:
/// - **Pull Gesture Detection**: Recognizes pull gestures beyond scroll boundaries
/// - **Visual Feedback**: Customizable refresh indicators with progress animation
/// - **Flexible Direction**: Supports vertical and horizontal refresh directions
/// - **Reverse Mode**: Can trigger from opposite direction (e.g., bottom-up)
/// - **Theme Integration**: Full theme support with customizable appearance
/// - **Async Support**: Handles async refresh operations with loading states
/// - **Physics Integration**: Works with any ScrollPhysics implementation
///
/// Operation Flow:
/// 1. User pulls scrollable content beyond normal bounds
/// 2. Visual indicator appears and updates based on pull distance
/// 3. When minimum threshold reached, indicator shows "ready to refresh" state
/// 4. On release, onRefresh callback is triggered
/// 5. Loading indicator shows during async refresh operation
/// 6. Completion animation plays when refresh finishes
/// 7. Content returns to normal scroll position
///
/// The component integrates seamlessly with ListView, GridView, CustomScrollView,
/// and other scrollable widgets without requiring changes to existing scroll behavior.
///
/// Example:
/// ```dart
/// RefreshTrigger(
///   minExtent: 80.0,
///   maxExtent: 150.0,
///   onRefresh: () async {
///     await Future.delayed(Duration(seconds: 2));
///     // Refresh data here
///   },
///   child: ListView.builder(
///     itemCount: items.length,
///     itemBuilder: (context, index) => ListTile(
///       title: Text(items[index]),
///     ),
///   ),
/// )
/// ```
class RefreshTrigger extends StatefulWidget {
  /// Default indicator builder that creates a spinning progress indicator.
  ///
  /// Displays a platform-appropriate circular progress indicator that rotates
  /// based on pull extent and animates during refresh.
  static Widget defaultIndicatorBuilder(BuildContext context, RefreshTriggerStage stage);
  /// Minimum pull extent required to trigger refresh.
  ///
  /// Pull distance must exceed this value to activate the refresh callback.
  /// If null, uses theme or default value.
  final double? minExtent;
  /// Maximum pull extent allowed.
  ///
  /// Limits how far the user can pull to prevent excessive stretching.
  /// If null, uses theme or default value.
  final double? maxExtent;
  /// Callback invoked when refresh is triggered.
  ///
  /// Should return a Future that completes when the refresh operation finishes.
  /// While the Future is pending, the refresh indicator shows loading state.
  final FutureVoidCallback? onRefresh;
  /// The scrollable child widget being refreshed.
  final Widget child;
  /// Direction of the pull gesture.
  ///
  /// Defaults to [Axis.vertical] for standard top-down pull-to-refresh.
  final Axis direction;
  /// Whether to reverse the pull direction.
  ///
  /// If true, pull gesture is inverted (e.g., pull down instead of up).
  final bool reverse;
  /// Custom builder for the refresh indicator.
  ///
  /// If null, uses [defaultIndicatorBuilder].
  final RefreshIndicatorBuilder? indicatorBuilder;
  /// Animation curve for extent changes.
  ///
  /// Controls how the pull extent animates during interactions.
  final Curve? curve;
  /// Duration for the completion animation.
  ///
  /// Time to display the completion state before hiding the indicator.
  final Duration? completeDuration;
  /// Creates a [RefreshTrigger] with pull-to-refresh functionality.
  ///
  /// Wraps the provided child widget with refresh gesture detection and
  /// visual indicator management.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Scrollable content to wrap with refresh capability
  /// - [onRefresh] (FutureVoidCallback?, optional): Async callback triggered on refresh
  /// - [direction] (Axis, default: Axis.vertical): Pull gesture direction
  /// - [reverse] (bool, default: false): Whether to trigger from opposite direction
  /// - [minExtent] (double?, optional): Minimum pull distance to trigger refresh
  /// - [maxExtent] (double?, optional): Maximum allowed pull distance
  /// - [indicatorBuilder] (RefreshIndicatorBuilder?, optional): Custom indicator widget builder
  /// - [curve] (Curve?, optional): Animation curve for refresh transitions
  /// - [completeDuration] (Duration?, optional): Duration of completion animation
  ///
  /// The [onRefresh] callback should return a Future that completes when the
  /// refresh operation is finished. During this time, a loading indicator will be shown.
  ///
  /// Example:
  /// ```dart
  /// RefreshTrigger(
  ///   onRefresh: () async {
  ///     final newData = await fetchDataFromAPI();
  ///     setState(() => items = newData);
  ///   },
  ///   minExtent: 60,
  ///   direction: Axis.vertical,
  ///   child: ListView(children: widgets),
  /// )
  /// ```
  const RefreshTrigger({super.key, this.minExtent, this.maxExtent, this.onRefresh, this.direction = Axis.vertical, this.reverse = false, this.indicatorBuilder, this.curve, this.completeDuration, required this.child});
  State<RefreshTrigger> createState();
}
```
