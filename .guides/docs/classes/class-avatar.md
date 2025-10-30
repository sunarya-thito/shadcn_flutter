---
title: "Class: Avatar"
description: "A circular or rounded rectangular widget for displaying user profile images or initials."
---

```dart
/// A circular or rounded rectangular widget for displaying user profile images or initials.
///
/// [Avatar] provides a versatile component for representing users in UI interfaces.
/// It can display either an image (from network or other sources) or user initials,
/// with automatic fallback to initials when image loading fails. The avatar supports
/// optional badges for status indicators and integrates seamlessly with [AvatarGroup]
/// for overlapping avatar layouts.
///
/// ## Key Features
/// - **Flexible Content**: Supports both images and text initials
/// - **Automatic Fallback**: Falls back to initials when images fail to load
/// - **Badge Support**: Optional badge overlay for status or notification indicators
/// - **Network Images**: Built-in support for network images with caching
/// - **Theming**: Comprehensive theming via [AvatarTheme]
/// - **Group Integration**: Works with [AvatarGroup] for overlapping layouts
///
/// ## Initials Generation
/// The avatar includes intelligent initials generation via [getInitials]:
/// - For single words: First two characters (e.g., "John" → "JO")
/// - For multiple words: First character of first two words (e.g., "John Doe" → "JD")
/// - Proper capitalization and fallback handling
///
/// Example:
/// ```dart
/// Avatar(
///   initials: 'JD',
///   size: 48,
///   backgroundColor: Colors.blue.shade100,
///   badge: AvatarBadge(
///     color: Colors.green,
///     size: 12,
///   ),
/// );
/// ```
class Avatar extends StatefulWidget implements AvatarWidget {
  /// Generates initials from a user's full name.
  ///
  /// Creates appropriate initials for avatar display from a given name string.
  /// Uses intelligent logic to extract meaningful characters:
  /// - For single words: First two characters (e.g., "John" → "JO")
  /// - For multiple words: First character of first two words (e.g., "John Doe" → "JD")
  /// - Handles edge cases with proper capitalization
  ///
  /// Parameters:
  /// - [name] (String): The full name to extract initials from
  ///
  /// Returns:
  /// A [String] containing the generated initials, typically 1-2 characters.
  ///
  /// Example:
  /// ```dart
  /// String initials1 = Avatar.getInitials('John Doe'); // Returns 'JD'
  /// String initials2 = Avatar.getInitials('Madonna'); // Returns 'MA'
  /// ```
  static String getInitials(String name);
  /// User initials or text to display in the avatar.
  ///
  /// Primary fallback content when no image is provided via [provider]
  /// or when image loading fails. Should typically contain user's initials
  /// or a short representative text.
  final String initials;
  /// Background color for the avatar when displaying initials.
  ///
  /// Type: `Color?`. Used as the container background color when showing
  /// [initials]. If null, defaults to the theme's muted color.
  final Color? backgroundColor;
  /// Size of the avatar in logical pixels.
  ///
  /// Type: `double?`. Controls both width and height of the avatar container.
  /// If null, defaults to theme.scaling * 40 pixels.
  final double? size;
  /// Border radius for avatar corners in logical pixels.
  ///
  /// Type: `double?`. Creates rounded corners on the avatar container.
  /// If null, defaults to theme.radius * size for proportional rounding.
  final double? borderRadius;
  /// Optional badge widget to overlay on the avatar.
  ///
  /// Type: `AvatarWidget?`. Typically an [AvatarBadge] for status indicators.
  /// Positioned according to [badgeAlignment] with [badgeGap] spacing.
  final AvatarWidget? badge;
  /// Position of the badge relative to the avatar.
  ///
  /// Type: `AlignmentGeometry?`. Controls where the [badge] is positioned.
  /// If null, uses a calculated offset based on avatar and badge sizes.
  final AlignmentGeometry? badgeAlignment;
  /// Spacing between the avatar and badge in logical pixels.
  ///
  /// Type: `double?`. Controls the gap between the avatar edge and badge edge.
  /// If null, defaults to theme.scaling * 4 pixels.
  final double? badgeGap;
  /// Image provider for displaying user photos.
  ///
  /// Type: `ImageProvider?`. Can be any Flutter image provider (NetworkImage,
  /// AssetImage, etc.). If null or loading fails, shows [initials] instead.
  final ImageProvider? provider;
  /// Creates an [Avatar] widget with optional image provider.
  ///
  /// The default constructor creates an avatar that can display either an image
  /// (via [provider]) or user initials. If no image provider is specified or
  /// image loading fails, the avatar falls back to displaying [initials].
  ///
  /// Parameters:
  /// - [initials] (String, required): Text to display when no image is provided
  ///   or image loading fails. Should typically be user's initials.
  /// - [backgroundColor] (Color?, optional): Background color for the initials
  ///   display. If null, uses theme's muted color.
  /// - [size] (double?, optional): Width and height of the avatar in logical
  ///   pixels. If null, defaults to theme.scaling * 40.
  /// - [borderRadius] (double?, optional): Corner radius in logical pixels.
  ///   If null, defaults to theme.radius * size for proportional rounding.
  /// - [badge] (AvatarWidget?, optional): Optional badge overlay for status
  ///   indicators. Positioned according to [badgeAlignment].
  /// - [badgeAlignment] (AlignmentGeometry?, optional): Position of the badge
  ///   relative to the avatar. If null, uses calculated offset based on sizes.
  /// - [badgeGap] (double?, optional): Spacing between avatar and badge.
  ///   If null, defaults to theme.scaling * 4.
  /// - [provider] (ImageProvider?, optional): Image to display. If null or
  ///   loading fails, shows [initials] instead.
  ///
  /// Example:
  /// ```dart
  /// Avatar(
  ///   initials: 'JD',
  ///   size: 48,
  ///   backgroundColor: Colors.blue.shade100,
  ///   badge: AvatarBadge(color: Colors.green),
  /// );
  /// ```
  const Avatar({super.key, required this.initials, this.backgroundColor, this.size, this.borderRadius, this.badge, this.badgeAlignment, this.badgeGap, this.provider});
  /// Creates an [Avatar] with a network image.
  ///
  /// This named constructor automatically configures a [NetworkImage] provider
  /// with optional image resizing for memory optimization. Falls back to
  /// displaying [initials] if the network image fails to load.
  ///
  /// Parameters:
  /// - [initials] (String, required): Fallback text when image loading fails.
  /// - [photoUrl] (String, required): URL of the network image to display.
  /// - [cacheWidth] (int?, optional): Resize width for memory optimization.
  ///   If specified, image will be decoded at this width.
  /// - [cacheHeight] (int?, optional): Resize height for memory optimization.
  ///   If specified, image will be decoded at this height.
  /// - [backgroundColor] (Color?, optional): Background color for initials fallback.
  /// - [size] (double?, optional): Avatar dimensions in logical pixels.
  /// - [borderRadius] (double?, optional): Corner radius in logical pixels.
  /// - [badge] (AvatarWidget?, optional): Optional badge overlay.
  /// - [badgeAlignment] (AlignmentGeometry?, optional): Badge position.
  /// - [badgeGap] (double?, optional): Spacing between avatar and badge.
  ///
  /// Example:
  /// ```dart
  /// Avatar.network(
  ///   initials: 'JD',
  ///   photoUrl: 'https://example.com/photo.jpg',
  ///   cacheWidth: 100,
  ///   cacheHeight: 100,
  /// );
  /// ```
  Avatar.network({super.key, required this.initials, this.backgroundColor, this.size, this.borderRadius, this.badge, this.badgeAlignment, this.badgeGap, int? cacheWidth, int? cacheHeight, required String photoUrl});
  State<Avatar> createState();
}
```
