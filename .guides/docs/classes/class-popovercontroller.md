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
  bool get hasOpenPopover;
  bool get hasMountedPopover;
  Iterable<Popover> get openPopovers;
  Future<T?> show<T>({required BuildContext context, required WidgetBuilder builder, required AlignmentGeometry alignment, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, bool modal = true, bool closeOthers = true, Offset? offset, GlobalKey<OverlayHandlerStateMixin>? key, Object? regionGroupId, AlignmentGeometry? transitionAlignment, bool consumeOutsideTaps = true, EdgeInsetsGeometry? margin, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool follow = true, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? hideDuration, OverlayBarrier? overlayBarrier, OverlayHandler? handler});
  void close([bool immediate = false]);
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
  void disposePopovers();
  void dispose();
}
```
