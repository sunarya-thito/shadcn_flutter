import 'package:shadcn_flutter/shadcn_flutter.dart';

OverlayCompleter<T?> showDropdown<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Offset? position,
  AlignmentGeometry? anchorAlignment,
  PopoverConstraint widthConstraint = PopoverConstraint.flexible,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  bool rootOverlay = true,
  bool modal = true,
  Clip clipBehavior = Clip.none,
  Object? regionGroupId,
  Offset? offset,
  AlignmentGeometry? transitionAlignment,
  EdgeInsetsGeometry? margin,
  bool follow = true,
  bool consumeOutsideTaps = false,
  ValueChanged<PopoverAnchorState>? onTickFollow,
  bool allowInvertHorizontal = true,
  bool allowInvertVertical = true,
  bool dismissBackdropFocus = true,
  Duration? showDuration,
  Duration? dismissDuration,
}) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  final overlayManager = OverlayManager.of(context);
  return overlayManager.showMenu<T>(
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
    consumeOutsideTaps: consumeOutsideTaps,
    modal: modal,
    dismissBackdropFocus: dismissBackdropFocus,
    overlayBarrier: OverlayBarrier(
      borderRadius: BorderRadius.circular(theme.radiusMd),
    ),
    builder: (context) {
      return Data.inherit(
        data: DropdownMenuData(),
        child: builder(context),
      );
    },
  );
}

class DropdownMenuData {
  DropdownMenuData();
}

class DropdownMenu extends StatefulWidget {
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final List<MenuItem> children;

  const DropdownMenu({
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
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 192,
      ),
      child: MenuGroup(
        subMenuOffset: const Offset(8, -4) * theme.scaling,
        itemPadding: isSheetOverlay
            ? const EdgeInsets.symmetric(horizontal: 8) * theme.scaling
            : EdgeInsets.zero,
        onDismissed: () {
          closeOverlay(context);
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
