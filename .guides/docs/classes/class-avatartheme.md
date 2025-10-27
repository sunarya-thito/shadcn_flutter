---
title: "Class: AvatarTheme"
description: "Theme configuration for [Avatar] and related avatar components."
---

```dart
/// Theme configuration for [Avatar] and related avatar components.
///
/// [AvatarTheme] provides styling options for avatar components including size,
/// border radius, colors, and badge positioning. It enables consistent avatar
/// styling across an application while allowing per-instance customization.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<AvatarTheme>(
///   data: AvatarTheme(
///     size: 48.0,
///     borderRadius: 8.0,
///     backgroundColor: Colors.grey.shade200,
///     badgeAlignment: Alignment.topRight,
///     textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
///   ),
///   child: MyAvatarWidget(),
/// );
/// ```
class AvatarTheme {
  /// Default size for avatar components in logical pixels.
  ///
  /// Controls the width and height of avatar containers. If null, defaults
  /// to 40 logical pixels scaled by theme scaling factor.
  final double? size;
  /// Border radius for avatar corners in logical pixels.
  ///
  /// Creates rounded corners on avatar containers. If null, defaults to
  /// theme radius multiplied by avatar size for proportional rounding.
  final double? borderRadius;
  /// Background color for avatar containers when displaying initials.
  ///
  /// Used as the background color when no image is provided or when image
  /// loading fails. If null, uses the muted color from theme color scheme.
  final Color? backgroundColor;
  /// Alignment of badge relative to the main avatar.
  ///
  /// Controls where badges are positioned when attached to avatars.
  /// If null, badges are positioned at a calculated offset based on avatar size.
  final AlignmentGeometry? badgeAlignment;
  /// Spacing between avatar and badge components.
  ///
  /// Controls the gap between the main avatar and any attached badges.
  /// If null, defaults to 4 logical pixels scaled by theme scaling factor.
  final double? badgeGap;
  /// Text style for avatar initials display.
  ///
  /// Applied to text when displaying user initials in avatar containers.
  /// If null, uses bold foreground color from theme.
  final TextStyle? textStyle;
  /// Creates an [AvatarTheme] with the specified styling options.
  ///
  /// All parameters are optional and will fall back to component defaults
  /// when not specified.
  ///
  /// Parameters:
  /// - [size] (double?, optional): Default size for avatars.
  /// - [borderRadius] (double?, optional): Border radius for avatar corners.
  /// - [backgroundColor] (Color?, optional): Background color for initials display.
  /// - [badgeAlignment] (AlignmentGeometry?, optional): Badge positioning relative to avatar.
  /// - [badgeGap] (double?, optional): Spacing between avatar and badge.
  /// - [textStyle] (TextStyle?, optional): Text style for initials.
  const AvatarTheme({this.size, this.borderRadius, this.backgroundColor, this.badgeAlignment, this.badgeGap, this.textStyle});
  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   size: () => 60.0,
  ///   backgroundColor: () => Colors.blue.shade100,
  /// );
  /// ```
  AvatarTheme copyWith({ValueGetter<double?>? size, ValueGetter<double?>? borderRadius, ValueGetter<Color?>? backgroundColor, ValueGetter<AlignmentGeometry?>? badgeAlignment, ValueGetter<double?>? badgeGap, ValueGetter<TextStyle?>? textStyle});
  bool operator ==(Object other);
  int get hashCode;
}
```
