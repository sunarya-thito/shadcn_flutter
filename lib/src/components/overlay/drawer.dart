import 'dart:async';
import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builder function signature for drawer content.
///
/// Parameters:
/// - [context]: build context for the drawer content
/// - [extraSize]: additional size available due to backdrop transforms
/// - [size]: total size constraints for the drawer
/// - [padding]: safe area padding to respect
/// - [stackIndex]: index in the drawer stack (for layered drawers)
typedef DrawerBuilder = Widget Function(BuildContext context, Size extraSize,
    Size size, EdgeInsets padding, int stackIndex);

/// Theme configuration for drawer and sheet overlays.
///
/// Defines visual properties for drawer and sheet components including
/// surface effects, drag handles, and barrier appearance.
///
/// Features:
/// - Surface opacity and blur effects
/// - Customizable barrier colors
/// - Drag handle appearance control
/// - Consistent theming across drawer types
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     DrawerTheme: DrawerTheme(
///       surfaceOpacity: 0.9,
///       barrierColor: Colors.black54,
///       showDragHandle: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
class DrawerTheme {
  /// Surface opacity for backdrop effects.
  final double? surfaceOpacity;

  /// Surface blur intensity for backdrop effects.
  final double? surfaceBlur;

  /// Color of the barrier behind the drawer.
  final Color? barrierColor;

  /// Whether to display the drag handle for draggable drawers.
  final bool? showDragHandle;

  /// Size of the drag handle when displayed.
  final Size? dragHandleSize;

  /// Creates a [DrawerTheme].
  ///
  /// All parameters are optional and will use system defaults when null.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (double?, optional): opacity for backdrop surface effects
  /// - [surfaceBlur] (double?, optional): blur intensity for backdrop effects
  /// - [barrierColor] (Color?, optional): color of the modal barrier
  /// - [showDragHandle] (bool?, optional): whether to show drag handles
  /// - [dragHandleSize] (Size?, optional): size of the drag handle
  ///
  /// Example:
  /// ```dart
  /// const DrawerTheme(
  ///   surfaceOpacity: 0.95,
  ///   showDragHandle: true,
  ///   barrierColor: Color.fromRGBO(0, 0, 0, 0.7),
  /// )
  /// ```
  const DrawerTheme({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.showDragHandle,
    this.dragHandleSize,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (`ValueGetter<double?>?`, optional): New surface opacity.
  /// - [surfaceBlur] (`ValueGetter<double?>?`, optional): New surface blur amount.
  /// - [barrierColor] (`ValueGetter<Color?>?`, optional): New barrier color.
  /// - [showDragHandle] (`ValueGetter<bool?>?`, optional): New show drag handle setting.
  /// - [dragHandleSize] (`ValueGetter<Size?>?`, optional): New drag handle size.
  ///
  /// Returns: A new [DrawerTheme] with updated properties.
  DrawerTheme copyWith({
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<Color?>? barrierColor,
    ValueGetter<bool?>? showDragHandle,
    ValueGetter<Size?>? dragHandleSize,
  }) {
    return DrawerTheme(
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      barrierColor: barrierColor == null ? this.barrierColor : barrierColor(),
      showDragHandle:
          showDragHandle == null ? this.showDragHandle : showDragHandle(),
      dragHandleSize:
          dragHandleSize == null ? this.dragHandleSize : dragHandleSize(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is DrawerTheme &&
      other.surfaceOpacity == surfaceOpacity &&
      other.surfaceBlur == surfaceBlur &&
      other.barrierColor == barrierColor &&
      other.showDragHandle == showDragHandle &&
      other.dragHandleSize == dragHandleSize;

  @override
  int get hashCode => Object.hash(surfaceOpacity, surfaceBlur, barrierColor,
      showDragHandle, dragHandleSize);

  @override
  String toString() =>
      'DrawerTheme(surfaceOpacity: $surfaceOpacity, surfaceBlur: $surfaceBlur, barrierColor: $barrierColor, showDragHandle: $showDragHandle, dragHandleSize: $dragHandleSize)';
}

/// Opens a drawer overlay with comprehensive customization options.
///
/// Creates a modal drawer that slides in from the specified position with
/// draggable interaction, backdrop transformation, and proper theme integration.
/// Returns a completer that can be used to control the drawer lifecycle.
///
/// Features:
/// - Configurable slide-in positions (left, right, top, bottom)
/// - Draggable interaction with gesture support
/// - Backdrop transformation and scaling effects
/// - Safe area handling and proper theming
/// - Dismissible barriers and custom backdrop builders
///
/// Parameters:
/// - [context] (BuildContext, required): build context for overlay creation
/// - [builder] (WidgetBuilder, required): function that builds drawer content
/// - [position] (OverlayPosition, required): side from which drawer slides in
/// - [expands] (bool, default: false): whether drawer should expand to fill available space
/// - [draggable] (bool, default: true): whether drawer can be dragged to dismiss
/// - [barrierDismissible] (bool, default: true): whether tapping barrier dismisses drawer
/// - [backdropBuilder] (WidgetBuilder?, optional): custom backdrop builder
/// - [useSafeArea] (bool, default: true): whether to respect device safe areas
/// - [showDragHandle] (bool?, optional): whether to show drag handle
/// - [borderRadius] (BorderRadiusGeometry?, optional): corner radius for drawer
/// - [dragHandleSize] (Size?, optional): size of the drag handle
/// - [transformBackdrop] (bool, default: true): whether to scale backdrop
/// - [surfaceOpacity] (double?, optional): opacity for surface effects
/// - [surfaceBlur] (double?, optional): blur intensity for surface effects
/// - [barrierColor] (Color?, optional): color of the modal barrier
/// - [animationController] (AnimationController?, optional): custom animation controller
/// - [autoOpen] (bool, default: true): whether to automatically open on creation
/// - [constraints] (BoxConstraints?, optional): size constraints for drawer
/// - [alignment] (AlignmentGeometry?, optional): alignment within constraints
///
/// Returns:
/// A [DrawerOverlayCompleter] that provides control over the drawer lifecycle.
///
/// Example:
/// ```dart
/// final completer = openDrawerOverlay<String>(
///   context: context,
///   position: OverlayPosition.left,
///   builder: (context) => DrawerContent(),
///   draggable: true,
///   barrierDismissible: true,
/// );
/// final result = await completer.future;
/// ```
DrawerOverlayCompleter<T?> openDrawerOverlay<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required OverlayPosition position,
  bool expands = false,
  bool draggable = true,
  bool barrierDismissible = true,
  WidgetBuilder? backdropBuilder,
  bool useSafeArea = true,
  bool? showDragHandle,
  BorderRadiusGeometry? borderRadius,
  Size? dragHandleSize,
  bool transformBackdrop = true,
  double? surfaceOpacity,
  double? surfaceBlur,
  Color? barrierColor,
  AnimationController? animationController,
  bool autoOpen = true,
  BoxConstraints? constraints,
  AlignmentGeometry? alignment,
}) {
  final theme = ComponentTheme.maybeOf<DrawerTheme>(context);
  showDragHandle ??= theme?.showDragHandle ?? true;
  surfaceOpacity ??= theme?.surfaceOpacity;
  surfaceBlur ??= theme?.surfaceBlur;
  barrierColor ??= theme?.barrierColor;
  dragHandleSize ??= theme?.dragHandleSize;
  return openRawDrawer<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    backdropBuilder: backdropBuilder,
    useSafeArea: useSafeArea,
    transformBackdrop: transformBackdrop,
    animationController: animationController,
    autoOpen: autoOpen,
    constraints: constraints,
    alignment: alignment,
    builder: (context, extraSize, size, padding, stackIndex) {
      return DrawerWrapper(
        position: position,
        expands: expands,
        draggable: draggable,
        extraSize: extraSize,
        size: size,
        showDragHandle: showDragHandle ?? true,
        dragHandleSize: dragHandleSize,
        padding: padding,
        borderRadius: borderRadius,
        surfaceOpacity: surfaceOpacity,
        surfaceBlur: surfaceBlur,
        barrierColor: barrierColor,
        stackIndex: stackIndex,
        child: Builder(builder: (context) {
          return builder(context);
        }),
      );
    },
    position: position,
  );
}

/// Opens a sheet overlay with minimal styling and full-screen expansion.
///
/// Creates a sheet overlay that slides in from the specified position,
/// typically used for bottom sheets or side panels. Unlike drawers,
/// sheets don't transform the backdrop and have minimal decoration.
///
/// Features:
/// - Full-screen expansion with edge-to-edge content
/// - Minimal styling and decoration
/// - Optional drag interaction
/// - Safe area integration
/// - Barrier dismissal support
///
/// Parameters:
/// - [context] (BuildContext, required): build context for overlay creation
/// - [builder] (WidgetBuilder, required): function that builds sheet content
/// - [position] (OverlayPosition, required): side from which sheet slides in
/// - [barrierDismissible] (bool, default: true): whether tapping barrier dismisses sheet
/// - [transformBackdrop] (bool, default: false): whether to transform backdrop
/// - [backdropBuilder] (WidgetBuilder?, optional): custom backdrop builder
/// - [barrierColor] (Color?, optional): color of the modal barrier
/// - [draggable] (bool, default: false): whether sheet can be dragged to dismiss
/// - [animationController] (AnimationController?, optional): custom animation controller
/// - [autoOpen] (bool, default: true): whether to automatically open on creation
/// - [constraints] (BoxConstraints?, optional): size constraints for sheet
/// - [alignment] (AlignmentGeometry?, optional): alignment within constraints
///
/// Returns:
/// A [DrawerOverlayCompleter] that provides control over the sheet lifecycle.
///
/// Example:
/// ```dart
/// final completer = openSheetOverlay<bool>(
///   context: context,
///   position: OverlayPosition.bottom,
///   builder: (context) => BottomSheetContent(),
///   draggable: true,
/// );
/// ```
DrawerOverlayCompleter<T?> openSheetOverlay<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required OverlayPosition position,
  bool barrierDismissible = true,
  bool transformBackdrop = false,
  WidgetBuilder? backdropBuilder,
  Color? barrierColor,
  bool draggable = false,
  AnimationController? animationController,
  bool autoOpen = true,
  BoxConstraints? constraints,
  AlignmentGeometry? alignment,
}) {
  final theme = ComponentTheme.maybeOf<DrawerTheme>(context);
  barrierColor ??= theme?.barrierColor;
  return openRawDrawer<T>(
    context: context,
    transformBackdrop: transformBackdrop,
    barrierDismissible: barrierDismissible,
    useSafeArea: false, // handled by the sheet itself
    animationController: animationController,
    backdropBuilder: backdropBuilder,
    autoOpen: autoOpen,
    constraints: constraints,
    alignment: alignment,
    builder: (context, extraSize, size, padding, stackIndex) {
      return SheetWrapper(
        position: position,
        expands: true,
        draggable: draggable,
        extraSize: extraSize,
        size: size,
        padding: padding,
        barrierColor: barrierColor,
        stackIndex: stackIndex,
        child: Builder(builder: (context) {
          return builder(context);
        }),
      );
    },
    position: position,
  );
}

/// Opens a drawer and returns a future that completes when dismissed.
///
/// Convenience function that opens a drawer overlay and returns the future
/// directly, suitable for use with async/await patterns.
///
/// Returns:
/// A [Future] that completes with the result when the drawer is dismissed.
///
/// Example:
/// ```dart
/// final result = await openDrawer<String>(
///   context: context,
///   position: OverlayPosition.left,
///   builder: (context) => MyDrawerContent(),
/// );
/// ```
Future<T?> openDrawer<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required OverlayPosition position,
  bool expands = false,
  bool draggable = true,
  bool barrierDismissible = true,
  WidgetBuilder? backdropBuilder,
  bool useSafeArea = true,
  bool? showDragHandle,
  BorderRadiusGeometry? borderRadius,
  Size? dragHandleSize,
  bool transformBackdrop = true,
  double? surfaceOpacity,
  double? surfaceBlur,
  Color? barrierColor,
  AnimationController? animationController,
  BoxConstraints? constraints,
  AlignmentGeometry? alignment,
}) {
  return openDrawerOverlay<T>(
    context: context,
    builder: builder,
    position: position,
    expands: expands,
    draggable: draggable,
    barrierDismissible: barrierDismissible,
    backdropBuilder: backdropBuilder,
    useSafeArea: useSafeArea,
    showDragHandle: showDragHandle,
    borderRadius: borderRadius,
    dragHandleSize: dragHandleSize,
    transformBackdrop: transformBackdrop,
    surfaceOpacity: surfaceOpacity,
    surfaceBlur: surfaceBlur,
    barrierColor: barrierColor,
    animationController: animationController,
    constraints: constraints,
    alignment: alignment,
  ).future;
}

