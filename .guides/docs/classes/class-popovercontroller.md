---
title: "Class: PopoverController"
description: "A controller for managing multiple popovers and their lifecycle."
---

```dart
/// A controller for managing multiple popovers and their lifecycle.
///
/// [PopoverController] provides centralized management for popover instances,
/// including creation, lifecycle tracking, and coordination between multiple
/// popovers. It handles the complexity of overlay management and provides
/// a clean API for popover operations.
///
/// Key responsibilities:
/// - Creating and showing new popovers
/// - Tracking active popover instances
/// - Coordinating close operations across popovers
/// - Managing popover lifecycle states
/// - Providing status queries for open/mounted popovers
///
/// The controller maintains a list of active popovers and provides methods
/// to query their status, close them individually or collectively, and
/// coordinate their display behavior.
///
/// Example:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   _MyWidgetState createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> {
///   final PopoverController _popoverController = PopoverController();
///
///   @override
///   void dispose() {
///     _popoverController.dispose();
///     super.dispose();
///   }
///
///   void _showMenu() async {
///     await _popoverController.show(
///       context: context,
///       alignment: Alignment.bottomStart,
///       builder: (context) => MyPopoverContent(),
///     );
///   }
/// }
/// ```
class PopoverController extends ChangeNotifier {
  /// Whether there are any open popovers that haven't completed.
  ///
  /// Returns true if any popover is currently open and not yet completed.
  bool get hasOpenPopover;
  /// Whether there are any mounted popovers with animations in progress.
  ///
  /// Returns true if any popover is mounted and its animation hasn't completed.
  bool get hasMountedPopover;
  /// Gets an unmodifiable view of currently open popovers.
  ///
  /// Returns an iterable of [Popover] instances that are currently managed
  /// by this controller.
  Iterable<Popover> get openPopovers;
  /// Shows a popover with the specified configuration.
  ///
  /// Creates and displays a popover overlay with extensive customization options.
  /// If [closeOthers] is true, closes existing popovers before showing the new one.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [builder] (WidgetBuilder, required): Popover content builder
  /// - [alignment] (AlignmentGeometry, required): Popover alignment
  /// - [anchorAlignment] (AlignmentGeometry?): Anchor alignment
  /// - [widthConstraint] (PopoverConstraint): Width constraint, defaults to flexible
  /// - [heightConstraint] (PopoverConstraint): Height constraint, defaults to flexible
  /// - [modal] (bool): Modal behavior, defaults to true
  /// - [closeOthers] (bool): Close other popovers, defaults to true
  /// - [offset] (Offset?): Position offset
  /// - [key] (`GlobalKey<OverlayHandlerStateMixin>?`): Widget key
  /// - [regionGroupId] (Object?): Region group ID
  /// - [transitionAlignment] (AlignmentGeometry?): Transition alignment
  /// - [consumeOutsideTaps] (bool): Consume outside taps, defaults to true
  /// - [margin] (EdgeInsetsGeometry?): Popover margin
  /// - [onTickFollow] (`ValueChanged<PopoverOverlayWidgetState>?`): Follow tick callback
  /// - [follow] (bool): Follow anchor on move, defaults to true
  /// - [allowInvertHorizontal] (bool): Allow horizontal inversion, defaults to true
  /// - [allowInvertVertical] (bool): Allow vertical inversion, defaults to true
  /// - [dismissBackdropFocus] (bool): Dismiss on backdrop focus, defaults to true
  /// - [showDuration] (Duration?): Show animation duration
  /// - [hideDuration] (Duration?): Hide animation duration
  /// - [overlayBarrier] (OverlayBarrier?): Custom barrier configuration
  /// - [handler] (OverlayHandler?): Custom overlay handler
  ///
  /// Returns a [Future] that completes with the popover result when dismissed.
  Future<T?> show<T>({required BuildContext context, required WidgetBuilder builder, required AlignmentGeometry alignment, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, bool modal = true, bool closeOthers = true, Offset? offset, GlobalKey<OverlayHandlerStateMixin>? key, Object? regionGroupId, AlignmentGeometry? transitionAlignment, bool consumeOutsideTaps = true, EdgeInsetsGeometry? margin, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool follow = true, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? hideDuration, OverlayBarrier? overlayBarrier, OverlayHandler? handler});
  /// Closes all managed popovers.
  ///
  /// Closes all popovers managed by this controller. If [immediate] is true,
  /// closes without animation.
  ///
  /// Parameters:
  /// - [immediate] (bool): Skip animation if true, defaults to false
  void close([bool immediate = false]);
  /// Schedules closure of all popovers for the next frame.
  ///
  /// Defers closing to avoid issues when called during widget builds.
  void closeLater();
  set anchorContext(BuildContext value);
  set alignment(AlignmentGeometry value);
  set anchorAlignment(AlignmentGeometry value);
  set widthConstraint(PopoverConstraint value);
  set heightConstraint(PopoverConstraint value);
  set margin(EdgeInsets value);
  set follow(bool value);
  set offset(Offset? value);
  set allowInvertHorizontal(bool value);
  set allowInvertVertical(bool value);
  /// Disposes all managed popovers.
  ///
  /// Schedules closure of all popovers. Called automatically when the
  /// controller is disposed.
  void disposePopovers();
  void dispose();
}
```
