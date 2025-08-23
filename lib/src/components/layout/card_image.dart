import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [CardImage] components.
///
/// Defines visual properties like scale animations, background colors,
/// border styling, and layout direction. Applied through the widget tree
/// using [ComponentTheme] to provide consistent theming across card images.
///
/// Example:
/// ```dart
/// ComponentTheme(
///   data: CardImageTheme(
///     hoverScale: 1.1,
///     backgroundColor: Colors.grey.shade100,
///     direction: Axis.horizontal,
///   ),
///   child: MyApp(),
/// );
/// ```
class CardImageTheme {
  /// Button style for the card.
  final AbstractButtonStyle? style;

  /// Layout direction for title/subtitle relative to the image.
  final Axis? direction;

  /// Scale factor when hovering over the image.
  final double? hoverScale;

  /// Normal scale factor for the image.
  final double? normalScale;

  /// Background color for the image container.
  final Color? backgroundColor;

  /// Border color for the image container.
  final Color? borderColor;

  /// Gap between image and text content.
  final double? gap;

  /// Creates a [CardImageTheme].
  ///
  /// All parameters are optional and provide default styling for [CardImage]
  /// widgets in the component tree.
  ///
  /// Parameters:
  /// - [style] (AbstractButtonStyle?): button style configuration
  /// - [direction] (Axis?): layout direction (vertical/horizontal)
  /// - [hoverScale] (double?): image scale on hover (default: 1.05)
  /// - [normalScale] (double?): normal image scale (default: 1.0)
  /// - [backgroundColor] (Color?): image background color
  /// - [borderColor] (Color?): image border color
  /// - [gap] (double?): spacing between image and content
  ///
  /// Example:
  /// ```dart
  /// CardImageTheme(
  ///   hoverScale: 1.1,
  ///   direction: Axis.horizontal,
  ///   backgroundColor: Colors.grey.shade50,
  /// );
  /// ```
  const CardImageTheme({
    this.style,
    this.direction,
    this.hoverScale,
    this.normalScale,
    this.backgroundColor,
    this.borderColor,
    this.gap,
  });

  /// Creates a copy of this theme with optionally overridden properties.
  ///
  /// Uses [ValueGetter] functions to allow nullable overrides.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = existingTheme.copyWith(
  ///   hoverScale: () => 1.2,
  ///   backgroundColor: () => Colors.blue.shade50,
  /// );
  /// ```
  CardImageTheme copyWith({
    ValueGetter<AbstractButtonStyle?>? style,
    ValueGetter<Axis?>? direction,
    ValueGetter<double?>? hoverScale,
    ValueGetter<double?>? normalScale,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? gap,
  }) {
    return CardImageTheme(
      style: style == null ? this.style : style(),
      direction: direction == null ? this.direction : direction(),
      hoverScale: hoverScale == null ? this.hoverScale : hoverScale(),
      normalScale: normalScale == null ? this.normalScale : normalScale(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      gap: gap == null ? this.gap : gap(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CardImageTheme &&
        other.style == style &&
        other.direction == direction &&
        other.hoverScale == hoverScale &&
        other.normalScale == normalScale &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.gap == gap;
  }

  @override
  int get hashCode => Object.hash(
        style,
        direction,
        hoverScale,
        normalScale,
        backgroundColor,
        borderColor,
        gap,
      );
}

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
  const CardImage({
    super.key,
    required this.image,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onPressed,
    this.enabled,
    this.style,
    this.direction,
    this.hoverScale,
    this.normalScale,
    this.backgroundColor,
    this.borderColor,
    this.gap,
  });

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  final WidgetStatesController _statesController = WidgetStatesController();

  /// Wraps child widget with appropriate intrinsic sizing based on direction.
  Widget _wrapIntrinsic(Widget child, Axis direction) {
    return direction == Axis.horizontal
        ? IntrinsicHeight(child: child)
        : IntrinsicWidth(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<CardImageTheme>(context);
    final style = styleValue(
        widgetValue: widget.style,
        themeValue: compTheme?.style,
        defaultValue: const ButtonStyle.fixed(
          density: ButtonDensity.compact,
        ));
    final direction = styleValue(
        widgetValue: widget.direction,
        themeValue: compTheme?.direction,
        defaultValue: Axis.vertical);
    final hoverScale = styleValue(
        widgetValue: widget.hoverScale,
        themeValue: compTheme?.hoverScale,
        defaultValue: 1.05);
    final normalScale = styleValue(
        widgetValue: widget.normalScale,
        themeValue: compTheme?.normalScale,
        defaultValue: 1.0);
    final backgroundColor = styleValue(
        widgetValue: widget.backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: Colors.transparent);
    final borderColor = styleValue(
        widgetValue: widget.borderColor,
        themeValue: compTheme?.borderColor,
        defaultValue: Colors.transparent);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 12 * scaling);
    return Button(
      statesController: _statesController,
      style: style,
      onPressed: widget.onPressed,
      enabled: widget.enabled,
      child: _wrapIntrinsic(
        Flex(
          direction: direction,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: OutlinedContainer(
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                child: AnimatedBuilder(
                    animation: _statesController,
                    builder: (context, child) {
                      return AnimatedScale(
                        duration: kDefaultDuration,
                        scale: _statesController.value
                                .contains(WidgetState.hovered)
                            ? hoverScale
                            : normalScale,
                        child: widget.image,
                      );
                    }),
              ),
            ),
            Gap(gap),
            Basic(
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: widget.trailing,
              leading: widget.leading,
            ),
          ],
        ),
        direction,
      ),
    );
  }
}
