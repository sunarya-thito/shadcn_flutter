import '../../../shadcn_flutter.dart';

abstract class AvatarWidget extends Widget {
  double? get size;
  double? get borderRadius;
}

class Avatar extends StatefulWidget implements AvatarWidget {
  static String getInitials(String name) {
    // replace all non-alphabetic characters
    name = name.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');
    final List<String> parts = name.split(' ');
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

  final String? photoUrl;
  final String initials;
  final Color? backgroundColor;
  @override
  final double? size;
  @override
  final double? borderRadius;
  final AvatarWidget? badge;
  final Offset? badgeOffset;
  final double? badgeGap;

  const Avatar({
    Key? key,
    this.photoUrl,
    required this.initials,
    this.backgroundColor,
    this.size,
    this.borderRadius,
    this.badge,
    this.badgeOffset,
    this.badgeGap,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Widget _build(BuildContext context) {
    final theme = Theme.of(context);
    double size = widget.size ?? (theme.scaling * 40);
    double borderRadius = widget.borderRadius ?? theme.radiusXxl * size;
    // use photo if available, use initials if not
    // also if photo is failed to load, use initials
    if (widget.photoUrl?.isNotEmpty ?? false) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            widget.photoUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print('Failed to load image: $error');
              print(stackTrace);
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
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.muted,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Padding(
          padding: EdgeInsets.all(theme.scaling * 8),
          child: mergeAnimatedTextStyle(
            duration: kDefaultDuration,
            child: Text(
              widget.initials,
            ),
            style: TextStyle(
              color: theme.colorScheme.foreground,
              fontWeight: FontWeight.bold,
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
    double size = widget.size ?? theme.scaling * 40;
    double badgeSize = widget.badge!.size ?? theme.scaling * 12;
    double offset = size / 2 - badgeSize / 2;
    offset = offset / size;
    return AvatarGroup(
      fractionalOffset: widget.badgeOffset ?? Offset(offset, offset),
      gap: widget.badgeGap ?? theme.scaling * 4,
      children: [
        _AvatarWidget(
          size: widget.badge!.size ?? theme.scaling * 12,
          borderRadius: widget.badge!.borderRadius,
          child: widget.badge!,
        ),
        _AvatarWidget(
          size: widget.size,
          borderRadius: widget.borderRadius,
          child: _build(context),
        ),
      ],
    );
  }
}

class AvatarBadge extends StatelessWidget implements AvatarWidget {
  final double? size;
  final double? borderRadius;
  final Widget? child;
  final Color? color;

  AvatarBadge({
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
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}

class _AvatarWidget extends StatelessWidget implements AvatarWidget {
  final double? size;
  final double? borderRadius;
  final Widget child;

  _AvatarWidget({
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
  final Offset fractionalOffset;
  final double? gap;
  final Clip? clipBehavior;

  const AvatarGroup({
    Key? key,
    required this.fractionalOffset,
    required this.children,
    this.gap,
    this.clipBehavior,
  }) : super(key: key);

  factory AvatarGroup.toLeft({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      fractionalOffset: Offset(offset, 0),
      children: children,
      gap: gap,
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
      fractionalOffset: Offset(-offset, 0),
      children: children,
      gap: gap,
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
      fractionalOffset: Offset(0, offset),
      children: children,
      gap: gap,
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
      fractionalOffset: Offset(0, -offset),
      children: children,
      gap: gap,
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

        var offsetWidth = -currentWidth * fractionalOffset.dx;
        var offsetHeight = -currentHeight * fractionalOffset.dy;
        var offsetWidthDiff = widthDiff * fractionalOffset.dx;
        var offsetHeightDiff = heightDiff * fractionalOffset.dy;
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
                fractionalOffset: fractionalOffset,
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
  final Offset fractionalOffset;
  final double previousAvatarSize;
  final double gap;

  const AvatarGroupClipper({
    required this.borderRadius,
    required this.fractionalOffset,
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

    left += size.width * fractionalOffset.dx;
    top += size.height * fractionalOffset.dy;

    Path path = Path();
    path.fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          left - gap,
          top - gap,
          prevAvatarSize + gap * 2,
          prevAvatarSize + gap * 2,
        ),
        Radius.circular(borderRadius + gap),
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant AvatarGroupClipper oldClipper) {
    return oldClipper.borderRadius != borderRadius ||
        oldClipper.fractionalOffset != fractionalOffset ||
        oldClipper.previousAvatarSize != previousAvatarSize ||
        oldClipper.gap != gap;
  }
}
