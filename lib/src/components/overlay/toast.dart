import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for toast notification system.
///
/// Provides comprehensive styling properties for toast notifications including
/// layout, positioning, animation behavior, and visual effects. These properties
/// integrate with the design system and can be overridden at the widget level.
///
/// The theme supports advanced features like stacking behavior, expansion modes,
/// and sophisticated animation timing for professional toast experiences.
class ToastTheme {
  /// Maximum number of toast notifications to stack visually.
  ///
  /// Type: `int?`. If null, defaults to 3 stacked entries. Controls how many
  /// toasts are visible simultaneously, with older toasts being collapsed or hidden.
  final int? maxStackedEntries;

  /// Padding around the toast notification area.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, defaults to EdgeInsets.all(24) scaled
  /// by theme scaling factor. Applied to the toast positioning within safe area.
  final EdgeInsetsGeometry? padding;

  /// Behavior mode for toast stack expansion.
  ///
  /// Type: `ExpandMode?`. If null, defaults to [ExpandMode.expandOnHover].
  /// Controls when stacked toasts expand to show multiple entries simultaneously.
  final ExpandMode? expandMode;

  /// Offset for collapsed toast positioning.
  ///
  /// Type: `Offset?`. If null, defaults to Offset(0, 12) scaled by theme.
  /// Controls the vertical/horizontal spacing between stacked toast entries.
  final Offset? collapsedOffset;

  /// Scale factor for collapsed toast entries.
  ///
  /// Type: `double?`. If null, defaults to 0.9. Controls the size reduction
  /// of toast notifications that are stacked behind the active toast.
  final double? collapsedScale;

  /// Animation curve for toast expansion transitions.
  ///
  /// Type: `Curve?`. If null, defaults to Curves.easeOutCubic.
  /// Applied when transitioning between collapsed and expanded stack states.
  final Curve? expandingCurve;

  /// Duration for toast expansion animations.
  ///
  /// Type: `Duration?`. If null, defaults to 500 milliseconds.
  /// Controls the timing of stack expansion and collapse transitions.
  final Duration? expandingDuration;

  /// Opacity level for collapsed toast entries.
  ///
  /// Type: `double?`. If null, defaults to 1.0 (fully opaque).
  /// Controls the visibility of toast notifications in the stack behind the active toast.
  final double? collapsedOpacity;

  /// Initial opacity for toast entry animations.
  ///
  /// Type: `double?`. If null, defaults to 0.0 (fully transparent).
  /// Starting opacity value for toast notifications when they first appear.
  final double? entryOpacity;

  /// Spacing between expanded toast entries.
  ///
  /// Type: `double?`. If null, defaults to 8.0. Controls the gap between
  /// toast notifications when the stack is in expanded state.
  final double? spacing;

  /// Size constraints for individual toast notifications.
  ///
  /// Type: `BoxConstraints?`. If null, defaults to fixed width of 320 scaled
  /// by theme. Defines the maximum/minimum dimensions for toast content.
  final BoxConstraints? toastConstraints;

  /// Creates a [ToastTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// that integrate with the current theme's design system and provide
  /// professional toast notification behavior.
  ///
  /// Example:
  /// ```dart
  /// const ToastTheme(
  ///   maxStackedEntries: 5,
  ///   expandMode: ExpandMode.expandOnHover,
  ///   spacing: 12.0,
  ///   collapsedScale: 0.95,
  /// );
  /// ```
  const ToastTheme({
    this.maxStackedEntries,
    this.padding,
    this.expandMode,
    this.collapsedOffset,
    this.collapsedScale,
    this.expandingCurve,
    this.expandingDuration,
    this.collapsedOpacity,
    this.entryOpacity,
    this.spacing,
    this.toastConstraints,
  });

  /// Type definition for toast content builder functions.
  ///
  /// Takes a [BuildContext] and [ToastOverlay] instance, returning the widget
  /// that represents the toast's visual content. The overlay parameter provides
  /// control methods for dismissing or manipulating the toast notification.
  ///
  /// Example:
  /// ```dart
  /// ToastBuilder builder = (context, overlay) => Card(
  ///   child: ListTile(
  ///     title: Text('Notification'),
  ///     trailing: IconButton(
  ///       icon: Icon(Icons.close),
  ///       onPressed: overlay.close,
  ///     ),
  ///   ),
  /// );
  /// ```

