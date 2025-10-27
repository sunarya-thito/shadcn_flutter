---
title: "Class: AvatarBadge"
description: "A circular badge widget designed to overlay on [Avatar] components."
---

```dart
/// A circular badge widget designed to overlay on [Avatar] components.
///
/// [AvatarBadge] provides a small circular indicator typically used to show
/// status information, notifications, or other contextual data on avatars.
/// The badge can contain custom content via [child] or display as a solid
/// colored circle for simple status indicators.
///
/// ## Features
/// - **Status Indicators**: Colored circles for online/offline status
/// - **Custom Content**: Support for icons, text, or other widgets
/// - **Theme Integration**: Uses primary color by default with theme radius
/// - **Size Flexibility**: Configurable dimensions with automatic scaling
///
/// ## Common Use Cases
/// - Online status indicators (green dot)
/// - Notification badges (red circle with count)
/// - Custom status icons (checkmarks, warnings)
///
/// Example:
/// ```dart
/// AvatarBadge(
///   size: 16,
///   color: Colors.green,
///   child: Icon(Icons.check, size: 10, color: Colors.white),
/// );
/// ```
class AvatarBadge extends StatelessWidget implements AvatarWidget {
  /// Size of the badge in logical pixels.
  ///
  /// Controls both width and height of the circular badge container.
  /// If null, defaults to theme.scaling * 12.
  final double? size;
  /// Border radius for the badge corners in logical pixels.
  ///
  /// If null, defaults to theme.radius * size for proportional rounding,
  /// typically creating a circular badge.
  final double? borderRadius;
  /// Optional child widget to display inside the badge.
  ///
  /// Can be an icon, text, or other widget. If null, displays as a
  /// solid colored circle using [color].
  final Widget? child;
  /// Background color of the badge.
  ///
  /// If null, defaults to the theme's primary color. Used as the
  /// background color for the circular container.
  final Color? color;
  /// Creates an [AvatarBadge].
  ///
  /// The badge can display either custom content via [child] or function
  /// as a simple colored indicator.
  ///
  /// Parameters:
  /// - [child] (Widget?, optional): Content to display inside the badge.
  ///   If null, shows as a solid colored circle.
  /// - [size] (double?, optional): Badge dimensions in logical pixels.
  ///   Defaults to theme.scaling * 12.
  /// - [borderRadius] (double?, optional): Corner radius in logical pixels.
  ///   Defaults to theme.radius * size for circular appearance.
  /// - [color] (Color?, optional): Background color. Defaults to theme primary.
  ///
  /// Example:
  /// ```dart
  /// AvatarBadge(
  ///   color: Colors.red,
  ///   child: Text('5', style: TextStyle(color: Colors.white, fontSize: 8)),
  /// );
  /// ```
  const AvatarBadge({super.key, this.child, this.size, this.borderRadius, this.color});
  Widget build(BuildContext context);
}
```