/// Opens a sheet and returns a future that completes when dismissed.
///
/// Convenience function that opens a sheet overlay and returns the future
/// directly, suitable for use with async/await patterns.
///
/// Returns:
/// A [Future] that completes with the result when the sheet is dismissed.
///
/// Example:
/// ```dart
/// final accepted = await openSheet<bool>(
///   context: context,
///   position: OverlayPosition.bottom,
///   builder: (context) => ConfirmationSheet(),
/// );
/// ```
Future<T?> openSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required OverlayPosition position,
  bool barrierDismissible = true,
  bool transformBackdrop = false,
  Color? barrierColor,
  bool draggable = false,
  AnimationController? animationController,
  WidgetBuilder? backdropBuilder,
  BoxConstraints? constraints,
  AlignmentGeometry? alignment,
}) {
  return openSheetOverlay<T>(
    context: context,
    builder: builder,
    position: position,
    barrierDismissible: barrierDismissible,
    transformBackdrop: transformBackdrop,
    barrierColor: barrierColor,
    draggable: draggable,
    animationController: animationController,
    backdropBuilder: backdropBuilder,
    constraints: constraints,
    alignment: alignment,
  ).future;
}

/// Internal wrapper widget for drawer/sheet rendering.
///
/// Manages the visual presentation and interaction behavior of drawer overlays.
/// Handles sizing, positioning, drag interactions, and animations.
class DrawerWrapper extends StatefulWidget {
  /// Position of the drawer on screen.
  final OverlayPosition position;

  /// Content widget displayed in the drawer.
  final Widget child;