  ToastTheme copyWith({
    ValueGetter<int?>? maxStackedEntries,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<ExpandMode?>? expandMode,
    ValueGetter<Offset?>? collapsedOffset,
    ValueGetter<double?>? collapsedScale,
    ValueGetter<Curve?>? expandingCurve,
    ValueGetter<Duration?>? expandingDuration,
    ValueGetter<double?>? collapsedOpacity,
    ValueGetter<double?>? entryOpacity,
    ValueGetter<double?>? spacing,
    ValueGetter<BoxConstraints?>? toastConstraints,
  }) {
    return ToastTheme(
      maxStackedEntries: maxStackedEntries == null
          ? this.maxStackedEntries
          : maxStackedEntries(),
      padding: padding == null ? this.padding : padding(),
      expandMode: expandMode == null ? this.expandMode : expandMode(),
      collapsedOffset:
          collapsedOffset == null ? this.collapsedOffset : collapsedOffset(),
      collapsedScale:
          collapsedScale == null ? this.collapsedScale : collapsedScale(),
      expandingCurve:
          expandingCurve == null ? this.expandingCurve : expandingCurve(),
      expandingDuration: expandingDuration == null
          ? this.expandingDuration
          : expandingDuration(),
      collapsedOpacity:
          collapsedOpacity == null ? this.collapsedOpacity : collapsedOpacity(),
      entryOpacity: entryOpacity == null ? this.entryOpacity : entryOpacity(),
      spacing: spacing == null ? this.spacing : spacing(),
      toastConstraints:
          toastConstraints == null ? this.toastConstraints : toastConstraints(),
    );
  }

  @override
  int get hashCode => Object.hash(
        maxStackedEntries,
        padding,
        expandMode,
        collapsedOffset,
        collapsedScale,
        expandingCurve,
        expandingDuration,
        collapsedOpacity,
        entryOpacity,
        spacing,
        toastConstraints,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToastTheme &&
        other.maxStackedEntries == maxStackedEntries &&
        other.padding == padding &&
        other.expandMode == expandMode &&
        other.collapsedOffset == collapsedOffset &&
        other.collapsedScale == collapsedScale &&
        other.expandingCurve == expandingCurve &&
        other.expandingDuration == expandingDuration &&
        other.collapsedOpacity == collapsedOpacity &&
        other.entryOpacity == entryOpacity &&
        other.spacing == spacing &&
        other.toastConstraints == toastConstraints;
  }

  @override
  String toString() {
    return 'ToastTheme(maxStackedEntries: $maxStackedEntries, padding: $padding, expandMode: $expandMode, collapsedOffset: $collapsedOffset, collapsedScale: $collapsedScale, expandingCurve: $expandingCurve, expandingDuration: $expandingDuration, collapsedOpacity: $collapsedOpacity, entryOpacity: $entryOpacity, spacing: $spacing, toastConstraints: $toastConstraints)';
  }
}

/// Builder function for custom toast widgets.
///
/// Parameters:
/// - [context]: The build context
/// - [gap]: Vertical spacing between toasts
/// - [alignment]: Visual alignment of the toast
///
/// Returns a widget representing the toast.
typedef ToastBuilder = Widget Function(
    BuildContext context, ToastOverlay overlay);

/// Displays a toast notification with sophisticated positioning and animation.
///
/// Creates and shows a toast notification using the provided builder function
/// within the nearest [ToastLayer] in the widget tree. The toast appears at
/// the specified location with configurable animation, dismissal behavior,
/// and automatic timeout.
///
/// The function handles theme capture and data inheritance to ensure the toast
/// maintains consistent styling and access to inherited data from the calling
/// context. Toast notifications are managed through a layered system that
/// supports stacking, expansion, and smooth animations.
///
/// Parameters:
/// - [context] (BuildContext, required): The build context for theme and data capture
/// - [builder] (ToastBuilder, required): Function that builds the toast content widget
/// - [location] (ToastLocation, default: bottomRight): Screen position for the toast
/// - [dismissible] (bool, default: true): Whether users can dismiss via gesture
/// - [curve] (Curve, default: easeOutCubic): Animation curve for entry/exit transitions
/// - [entryDuration] (Duration, default: 500ms): Duration for toast entry animation
/// - [onClosed] (VoidCallback?, optional): Callback invoked when toast is dismissed
/// - [showDuration] (Duration, default: 5s): Auto-dismiss timeout duration
///
/// Returns:
/// A [ToastOverlay] instance that provides control methods for the displayed toast.
///
/// Throws:
/// - [AssertionError] if no [ToastLayer] is found in the widget tree.
///
/// Example:
/// ```dart
/// final toast = showToast(
///   context: context,
///   builder: (context, overlay) => AlertCard(
///     title: 'Success',
///     message: 'Operation completed successfully',
///     onDismiss: overlay.close,
///   ),
///   location: ToastLocation.topRight,
///   showDuration: Duration(seconds: 3),
/// );
/// ```

