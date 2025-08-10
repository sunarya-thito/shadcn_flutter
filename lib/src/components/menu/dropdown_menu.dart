import 'package:shadcn_flutter/shadcn_flutter.dart';

OverlayCompleter<T?> showDropdown<T>({
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
  AlignmentGeometry? transitionAlignment,
  EdgeInsetsGeometry? margin,
  bool follow = true,
  bool consumeOutsideTaps = false,
  ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
  bool allowInvertHorizontal = true,
  bool allowInvertVertical = true,
  bool dismissBackdropFocus = true,
  Duration? showDuration,
  Duration? dismissDuration,
}) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  final GlobalKey key = GlobalKey();
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
    regionGroupId: key,
    modal: modal,
    dismissBackdropFocus: dismissBackdropFocus,
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

/// Theme for [DropdownMenu].
class DropdownMenuTheme {
  /// Surface opacity for the popup container.
  final double? surfaceOpacity;

  /// Surface blur for the popup container.
  final double? surfaceBlur;

  /// Creates a [DropdownMenuTheme].
  const DropdownMenuTheme({this.surfaceOpacity, this.surfaceBlur});

  /// Returns a copy of this theme with the given fields replaced.
  DropdownMenuTheme copyWith({
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
  }) {
    return DropdownMenuTheme(
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DropdownMenuTheme &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur;
  }

  @override
  int get hashCode => Object.hash(surfaceOpacity, surfaceBlur);
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
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final compTheme = ComponentTheme.maybeOf<DropdownMenuTheme>(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 192,
      ),
      child: MenuGroup(
        regionGroupId: Data.maybeOf<DropdownMenuData>(context)?.key,
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
            surfaceOpacity:
                widget.surfaceOpacity ?? compTheme?.surfaceOpacity,
            surfaceBlur: widget.surfaceBlur ?? compTheme?.surfaceBlur,
            children: children,
          );
        },
        children: widget.children,
      ),
    );
  }
}