  /// Whether the drawer expands to fill available space.
  final bool expands;

  /// Whether the drawer can be dragged to resize or dismiss.
  final bool draggable;

  /// Additional size beyond the content size.
  final Size extraSize;

  /// Size of the drawer.
  final Size size;

  /// Whether to show the drag handle.
  final bool showDragHandle;

  /// Border radius for the drawer.
  final BorderRadiusGeometry? borderRadius;

  /// Size of the drag handle.
  final Size? dragHandleSize;

  /// Internal padding of the drawer content.
  final EdgeInsets padding;

  /// Surface opacity for the drawer background.
  final double? surfaceOpacity;

  /// Surface blur amount for the drawer background.
  final double? surfaceBlur;

  /// Color of the barrier behind the drawer.
  final Color? barrierColor;

  /// Z-index for stacking multiple drawers.
  final int stackIndex;

  /// Gap before the drag handle.
  final double? gapBeforeDragger;

  /// Gap after the drag handle.
  final double? gapAfterDragger;

  /// Optional animation controller for custom animations.
  final AnimationController? animationController;

  /// Size constraints for the drawer.
  final BoxConstraints? constraints;

  /// Alignment of the drawer content.
  final AlignmentGeometry? alignment;

  /// Creates a [DrawerWrapper].
  const DrawerWrapper({
    super.key,
    required this.position,
    required this.child,
    this.expands = false,
    this.draggable = true,
    this.extraSize = Size.zero,
    required this.size,
    this.showDragHandle = true,
    this.borderRadius,
    this.dragHandleSize,
    this.padding = EdgeInsets.zero,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.gapBeforeDragger,
    this.gapAfterDragger,
    required this.stackIndex,
    this.animationController,
    this.constraints,
    this.alignment,
  });

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ControlledAnimation _extraOffset;

  OverlayPosition get resolvedPosition {
    var position = widget.position;
    if (position == OverlayPosition.start) {
      return Directionality.of(context) == TextDirection.ltr
          ? OverlayPosition.left
          : OverlayPosition.right;
    }
    if (position == OverlayPosition.end) {
      return Directionality.of(context) == TextDirection.ltr
          ? OverlayPosition.right
          : OverlayPosition.left;
    }
    return position;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.animationController ??
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 350),
        );
    _extraOffset = ControlledAnimation(_controller);
  }

  double? get expandingHeight {
    switch (resolvedPosition) {
      case OverlayPosition.left:
      case OverlayPosition.right:
        return double.infinity;
      default:
        return null;
    }
  }

  double? get expandingWidth {
    switch (resolvedPosition) {
      case OverlayPosition.top:
      case OverlayPosition.bottom:
        return double.infinity;
      default:
        return null;
    }
  }

  Widget buildDraggableBar(ThemeData theme) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
      case OverlayPosition.right:
        return Container(
          width: widget.dragHandleSize?.width ?? 6 * theme.scaling,
          height: widget.dragHandleSize?.height ?? 100 * theme.scaling,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: theme.borderRadiusXxl,
          ),
        );
      case OverlayPosition.top:
      case OverlayPosition.bottom:
        return Container(
          width: widget.dragHandleSize?.width ?? 100 * theme.scaling,
          height: widget.dragHandleSize?.height ?? 6 * theme.scaling,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: theme.borderRadiusXxl,
          ),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  Size getSize(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.hasSize ?? false
        ? renderBox?.size ?? widget.size
        : widget.size;
  }

  Widget buildDraggable(BuildContext context, ControlledAnimation? controlled,
      Widget child, ThemeData theme) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.width;
            double newValue = controlled.value + increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onHorizontalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                  animation: _extraOffset,
                  builder: (context, child) {
                    return Gap(
                        widget.extraSize.width + _extraOffset.value.max(0));
                  }),
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                        scaleX:
                            1 + _extraOffset.value / getSize(context).width / 4,
                        alignment: Alignment.centerRight,
                        child: child);
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              if (widget.showDragHandle) ...[
                Gap(widget.gapAfterDragger ?? 16 * theme.scaling),
                buildDraggableBar(theme),
                Gap(widget.gapBeforeDragger ?? 12 * theme.scaling),
              ],
            ],
          ),
        );
      case OverlayPosition.right:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.width;
            double newValue = controlled.value - increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  -details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onHorizontalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showDragHandle) ...[
                Gap(widget.gapBeforeDragger ?? 12 * theme.scaling),
                buildDraggableBar(theme),
                Gap(widget.gapAfterDragger ?? 16 * theme.scaling),
              ],
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                        scaleX:
                            1 + _extraOffset.value / getSize(context).width / 4,
                        alignment: Alignment.centerLeft,
                        child: child);
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              AnimatedBuilder(
                  animation: _extraOffset,
                  builder: (context, child) {
                    return Gap(
                        widget.extraSize.width + _extraOffset.value.max(0));
                  }),
            ],
          ),
        );
      case OverlayPosition.top:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.height;
            double newValue = controlled.value + increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onVerticalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                  animation: _extraOffset,
                  builder: (context, child) {
                    return Gap(
                        widget.extraSize.height + _extraOffset.value.max(0));
                  }),
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                        scaleY: 1 +
                            _extraOffset.value / getSize(context).height / 4,
                        alignment: Alignment.bottomCenter,
                        child: child);
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              if (widget.showDragHandle) ...[
                Gap(widget.gapAfterDragger ?? 16 * theme.scaling),
                buildDraggableBar(theme),
                Gap(widget.gapBeforeDragger ?? 12 * theme.scaling),
              ],
            ],
          ),
        );
      case OverlayPosition.bottom:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            if (controlled == null) {
              return;
            }
            final size = getSize(context);
            final increment = details.primaryDelta! / size.height;
            double newValue = controlled.value - increment;
            if (newValue < 0) {
              newValue = 0;
            }
            if (newValue > 1) {
              _extraOffset.value +=
                  -details.primaryDelta! / max(_extraOffset.value, 1);
              newValue = 1;
            }
            controlled.value = newValue;
          },
          onVerticalDragEnd: (details) {
            if (controlled == null) {
              return;
            }
            _extraOffset.forward(0, Curves.easeOut);
            if (controlled.value + _extraOffset.value < 0.5) {
              controlled.forward(0, Curves.easeOut).then((value) {
                closeDrawer(context);
              });
            } else {
              controlled.forward(1, Curves.easeOut);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showDragHandle) ...[
                Gap(widget.gapBeforeDragger ?? 12 * theme.scaling),
                buildDraggableBar(theme),
                Gap(widget.gapAfterDragger ?? 16 * theme.scaling),
              ],
              Flexible(
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.scale(
                        scaleY: 1 +
                            _extraOffset.value / getSize(context).height / 4,
                        alignment: Alignment.topCenter,
                        child: child);
                  },
                  animation: _extraOffset,
                  child: child,
                ),
              ),
              AnimatedBuilder(
                  animation: _extraOffset,
                  builder: (context, child) {
                    return Gap(
                        widget.extraSize.height + _extraOffset.value.max(0));
                  }),
            ],
          ),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  @override
  void didUpdateWidget(covariant DrawerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationController != oldWidget.animationController) {
      if (oldWidget.animationController == null) {
        _controller.dispose();
      }
      _controller = widget.animationController ??
          AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 350),
          );
    }
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Border getBorder(ThemeData theme) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        // top, right, bottom
        return Border(
          right: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.right:
        // top, left, bottom
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.top:
        // left, right, bottom
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          right: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.bottom:
        // left, right, top
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          right: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  BorderRadiusGeometry getBorderRadius(double radius) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case OverlayPosition.right:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      case OverlayPosition.top:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case OverlayPosition.bottom:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  BoxDecoration getDecoration(ThemeData theme) {
    var border = getBorder(theme);
    // according to the design, the border radius is 10
    // seems to be a fixed value
    var borderRadius = widget.borderRadius ?? getBorderRadius(theme.radiusXxl);
    var backgroundColor = theme.colorScheme.background;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    if (surfaceOpacity != null && surfaceOpacity < 1) {
      if (widget.stackIndex == 0) {
        // the top sheet should have a higher opacity to prevent
        // visual bleeding from the main content
        surfaceOpacity = surfaceOpacity * 1.25;
      }
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    return BoxDecoration(
      borderRadius: borderRadius,
      color: backgroundColor,
      border: border,
    );
  }

  Widget buildChild(BuildContext context) {
    return widget.child;
  }

  EdgeInsets buildPadding(BuildContext context) {
    return widget.padding;
  }

  EdgeInsets buildMargin(BuildContext context) {
    return EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<_MountedOverlayEntryData>(context);
    final animation = data?.state._controlledAnimation;
    final theme = Theme.of(context);
    var surfaceBlur = widget.surfaceBlur ?? theme.surfaceBlur;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    var borderRadius = widget.borderRadius ?? getBorderRadius(theme.radiusXxl);
    Widget container = Container(
      width: widget.expands ? expandingWidth : null,
      height: widget.expands ? expandingHeight : null,
      decoration: getDecoration(theme),
      padding: buildPadding(context),
      margin: buildMargin(context),
      child: widget.draggable
          ? buildDraggable(context, animation, buildChild(context), theme)
          : buildChild(context),
    );

    if (widget.constraints != null) {
      container = ConstrainedBox(
        constraints: widget.constraints!,
        child: container,
      );
    }

    if (widget.alignment != null) {
      container = Align(
        alignment: widget.alignment!,
        child: container,
      );
    }

    if (surfaceBlur != null && surfaceBlur > 0) {
      container = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: getBorderRadius(theme.radiusXxl),
        child: container,
      );
    }
    var barrierColor = widget.barrierColor ?? Colors.black.scaleAlpha(0.8);
    if (animation != null) {
      if (widget.stackIndex != 0) {
        // weaken the barrier color for the upper sheets
        barrierColor = barrierColor.scaleAlpha(0.75);
      }
      container = ModalBackdrop(
        surfaceClip: ModalBackdrop.shouldClipSurface(surfaceOpacity),
        borderRadius: borderRadius,
        barrierColor: barrierColor,
        fadeAnimation: animation,
        padding: buildMargin(context),
        child: container,
      );
    }
    return container;
  }
}