ToastOverlay showToast({
  required BuildContext context,
  required ToastBuilder builder,
  ToastLocation location = ToastLocation.bottomRight,
  bool dismissible = true,
  Curve curve = Curves.easeOutCubic,
  Duration entryDuration = const Duration(milliseconds: 500),
  VoidCallback? onClosed,
  Duration showDuration = const Duration(seconds: 5),
}) {
  CapturedThemes? themes;
  CapturedData? data;
  _ToastLayerState? layer = Data.maybeFind<_ToastLayerState>(context);
  if (layer != null) {
    themes = InheritedTheme.capture(from: context, to: layer.context);
    data = Data.capture(from: context, to: layer.context);
  } else {
    layer = Data.maybeFindMessenger<_ToastLayerState>(context);
  }
  assert(layer != null, 'No ToastLayer found in context');
  final entry = ToastEntry(
    builder: builder,
    location: location,
    dismissible: dismissible,
    curve: curve,
    duration: entryDuration,
    themes: themes,
    data: data,
    onClosed: onClosed,
    showDuration: showDuration,
  );
  return layer!.addEntry(entry);
}

/// Screen position enumeration for toast notification placement.
///
/// ToastLocation defines six standard positions around the screen edges where
/// toast notifications can appear. Each location includes alignment information
/// for both the toast container and the stacking direction of multiple toasts.
///
/// The enum ensures consistent positioning behavior across different screen
/// sizes and orientations while providing intuitive placement options for
/// various UI patterns and user experience requirements.
enum ToastLocation {
  /// Top-left corner with downward stacking.
  ///
  /// Toasts appear in the top-left area with new toasts stacking below existing ones.
  /// Suitable for notifications that shouldn't interfere with main content areas.
  topLeft(
    childrenAlignment: Alignment.bottomCenter,
    alignment: Alignment.topLeft,
  ),

  /// Top-center with downward stacking.
  ///
  /// Toasts appear centered at the top with new toasts stacking below existing ones.
  /// Ideal for important notifications that need prominent visibility.
  topCenter(
    childrenAlignment: Alignment.bottomCenter,
    alignment: Alignment.topCenter,
  ),

  /// Top-right corner with downward stacking.
  ///
  /// Toasts appear in the top-right area with new toasts stacking below existing ones.
  /// Common choice for status updates and non-critical notifications.
  topRight(
    childrenAlignment: Alignment.bottomCenter,
    alignment: Alignment.topRight,
  ),

  /// Bottom-left corner with upward stacking.
  ///
  /// Toasts appear in the bottom-left area with new toasts stacking above existing ones.
  /// Useful for contextual actions and secondary notifications.
  bottomLeft(
    childrenAlignment: Alignment.topCenter,
    alignment: Alignment.bottomLeft,
  ),

  /// Bottom-center with upward stacking.
  ///
  /// Toasts appear centered at the bottom with new toasts stacking above existing ones.
  /// Popular for confirmation messages and user action feedback.
  bottomCenter(
    childrenAlignment: Alignment.topCenter,
    alignment: Alignment.bottomCenter,
  ),

  /// Bottom-right corner with upward stacking.
  ///
  /// Toasts appear in the bottom-right area with new toasts stacking above existing ones.
  /// Default location providing unobtrusive notification placement.
  bottomRight(
    childrenAlignment: Alignment.topCenter,
    alignment: Alignment.bottomRight,
  );

  /// The alignment of the toast container within the screen.
  ///
  /// Type: `AlignmentGeometry`. Defines where the toast stack positions
  /// itself relative to the screen boundaries and safe area constraints.
  final AlignmentGeometry alignment;

  /// The alignment direction for stacking multiple toast notifications.
  ///
  /// Type: `AlignmentGeometry`. Defines the direction in which new toasts
  /// are added to the stack relative to existing toast notifications.
  final AlignmentGeometry childrenAlignment;

  /// Creates a [ToastLocation] with specified alignment properties.
  ///
  /// Parameters:
  /// - [alignment] (AlignmentGeometry, required): Screen positioning for the toast stack
  /// - [childrenAlignment] (AlignmentGeometry, required): Stacking direction for multiple toasts
  const ToastLocation({
    required this.alignment,
    required this.childrenAlignment,
  });
}

/// Expansion behavior modes for toast notification stacks.
///
/// ExpandMode controls when and how stacked toast notifications expand to
/// show multiple entries simultaneously. Different modes provide various
/// user interaction patterns for managing multiple notifications.
enum ExpandMode {
  /// Toast stack is always expanded, showing all notifications simultaneously.
  ///
  /// All stacked toasts remain visible and fully sized at all times.
  /// Provides maximum information density but requires more screen space.
  alwaysExpanded,

  /// Toast stack expands when mouse cursor hovers over the notification area.
  ///
  /// Default behavior that provides on-demand access to stacked notifications
  /// through hover interaction. Collapses automatically after hover ends.
  expandOnHover,

  /// Toast stack expands when user taps or clicks on the notification area.
  ///
  /// Provides touch-friendly interaction for mobile devices and touch screens.
  /// Requires explicit user action to reveal stacked notifications.
  expandOnTap,

  /// Toast expansion is completely disabled.
  ///
  /// Only the topmost toast is ever visible, with background toasts remaining
  /// collapsed. Provides minimal screen footprint at the cost of stack visibility.
  disabled,
}

