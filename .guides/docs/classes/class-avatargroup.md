---
title: "Class: AvatarGroup"
description: "A widget that arranges multiple [AvatarWidget]s in an overlapping layout."
---

```dart
/// A widget that arranges multiple [AvatarWidget]s in an overlapping layout.
///
/// [AvatarGroup] creates visually appealing overlapping arrangements of avatars,
/// commonly used to display multiple users or participants in a compact space.
/// It automatically handles clipping and positioning to create smooth overlapping
/// effects with configurable gaps and alignment directions.
///
/// ## Features
/// - **Overlapping Layout**: Automatic positioning with smooth overlapping
/// - **Directional Alignment**: Support for all 8 directional alignments
/// - **Smart Clipping**: Intelligent path clipping preserves rounded corners
/// - **Gap Control**: Configurable spacing between overlapping avatars
/// - **Size Adaptation**: Automatically adapts to different avatar sizes
///
/// ## Layout Behavior
/// The first avatar is positioned normally, while subsequent avatars are
/// positioned and clipped to create the overlapping effect. The [alignment]
/// parameter controls the direction of overlap, and [gap] controls the
/// spacing between avatars.
///
/// ## Factory Constructors
/// Convenient factory methods are provided for common alignment patterns:
/// - [toLeft], [toRight]: Horizontal overlapping
/// - [toStart], [toEnd]: Locale-aware horizontal overlapping
/// - [toTop], [toBottom]: Vertical overlapping
///
/// Example:
/// ```dart
/// AvatarGroup.toRight(
///   children: [
///     Avatar(initials: 'AB'),
///     Avatar(initials: 'CD'),
///     Avatar(initials: 'EF'),
///   ],
///   gap: 8.0,
/// );
/// ```
class AvatarGroup extends StatelessWidget {
  /// List of avatar widgets to arrange in overlapping layout.
  ///
  /// The first avatar in the list serves as the base position, with
  /// subsequent avatars overlapping according to [alignment].
  final List<AvatarWidget> children;
  /// Controls the direction and amount of overlap between avatars.
  ///
  /// Uses standard Flutter [AlignmentGeometry] values:
  /// - Positive x values move subsequent avatars to the right
  /// - Negative x values move subsequent avatars to the left
  /// - Similar behavior for y axis with top/bottom movement
  final AlignmentGeometry alignment;
  /// Spacing between overlapping avatars in logical pixels.
  ///
  /// Controls the gap between the edges of overlapping avatars.
  /// If null, defaults to theme.scaling * 4.
  final double? gap;
  /// Clipping behavior for the avatar stack.
  ///
  /// Controls how avatars are clipped at the group boundaries.
  /// If null, defaults to [Clip.none].
  final Clip? clipBehavior;
  /// Creates an [AvatarGroup] with custom alignment.
  ///
  /// This is the base constructor that allows full control over the
  /// overlapping behavior through the [alignment] parameter.
  ///
  /// Parameters:
  /// - [alignment] (AlignmentGeometry, required): Direction of overlap
  /// - [children] (`List<AvatarWidget>`, required): Avatars to arrange
  /// - [gap] (double?, optional): Spacing between avatars
  /// - [clipBehavior] (Clip?, optional): Clipping behavior
  ///
  /// Example:
  /// ```dart
  /// AvatarGroup(
  ///   alignment: Alignment(0.5, 0),
  ///   children: [Avatar(initials: 'A'), Avatar(initials: 'B')],
  ///   gap: 6.0,
  /// );
  /// ```
  const AvatarGroup({super.key, required this.alignment, required this.children, this.gap, this.clipBehavior});
  /// Creates an [AvatarGroup] with left-to-right overlapping.
  ///
  /// Arranges avatars so that subsequent avatars overlap to the left side
  /// of previous avatars, creating a rightward flow.
  ///
  /// Parameters:
  /// - [children] (`List<AvatarWidget>`, required): Avatars to arrange
  /// - [gap] (double?, optional): Spacing between overlapping edges
  /// - [offset] (double, default: 0.5): Amount of overlap (0.0 to 1.0)
  ///
  /// Example:
  /// ```dart
  /// AvatarGroup.toLeft(
  ///   children: [Avatar(initials: 'A'), Avatar(initials: 'B')],
  ///   offset: 0.7,
  /// );
  /// ```
  factory AvatarGroup.toLeft({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  /// Creates an [AvatarGroup] with right-to-left overlapping.
  ///
  /// Arranges avatars so that subsequent avatars overlap to the right side
  /// of previous avatars, creating a leftward flow.
  ///
  /// Parameters:
  /// - [children] (`List<AvatarWidget>`, required): Avatars to arrange
  /// - [gap] (double?, optional): Spacing between overlapping edges
  /// - [offset] (double, default: 0.5): Amount of overlap (0.0 to 1.0)
  ///
  /// Example:
  /// ```dart
  /// AvatarGroup.toRight(
  ///   children: [Avatar(initials: 'A'), Avatar(initials: 'B')],
  ///   gap: 4.0,
  /// );
  /// ```
  factory AvatarGroup.toRight({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  /// Creates an [AvatarGroup] with start-to-end overlapping.
  ///
  /// Locale-aware version of [toLeft]. In LTR locales, behaves like [toLeft].
  /// In RTL locales, behaves like [toRight].
  ///
  /// Parameters:
  /// - [children] (`List<AvatarWidget>`, required): Avatars to arrange
  /// - [gap] (double?, optional): Spacing between overlapping edges
  /// - [offset] (double, default: 0.5): Amount of overlap (0.0 to 1.0)
  ///
  /// Example:
  /// ```dart
  /// AvatarGroup.toStart(
  ///   children: [Avatar(initials: 'A'), Avatar(initials: 'B')],
  /// );
  /// ```
  factory AvatarGroup.toStart({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  /// Creates an [AvatarGroup] with end-to-start overlapping.
  ///
  /// Locale-aware version of [toRight]. In LTR locales, behaves like [toRight].
  /// In RTL locales, behaves like [toLeft].
  ///
  /// Parameters:
  /// - [children] (`List<AvatarWidget>`, required): Avatars to arrange
  /// - [gap] (double?, optional): Spacing between overlapping edges
  /// - [offset] (double, default: 0.5): Amount of overlap (0.0 to 1.0)
  ///
  /// Example:
  /// ```dart
  /// AvatarGroup.toEnd(
  ///   children: [Avatar(initials: 'A'), Avatar(initials: 'B')],
  /// );
  /// ```
  factory AvatarGroup.toEnd({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  /// Creates an [AvatarGroup] with top-to-bottom overlapping.
  ///
  /// Arranges avatars so that subsequent avatars overlap toward the top
  /// of previous avatars, creating a downward flow.
  ///
  /// Parameters:
  /// - [children] (`List<AvatarWidget>`, required): Avatars to arrange
  /// - [gap] (double?, optional): Spacing between overlapping edges
  /// - [offset] (double, default: 0.5): Amount of overlap (0.0 to 1.0)
  ///
  /// Example:
  /// ```dart
  /// AvatarGroup.toTop(
  ///   children: [Avatar(initials: 'A'), Avatar(initials: 'B')],
  /// );
  /// ```
  factory AvatarGroup.toTop({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  /// Creates an [AvatarGroup] with bottom-to-top overlapping.
  ///
  /// Arranges avatars so that subsequent avatars overlap toward the bottom
  /// of previous avatars, creating an upward flow.
  ///
  /// Parameters:
  /// - [children] (`List<AvatarWidget>`, required): Avatars to arrange
  /// - [gap] (double?, optional): Spacing between overlapping edges
  /// - [offset] (double, default: 0.5): Amount of overlap (0.0 to 1.0)
  ///
  /// Example:
  /// ```dart
  /// AvatarGroup.toBottom(
  ///   children: [Avatar(initials: 'A'), Avatar(initials: 'B')],
  /// );
  /// ```
  factory AvatarGroup.toBottom({Key? key, required List<AvatarWidget> children, double? gap, double offset = 0.5});
  Widget build(BuildContext context);
}
```
