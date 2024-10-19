import 'package:shadcn_flutter/shadcn_flutter.dart';

void showDropdown({
  required BuildContext context,
  required WidgetBuilder builder,
  Offset? position,
  AlignmentGeometry? anchorAlignment,
  PopoverConstraint widthConstraint = PopoverConstraint.flexible,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  Key? key,
  bool rootOverlay = true,
  bool modal = true,
  Clip clipBehavior = Clip.none,
  Object? regionGroupId,
  Offset? offset,
  Alignment? transitionAlignment,
  EdgeInsets? margin,
  bool follow = true,
  bool consumeOutsideTaps = true,
  ValueChanged<PopoverAnchorState>? onTickFollow,
  bool allowInvertHorizontal = true,
  bool allowInvertVertical = true,
  bool dismissBackdropFocus = true,
  Duration? showDuration,
  Duration? dismissDuration,
}) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  final GlobalKey key = GlobalKey();
  showPopover(
    context: context,
    alignment: Alignment.topCenter,
    offset: offset ?? (const Offset(0, 4) * scaling),
    follow: follow,
    clipBehavior: clipBehavior,
    margin: margin,
    transitionAlignment: transitionAlignment,
    onTickFollow: onTickFollow,
    allowInvertHorizontal: allowInvertHorizontal,
    allowInvertVertical: allowInvertVertical,
    showDuration: showDuration,
    dismissDuration: dismissDuration,
    widthConstraint: widthConstraint,
    heightConstraint: heightConstraint,
    position: position,
    anchorAlignment: anchorAlignment,
    consumeOutsideTaps: false,
    regionGroupId: key,
    modal: false,
    dismissBackdropFocus: true,
    overlayBarrier: OverlayBarrier(
      borderRadius: BorderRadius.circular(theme.radiusMd),
    ),
    builder: (context) {
      return Data.inherit(
        data: DropdownMenuData(key),
        child: builder(context),
      );
    },
  );
}

class DropdownMenuData {
  final GlobalKey key;

  DropdownMenuData(this.key);
}

class DropdownMenu extends StatefulWidget {
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final List<MenuItem> children;

  const DropdownMenu({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
  });

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 192,
      ),
      child: MenuGroup(
        regionGroupId: Data.maybeOf<DropdownMenuData>(context)?.key,
        subMenuOffset: const Offset(8, -4) * theme.scaling,
        onDismissed: () {
          closePopover(context);
        },
        direction: Axis.vertical,
        builder: (context, children) {
          return MenuPopup(
            // does not need to check for theme.surfaceOpacity and theme.surfaceBlur
            // MenuPopup already has default values for these properties
            surfaceOpacity: widget.surfaceOpacity,
            surfaceBlur: widget.surfaceBlur,
            children: children,
          );
        },
        children: widget.children,
      ),
    );
  }
}