/// A sophisticated layer widget that provides toast notification infrastructure.
///
/// ToastLayer serves as the foundation for the toast notification system,
/// managing the display, positioning, animation, and lifecycle of multiple
/// toast notifications. It wraps application content and provides the necessary
/// context for [showToast] functions to work properly.
///
/// The layer handles complex features including toast stacking, expansion modes,
/// hover/tap interactions, automatic dismissal timing, gesture-based dismissal,
/// and smooth animations between states. It ensures proper theme integration
/// and responsive behavior across different screen sizes.
///
/// Key features:
/// - Multi-location toast support with six standard positions
/// - Intelligent toast stacking with configurable maximum entries
/// - Interactive expansion modes (hover, tap, always, disabled)
/// - Gesture-based dismissal with swipe recognition
/// - Automatic timeout handling with pause on hover
/// - Smooth animations for entry, exit, and state transitions
/// - Safe area and padding handling for various screen layouts
/// - Theme integration with comprehensive customization options
///
/// This is typically placed high in the widget tree, often wrapping the main
/// application content or individual screens that need toast functionality.
///
/// Example:
/// ```dart
/// ToastLayer(
///   maxStackedEntries: 4,
///   expandMode: ExpandMode.expandOnHover,
///   child: MyAppContent(),
/// );
/// ```
class ToastLayer extends StatefulWidget {
  /// The child widget to wrap with toast functionality.
  ///
  /// Type: `Widget`, required. The main application content that will have
  /// toast notification capabilities available through the widget tree.
  final Widget child;

  /// Maximum number of toast notifications to display simultaneously.
  ///
  /// Type: `int`, default: `3`. Controls how many toasts are visible at once,
  /// with older toasts being hidden or collapsed when limit is exceeded.
  final int maxStackedEntries;

  /// Padding around toast notification areas.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses default padding that respects
  /// safe area constraints. Applied to toast positioning within screen boundaries.
  final EdgeInsetsGeometry? padding;

  /// Behavior for toast stack expansion interactions.
  ///
  /// Type: `ExpandMode`, default: [ExpandMode.expandOnHover]. Controls when
  /// stacked toasts expand to show multiple entries simultaneously.
  final ExpandMode expandMode;

  /// Position offset for collapsed toast entries.
  ///
  /// Type: `Offset?`. If null, uses default offset that creates subtle
  /// stacking effect. Applied to toasts behind the active notification.
  final Offset? collapsedOffset;

  /// Scale factor for collapsed toast entries.
  ///
  /// Type: `double`, default: `0.9`. Controls size reduction of background
  /// toasts to create depth perception in the stack visualization.
  final double collapsedScale;

  /// Animation curve for expansion state transitions.
  ///
  /// Type: `Curve`, default: [Curves.easeOutCubic]. Applied when transitioning
  /// between collapsed and expanded stack states.
  final Curve expandingCurve;

  /// Duration for expansion animation transitions.
  ///
  /// Type: `Duration`, default: `500ms`. Controls timing of stack expansion
  /// and collapse animations for smooth user experience.
  final Duration expandingDuration;

  /// Opacity level for collapsed toast entries.
  ///
  /// Type: `double`, default: `1.0`. Controls visibility of background toasts
  /// in the stack, with 1.0 being fully opaque and 0.0 being transparent.
  final double collapsedOpacity;

  /// Initial opacity for toast entry animations.
  ///
  /// Type: `double`, default: `0.0`. Starting opacity value for toast
  /// notifications during their entrance animation sequence.
  final double entryOpacity;

  /// Spacing between toast entries in expanded mode.
  ///
  /// Type: `double`, default: `8.0`. Gap between individual toast notifications
  /// when the stack is expanded to show multiple entries.
  final double spacing;

  /// Size constraints for individual toast notifications.
  ///
  /// Type: `BoxConstraints?`. If null, uses responsive width based on screen
  /// size and theme scaling. Defines maximum and minimum toast dimensions.
  final BoxConstraints? toastConstraints;

  /// Creates a [ToastLayer].
  ///
  /// The [child] parameter is required as the content to wrap with toast
  /// functionality. All other parameters have sensible defaults but can be
  /// customized to match specific design requirements.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content to wrap with toast capabilities
  /// - [maxStackedEntries] (int, default: 3): Maximum visible toast count
  /// - [padding] (EdgeInsetsGeometry?, optional): Toast area padding override
  /// - [expandMode] (ExpandMode, default: expandOnHover): Stack expansion behavior
  /// - [collapsedOffset] (Offset?, optional): Background toast positioning offset
  /// - [collapsedScale] (double, default: 0.9): Background toast size reduction
  /// - [expandingCurve] (Curve, default: easeOutCubic): Expansion animation curve
  /// - [expandingDuration] (Duration, default: 500ms): Expansion animation timing
  /// - [collapsedOpacity] (double, default: 1.0): Background toast visibility
  /// - [entryOpacity] (double, default: 0.0): Toast entrance starting opacity
  /// - [spacing] (double, default: 8.0): Gap between expanded toast entries
  /// - [toastConstraints] (BoxConstraints?, optional): Individual toast size limits
  ///
  /// Example:
  /// ```dart
  /// ToastLayer(
  ///   maxStackedEntries: 5,
  ///   expandMode: ExpandMode.expandOnTap,
  ///   spacing: 12.0,
  ///   child: MaterialApp(home: HomePage()),
  /// );
  /// ```
  const ToastLayer({
    super.key,
    required this.child,
    this.maxStackedEntries = 3,
    this.padding,
    this.expandMode = ExpandMode.expandOnHover,
    this.collapsedOffset,
    this.collapsedScale = 0.9,
    this.expandingCurve = Curves.easeOutCubic,
    this.expandingDuration = const Duration(milliseconds: 500),
    this.collapsedOpacity = 1,
    this.entryOpacity = 0.0,
    this.spacing = 8,
    this.toastConstraints,
  });