/// Closes the currently open sheet overlay.
///
/// Dismisses the active sheet by closing the drawer. Sheets are drawers
/// without backdrop transformation.
///
/// Parameters:
/// - [context] (`BuildContext`, required): Build context.
///
/// Returns: `Future<void>` that completes when sheet is closed.
Future<void> closeSheet(BuildContext context) {
  // sheet is just a drawer with no backdrop transformation
  return closeDrawer(context);
}

/// Wrapper widget for sheet overlays.
///
/// Extends [DrawerWrapper] with sheet-specific defaults (no drag, no expansion).
/// Sheets are simplified drawers without backdrop transformation.
class SheetWrapper extends DrawerWrapper {
  /// Creates a [SheetWrapper].
  const SheetWrapper({
    super.key,
    required super.position,
    required super.child,
    required super.size,
    required super.stackIndex,
    super.draggable = false,
    super.expands = false,
    super.extraSize = Size.zero,
    super.padding,
    super.surfaceBlur,
    super.surfaceOpacity,
    super.barrierColor,
    super.gapBeforeDragger,
    super.gapAfterDragger,
    super.constraints,
    super.alignment,
  });

  @override
  State<DrawerWrapper> createState() => _SheetWrapperState();
}

class _SheetWrapperState extends _DrawerWrapperState {
  @override
  Border getBorder(ThemeData theme) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        return Border(right: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.right:
        return Border(left: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.top:
        return Border(bottom: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.bottom:
        return Border(top: BorderSide(color: theme.colorScheme.border));
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  @override
  EdgeInsets buildMargin(BuildContext context) {
    var mediaPadding = MediaQuery.paddingOf(context);
    double marginTop = 0;
    double marginBottom = 0;
    double marginLeft = 0;
    double marginRight = 0;
    switch (resolvedPosition) {
      case OverlayPosition.left:
        marginRight = mediaPadding.right;
        break;
      case OverlayPosition.right:
        marginLeft = mediaPadding.left;
        break;
      case OverlayPosition.top:
        marginBottom = mediaPadding.bottom;
        break;
      case OverlayPosition.bottom:
        marginTop = mediaPadding.top;
        break;
      default:
        throw UnimplementedError('Unknown position');
    }
    return super.buildMargin(context) +
        EdgeInsets.only(
          top: marginTop,
          bottom: marginBottom,
          left: marginLeft,
          right: marginRight,
        );
  }

  @override
  Widget buildChild(BuildContext context) {
    var mediaPadding = MediaQuery.paddingOf(context);
    double paddingTop = 0;
    double paddingBottom = 0;
    double paddingLeft = 0;
    double paddingRight = 0;
    switch (resolvedPosition) {
      case OverlayPosition.left:
        paddingTop = mediaPadding.top;
        paddingBottom = mediaPadding.bottom;
        paddingLeft = mediaPadding.left;
        break;
      case OverlayPosition.right:
        paddingTop = mediaPadding.top;
        paddingBottom = mediaPadding.bottom;
        paddingRight = mediaPadding.right;
        break;
      case OverlayPosition.top:
        paddingLeft = mediaPadding.left;
        paddingRight = mediaPadding.right;
        paddingTop = mediaPadding.top;
        break;
      case OverlayPosition.bottom:
        paddingLeft = mediaPadding.left;
        paddingRight = mediaPadding.right;
        paddingBottom = mediaPadding.bottom;
        break;
      default:
        throw UnimplementedError('Unknown position');
    }
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: super.buildChild(context),
    );
  }

  @override
  BorderRadiusGeometry getBorderRadius(double radius) {
    return BorderRadius.zero;
  }

  @override
  BoxDecoration getDecoration(ThemeData theme) {
    var backgroundColor = theme.colorScheme.background;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    if (surfaceOpacity != null && surfaceOpacity < 1) {
      if (widget.stackIndex == 0) {
        // the top sheet should have a higher opacity to prevent
        // visual bleeding from the main content
        surfaceOpacity = surfaceOpacity * 1.25;
      }
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    return BoxDecoration(
      color: backgroundColor,
      border: getBorder(theme),
    );
  }
}

/// Position for overlay components like drawers and sheets.
enum OverlayPosition {
  /// Positioned on the left edge
  left,

  /// Positioned on the right edge
  right,

  /// Positioned on the top edge
  top,

  /// Positioned on the bottom edge
  bottom,

  /// Positioned at the start (left in LTR, right in RTL)
  start,

  /// Positioned at the end (right in LTR, left in RTL)
  end,
}

/// Scale factor for backdrop transform when drawer is open.
///
/// Constant value of 0.95 creates a subtle zoom-out effect on the
/// background content when overlays appear.
const kBackdropScaleDown = 0.95;

/// Data class containing backdrop transformation information.
///
/// Holds the size difference needed to scale and position backdrop
/// content when overlays are displayed.
class BackdropTransformData {
  /// The difference in size between original and transformed backdrop.
  final Size sizeDifference;

  /// Creates backdrop transform data.
  ///
  /// Parameters:
  /// - [sizeDifference] (Size, required): Size difference for transform
  BackdropTransformData(this.sizeDifference);
}

class _DrawerOverlayWrapper extends StatefulWidget {
  final Widget child;
  final Completer completer;
  const _DrawerOverlayWrapper({
    required this.child,
    required this.completer,
  });

  @override
  State<_DrawerOverlayWrapper> createState() => _DrawerOverlayWrapperState();
}

class _DrawerOverlayWrapperState extends State<_DrawerOverlayWrapper>
    with OverlayHandlerStateMixin {
  @override
  Widget build(BuildContext context) {
    return Data<OverlayHandlerStateMixin>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  Future<void> close([bool immediate = false]) {
    if (immediate) {
      widget.completer.complete();
      return widget.completer.future;
    }
    return closeDrawer(context);
  }

  @override
  void closeLater() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          closeDrawer(context);
        } else {
          widget.completer.complete();
        }
      });
    }
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    return closeDrawer(context, value);
  }
}

