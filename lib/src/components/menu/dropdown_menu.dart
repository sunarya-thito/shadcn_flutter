import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays a dropdown menu overlay with comprehensive customization options.
///
/// [showDropdown] creates a popup menu that appears relative to the current
/// context or a specified position. It provides extensive control over positioning,
/// appearance, behavior, and interaction patterns, making it suitable for
/// various dropdown scenarios including context menus, select widgets, and
/// custom popup interfaces.
///
/// The function returns an [OverlayCompleter] that can be used to control the
/// dropdown programmatically or await its result when the user makes a selection.
///
/// Key features:
/// - Flexible positioning with anchor alignment and offset control
/// - Configurable size constraints (width/height)
/// - Animation and transition customization
/// - Modal and non-modal display modes
/// - Automatic position inversion to stay within screen bounds
/// - Gesture handling with customizable outside tap behavior
/// - Integration with theme system for consistent styling
///
/// Type parameter [T] represents the type of value that can be returned
/// when the dropdown is dismissed with a selection.
///
/// Example:
/// ```dart
/// final result = await showDropdown<String>(
///   context: context,
///   builder: (context) => MenuContent(
///     children: [
///       MenuItem(child: Text('Option 1'), onPressed: () => Navigator.pop(context, 'option1')),
///       MenuItem(child: Text('Option 2'), onPressed: () => Navigator.pop(context, 'option2')),
///     ],
///   ),
///   alignment: Alignment.bottomLeft,
///   widthConstraint: PopoverConstraint.anchorMaxWidth,
/// );
/// if (result != null) {
///   print('Selected: $result');
/// }
/// ```
///
/// Parameters:
/// - [context]: The build context for overlay positioning and theming
/// - [builder]: Function that builds the dropdown content widget
/// - [position]: Optional absolute position override for the dropdown
/// - [anchorAlignment]: How the dropdown aligns relative to its anchor point
/// - [widthConstraint]: Constraint mode for dropdown width (flexible, fixed, etc.)
/// - [heightConstraint]: Constraint mode for dropdown height
/// - [alignment]: Default alignment when no position is specified
/// - [offset]: Additional offset from the calculated position
/// - [modal]: Whether the dropdown blocks interaction with underlying UI
/// - [consumeOutsideTaps]: Whether tapping outside dismisses the dropdown
/// - [follow]: Whether the dropdown follows anchor movement (e.g., during scroll)
/// - [allowInvertHorizontal]: Allow horizontal position flip to stay in bounds
/// - [allowInvertVertical]: Allow vertical position flip to stay in bounds
/// - [showDuration]: Animation duration for dropdown appearance
/// - [dismissDuration]: Animation duration for dropdown dismissal
///
/// Returns:
/// An [OverlayCompleter<T?>] that resolves when the dropdown is dismissed,
/// potentially with a selected value of type [T].
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

/// Data container for dropdown menu context and identification.
///
/// [DropdownMenuData] provides contextual information to widgets within
/// a dropdown menu, enabling them to access menu-specific functionality
/// and maintain proper relationships with the containing dropdown.
///
/// The [key] property serves as a unique identifier for the dropdown
/// instance, which can be used for focus management, animation coordination,
/// or programmatic control of the dropdown's lifecycle.
///
/// This data is typically provided through the [Data] inheritance system
/// and accessed by child widgets that need dropdown-specific context.
class DropdownMenuData {
  /// Unique identifier key for the dropdown menu instance.
  ///
  /// This [GlobalKey] serves as a stable reference to the dropdown menu
  /// and can be used for various purposes including focus management,
  /// animation targeting, or programmatic dropdown control.
  final GlobalKey key;

  /// Creates [DropdownMenuData] with the specified identifier key.
  ///
  /// The [key] parameter should be unique for each dropdown instance
  /// to ensure proper isolation and functionality.
  DropdownMenuData(this.key);
}

/// Theme configuration for [DropdownMenu] visual appearance and effects.
///
/// [DropdownMenuTheme] provides styling options for dropdown menus including
/// surface effects like opacity and blur that create modern glassmorphism
/// appearances. These properties integrate with the overall design system
/// to ensure consistent dropdown styling across the application.
///
/// The theme can be applied globally through [ComponentTheme] or used to
/// customize specific dropdown instances with unique visual treatments.
///
/// Example:
/// ```dart
/// ComponentTheme<DropdownMenuTheme>(
///   data: DropdownMenuTheme(
///     surfaceOpacity: 0.9,
///     surfaceBlur: 10.0,
///   ),
///   child: MyDropdownWidget(),
/// );
/// ```
class DropdownMenuTheme {
  /// Opacity level for the dropdown container background surface.
  ///
  /// Controls the transparency of the dropdown background, enabling
  /// glassmorphism effects where content behind the dropdown shows through.
  /// Values range from 0.0 (fully transparent) to 1.0 (fully opaque).
  /// When null, uses the default theme opacity.
  final double? surfaceOpacity;

  /// Blur intensity for the dropdown container background surface.
  ///
  /// Creates a frosted glass effect by blurring content behind the dropdown.
  /// Higher values produce more blur. When null, uses the default theme blur.
  /// Works in combination with [surfaceOpacity] for glassmorphism styling.
  final double? surfaceBlur;

  /// Creates a [DropdownMenuTheme] with optional surface effect customization.
  ///
  /// Both [surfaceOpacity] and [surfaceBlur] are optional and will fall back
  /// to theme defaults when null. Use these properties to create custom
  /// glassmorphism effects or solid dropdown appearances.
  ///
  /// Example:
  /// ```dart
  /// DropdownMenuTheme(
  ///   surfaceOpacity: 0.95,
  ///   surfaceBlur: 8.0,
  /// );
  /// ```
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
