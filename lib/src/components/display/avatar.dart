import '../../../shadcn_flutter.dart';

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
  const AvatarTheme({
    this.size,
    this.borderRadius,
    this.backgroundColor,
    this.badgeAlignment,
    this.badgeGap,
    this.textStyle,
  });

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
  AvatarTheme copyWith({
    ValueGetter<double?>? size,
    ValueGetter<double?>? borderRadius,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<AlignmentGeometry?>? badgeAlignment,
    ValueGetter<double?>? badgeGap,
    ValueGetter<TextStyle?>? textStyle,
  }) {
    return AvatarTheme(
      size: size == null ? this.size : size(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      badgeAlignment:
          badgeAlignment == null ? this.badgeAlignment : badgeAlignment(),
      badgeGap: badgeGap == null ? this.badgeGap : badgeGap(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AvatarTheme &&
        other.size == size &&
        other.borderRadius == borderRadius &&
        other.backgroundColor == backgroundColor &&
        other.badgeAlignment == badgeAlignment &&
        other.badgeGap == badgeGap &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode => Object.hash(
        size,
        borderRadius,
        backgroundColor,
        badgeAlignment,
        badgeGap,
        textStyle,
      );
}

/// Abstract base class for avatar-related widgets.
///
/// [AvatarWidget] provides a common interface for avatar components, ensuring
/// they expose size and border radius properties that can be used by container
/// components like [AvatarGroup] for proper layout and clipping.
abstract class AvatarWidget extends Widget {
  /// Creates an [AvatarWidget] with optional key.
  const AvatarWidget({super.key});

  /// Size of the avatar widget in logical pixels.
  ///
  /// Used by container widgets for layout calculations and clipping operations.
  double? get size;

  /// Border radius of the avatar widget in logical pixels.
  ///
  /// Used by container widgets for proper clipping and visual effects.
  double? get borderRadius;
}

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
  static String getInitials(String name) {
    final List<String> parts = name.split(r'\s+');
    if (parts.isEmpty) {
      // get the first 2 characters (title cased)
      String first = name.substring(0, 1).toUpperCase();
      if (name.length > 1) {
        String second = name.substring(1, 2).toUpperCase();
        return first + second;
      }
      return first;
    }
    // get the first two characters
    String first = parts[0].substring(0, 1).toUpperCase();
    if (parts.length > 1) {
      String second = parts[1].substring(0, 1).toUpperCase();
      return first + second;
    }
    // append with the 2nd character of the first part
    if (parts[0].length > 1) {
      String second = parts[0].substring(1, 2).toUpperCase();
      return first + second;
    }
    return first;
  }

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
  @override
  final double? size;

  /// Border radius for avatar corners in logical pixels.
  ///
  /// Type: `double?`. Creates rounded corners on the avatar container.
  /// If null, defaults to theme.radius * size for proportional rounding.
  @override
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
  const Avatar({
    super.key,
    required this.initials,
    this.backgroundColor,
    this.size,
    this.borderRadius,
    this.badge,
    this.badgeAlignment,
    this.badgeGap,
    this.provider,
  });

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
  Avatar.network({
    super.key,
    required this.initials,
    this.backgroundColor,
    this.size,
    this.borderRadius,
    this.badge,
    this.badgeAlignment,
    this.badgeGap,
    int? cacheWidth,
    int? cacheHeight,
    required String photoUrl,
  }) : provider = ResizeImage.resizeIfNeeded(
          cacheWidth,
          cacheHeight,
          NetworkImage(photoUrl),
        );

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Widget _build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AvatarTheme>(context);
    double size = styleValue(
        widgetValue: widget.size,
        themeValue: compTheme?.size,
        defaultValue: theme.scaling * 40);
    double borderRadius = styleValue(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.radius * size);
    if (widget.provider != null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image(
            image: widget.provider!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildInitials(context, borderRadius);
            },
          ),
        ),
      );
    }
    return SizedBox(
      width: size,
      height: size,
      child: _buildInitials(context, borderRadius),
    );
  }

  Widget _buildInitials(BuildContext context, double borderRadius) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AvatarTheme>(context);
    return Container(
      decoration: BoxDecoration(
        color: styleValue(
            widgetValue: widget.backgroundColor,
            themeValue: compTheme?.backgroundColor,
            defaultValue: theme.colorScheme.muted),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Padding(
          padding: EdgeInsets.all(theme.scaling * 8),
          child: DefaultTextStyle.merge(
            child: Center(
              child: Text(
                widget.initials,
              ),
            ),
            style: styleValue(
              themeValue: compTheme?.textStyle,
              defaultValue: TextStyle(
                color: theme.colorScheme.foreground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.badge == null) {
      return _build(context);
    }
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AvatarTheme>(context);
    double size = styleValue(
        widgetValue: widget.size,
        themeValue: compTheme?.size,
        defaultValue: theme.scaling * 40);
    double borderRadius = styleValue(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.radius * size);
    double badgeSize = widget.badge!.size ?? theme.scaling * 12;
    double offset = size / 2 - badgeSize / 2;
    offset = offset / size;
    final alignment = styleValue(
        widgetValue: widget.badgeAlignment,
        themeValue: compTheme?.badgeAlignment,
        defaultValue: AlignmentDirectional(offset, offset));
    final gap = styleValue(
        widgetValue: widget.badgeGap,
        themeValue: compTheme?.badgeGap,
        defaultValue: theme.scaling * 4);
    return AvatarGroup(
      alignment: alignment,
      gap: gap,
      children: [
        _AvatarWidget(
          size: widget.badge!.size ?? theme.scaling * 12,
          borderRadius: widget.badge!.borderRadius,
          child: widget.badge!,
        ),
        _AvatarWidget(
          size: size,
          borderRadius: borderRadius,
          child: _build(context),
        ),
      ],
    );
  }
}

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
  @override
  final double? size;

  /// Border radius for the badge corners in logical pixels.
  ///
  /// If null, defaults to theme.radius * size for proportional rounding,
  /// typically creating a circular badge.
  @override
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
  const AvatarBadge({
    super.key,
    this.child,
    this.size,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = this.size ?? theme.scaling * 12;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.primary,
        borderRadius:
            BorderRadius.circular(borderRadius ?? theme.radius * size),
      ),
      child: child,
    );
  }
}

class _AvatarWidget extends StatelessWidget implements AvatarWidget {
  @override
  final double? size;
  @override
  final double? borderRadius;
  final Widget child;

  const _AvatarWidget({
    required this.child,
    this.size,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

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
  const AvatarGroup({
    super.key,
    required this.alignment,
    required this.children,
    this.gap,
    this.clipBehavior,
  });

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
  factory AvatarGroup.toLeft({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(offset, 0),
      gap: gap,
      children: children,
    );
  }

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
  factory AvatarGroup.toRight({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(-offset, 0),
      gap: gap,
      children: children,
    );
  }

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
  factory AvatarGroup.toStart({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: AlignmentDirectional(offset, 0),
      gap: gap,
      children: children,
    );
  }

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
  factory AvatarGroup.toEnd({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: AlignmentDirectional(-offset, 0),
      gap: gap,
      children: children,
    );
  }

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
  factory AvatarGroup.toTop({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(0, offset),
      gap: gap,
      children: children,
    );
  }

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
  factory AvatarGroup.toBottom({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(0, -offset),
      gap: gap,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Positioned> children = [];
    double currentX = 0;
    double currentY = 0;
    double currentWidth = 0;
    double currentHeight = 0;
    Rect rect = Rect.zero;
    double currentBorderRadius = 0;
    Alignment resolved = alignment.optionallyResolve(context);
    for (int i = 0; i < this.children.length; i++) {
      AvatarWidget avatar = this.children[i];
      double size = avatar.size ?? theme.scaling * 40;
      if (i == 0) {
        children.add(
          Positioned(
            left: currentX,
            top: currentY,
            child: avatar,
          ),
        );
        rect = Rect.fromLTWH(currentX, currentY, size, size);
        currentWidth = size;
        currentHeight = size;
        currentBorderRadius =
            avatar.borderRadius ?? Theme.of(context).radius * size;
      } else {
        double width = size;
        double height = size;
        double widthDiff = currentWidth - width;
        double heightDiff = currentHeight - height;

        var offsetWidth = -currentWidth * resolved.x;
        var offsetHeight = -currentHeight * resolved.y;
        var offsetWidthDiff = widthDiff * resolved.x;
        var offsetHeightDiff = heightDiff * resolved.y;
        double x = (widthDiff / 2) + offsetWidth + currentX + offsetWidthDiff;
        double y =
            (heightDiff / 2) + offsetHeight + currentY + offsetHeightDiff;

        // NOTE: child positions are not affected by gap

        children.add(
          Positioned(
            left: x,
            top: y,
            width: size,
            height: size,
            child: ClipPath(
              clipper: AvatarGroupClipper(
                borderRadius: currentBorderRadius,
                alignment: resolved,
                previousAvatarSize: currentWidth,
                gap: gap ?? theme.scaling * 4,
              ),
              child: avatar,
            ),
          ),
        );

        currentX = x;
        currentY = y;
        currentWidth = size;
        currentHeight = size;
        currentBorderRadius = avatar.borderRadius ?? theme.radius * size;

        rect = rect.expandToInclude(Rect.fromLTWH(x, y, size, size));
      }
    }
    return SizedBox(
      width: rect.width,
      height: rect.height,
      child: Stack(
        clipBehavior: clipBehavior ?? Clip.none,
        alignment: Alignment.center,
        children: children.map(
          (e) {
            return Positioned(
              left: e.left! - rect.left,
              top: e.top! - rect.top,
              width: e.width,
              height: e.height,
              child: e.child,
            );
          },
        ).toList(),
      ),
    );
  }
}

/// Custom clipper for creating overlapping avatar group effects.
///
/// Clips avatars to create a stacked appearance where each avatar partially
/// overlaps the previous one, accounting for border radius and alignment.
class AvatarGroupClipper extends CustomClipper<Path> {
  /// The border radius for rounded corners on avatars.
  final double borderRadius;

  /// The alignment of avatars within the group.
  final Alignment alignment;

  /// The size of the previous avatar in the stack.
  final double previousAvatarSize;

  /// The gap between overlapping avatars.
  final double gap;

  /// Creates an avatar group clipper with the specified parameters.
  const AvatarGroupClipper({
    required this.borderRadius,
    required this.alignment,
    required this.previousAvatarSize,
    required this.gap,
  });

  @override
  Path getClip(Size size) {
    // cut the avatar by the previous avatar
    // avatars are rounded rectangles

    var prevAvatarSize = previousAvatarSize;

    double widthDiff = size.width - prevAvatarSize;
    double heightDiff = size.height - prevAvatarSize;

    // align both at center first
    double left = (widthDiff / 2);
    double top = (heightDiff / 2);

    left += size.width * alignment.x;
    top += size.height * alignment.y;

    Path path = Path();
    path.fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    if (borderRadius > 0) {
      path.addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            left - gap,
            top - gap,
            prevAvatarSize + gap * 2,
            prevAvatarSize + gap * 2,
          ),
          Radius.circular(borderRadius + gap * 2),
        ),
      );
    } else {
      path.addRect(
        Rect.fromLTWH(
          left - gap,
          top - gap,
          prevAvatarSize + gap * 2,
          prevAvatarSize + gap * 2,
        ),
      );
    }
    return path;
  }

  @override
  bool shouldReclip(covariant AvatarGroupClipper oldClipper) {
    return oldClipper.borderRadius != borderRadius ||
        oldClipper.alignment != alignment ||
        oldClipper.previousAvatarSize != previousAvatarSize ||
        oldClipper.gap != gap;
  }
}
