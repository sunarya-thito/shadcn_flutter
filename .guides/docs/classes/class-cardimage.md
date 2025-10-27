---
title: "Class: CardImage"
description: "Interactive card component with an image and optional text content."
---

```dart
/// Interactive card component with an image and optional text content.
///
/// Combines an image with title, subtitle, and optional leading/trailing
/// widgets in a clickable card layout. Features hover animations with
/// configurable scale effects and supports both vertical and horizontal
/// orientations.
///
/// The widget wraps the content in a [Button] for interaction handling
/// and uses [OutlinedContainer] for the image styling. Layout direction
/// can be configured to show content below (vertical) or beside
/// (horizontal) the image.
///
/// Example:
/// ```dart
/// CardImage(
///   image: Image.network('https://example.com/image.jpg'),
///   title: Text('Card Title'),
///   subtitle: Text('Subtitle text'),
///   onPressed: () => print('Card tapped'),
/// );
/// ```
class CardImage extends StatefulWidget {
  /// The primary image widget to display.
  final Widget image;
  /// Optional title widget displayed with the image.
  final Widget? title;
  /// Optional subtitle widget displayed below the title.
  final Widget? subtitle;
  /// Optional trailing widget (e.g., action buttons).
  final Widget? trailing;
  /// Optional leading widget (e.g., icon).
  final Widget? leading;
  /// Callback invoked when the card is pressed.
  final VoidCallback? onPressed;
  /// Whether the card is enabled for interaction.
  final bool? enabled;
  /// Custom button style for the card.
  final AbstractButtonStyle? style;
  /// Layout direction for content relative to image.
  final Axis? direction;
  /// Scale factor applied to image on hover.
  final double? hoverScale;
  /// Normal scale factor for the image.
  final double? normalScale;
  /// Background color for the image container.
  final Color? backgroundColor;
  /// Border color for the image container.
  final Color? borderColor;
  /// Gap between image and text content.
  final double? gap;
  /// Creates a [CardImage].
  ///
  /// The [image] parameter is required and should contain the primary
  /// visual content. All other parameters are optional and provide
  /// customization for layout, interaction, and styling.
  ///
  /// Parameters:
  /// - [image] (Widget, required): primary image content
  /// - [title] (Widget?): optional title text or widget
  /// - [subtitle] (Widget?): optional subtitle below title
  /// - [trailing] (Widget?): optional widget on the end side
  /// - [leading] (Widget?): optional widget on the start side
  /// - [onPressed] (VoidCallback?): tap callback, enables interaction
  /// - [enabled] (bool?): whether card responds to interaction
  /// - [style] (AbstractButtonStyle?): custom button styling
  /// - [direction] (Axis?): vertical or horizontal layout
  /// - [hoverScale] (double?): image scale on hover (default: 1.05)
  /// - [normalScale] (double?): normal image scale (default: 1.0)
  /// - [backgroundColor] (Color?): image background color
  /// - [borderColor] (Color?): image border color
  /// - [gap] (double?): spacing between image and content
  ///
  /// Example:
  /// ```dart
  /// CardImage(
  ///   image: Image.asset('assets/photo.jpg'),
  ///   title: Text('Beautiful Landscape'),
  ///   subtitle: Text('Captured in the mountains'),
  ///   direction: Axis.horizontal,
  ///   hoverScale: 1.1,
  ///   onPressed: () => showDetails(),
  /// );
  /// ```
  const CardImage({super.key, required this.image, this.title, this.subtitle, this.trailing, this.leading, this.onPressed, this.enabled, this.style, this.direction, this.hoverScale, this.normalScale, this.backgroundColor, this.borderColor, this.gap});
  State<CardImage> createState();
}
```
