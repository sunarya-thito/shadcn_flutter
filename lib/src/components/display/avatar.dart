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
      borderRadius:
          borderRadius == null ? this.borderRadius : borderRadius(),
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

  final String initials;
  final Color? backgroundColor;
  @override
  final double? size;
  @override
  final double? borderRadius;
  final AvatarWidget? badge;
  final AlignmentGeometry? badgeAlignment;
  final double? badgeGap;
  final ImageProvider? provider;

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
  _AvatarState createState() => _AvatarState();
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

class AvatarBadge extends StatelessWidget implements AvatarWidget {
  @override
  final double? size;
  @override
  final double? borderRadius;
  final Widget? child;
  final Color? color;

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

class AvatarGroup extends StatelessWidget {
  final List<AvatarWidget> children;
  final AlignmentGeometry alignment;
  final double? gap;
  final Clip? clipBehavior;

  const AvatarGroup({
    super.key,
    required this.alignment,
    required this.children,
    this.gap,
    this.clipBehavior,
  });

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

class AvatarGroupClipper extends CustomClipper<Path> {
  final double borderRadius;
  final Alignment alignment;
  final double previousAvatarSize;
  final double gap;

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