/// Opens a raw drawer overlay with full customization.
///
/// Low-level function for creating custom drawer overlays. Provides complete
/// control over drawer positioning, appearance, and behavior.
///
/// Parameters:
/// - [key] (`Key?`, optional): Widget key.
/// - [context] (`BuildContext`, required): Build context.
/// - [builder] (`DrawerBuilder`, required): Drawer content builder.
/// - [position] (`OverlayPosition`, required): Drawer position on screen.
/// - [transformBackdrop] (`bool`, default: `true`): Whether to transform backdrop.
/// - [useRootDrawerOverlay] (`bool`, default: `true`): Use root overlay.
/// - [modal] (`bool`, default: `true`): Whether drawer is modal.
/// - [barrierColor] (`Color?`, optional): Barrier color.
/// - [barrierDismissible] (`bool`, default: `true`): Dismissible by tapping barrier.
/// - [backdropBuilder] (`WidgetBuilder?`, optional): Custom backdrop builder.
/// - [useSafeArea] (`bool`, default: `true`): Respect safe area.
/// - [animationController] (`AnimationController?`, optional): Custom animation.
/// - [autoOpen] (`bool`, default: `true`): Auto-open on creation.
/// - [constraints] (`BoxConstraints?`, optional): Size constraints.
/// - [alignment] (`AlignmentGeometry?`, optional): Content alignment.
///
/// Returns: `DrawerOverlayCompleter<T?>` for managing the drawer lifecycle.
DrawerOverlayCompleter<T?> openRawDrawer<T>({
  Key? key,
  required BuildContext context,
  required DrawerBuilder builder,
  required OverlayPosition position,
  bool transformBackdrop = true,
  bool useRootDrawerOverlay = true,
  bool modal = true,
  Color? barrierColor,
  bool barrierDismissible = true,
  WidgetBuilder? backdropBuilder,
  bool useSafeArea = true,
  AnimationController? animationController,
  bool autoOpen = true,
  BoxConstraints? constraints,
  AlignmentGeometry? alignment,
}) {
  DrawerLayerData? parentLayer =
      DrawerOverlay.maybeFind(context, useRootDrawerOverlay);
  CapturedThemes? themes;
  CapturedData? data;
  if (parentLayer != null) {
    themes =
        InheritedTheme.capture(from: context, to: parentLayer.overlay.context);
    data = Data.capture(from: context, to: parentLayer.overlay.context);
  } else {
    parentLayer =
        DrawerOverlay.maybeFindMessenger(context, useRootDrawerOverlay);
  }
  assert(parentLayer != null, 'No DrawerOverlay found in the widget tree');
  final completer = Completer<T?>();
  final entry = DrawerOverlayEntry(
    animationController: animationController,
    autoOpen: autoOpen,
    builder: (context, extraSize, size, padding, stackIndex) {
      return _DrawerOverlayWrapper(
        completer: completer,
        child: Builder(builder: (context) {
          return builder(context, extraSize, size, padding, stackIndex);
        }),
      );
    },
    modal: modal,
    data: data,
    barrierDismissible: barrierDismissible,
    useSafeArea: useSafeArea,
    constraints: constraints,
    alignment: alignment,
    backdropBuilder: transformBackdrop
        ? (context, child, animation, stackIndex) {
            final theme = Theme.of(context);
            final existingData = Data.maybeOf<BackdropTransformData>(context);
            return LayoutBuilder(builder: (context, constraints) {
              return stackIndex == 0
                  ? AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        Size size = constraints.biggest;
                        double scale =
                            1 - (1 - kBackdropScaleDown) * animation.value;
                        Size sizeAfterScale = Size(
                          size.width * scale,
                          size.height * scale,
                        );
                        var extraSize = Size(
                          size.width -
                              sizeAfterScale.width / kBackdropScaleDown,
                          size.height -
                              sizeAfterScale.height / kBackdropScaleDown,
                        );
                        if (existingData != null) {
                          extraSize = Size(
                            extraSize.width +
                                existingData.sizeDifference.width /
                                    kBackdropScaleDown,
                            extraSize.height +
                                existingData.sizeDifference.height /
                                    kBackdropScaleDown,
                          );
                        }
                        return Data.inherit(
                          data: BackdropTransformData(extraSize),
                          child: Transform.scale(
                            scale: scale,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  theme.radiusXxl * animation.value),
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: child,
                    )
                  : AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        Size size = constraints.biggest;
                        double scale =
                            1 - (1 - kBackdropScaleDown) * animation.value;
                        Size sizeAfterScale = Size(
                          size.width * scale,
                          size.height * scale,
                        );
                        var extraSize = Size(
                          size.width - sizeAfterScale.width,
                          size.height - sizeAfterScale.height,
                        );
                        if (existingData != null) {
                          extraSize = Size(
                            extraSize.width +
                                existingData.sizeDifference.width /
                                    kBackdropScaleDown,
                            extraSize.height +
                                existingData.sizeDifference.height /
                                    kBackdropScaleDown,
                          );
                        }
                        return Data.inherit(
                          data: BackdropTransformData(extraSize),
                          child: Transform.scale(
                            scale: scale,
                            child: child,
                          ),
                        );
                      },
                      child: child,
                    );
            });
          }
        : (context, child, animation, stackIndex) => child,
    barrierBuilder: (context, child, animation, stackIndex) {
      if (stackIndex > 0) {
        if (!transformBackdrop) {
          return null;
        }
      }
      return Positioned(
        top: -9999,
        left: -9999,
        right: -9999,
        bottom: -9999,
        child: FadeTransition(
          opacity: animation,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return IgnorePointer(
                ignoring: animation.status != AnimationStatus.completed,
                child: child!,
              );
            },
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: barrierDismissible ? () => closeDrawer(context) : null,
              child: Container(
                child: backdropBuilder?.call(context),
              ),
            ),
          ),
        ),
      );
    },
    themes: themes,
    completer: completer,
    position: position,
  );
  final overlay = parentLayer!.overlay;
  overlay.addEntry(entry);
  completer.future.whenComplete(() {
    overlay.removeEntry(entry);
  });
  return DrawerOverlayCompleter<T?>(entry);
}

