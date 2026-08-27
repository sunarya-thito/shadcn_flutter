---
title: "Class: OverlayController"
description: "A controller for managing a single overlay's lifecycle, driven by  [OverlayConfiguration] instead of popover-specific parameters.   If [show] is called again with the same configuration type (still a  [PopoverConfiguration], say, just with a different  [PopoverConfiguration.alignment]), the open overlay is updated in place  through [OverlayCompleter.config] rather than being closed and reopened.  A different configuration type, or no overlay currently open, always  closes whatever is open and starts fresh.   Field meanings like \"alignment\" or \"margin\" aren't interpreted here.  Each [OverlayCompleter] implementation, for example the one  [PopoverConfiguration.show] returns, reads whatever configuration it's  assigned through [OverlayCompleter.config] on its own terms.   Example:  ```dart  class _MyWidgetState extends State<MyWidget> {    final OverlayController _controller = OverlayController();     @override    void dispose() {      _controller.dispose();      super.dispose();    }     void _showMenu() async {      await _controller.show(        context,        PopoverConfiguration(          anchor: LinkedAnchor(#myAnchor),          alignment: Alignment.bottomStart,        ),        builder: (context) => MyPopoverContent(),      );    }  }  ```"
---

```dart
/// A controller for managing a single overlay's lifecycle, driven by
/// [OverlayConfiguration] instead of popover-specific parameters.
///
/// If [show] is called again with the same configuration type (still a
/// [PopoverConfiguration], say, just with a different
/// [PopoverConfiguration.alignment]), the open overlay is updated in place
/// through [OverlayCompleter.config] rather than being closed and reopened.
/// A different configuration type, or no overlay currently open, always
/// closes whatever is open and starts fresh.
///
/// Field meanings like "alignment" or "margin" aren't interpreted here.
/// Each [OverlayCompleter] implementation, for example the one
/// [PopoverConfiguration.show] returns, reads whatever configuration it's
/// assigned through [OverlayCompleter.config] on its own terms.
///
/// Example:
/// ```dart
/// class _MyWidgetState extends State<MyWidget> {
///   final OverlayController _controller = OverlayController();
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
///
///   void _showMenu() async {
///     await _controller.show(
///       context,
///       PopoverConfiguration(
///         anchor: LinkedAnchor(#myAnchor),
///         alignment: Alignment.bottomStart,
///       ),
///       builder: (context) => MyPopoverContent(),
///     );
///   }
/// }
/// ```
class OverlayController extends ChangeNotifier {
  /// The configuration of the currently-open overlay, or `null` if nothing
  /// is open. There's no setter: use [show] to open or update an overlay,
  /// since assigning [config] directly has no [BuildContext] to anchor to.
  OverlayConfiguration? get config;
  /// Whether there's an open overlay that hasn't completed.
  bool get hasOpenOverlay;
  /// Whether there's a mounted overlay with an animation in progress.
  bool get hasMountedOverlay;
  /// Shows an overlay using the given [configuration], anchored to [context],
  /// with [builder] as its content.
  ///
  /// If an overlay managed by this controller is already open with a
  /// configuration of the exact same runtime type as [configuration], it's
  /// updated in place via [OverlayCompleter.config] (see class docs);
  /// otherwise it's closed and the new configuration is opened fresh.
  /// [adaptive] is forwarded to [OverlayConfiguration.adaptiveConversion].
  Future<T?> show<T>(BuildContext context, OverlayConfiguration configuration, {required WidgetBuilder builder, bool adaptive = true});
  /// Closes the managed overlay, if any.
  ///
  /// Parameters:
  /// - [immediate] (bool, default: false): Skip closing animations when true.
  void close([bool immediate = false]);
  /// Schedules closure of the managed overlay for the next frame.
  void closeLater();
  void dispose();
}
```