  @override
  State<ToastLayer> createState() => _ToastLayerState();
}

class _ToastLocationData {
  final List<_AttachedToastEntry> entries = [];
  bool _expanding = false;
  int _hoverCount = 0;
}

class _ToastLayerState extends State<ToastLayer> {
  final Map<ToastLocation, _ToastLocationData> entries = {
    ToastLocation.topLeft: _ToastLocationData(),
    ToastLocation.topCenter: _ToastLocationData(),
    ToastLocation.topRight: _ToastLocationData(),
    ToastLocation.bottomLeft: _ToastLocationData(),
    ToastLocation.bottomCenter: _ToastLocationData(),
    ToastLocation.bottomRight: _ToastLocationData(),
  };

  void _triggerEntryClosing() {
    if (!mounted) {
      return;
    }
    setState(() {
      // this will rebuild the toast entries
    });
  }

  ToastOverlay addEntry(ToastEntry entry) {
    var attachedToastEntry = _AttachedToastEntry(entry, this);
    setState(() {
      var entries = this.entries[entry.location];
      entries!.entries.add(attachedToastEntry);
    });
    return attachedToastEntry;
  }

  void removeEntry(ToastEntry entry) {
    _AttachedToastEntry? last = entries[entry.location]!
        .entries
        .where((e) => e.entry == entry)
        .lastOrNull;
    if (last != null) {
      setState(() {
        entries[entry.location]!.entries.remove(last);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ToastTheme>(context);
    final maxStackedEntries =
        compTheme?.maxStackedEntries ?? widget.maxStackedEntries;
    final expandMode = compTheme?.expandMode ?? widget.expandMode;
    final collapsedOffset = (compTheme?.collapsedOffset ??
            widget.collapsedOffset ??
            const Offset(0, 12)) *
        scaling;
    final padding = (compTheme?.padding?.optionallyResolve(context) ??
            widget.padding?.optionallyResolve(context) ??
            const EdgeInsets.all(24)) *
        scaling;
    final toastConstraints = compTheme?.toastConstraints ??
        widget.toastConstraints ??
        BoxConstraints.tightFor(width: 320 * scaling);
    final collapsedScale = compTheme?.collapsedScale ?? widget.collapsedScale;
    final expandingCurve = compTheme?.expandingCurve ?? widget.expandingCurve;
    final expandingDuration =
        compTheme?.expandingDuration ?? widget.expandingDuration;
    final collapsedOpacity =
        compTheme?.collapsedOpacity ?? widget.collapsedOpacity;
    final entryOpacity = compTheme?.entryOpacity ?? widget.entryOpacity;
    final spacing = compTheme?.spacing ?? widget.spacing;
    int reservedEntries = maxStackedEntries;
    List<Widget> children = [
      widget.child,
    ];
    for (var locationEntry in entries.entries) {
      var location = locationEntry.key;
      var entries = locationEntry.value.entries;
      var expanding = locationEntry.value._expanding;
      int startVisible =
          (entries.length - (maxStackedEntries + reservedEntries)).max(0);
      Alignment entryAlignment =
          location.childrenAlignment.optionallyResolve(context) * -1;
      List<Widget> positionedChildren = [];
      int toastIndex = 0;
      for (var i = entries.length - 1; i >= startVisible; i--) {
        var entry = entries[i];
        positionedChildren.insert(
          0,
          ToastEntryLayout(
            key: entry.key,
            entry: entry.entry,
            expanded: expanding || expandMode == ExpandMode.alwaysExpanded,
            visible: toastIndex < maxStackedEntries,
            dismissible: entry.entry.dismissible,
            previousAlignment: location.childrenAlignment,
            curve: entry.entry.curve,
            duration: entry.entry.duration,
            themes: entry.entry.themes,
            data: entry.entry.data,
            closing: entry._isClosing,
            collapsedOffset: collapsedOffset,
            collapsedScale: collapsedScale,
            expandingCurve: expandingCurve,
            expandingDuration: expandingDuration,
            collapsedOpacity: collapsedOpacity,
            entryOpacity: entryOpacity,
            onClosed: () {
              removeEntry(entry.entry);
              entry.entry.onClosed?.call();
            },
            entryOffset: Offset(
              padding.left * entryAlignment.x.clamp(0, 1) +
                  padding.right * entryAlignment.x.clamp(-1, 0),
              padding.top * entryAlignment.y.clamp(0, 1) +
                  padding.bottom * entryAlignment.y.clamp(-1, 0),
            ),
            entryAlignment: entryAlignment,
            spacing: spacing,
            index: toastIndex,
            actualIndex: entries.length - i - 1,
            onClosing: () {
              entry.close();
            },
            child: ConstrainedBox(
              constraints: toastConstraints,
              child: entry.entry.builder(context, entry),
            ),
          ),
        );
        if (!entry._isClosing.value) {
          toastIndex++;
        }
      }
      if (positionedChildren.isEmpty) {
        continue;
      }
      children.add(
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: padding,
              child: Align(
                alignment: location.alignment,
                child: MouseRegion(
                  hitTestBehavior: HitTestBehavior.deferToChild,
                  onEnter: (event) {
                    locationEntry.value._hoverCount++;
                    if (expandMode == ExpandMode.expandOnHover) {
                      setState(() {
                        locationEntry.value._expanding = true;
                      });
                    }
                  },
                  onExit: (event) {
                    int currentCount = ++locationEntry.value._hoverCount;
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (currentCount == locationEntry.value._hoverCount) {
                        if (mounted) {
                          setState(() {
                            locationEntry.value._expanding = false;
                          });
                        } else {
                          locationEntry.value._expanding = false;
                        }
                      }
                    });
                  },
                  child: ConstrainedBox(
                    constraints: toastConstraints,
                    child: Stack(
                      alignment: location.alignment,
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
                      children: positionedChildren,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Data.inherit(
      data: this,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: children,
      ),
    );
  }
}

/// Abstract interface for controlling individual toast notification instances.
///
/// ToastOverlay provides methods for managing the lifecycle and state of
/// individual toast notifications after they have been displayed. Instances
/// are returned by [showToast] and passed to [ToastBuilder] functions.
///
/// The interface allows checking the current display state and programmatically
/// dismissing toast notifications, enabling responsive user interactions and
/// proper cleanup when needed.
abstract class ToastOverlay {
  /// Whether the toast notification is currently being displayed.
  ///
  /// Type: `bool`. Returns true if the toast is visible or in the process
  /// of animating in/out, false if it has been dismissed or closed.
  bool get isShowing;

  /// Programmatically dismisses the toast notification.
  ///
  /// Triggers the dismissal animation and removes the toast from the display
  /// stack. This method can be called multiple times safely - subsequent
  /// calls after dismissal will have no effect.
  ///
  /// Example:
  /// ```dart
  /// final toast = showToast(context: context, builder: (context, overlay) {
  ///   return AlertCard(
  ///     title: 'Auto-close',
  ///     trailing: IconButton(
  ///       icon: Icon(Icons.close),
  ///       onPressed: overlay.close,
  ///     ),
  ///   );
  /// });
  ///
  /// // Close programmatically after delay
  /// Timer(Duration(seconds: 2), toast.close);
  /// ```
  void close();
}

class _AttachedToastEntry implements ToastOverlay {
  final GlobalKey<_ToastEntryLayoutState> key = GlobalKey();
  final ToastEntry entry;

  _ToastLayerState? _attached;

  @override
  bool get isShowing => _attached != null;

  final ValueNotifier<bool> _isClosing = ValueNotifier(false);

  _AttachedToastEntry(this.entry, this._attached);

  @override
  void close() {
    if (_attached == null) {
      return;
    }
    _isClosing.value = true;
    _attached!._triggerEntryClosing();
    _attached = null;
  }
}

/// Configuration for a single toast notification.
///
/// Encapsulates all properties needed to display and manage a toast,
/// including builder, location, timing, and dismissal behavior.
class ToastEntry {
  /// Builder function to create the toast widget.
  final ToastBuilder builder;

  /// Position where the toast should appear.
  final ToastLocation location;

  /// Whether the toast can be dismissed by user interaction.
  ///
  /// Defaults to true. When false, toast only closes after duration expires.
  final bool dismissible;

  /// Animation curve for entry/exit transitions.
  final Curve curve;

  /// Duration for entry/exit animations.
  final Duration duration;

  /// Captured theme data to apply to the toast.
  final CapturedThemes? themes;

  /// Captured inherited widget data to apply to the toast.
  final CapturedData? data;

  /// Callback invoked when toast is closed.
  final VoidCallback? onClosed;

  /// How long the toast remains visible before auto-dismissing.
  ///
  /// Defaults to 5 seconds. If null, toast remains indefinitely.
  final Duration? showDuration;

  /// Creates a toast entry configuration.
  ToastEntry({
    required this.builder,
    required this.location,
    this.dismissible = true,
    this.curve = Curves.easeInOut,
    this.duration = kDefaultDuration,
    required this.themes,
    required this.data,
    this.onClosed,
    this.showDuration = const Duration(seconds: 5),
  });
}

/// Internal widget for managing toast entry layout and animations.
///
/// Handles the positioning, transitions, and lifecycle of individual toast
/// notifications. Manages expansion/collapse animations, entry/exit transitions,
/// and stacking behavior for multiple toasts.
///
/// This is an internal implementation class used by the toast system and
/// should not be used directly in application code.
class ToastEntryLayout extends StatefulWidget {
  /// The toast entry data containing the notification content.
  final ToastEntry entry;

  /// Whether the toast is in expanded state.
  final bool expanded;

  /// Whether the toast is currently visible.
  final bool visible;

  /// Whether the toast can be dismissed by user interaction.
  final bool dismissible;

  /// Alignment used before the current animation.
  final AlignmentGeometry previousAlignment;

  /// Animation curve for transitions.
  final Curve curve;

  /// Duration of transition animations.
  final Duration duration;

  /// Captured theme data to apply to the toast content.
  final CapturedThemes? themes;

  /// Captured inherited data to apply to the toast content.
  final CapturedData? data;

  /// Notifies when the toast is closing.
  final ValueListenable<bool> closing;

  /// Callback invoked when the toast has completely closed.
  final VoidCallback onClosed;

  /// Offset applied when toast is in collapsed state.
  final Offset collapsedOffset;

  /// Scale factor applied when toast is in collapsed state.
  final double collapsedScale;

  /// Curve used for expansion animations.
  final Curve expandingCurve;

  /// Duration of expansion animations.
  final Duration expandingDuration;

  /// Opacity when toast is collapsed.
  final double collapsedOpacity;

  /// Initial opacity when toast enters.
  final double entryOpacity;

  /// The toast content widget.
  final Widget child;

  /// Initial offset when toast enters.
  final Offset entryOffset;

  /// Alignment of the toast entry.
  final AlignmentGeometry entryAlignment;

  /// Spacing between stacked toasts.
  final double spacing;

  /// Visual index in the toast stack.
  final int index;

  /// Actual index in the internal list.
  final int actualIndex;

  /// Callback invoked when toast starts closing.
  final VoidCallback? onClosing;

  /// Creates a [ToastEntryLayout].
  ///
  /// Most parameters control animation and positioning behavior. This is
  /// an internal widget used by the toast system.
  const ToastEntryLayout({
    super.key,
    required this.entry,
    required this.expanded,
    this.visible = true,
    this.dismissible = true,
    this.previousAlignment = Alignment.center,
    this.curve = Curves.easeInOut,
    this.duration = kDefaultDuration,
    required this.themes,
    required this.data,
    required this.closing,
    required this.onClosed,
    required this.collapsedOffset,
    required this.collapsedScale,
    this.expandingCurve = Curves.easeInOut,
    this.expandingDuration = kDefaultDuration,
    this.collapsedOpacity = 0.8,
    this.entryOpacity = 0.0,
    required this.entryOffset,
    required this.child,
    required this.entryAlignment,
    required this.spacing,
    required this.index,
    required this.actualIndex,
    required this.onClosing,
  });

  @override
  State<ToastEntryLayout> createState() => _ToastEntryLayoutState();
}

class _ToastEntryLayoutState extends State<ToastEntryLayout> {
  bool _dismissing = false;
  double _dismissOffset = 0;
  late int index;
  double? _closeDismissing;
  Timer? _closingTimer;

  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _startClosingTimer();
  }

  void _startClosingTimer() {
    if (widget.entry.showDuration != null) {
      _closingTimer?.cancel();
      _closingTimer = Timer(widget.entry.showDuration!, () {
        widget.onClosing?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = MouseRegion(
      key: _key,
      hitTestBehavior: HitTestBehavior.deferToChild,
      onEnter: (event) {
        _closingTimer?.cancel();
      },
      onExit: (event) {
        _startClosingTimer();
      },
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          if (widget.dismissible) {
            setState(() {
              _closingTimer?.cancel();
              _dismissing = true;
            });
          }
        },
        onHorizontalDragUpdate: (details) {
          if (widget.dismissible) {
            setState(() {
              _dismissOffset += details.primaryDelta! / context.size!.width;
            });
          }
        },
        onHorizontalDragEnd: (details) {
          if (widget.dismissible) {
            setState(() {
              _dismissing = false;
            });
            // if its < -0.5 or > 0.5 dismiss it
            if (_dismissOffset < -0.5) {
              _closeDismissing = -1.0;
            } else if (_dismissOffset > 0.5) {
              _closeDismissing = 1.0;
            } else {
              _dismissOffset = 0;
              _startClosingTimer();
            }
          }
        },
        child: AnimatedBuilder(
            animation: widget.closing,
            builder: (context, child) {
              return AnimatedValueBuilder(
                  value: widget.closing.value ? 0.0 : _dismissOffset,
                  duration: _dismissing && !widget.closing.value
                      ? Duration.zero
                      : kDefaultDuration,
                  builder: (context, dismissProgress, child) {
                    return AnimatedValueBuilder(
                        value: widget.closing.value
                            ? 0.0
                            : _closeDismissing ?? 0.0,
                        duration: kDefaultDuration,
                        onEnd: (value) {
                          if (value == -1.0 || value == 1.0) {
                            widget.onClosed();
                          }
                        },
                        builder: (context, closeDismissingProgress, child) {
                          return AnimatedValueBuilder(
                              value: widget.index.toDouble(),
                              curve: widget.curve,
                              duration: widget.duration,
                              builder: (context, indexProgress, child) {
                                return AnimatedValueBuilder(
                                  initialValue: widget.index > 0 ? 1.0 : 0.0,
                                  value: widget.closing.value && !_dismissing
                                      ? 0.0
                                      : 1.0,
                                  curve: widget.curve,
                                  duration: widget.duration,
                                  onEnd: (value) {
                                    if (value == 0.0 && widget.closing.value) {
                                      widget.onClosed();
                                    }
                                  },
                                  builder: (context, showingProgress, child) {
                                    return AnimatedValueBuilder(
                                        value: widget.visible ? 1.0 : 0.0,
                                        curve: widget.curve,
                                        duration: widget.duration,
                                        builder:
                                            (context, visibleProgress, child) {
                                          return AnimatedValueBuilder(
                                              value:
                                                  widget.expanded ? 1.0 : 0.0,
                                              curve: widget.expandingCurve,
                                              duration:
                                                  widget.expandingDuration,
                                              builder: (context, expandProgress,
                                                  child) {
                                                return buildToast(
                                                    expandProgress,
                                                    showingProgress,
                                                    visibleProgress,
                                                    indexProgress,
                                                    dismissProgress,
                                                    closeDismissingProgress);
                                              });
                                        });
                                  },
                                );
                              });
                        });
                  });
            }),
      ),
    );
    if (widget.themes != null) {
      childWidget = widget.themes!.wrap(childWidget);
    }
    if (widget.data != null) {
      childWidget = widget.data!.wrap(childWidget);
    }
    return childWidget;
  }

  Widget buildToast(
      double expandProgress,
      double showingProgress,
      double visibleProgress,
      double indexProgress,
      double dismissProgress,
      double closeDismissingProgress) {
    double nonCollapsingProgress = (1.0 - expandProgress) * showingProgress;
    var offset = widget.entryOffset * (1.0 - showingProgress);

    // when its behind another toast, shift it up based on index
    var previousAlignment = widget.previousAlignment.optionallyResolve(context);
    offset += Offset(
          (widget.collapsedOffset.dx * previousAlignment.x) *
              nonCollapsingProgress,
          (widget.collapsedOffset.dy * previousAlignment.y) *
              nonCollapsingProgress,
        ) *
        indexProgress;

    final theme = Theme.of(context);

    Offset expandingShift = Offset(
      previousAlignment.x * (16 * theme.scaling) * expandProgress,
      previousAlignment.y * (16 * theme.scaling) * expandProgress,
    );

    offset += expandingShift;

    // and then add the spacing when its in expanded mode
    offset += Offset(
          (widget.spacing * previousAlignment.x) * expandProgress,
          (widget.spacing * previousAlignment.y) * expandProgress,
        ) *
        indexProgress;

    var entryAlignment = widget.entryAlignment.optionallyResolve(context);
    var fractionalOffset = Offset(
      entryAlignment.x * (1.0 - showingProgress),
      entryAlignment.y * (1.0 - showingProgress),
    );

    fractionalOffset += Offset(
      closeDismissingProgress + dismissProgress,
      0,
    );

    // when its behind another toast AND is expanded, shift it up based on index and the size of self
    fractionalOffset += Offset(
          expandProgress * previousAlignment.x,
          expandProgress * previousAlignment.y,
        ) *
        indexProgress;

    var opacity = tweenValue(
      widget.entryOpacity,
      1.0,
      showingProgress * visibleProgress,
    );

    // fade out the toast behind
    opacity *=
        pow(widget.collapsedOpacity, indexProgress * nonCollapsingProgress);

    opacity *= 1 - (closeDismissingProgress + dismissProgress).abs();

    double scale =
        1.0 * pow(widget.collapsedScale, indexProgress * (1 - expandProgress));

    return Align(
      alignment: entryAlignment,
      child: Transform.translate(
        offset: offset,
        child: FractionalTranslation(
          translation: fractionalOffset,
          child: Opacity(
            opacity: opacity.clamp(0, 1),
            child: Transform.scale(
              scale: scale,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