class _MountedOverlayEntryData {
  final DrawerEntryWidgetState state;

  _MountedOverlayEntryData(this.state);
}

/// Closes the currently open drawer overlay.
///
/// Dismisses the active drawer from the overlay stack. Optionally returns
/// a result value to the code that opened the drawer.
///
/// Parameters:
/// - [context] (`BuildContext`, required): Build context from within the drawer.
/// - [result] (`T?`, optional): Optional result to return.
///
/// Returns: `Future<void>` that completes when drawer is closed.
Future<void> closeDrawer<T>(BuildContext context, [T? result]) {
  final data = Data.maybeOf<_MountedOverlayEntryData>(context);
  assert(data != null, 'No DrawerEntryWidget found in the widget tree');
  return data!.state.close(result);
}

/// Data class representing a drawer overlay layer in the hierarchy.
///
/// Tracks the drawer overlay state and its parent layer, enabling nested
/// drawer management and size computation across the layer stack.
class DrawerLayerData {
  /// The drawer overlay state for this layer.
  final DrawerOverlayState overlay;

  /// The parent drawer layer, null if this is the root layer.
  final DrawerLayerData? parent;

  /// Creates drawer layer data.
  ///
  /// Parameters:
  /// - [overlay] (DrawerOverlayState, required): Overlay state for this layer
  /// - [parent] (DrawerLayerData?): Parent layer in the hierarchy
  const DrawerLayerData(this.overlay, this.parent);

  /// Computes the size of this drawer layer.
  ///
  /// Delegates to the overlay state to calculate the layer dimensions.
  ///
  /// Returns the computed size or null if not available.
  Size? computeSize() {
    return overlay.computeSize();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DrawerLayerData &&
        other.overlay == overlay &&
        other.parent == parent;
  }

  @override
  int get hashCode {
    return overlay.hashCode ^ parent.hashCode;
  }
}

/// Widget that manages drawer overlay layers.
///
/// Provides a container for drawer overlays, managing their lifecycle and
/// hierarchical relationships. Supports nested drawers through layer data
/// propagation.
///
/// Example:
/// ```dart
/// DrawerOverlay(
///   child: MyAppContent(),
/// )
/// ```
class DrawerOverlay extends StatefulWidget {
  /// Child widget displayed under the overlay layer.
  final Widget child;

  /// Creates a drawer overlay.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content widget
  const DrawerOverlay({super.key, required this.child});

  @override
  State<DrawerOverlay> createState() => DrawerOverlayState();

  /// Finds the drawer layer data from the widget tree.
  ///
  /// Searches up the widget tree for the nearest [DrawerLayerData].
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFind(BuildContext context, [bool root = false]) {
    var data = Data.maybeFind<DrawerLayerData>(context);
    if (root) {
      while (data?.parent != null) {
        data = data!.parent;
      }
    }
    return data;
  }

  /// Finds the drawer layer data using messenger lookup.
  ///
  /// Similar to [maybeFind] but uses the messenger mechanism for lookup.
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFindMessenger(BuildContext context,
      [bool root = false]) {
    var data = Data.maybeFindMessenger<DrawerLayerData>(context);
    if (root) {
      while (data?.parent != null) {
        data = data!.parent;
      }
    }
    return data;
  }
}

/// State class for [DrawerOverlay] managing drawer entry lifecycle.
///
/// Manages the stack of active drawer overlays, handling their addition,
/// removal, and size computation. Maintains a backdrop key for managing
/// backdrop transformations.
class DrawerOverlayState extends State<DrawerOverlay> {
  final List<DrawerOverlayEntry> _entries = [];

  /// Key for the backdrop widget to enable transformations.
  final GlobalKey backdropKey = GlobalKey();

  /// Adds a drawer overlay entry to the list of active entries.
  ///
  /// Updates the widget state to include the new entry, triggering a rebuild
  /// to display the drawer overlay.
  ///
  /// Parameters:
  /// - [entry] (`DrawerOverlayEntry`, required): The drawer entry to add.
  ///
  /// Example:
  /// ```dart
  /// final entry = DrawerOverlayEntry(
  ///   builder: (context) => MyDrawerContent(),
  /// );
  /// drawerState.addEntry(entry);
  /// ```
  void addEntry(DrawerOverlayEntry entry) {
    setState(() {
      _entries.add(entry);
    });
  }

  /// Computes the size of the drawer overlay area.
  ///
  /// Returns the size of the overlay's render box. Used for positioning
  /// and sizing drawer content.
  ///
  /// Throws [AssertionError] if overlay is not ready (no size available).
  ///
  /// Returns [Size] of the overlay area.
  Size computeSize() {
    Size? size = context.size;
    assert(size != null, 'DrawerOverlay is not ready');
    return size!;
  }

