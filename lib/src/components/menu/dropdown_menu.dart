import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Shows a dropdown menu overlay at a specified position or anchored to a widget.
///
/// Creates and displays a dropdown menu as an overlay, with full control over
/// positioning, alignment, sizing, and behavior. Returns an [OverlayCompleter]
/// that resolves when the menu is dismissed, optionally with a selected value.
///
/// This is a low-level function typically used by higher-level dropdown components.
/// For most use cases, prefer using [DropdownMenu] or similar widgets.
///
/// Key Features:
/// - **Flexible Positioning**: Anchor to widget or absolute position
/// - **Auto-sizing**: Constraint-based width/height
/// - **Smart Alignment**: Auto-inverts to stay on screen
/// - **Following**: Menu follows anchor when it moves
/// - **Modal/Non-modal**: Configurable interaction blocking
///
/// Parameters:
/// - [context]: Build context for overlay insertion (required)
/// - [builder]: Widget builder for menu content (required)
/// - [position]: Absolute position override
/// - [anchorAlignment]: Alignment on the anchor widget
/// - [widthConstraint]: Width sizing behavior (defaults to flexible)
/// - [heightConstraint]: Height sizing behavior (defaults to flexible)
/// - [key]: Key for the overlay widget
/// - [rootOverlay]: Use root overlay vs nearest (defaults to `true`)
/// - [modal]: Block interactions outside menu (defaults to `true`)
/// - [clipBehavior]: How to clip overflow (defaults to [Clip.none])
/// - [regionGroupId]: Grouping ID for related overlays
/// - [offset]: Additional offset from anchor
/// - [transitionAlignment]: Alignment for show/hide transitions
/// - [alignment]: Menu alignment relative to anchor
/// - [margin]: Outer margin around menu
/// - [follow]: Track anchor movement (defaults to `true`)
/// - [consumeOutsideTaps]: Dismiss on outside taps (defaults to `false`)
/// - [onTickFollow]: Callback during follow updates
/// - [allowInvertHorizontal]: Allow horizontal flip to stay on screen (defaults to `true`)
/// - [allowInvertVertical]: Allow vertical flip to stay on screen (defaults to `true`)
/// - [dismissBackdropFocus]: Dismiss when clicking backdrop (defaults to `true`)
/// - [showDuration]: Custom show animation duration
/// - [dismissDuration]: Custom dismiss animation duration
///
/// Returns an [OverlayCompleter] that resolves to the selected value when dismissed.
///
/// Example:
/// ```dart
/// final result = showDropdown<String>(
///   context: context,
///   builder: (context) => DropdownMenu(
///     children: [
///       MenuItem(title: Text('Option 1'), onTap: () => Navigator.pop(context, 'opt1')),
///       MenuItem(title: Text('Option 2'), onTap: () => Navigator.pop(context, 'opt2')),
///     ],
///   ),
/// );
/// final selected = await result.future;
/// print('Selected: $selected');
/// ```
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
  AlignmentGeometry? alignment,
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
    alignment: alignment ?? Alignment.topCenter,
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

/// Internal data class for dropdown menu context.
///
/// Holds shared data for dropdown menu implementation, including a unique
/// key for region grouping and overlay coordination.
///
/// This is typically used internally by the dropdown menu system and not
/// intended for direct use in application code.
class DropdownMenuData {
  /// Unique key identifying this dropdown menu instance.
  ///
  /// Used for coordinating overlays and region-based interactions.
  final GlobalKey key;

  /// Creates dropdown menu data with the specified key.
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

/// A dropdown menu widget that displays a list of menu items in a popup.
///
/// Provides a styled dropdown menu with vertical layout, automatic sizing,
/// and theme integration. Wraps menu items in a [MenuPopup] container with
/// appropriate padding and spacing for dropdown contexts.
///
/// Features:
/// - **Vertical Layout**: Displays menu items in a column
/// - **Auto-sizing**: Minimum width constraint of 192px
/// - **Surface Effects**: Configurable backdrop blur and opacity
/// - **Nested Menus**: Supports sub-menus with proper offset
/// - **Sheet Adaptation**: Adjusts padding for sheet overlay contexts
/// - **Auto-dismiss**: Closes when items are selected
///
/// Typically used with [showDropdown] function or as part of dropdown
/// button implementations. Menu items are provided as [MenuItem] widgets.
///
/// Example:
/// ```dart
/// DropdownMenu(
///   children: [
///     MenuItem(
///       title: Text('New File'),
///       leading: Icon(Icons.add),
///       onTap: () => createFile(),
///     ),
///     MenuItem(
///       title: Text('Open'),
///       trailing: Text('Ctrl+O'),
///       onTap: () => openFile(),
///     ),
///     MenuItem.divider(),
///     MenuItem(
///       title: Text('Exit'),
///       onTap: () => exit(),
///     ),
///   ],
/// )
/// ```
///
/// See also:
/// - [MenuItem] for individual menu items
/// - [MenuPopup] for the popup container
/// - [showDropdown] for displaying dropdowns programmatically
class DropdownMenu extends StatefulWidget {
  /// Opacity of the surface blur effect.
  ///
  /// If `null`, uses theme default.
  final double? surfaceOpacity;

  /// Amount of blur to apply to the surface.
  ///
  /// If `null`, uses theme default.
  final double? surfaceBlur;

  /// Menu items to display in the dropdown.
  ///
  /// Each item should be a [MenuItem] or similar menu component.
  final List<MenuItem> children;

  /// Creates a dropdown menu.
  ///
  /// Parameters:
  /// - [children]: Menu items to display (required)
  /// - [surfaceOpacity]: Backdrop blur opacity
  /// - [surfaceBlur]: Amount of surface blur
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
            surfaceOpacity: widget.surfaceOpacity ?? compTheme?.surfaceOpacity,
            surfaceBlur: widget.surfaceBlur ?? compTheme?.surfaceBlur,
            children: children,
          );
        },
        children: widget.children,
      ),
    );
  }
}
