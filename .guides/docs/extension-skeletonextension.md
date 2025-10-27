---
title: "Extension: SkeletonExtension"
description: "Extension methods for adding skeleton loading effects to any widget."
---

```dart
/// Extension methods for adding skeleton loading effects to any widget.
///
/// SkeletonExtension provides convenient methods to transform regular widgets
/// into skeleton loading states with proper animation and theming integration.
/// These methods work with the underlying Skeletonizer package while ensuring
/// consistency with the shadcn design system.
///
/// The extension handles common use cases including content loading, image
/// placeholders, form field loading, and complex layout skeletonization.
/// Different skeleton modes (sliver, leaf, unite, replace) provide flexibility
/// for various UI patterns and performance requirements.
///
/// Methods automatically detect certain widget types (Avatar, Image) and apply
/// appropriate skeleton handling to avoid common rendering issues.
extension SkeletonExtension on Widget {
  /// Converts the widget to a skeleton suitable for sliver layouts.
  ///
  /// Creates a [Skeletonizer] wrapper that works within [CustomScrollView]
  /// and other sliver-based layouts. The [ignoreContainers] parameter is
  /// set to false for consistent skeleton appearance in scroll contexts.
  ///
  /// Parameters:
  /// - [enabled] (bool, default: true): Whether skeleton effect is active
  ///
  /// Returns:
  /// A [Skeletonizer] widget configured for sliver layout compatibility.
  ///
  /// Example:
  /// ```dart
  /// ListView.builder(
  ///   itemBuilder: (context, index) => ListTile(
  ///     title: Text('Item $index'),
  ///   ).asSkeletonSliver(enabled: isLoading),
  /// );
  /// ```
  Widget asSkeletonSliver({bool enabled = true});
  /// Converts the widget to a skeleton with advanced configuration options.
  ///
  /// Provides comprehensive skeleton transformation with multiple modes and
  /// automatic handling of problematic widget types. Supports [AsyncSnapshot]
  /// integration for automatic skeleton state management based on data loading.
  ///
  /// Special handling:
  /// - Avatar and Image widgets use [Skeleton.leaf] to avoid rendering issues
  /// - [snapshot] parameter automatically enables/disables based on data state
  /// - Various skeleton modes (leaf, unite, replace) for different use cases
  ///
  /// Parameters:
  /// - [enabled] (bool, default: true): Whether skeleton effect is active
  /// - [leaf] (bool, default: false): Use leaf mode for simple widgets
  /// - [replacement] (Widget?, optional): Custom replacement widget in replace mode
  /// - [unite] (bool, default: false): Use unite mode for complex layouts
  /// - [snapshot] (AsyncSnapshot?, optional): Auto-enable based on data loading state
  ///
  /// Returns:
  /// A skeleton-wrapped widget with appropriate configuration for the specified mode.
  ///
  /// Example:
  /// ```dart
  /// FutureBuilder<String>(
  ///   future: loadData(),
  ///   builder: (context, snapshot) => Text(snapshot.data ?? 'Loading...').asSkeleton(
  ///     snapshot: snapshot,
  ///   ),
  /// );
  /// ```
  Widget asSkeleton({bool enabled = true, bool leaf = false, Widget? replacement, bool unite = false, AsyncSnapshot? snapshot});
  /// Excludes the widget from skeleton effects in its parent skeleton context.
  ///
  /// Wraps the widget with [Skeleton.ignore] to prevent skeleton transformation
  /// even when placed within a skeleton-enabled parent. Useful for preserving
  /// interactive elements or dynamic content within skeleton layouts.
  ///
  /// Returns:
  /// A [Skeleton.ignore] wrapper that prevents skeleton effects on this widget.
  ///
  /// Example:
  /// ```dart
  /// Column(children: [
  ///   Text('Loading content...'),
  ///   Button(
  ///     onPressed: () {},
  ///     child: Text('Cancel'),
  ///   ).ignoreSkeleton(), // Button remains interactive
  /// ]).asSkeleton();
  /// ```
  Widget ignoreSkeleton();
  /// Controls whether the widget should be preserved in skeleton mode.
  ///
  /// Wraps the widget with [Skeleton.keep] to conditionally preserve the
  /// original widget appearance when skeleton effects are active. When [exclude]
  /// is true, the widget maintains its normal appearance instead of being skeletonized.
  ///
  /// Parameters:
  /// - [exclude] (bool, default: true): Whether to exclude from skeleton effects
  ///
  /// Returns:
  /// A [Skeleton.keep] wrapper that conditionally preserves the widget's appearance.
  ///
  /// Example:
  /// ```dart
  /// Row(children: [
  ///   Text('Data: $value'),
  ///   Icon(Icons.star).excludeSkeleton(exclude: isImportant),
  /// ]).asSkeleton();
  /// ```
  Widget excludeSkeleton({bool exclude = true});
}
```