  /// Removes a drawer entry from the overlay stack.
  ///
  /// Triggers a rebuild to update the overlay display after removing
  /// the specified entry.
  ///
  /// Parameters:
  /// - [entry] (DrawerOverlayEntry, required): Entry to remove
  void removeEntry(DrawerOverlayEntry entry) {
    setState(() {
      _entries.remove(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    final parentLayer = Data.maybeOf<DrawerLayerData>(context);
    Widget child = KeyedSubtree(
      key: backdropKey,
      child: widget.child,
    );
    int index = 0;
    for (final entry in _entries) {
      child = DrawerEntryWidget(
        key: entry.key, // to make the overlay state persistent
        builder: entry.builder,
        backdrop: child,
        barrierBuilder: entry.barrierBuilder,
        modal: entry.modal,
        themes: entry.themes,
        completer: entry.completer,
        position: entry.position,
        backdropBuilder: entry.backdropBuilder,
        animationController: entry.animationController,
        stackIndex: index++,
        totalStack: _entries.length,
        data: entry.data,
        useSafeArea: entry.useSafeArea,
        autoOpen: entry.autoOpen,
      );
    }
    return PopScope(
      // prevent from popping when there is an overlay
      // instead, the overlay should be closed first
      // once everything is closed, then this can be popped
      canPop: _entries.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        if (_entries.isNotEmpty) {
          var last = _entries.last;
          if (last.barrierDismissible) {
            var state = last.key.currentState;
            if (state != null) {
              state.close(result);
            } else {
              last.completer.complete(result);
            }
          }
        }
      },
      child: ForwardableData(
        data: DrawerLayerData(this, parentLayer),
        child: child,
      ),
    );
  }
}

/// Widget representing a single drawer entry in the overlay stack.
///
/// Manages the lifecycle and rendering of an individual drawer overlay,
/// including its backdrop, barrier, and animated transitions.
class DrawerEntryWidget<T> extends StatefulWidget {
  /// Builder function for the drawer content.
  final DrawerBuilder builder;

  /// Backdrop widget (content behind the drawer).
  final Widget backdrop;

  /// Builder for transforming the backdrop.
  final BackdropBuilder backdropBuilder;

  /// Builder for the modal barrier.
  final BarrierBuilder barrierBuilder;

  /// Whether the drawer is modal (blocks interaction with backdrop).
  final bool modal;

  /// Captured theme data to apply within the drawer.
  final CapturedThemes? themes;

  /// Captured inherited data to propagate.
  final CapturedData? data;

  /// Completer for the drawer's result value.
  final Completer<T> completer;

  /// Position of the drawer (left, right, top, bottom, start, end).
  final OverlayPosition position;

  /// Index of this drawer in the stack.
  final int stackIndex;

  /// Total number of drawers in the stack.
  final int totalStack;

  /// Whether to apply safe area insets.
  final bool useSafeArea;

  /// Optional external animation controller.
  final AnimationController? animationController;

  /// Whether to automatically open on mount.
  final bool autoOpen;

  /// Creates a drawer entry widget.
  const DrawerEntryWidget({
    super.key,
    required this.builder,
    required this.backdrop,
    required this.backdropBuilder,
    required this.barrierBuilder,
    required this.modal,
    required this.themes,
    required this.completer,
    required this.position,
    required this.stackIndex,
    required this.totalStack,
    required this.data,
    required this.useSafeArea,
    required this.animationController,
    required this.autoOpen,
  });

  @override
  State<DrawerEntryWidget<T>> createState() => DrawerEntryWidgetState<T>();
}

/// State class for [DrawerEntryWidget] managing drawer animations and lifecycle.
///
/// Handles animation control, focus management, and drawer dismissal.
/// Manages both internal and external animation controllers.
class DrawerEntryWidgetState<T> extends State<DrawerEntryWidget<T>>
    with SingleTickerProviderStateMixin {
  /// Notifier for additional offset applied during drag gestures.
  late ValueNotifier<double> additionalOffset = ValueNotifier(0);
  late AnimationController _controller;
  late ControlledAnimation _controlledAnimation;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.animationController ??
        AnimationController(
            vsync: this, duration: const Duration(milliseconds: 350));

    _controlledAnimation = ControlledAnimation(_controller);
    if (widget.animationController == null && widget.autoOpen) {
      _controlledAnimation.forward(1, Curves.easeOut);
    }
    // discard any focus that was previously set
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DrawerEntryWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationController != oldWidget.animationController) {
      if (oldWidget.animationController == null) {
        _controller.dispose();
      }
      _controller = widget.animationController ??
          AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 350),
          );
    }
  }

  /// Closes the drawer with an optional result value.
  ///
  /// Animates the drawer out using an ease-out cubic curve, then completes
  /// the completer with the provided result.
  ///
  /// Parameters:
  /// - [result] (T?): Optional result to return when drawer closes
  ///
  /// Returns a [Future] that completes when the close animation finishes.
  Future<void> close([T? result]) {
    return _controlledAnimation.forward(0, Curves.easeOutCubic).then((value) {
      widget.completer.complete(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry alignment;
    Offset startFractionalOffset;
    var position = widget.position;
    final textDirection = Directionality.of(context);
    if (position == OverlayPosition.start) {
      position = textDirection == TextDirection.ltr
          ? OverlayPosition.left
          : OverlayPosition.right;
    } else if (position == OverlayPosition.end) {
      position = textDirection == TextDirection.ltr
          ? OverlayPosition.right
          : OverlayPosition.left;
    }
    bool padTop = widget.useSafeArea && position != OverlayPosition.top;
    bool padBottom = widget.useSafeArea && position != OverlayPosition.bottom;
    bool padLeft = widget.useSafeArea && position != OverlayPosition.left;
    bool padRight = widget.useSafeArea && position != OverlayPosition.right;
    switch (position) {
      case OverlayPosition.left:
        alignment = Alignment.centerLeft;
        startFractionalOffset = const Offset(-1, 0);
        break;
      case OverlayPosition.right:
        alignment = Alignment.centerRight;
        startFractionalOffset = const Offset(1, 0);
        break;
      case OverlayPosition.top:
        alignment = Alignment.topCenter;
        startFractionalOffset = const Offset(0, -1);
        break;
      case OverlayPosition.bottom:
        alignment = Alignment.bottomCenter;
        startFractionalOffset = const Offset(0, 1);
        break;
      default:
        throw UnimplementedError('Unknown position');
    }
    return FocusScope(
      node: _focusScopeNode,
      child: CapturedWrapper(
        themes: widget.themes,
        data: widget.data,
        child: Data.inherit(
          data: _MountedOverlayEntryData(this),
          child: Builder(builder: (context) {
            Widget barrier = (widget.modal
                    ? widget.barrierBuilder(context, widget.backdrop,
                        _controlledAnimation, widget.stackIndex)
                    : null) ??
                Positioned(
                  top: -9999,
                  left: -9999,
                  right: -9999,
                  bottom: -9999,
                  child: GestureDetector(
                    onTap: () {
                      close();
                    },
                  ),
                );
            final extraSize =
                Data.maybeOf<BackdropTransformData>(context)?.sizeDifference;
            Size additionalSize;
            Offset additionalOffset;
            bool insetTop =
                widget.useSafeArea && position == OverlayPosition.top;
            bool insetBottom =
                widget.useSafeArea && position == OverlayPosition.bottom;
            bool insetLeft =
                widget.useSafeArea && position == OverlayPosition.left;
            bool insetRight =
                widget.useSafeArea && position == OverlayPosition.right;
            MediaQueryData mediaQueryData = MediaQuery.of(context);
            EdgeInsets padding =
                mediaQueryData.padding + mediaQueryData.viewInsets;
            if (extraSize == null) {
              additionalSize = Size.zero;
              additionalOffset = Offset.zero;
            } else {
              switch (position) {
                case OverlayPosition.left:
                  additionalSize = Size(extraSize.width / 2, 0);
                  additionalOffset = Offset(-additionalSize.width, 0);
                  break;
                case OverlayPosition.right:
                  additionalSize = Size(extraSize.width / 2, 0);
                  additionalOffset = Offset(additionalSize.width, 0);
                  break;
                case OverlayPosition.top:
                  additionalSize = Size(0, extraSize.height / 2);
                  additionalOffset = Offset(0, -additionalSize.height);
                  break;
                case OverlayPosition.bottom:
                  additionalSize = Size(0, extraSize.height / 2);
                  additionalOffset = Offset(0, additionalSize.height);
                  break;
                default:
                  throw UnimplementedError('Unknown position');
              }
            }
            return Stack(
              clipBehavior: Clip.none,
              fit: StackFit.passthrough,
              children: [
                IgnorePointer(
                  child: widget.backdropBuilder(context, widget.backdrop,
                      _controlledAnimation, widget.stackIndex),
                ),
                barrier,
                Positioned.fill(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return MediaQuery(
                      data: widget.useSafeArea
                          ? mediaQueryData.removePadding(
                              removeTop: true,
                              removeBottom: true,
                              removeLeft: true,
                              removeRight: true,
                            )
                          : mediaQueryData,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: padTop ? padding.top : 0,
                          bottom: padBottom ? padding.bottom : 0,
                          left: padLeft ? padding.left : 0,
                          right: padRight ? padding.right : 0,
                        ),
                        child: Align(
                          alignment: alignment,
                          child: AnimatedBuilder(
                            animation: _controlledAnimation,
                            builder: (context, child) {
                              return FractionalTranslation(
                                translation: startFractionalOffset *
                                    (1 - _controlledAnimation.value),
                                child: child,
                              );
                            },
                            child: Transform.translate(
                              offset: additionalOffset / kBackdropScaleDown,
                              child: widget.builder(
                                  context,
                                  additionalSize,
                                  constraints.biggest,
                                  EdgeInsets.only(
                                    top: insetTop ? padding.top : 0,
                                    bottom: insetBottom ? padding.bottom : 0,
                                    left: insetLeft ? padding.left : 0,
                                    right: insetRight ? padding.right : 0,
                                  ),
                                  widget.stackIndex),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

/// Builder function for drawer backdrop transformations.
///
/// Creates a widget that wraps the backdrop content, applying transformations
/// during drawer animations.
///
/// Parameters:
/// - [context] (BuildContext): Build context
/// - [child] (Widget): Backdrop widget to transform
/// - [animation] (`Animation<double>`): Animation value from 0 (closed) to 1 (open)
/// - [stackIndex] (int): Index of the drawer in the stack
///
/// Returns the transformed backdrop widget.
typedef BackdropBuilder = Widget Function(BuildContext context, Widget child,
    Animation<double> animation, int stackIndex);

/// Builder function for drawer modal barriers.
///
/// Creates an optional barrier widget that appears over the backdrop when
/// the drawer is modal. Typically used for dimming and dismissal handling.
///
/// Parameters:
/// - [context] (BuildContext): Build context
/// - [child] (Widget): Content behind the barrier
/// - [animation] (`Animation<double>`): Animation value from 0 (closed) to 1 (open)
/// - [stackIndex] (int): Index of the drawer in the stack
///
/// Returns the barrier widget or null if no barrier needed.
typedef BarrierBuilder = Widget? Function(BuildContext context, Widget child,
    Animation<double> animation, int stackIndex);

/// Data class representing a drawer overlay entry in the stack.
///
/// Encapsulates all configuration and state needed to render a single
/// drawer overlay, including builders, animation, theming, and positioning.
class DrawerOverlayEntry<T> {
  /// Key for accessing the drawer entry widget state.
  final GlobalKey<DrawerEntryWidgetState<T>> key = GlobalKey();

  /// Builder for backdrop transformations.
  final BackdropBuilder backdropBuilder;

  /// Builder for drawer content.
  final DrawerBuilder builder;

  /// Whether the drawer is modal.
  final bool modal;

  /// Builder for the modal barrier.
  final BarrierBuilder barrierBuilder;

  /// Captured theme data.
  final CapturedThemes? themes;

  /// Captured inherited data.
  final CapturedData? data;

  /// Completer for the drawer result.
  final Completer<T> completer;

  /// Position of the drawer.
  final OverlayPosition position;

  /// Whether tapping the barrier dismisses the drawer.
  final bool barrierDismissible;

  /// Whether to apply safe area insets.
  final bool useSafeArea;

  /// Optional external animation controller.
  final AnimationController? animationController;

  /// Whether to automatically open on mount.
  final bool autoOpen;

  /// Size constraints for the drawer.
  final BoxConstraints? constraints;

  /// Alignment of the drawer content.
  final AlignmentGeometry? alignment;

  /// Creates a drawer overlay entry.
  DrawerOverlayEntry({
    required this.builder,
    required this.backdropBuilder,
    required this.modal,
    required this.barrierBuilder,
    required this.themes,
    required this.completer,
    required this.position,
    required this.data,
    required this.barrierDismissible,
    required this.useSafeArea,
    required this.animationController,
    required this.autoOpen,
    required this.constraints,
    required this.alignment,
  });
}

/// Completer for drawer overlay operations.
///
/// Wraps a [DrawerOverlayEntry] to provide overlay lifecycle management,
/// including animation tracking and dismissal handling.
class DrawerOverlayCompleter<T> extends OverlayCompleter<T> {
  final DrawerOverlayEntry<T> _entry;

  /// Creates a drawer overlay completer.
  ///
  /// Parameters:
  /// - [_entry] (`DrawerOverlayEntry<T>`, required): The drawer entry to manage
  DrawerOverlayCompleter(this._entry);

  @override
  Future<void> get animationFuture => _entry.completer.future;

  @override
  void dispose() {
    _entry.completer.complete();
  }

  /// Gets the animation controller for the drawer.
  ///
  /// Returns the external animation controller if provided, otherwise
  /// returns the internal controller from the drawer entry widget state.
  ///
  /// Returns [AnimationController] or null if not available.
  AnimationController? get animationController =>
      _entry.animationController ?? _entry.key.currentState?._controller;

  @override
  Future<T> get future => _entry.completer.future;

  @override
  bool get isAnimationCompleted => _entry.completer.isCompleted;

  @override
  bool get isCompleted => _entry.completer.isCompleted;

  @override
  void remove() {
    _entry.completer.complete();
  }
}

/// Overlay handler specialized for sheet-style overlays.
///
/// Provides a simplified API for showing sheet overlays (bottom sheets,
/// side sheets, etc.) with standard positioning and barrier behavior.
class SheetOverlayHandler extends OverlayHandler {
  /// Checks if the current context is within a sheet overlay.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context to check
  ///
  /// Returns true if context is within a sheet overlay, false otherwise.
  static bool isSheetOverlay(BuildContext context) {
    return Model.maybeOf<bool>(context, #shadcn_flutter_sheet_overlay) == true;
  }

  /// Position where the sheet appears.
  final OverlayPosition position;

  /// Optional barrier color for the modal backdrop.
  final Color? barrierColor;

  /// Creates a sheet overlay handler.
  ///
  /// Parameters:
  /// - [position] (OverlayPosition): Sheet position, defaults to bottom
  /// - [barrierColor] (Color?): Optional barrier color
  const SheetOverlayHandler({
    this.position = OverlayPosition.bottom,
    this.barrierColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SheetOverlayHandler &&
        other.position == position &&
        other.barrierColor == barrierColor;
  }

  @override
  int get hashCode => Object.hash(position, barrierColor);

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    return openRawDrawer<T>(
      context: context,
      transformBackdrop: false,
      useSafeArea: true,
      barrierDismissible: barrierDismissable,
      builder: (context, extraSize, size, padding, stackIndex) {
        final theme = Theme.of(context);
        return MultiModel(
          data: const [
            Model(#shadcn_flutter_sheet_overlay, true),
          ],
          child: SheetWrapper(
            position: this.position,
            gapAfterDragger: 8 * theme.scaling,
            expands: true,
            extraSize: extraSize,
            size: size,
            draggable: barrierDismissable,
            padding: padding,
            barrierColor: barrierColor,
            stackIndex: stackIndex,
            child: Builder(builder: (context) {
              return builder(context);
            }),
          ),
        );
      },
      position: this.position,
    );
  }
}
