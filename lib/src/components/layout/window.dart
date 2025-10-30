import 'dart:collection';
import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/group.dart';
import 'package:shadcn_flutter/src/components/patch.dart';

/// Theme configuration for window components.
///
/// Provides styling options for window elements including title bar height
/// and resize border thickness. Used to customize the visual appearance
/// of window components within the application.
///
/// Example:
/// ```dart
/// WindowTheme(
///   titleBarHeight: 32.0,
///   resizeThickness: 4.0,
/// )
/// ```
class WindowTheme {
  /// Height of the window's title bar in logical pixels.
  ///
  /// Determines the vertical space allocated for the title bar which typically
  /// contains the window title, control buttons (minimize, maximize, close),
  /// and any custom action widgets.
  ///
  /// If `null`, uses the default title bar height from the theme.
  final double? titleBarHeight;

  /// Thickness of the window's resize border in logical pixels.
  ///
  /// Defines the width of the interactive area along window edges that
  /// allows users to resize the window by dragging. A larger value makes
  /// it easier to grab the edge for resizing.
  ///
  /// If `null`, uses the default resize border thickness from the theme.
  final double? resizeThickness;

  /// Creates a window theme with optional title bar and resize border settings.
  ///
  /// Both parameters are optional. When `null`, the corresponding values
  /// will fall back to theme defaults.
  const WindowTheme({this.titleBarHeight, this.resizeThickness});

  /// Creates a copy of this theme with optionally replaced values.
  ///
  /// Uses [ValueGetter] functions to allow nullable value replacement.
  /// If a parameter is `null`, the current value is retained. If provided,
  /// the getter function is called to retrieve the new value.
  ///
  /// Parameters:
  /// - [titleBarHeight]: Optional getter for new title bar height
  /// - [resizeThickness]: Optional getter for new resize thickness
  ///
  /// Returns a new [WindowTheme] instance with updated values.
  WindowTheme copyWith({
    ValueGetter<double?>? titleBarHeight,
    ValueGetter<double?>? resizeThickness,
  }) {
    return WindowTheme(
      titleBarHeight:
          titleBarHeight == null ? this.titleBarHeight : titleBarHeight(),
      resizeThickness:
          resizeThickness == null ? this.resizeThickness : resizeThickness(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is WindowTheme &&
      other.titleBarHeight == titleBarHeight &&
      other.resizeThickness == resizeThickness;

  @override
  int get hashCode => Object.hash(titleBarHeight, resizeThickness);

  @override
  String toString() =>
      'WindowTheme(titleBarHeight: $titleBarHeight, resizeThickness: $resizeThickness)';
}

/// Configuration for window snapping behavior and positioning.
///
/// Defines how windows should snap to screen edges or specific regions,
/// including the target bounds and whether the window should be minimized
/// during the snap operation.
///
/// Example:
/// ```dart
/// WindowSnapStrategy(
///   relativeBounds: Rect.fromLTWH(0, 0, 0.5, 1), // Left half of screen
///   shouldMinifyWindow: false,
/// )
/// ```
class WindowSnapStrategy {
  /// Relative bounds where the window should snap, in screen-relative coordinates.
  ///
  /// Values range from 0.0 to 1.0, representing proportions of the screen.
  /// For example, `Rect.fromLTWH(0, 0, 0.5, 1)` represents the left half
  /// of the screen (0% to 50% horizontally, full height).
  final Rect relativeBounds;

  /// Whether the window should be minimized during the snap operation.
  ///
  /// When `true`, the window will minimize before snapping to the target
  /// position. When `false`, the window immediately snaps without minimizing.
  ///
  /// Defaults to `true`.
  final bool shouldMinifyWindow;

  /// Creates a window snap strategy with the specified bounds and behavior.
  ///
  /// Parameters:
  /// - [relativeBounds]: Target screen region (required, in 0.0-1.0 coordinates)
  /// - [shouldMinifyWindow]: Whether to minimize during snap (defaults to `true`)
  const WindowSnapStrategy({
    required this.relativeBounds,
    this.shouldMinifyWindow = true,
  });
}

/// Complete state configuration for a window instance.
///
/// Encapsulates all aspects of a window's current state including position, size,
/// visual state (minimized, maximized), capabilities (resizable, draggable), and
/// behavior settings (snapping, always on top).
///
/// Key Properties:
/// - **Position & Size**: [bounds] for current position, [maximized] for fullscreen state
/// - **Visual State**: [minimized] for taskbar state, [alwaysOnTop] for layering
/// - **Capabilities**: [resizable], [draggable], [closable], [maximizable], [minimizable]
/// - **Behavior**: [enableSnapping] for edge snapping, [constraints] for size limits
///
/// Used primarily with [WindowController] to manage window state programmatically
/// and provide reactive updates to window appearance and behavior.
///
/// Example:
/// ```dart
/// WindowState(
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
///   resizable: true,
///   draggable: true,
///   enableSnapping: true,
///   constraints: BoxConstraints(minWidth: 400, minHeight: 300),
/// )
/// ```
class WindowState {
  /// Current position and size of the window.
  ///
  /// Represents the window's bounding rectangle in logical pixels,
  /// with coordinates relative to the screen's top-left corner.
  final Rect bounds;

  /// Bounds of the window when maximized, or `null` if not maximized.
  ///
  /// When non-null, indicates the window is in maximized state and
  /// stores the previous bounds for restoration when un-maximizing.
  final Rect? maximized;

  /// Whether the window is currently minimized to the taskbar.
  ///
  /// When `true`, the window is hidden from view but remains in memory.
  /// Defaults to `false`.
  final bool minimized;

  /// Whether the window should always appear on top of other windows.
  ///
  /// When `true`, this window will be rendered above other windows
  /// regardless of focus state. Defaults to `false`.
  final bool alwaysOnTop;

  /// Whether the window can be closed by the user.
  ///
  /// When `false`, the close button is disabled or hidden.
  /// Defaults to `true`.
  final bool closable;

  /// Whether the window can be resized by dragging its edges or corners.
  ///
  /// When `false`, the window maintains a fixed size.
  /// Defaults to `true`.
  final bool resizable;

  /// Whether the window can be moved by dragging its title bar.
  ///
  /// When `false`, the window position is fixed.
  /// Defaults to `true`.
  final bool draggable;

  /// Whether the window can be maximized to fill the screen.
  ///
  /// When `false`, the maximize button is disabled or hidden.
  /// Defaults to `true`.
  final bool maximizable;

  /// Whether the window can be minimized to the taskbar.
  ///
  /// When `false`, the minimize button is disabled or hidden.
  /// Defaults to `true`.
  final bool minimizable;

  /// Whether edge snapping is enabled for this window.
  ///
  /// When `true`, dragging the window near screen edges or regions
  /// will trigger snap-to-edge behavior. Defaults to `true`.
  final bool enableSnapping;

  /// Size constraints for the window.
  ///
  /// Enforces minimum and maximum width/height limits when resizing.
  /// Defaults to [kDefaultWindowConstraints].
  final BoxConstraints constraints;

  /// Creates a window state with the specified configuration.
  ///
  /// Parameters:
  /// - [bounds]: Current window bounds (required)
  /// - [maximized]: Maximized state bounds (optional, `null` if not maximized)
  /// - [minimized]: Minimized state (defaults to `false`)
  /// - [alwaysOnTop]: Always-on-top behavior (defaults to `false`)
  /// - [closable]: Allow closing (defaults to `true`)
  /// - [resizable]: Allow resizing (defaults to `true`)
  /// - [draggable]: Allow dragging (defaults to `true`)
  /// - [maximizable]: Allow maximizing (defaults to `true`)
  /// - [minimizable]: Allow minimizing (defaults to `true`)
  /// - [enableSnapping]: Enable edge snapping (defaults to `true`)
  /// - [constraints]: Size constraints (defaults to [kDefaultWindowConstraints])
  const WindowState({
    required this.bounds,
    this.maximized,
    this.minimized = false,
    this.alwaysOnTop = false,
    this.closable = true,
    this.resizable = true,
    this.draggable = true,
    this.maximizable = true,
    this.minimizable = true,
    this.enableSnapping = true,
    this.constraints = kDefaultWindowConstraints,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WindowState) return false;
    return bounds == other.bounds &&
        maximized == other.maximized &&
        minimized == other.minimized &&
        alwaysOnTop == other.alwaysOnTop &&
        closable == other.closable &&
        resizable == other.resizable &&
        draggable == other.draggable &&
        maximizable == other.maximizable &&
        minimizable == other.minimizable &&
        enableSnapping == other.enableSnapping &&
        constraints == other.constraints;
  }

  @override
  int get hashCode => Object.hash(
      bounds,
      maximized,
      minimized,
      alwaysOnTop,
      closable,
      resizable,
      draggable,
      maximizable,
      minimizable,
      enableSnapping,
      constraints);

  @override
  String toString() {
    return 'WindowState(bounds: $bounds, maximized: $maximized, minimized: $minimized, alwaysOnTop: $alwaysOnTop, closable: $closable, resizable: $resizable, draggable: $draggable, maximizable: $maximizable, minimizable: $minimizable, enableSnapping: $enableSnapping, constraints: $constraints)';
  }

  /// Creates a copy of this state with only the maximized bounds changed.
  ///
  /// This is a specialized version of [copyWith] that only modifies the
  /// [maximized] property while preserving all other state values.
  ///
  /// Parameters:
  /// - [maximized]: New maximized bounds, or `null` to restore window
  ///
  /// Returns a new [WindowState] with updated maximized property.
  WindowState withMaximized(Rect? maximized) {
    return WindowState(
      bounds: bounds,
      minimized: minimized,
      alwaysOnTop: alwaysOnTop,
      closable: closable,
      resizable: resizable,
      draggable: draggable,
      maximizable: maximizable,
      minimizable: minimizable,
      enableSnapping: enableSnapping,
      constraints: constraints,
      maximized: maximized,
    );
  }

  /// Creates a copy of this state with selectively updated properties.
  ///
  /// Uses [ValueGetter] functions to allow nullable value replacement.
  /// Properties not provided (null) retain their current values. When
  /// a getter is provided, it's called to obtain the new value.
  ///
  /// Note: This method does not allow updating [maximized]. Use
  /// [withMaximized] instead for that purpose.
  ///
  /// Parameters:
  /// - [bounds]: Optional getter for new window bounds
  /// - [minimized]: Optional getter for minimized state
  /// - [alwaysOnTop]: Optional getter for always-on-top behavior
  /// - [closable]: Optional getter for closable state
  /// - [resizable]: Optional getter for resizable state
  /// - [draggable]: Optional getter for draggable state
  /// - [maximizable]: Optional getter for maximizable state
  /// - [minimizable]: Optional getter for minimizable state
  /// - [enableSnapping]: Optional getter for snapping enabled state
  /// - [constraints]: Optional getter for size constraints
  ///
  /// Returns a new [WindowState] instance with updated values.
  WindowState copyWith({
    ValueGetter<Rect>? bounds,
    ValueGetter<bool>? minimized,
    ValueGetter<bool>? alwaysOnTop,
    ValueGetter<bool>? closable,
    ValueGetter<bool>? resizable,
    ValueGetter<bool>? draggable,
    ValueGetter<bool>? maximizable,
    ValueGetter<bool>? minimizable,
    ValueGetter<bool>? enableSnapping,
    ValueGetter<BoxConstraints>? constraints,
  }) {
    return WindowState(
      bounds: bounds == null ? this.bounds : bounds(),
      minimized: minimized == null ? this.minimized : minimized(),
      alwaysOnTop: alwaysOnTop == null ? this.alwaysOnTop : alwaysOnTop(),
      closable: closable == null ? this.closable : closable(),
      resizable: resizable == null ? this.resizable : resizable(),
      draggable: draggable == null ? this.draggable : draggable(),
      maximizable: maximizable == null ? this.maximizable : maximizable(),
      minimizable: minimizable == null ? this.minimizable : minimizable(),
      enableSnapping:
          enableSnapping == null ? this.enableSnapping : enableSnapping(),
      constraints: constraints == null ? this.constraints : constraints(),
    );
  }
}

/// Reactive controller for managing window state and operations.
///
/// Provides programmatic control over window properties with automatic UI updates
/// through [ValueNotifier] pattern. Handles window state management, validation,
/// and coordination with the window widget lifecycle.
///
/// Key Capabilities:
/// - **Reactive Updates**: Automatic UI refresh when state changes
/// - **Property Management**: Convenient getters/setters for window properties
/// - **Lifecycle Handling**: Mount/unmount detection and validation
/// - **State Validation**: Ensures state consistency and constraint compliance
/// - **Handle Management**: Coordination with underlying window implementation
///
/// Usage Pattern:
/// 1. Create controller with initial window configuration
/// 2. Pass to Window.controlled() constructor
/// 3. Modify properties programmatically (bounds, minimized, etc.)
/// 4. UI automatically updates to reflect changes
/// 5. Listen to controller for state change notifications
///
/// Example:
/// ```dart
/// final controller = WindowController(
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
///   resizable: true,
///   draggable: true,
/// );
///
/// // Programmatic control
/// controller.bounds = Rect.fromLTWH(200, 200, 900, 700);
/// controller.minimized = true;
/// controller.maximized = Rect.fromLTWH(0, 0, 1920, 1080);
///
/// // Listen for changes
/// controller.addListener(() {
///   print('Window state changed: ${controller.value}');
/// });
/// ```
class WindowController extends ValueNotifier<WindowState> {
  WindowHandle? _attachedState;

  /// Creates a [WindowController].
  ///
  /// Parameters:
  /// - [bounds] (`Rect`, required): Initial window bounds.
  /// - [maximized] (`Rect?`, optional): Maximized bounds, or null if not maximized.
  /// - [minimized] (`bool`, default: `false`): Initial minimized state.
  /// - [focused] (`bool`, default: `false`): Initial focused state.
  /// - [closable] (`bool`, default: `true`): Whether window can be closed.
  /// - [resizable] (`bool`, default: `true`): Whether window can be resized.
  /// - [draggable] (`bool`, default: `true`): Whether window can be dragged.
  /// - [maximizable] (`bool`, default: `true`): Whether window can be maximized.
  /// - [minimizable] (`bool`, default: `true`): Whether window can be minimized.
  /// - [enableSnapping] (`bool`, default: `true`): Whether window snapping is enabled.
  /// - [constraints] (`BoxConstraints`, default: `kDefaultWindowConstraints`): Size constraints.
  WindowController({
    required Rect bounds,
    Rect? maximized,
    bool minimized = false,
    bool focused = false,
    bool closable = true,
    bool resizable = true,
    bool draggable = true,
    bool maximizable = true,
    bool minimizable = true,
    bool enableSnapping = true,
    BoxConstraints constraints = kDefaultWindowConstraints,
  }) : super(WindowState(
          bounds: bounds,
          maximized: maximized,
          minimized: minimized,
          alwaysOnTop: focused,
          closable: closable,
          resizable: resizable,
          draggable: draggable,
          maximizable: maximizable,
          minimizable: minimizable,
          enableSnapping: enableSnapping,
          constraints: constraints,
        ));

  /// Whether the controller is currently attached to a window widget.
  ///
  /// Returns `true` if the controller is mounted within a window widget
  /// and can safely access [attachedState]. Returns `false` otherwise.
  bool get mounted => _attachedState != null;

  /// The window handle this controller is attached to.
  ///
  /// Provides access to the underlying window implementation for advanced
  /// operations. Only accessible when [mounted] is `true`.
  ///
  /// Throws an assertion error if accessed when not mounted.
  WindowHandle get attachedState {
    assert(mounted, 'Window is not attached');
    return _attachedState!;
  }

  /// Current position and size of the window.
  ///
  /// Setting this property updates the window bounds and triggers a UI refresh.
  /// The setter is a no-op if the new value equals the current value.
  Rect get bounds => value.bounds;

  /// Updates the window bounds.
  ///
  /// Changes take effect immediately and trigger listener notifications.
  set bounds(Rect value) {
    if (value == bounds) return;
    this.value = this.value.copyWith(bounds: () => value);
  }

  /// Maximized bounds, or `null` if the window is not maximized.
  ///
  /// When non-null, indicates the window is in maximized state.
  Rect? get maximized => value.maximized;

  /// Sets the maximized state and bounds.
  ///
  /// Pass a [Rect] to maximize the window to those bounds.
  /// Pass `null` to restore the window from maximized state.
  set maximized(Rect? value) {
    if (value == maximized) return;
    this.value = this.value.withMaximized(value);
  }

  /// Whether the window is currently minimized.
  ///
  /// When `true`, the window is hidden from view (e.g., in taskbar).
  bool get minimized => value.minimized;

  /// Sets the minimized state.
  ///
  /// Set to `true` to minimize the window, `false` to restore it.
  set minimized(bool value) {
    if (value == minimized) return;
    this.value = this.value.copyWith(minimized: () => value);
  }

  /// Whether the window always appears on top of other windows.
  bool get alwaysOnTop => value.alwaysOnTop;

  /// Sets the always-on-top behavior.
  ///
  /// When `true`, the window renders above other windows regardless of focus.
  set alwaysOnTop(bool value) {
    if (value == alwaysOnTop) return;
    this.value = this.value.copyWith(alwaysOnTop: () => value);
  }

  /// Whether the window can be closed.
  bool get closable => value.closable;

  /// Sets whether the window can be closed.
  ///
  /// When `false`, the close button is disabled or hidden.
  set closable(bool value) {
    if (value == closable) return;
    this.value = this.value.copyWith(closable: () => value);
  }

  /// Whether the window can be resized by dragging edges/corners.
  bool get resizable => value.resizable;

  /// Sets whether the window can be resized.
  set resizable(bool value) {
    if (value == resizable) return;
    this.value = this.value.copyWith(resizable: () => value);
  }

  /// Whether the window can be moved by dragging the title bar.
  bool get draggable => value.draggable;

  /// Sets whether the window can be dragged.
  set draggable(bool value) {
    if (value == draggable) return;
    this.value = this.value.copyWith(draggable: () => value);
  }

  /// Whether the window can be maximized.
  bool get maximizable => value.maximizable;

  /// Sets whether the window can be maximized.
  ///
  /// When `false`, the maximize button is disabled or hidden.
  set maximizable(bool value) {
    if (value == maximizable) return;
    this.value = this.value.copyWith(maximizable: () => value);
  }

  /// Whether the window can be minimized.
  bool get minimizable => value.minimizable;

  /// Sets whether the window can be minimized.
  ///
  /// When `false`, the minimize button is disabled or hidden.
  set minimizable(bool value) {
    if (value == minimizable) return;
    this.value = this.value.copyWith(minimizable: () => value);
  }

  /// Whether edge snapping is enabled for the window.
  bool get enableSnapping => value.enableSnapping;

  /// Sets whether edge snapping is enabled.
  ///
  /// When `true`, dragging near screen edges triggers snap behavior.
  set enableSnapping(bool value) {
    if (value == enableSnapping) return;
    this.value = this.value.copyWith(enableSnapping: () => value);
  }

  /// Size constraints for the window.
  ///
  /// Defines min/max width and height limits for resizing.
  BoxConstraints get constraints => value.constraints;

  /// Sets the size constraints for the window.
  set constraints(BoxConstraints value) {
    if (value == constraints) return;
    this.value = this.value.copyWith(constraints: () => value);
  }
}

/// A resizable, draggable window widget with title bar and content area.
///
/// Provides a desktop-style window experience with full control over sizing,
/// positioning, and window controls (minimize, maximize, close). Supports both
/// controlled and uncontrolled modes for flexible state management.
///
/// Key Features:
/// - **Resizable**: Drag edges/corners to resize (when enabled)
/// - **Draggable**: Drag title bar to move window (when enabled)
/// - **Maximizable**: Fill screen or custom bounds
/// - **Minimizable**: Collapse to taskbar or hidden state
/// - **Snapping**: Auto-snap to screen edges when dragging near them
/// - **Customizable**: Title, actions, content, and theme settings
///
/// Usage Patterns:
///
/// **Uncontrolled Mode** (direct state props):
/// ```dart
/// WindowWidget(
///   title: Text('My Window'),
///   content: Text('Window content here'),
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
///   resizable: true,
///   draggable: true,
/// )
/// ```
///
/// **Controlled Mode** (via controller):
/// ```dart
/// final controller = WindowController(
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
/// );
///
/// WindowWidget.controlled(
///   controller: controller,
///   title: Text('Controlled Window'),
///   content: Text('Content'),
/// )
/// ```
///
/// See also:
/// - [WindowController] for programmatic window control
/// - [WindowTheme] for styling options
/// - [WindowState] for state configuration details
class WindowWidget extends StatefulWidget {
  /// Widget displayed in the window's title bar.
  ///
  /// Typically a [Text] widget, but can be any widget. Positioned on the
  /// left side of the title bar by default.
  final Widget? title;

  /// Widget(s) displayed in the title bar's action area.
  ///
  /// Usually contains window control buttons (minimize, maximize, close)
  /// or custom action buttons. Positioned on the right side of the title bar.
  final Widget? actions;

  /// Main content widget displayed in the window body.
  ///
  /// This is the primary content area below the title bar. Can be any widget,
  /// such as forms, lists, or custom layouts.
  final Widget? content;

  /// Optional controller for programmatic window control.
  ///
  /// When provided (via [WindowWidget.controlled]), the controller manages
  /// all window state. When `null` (default constructor), widget properties
  /// control the state directly.
  final WindowController? controller;

  /// Whether the window can be resized by dragging edges/corners.
  ///
  /// Defaults to `true`. Ignored when using [WindowWidget.controlled].
  final bool? resizable;

  /// Whether the window can be moved by dragging the title bar.
  ///
  /// Defaults to `true`. Ignored when using [WindowWidget.controlled].
  final bool? draggable;

  /// Whether the window can be closed.
  ///
  /// Defaults to `true`. Ignored when using [WindowWidget.controlled].
  final bool? closable;

  /// Whether the window can be maximized.
  ///
  /// Defaults to `true`. Ignored when using [WindowWidget.controlled].
  final bool? maximizable;

  /// Whether the window can be minimized.
  ///
  /// Defaults to `true`. Ignored when using [WindowWidget.controlled].
  final bool? minimizable;

  /// Initial position and size of the window.
  ///
  /// Required for default constructor. Ignored when using [WindowWidget.controlled].
  final Rect? bounds;

  /// Initial maximized bounds, or `null` if not maximized.
  ///
  /// Ignored when using [WindowWidget.controlled].
  final Rect? maximized;

  /// Whether the window starts minimized.
  ///
  /// Defaults to `false`. Ignored when using [WindowWidget.controlled].
  final bool? minimized;

  /// Whether edge snapping is enabled.
  ///
  /// Defaults to `true`. Ignored when using [WindowWidget.controlled].
  final bool? enableSnapping;

  /// Size constraints for the window.
  ///
  /// Enforces min/max dimensions during resizing.
  /// Defaults to [kDefaultWindowConstraints]. Ignored when using [WindowWidget.controlled].
  final BoxConstraints? constraints;

  /// Height of the title bar in logical pixels.
  ///
  /// If `null`, uses the theme's default title bar height.
  final double? titleBarHeight;

  /// Thickness of the resize border in logical pixels.
  ///
  /// If `null`, uses the theme's default resize thickness.
  final double? resizeThickness;

  /// Creates a window with direct state management.
  ///
  /// All window state properties ([bounds], [minimized], etc.) are managed
  /// directly through widget properties. State changes require rebuilding
  /// the widget with new property values.
  ///
  /// Parameters:
  /// - [title]: Title bar content
  /// - [actions]: Action buttons area content
  /// - [content]: Main window content
  /// - [titleBarHeight]: Custom title bar height (optional)
  /// - [resizeThickness]: Custom resize border thickness (optional)
  /// - [resizable]: Enable resizing (defaults to `true`)
  /// - [draggable]: Enable dragging (defaults to `true`)
  /// - [closable]: Enable closing (defaults to `true`)
  /// - [maximizable]: Enable maximizing (defaults to `true`)
  /// - [minimizable]: Enable minimizing (defaults to `true`)
  /// - [enableSnapping]: Enable edge snapping (defaults to `true`)
  /// - [bounds]: Initial window bounds (required)
  /// - [maximized]: Initial maximized bounds (optional)
  /// - [minimized]: Start minimized (defaults to `false`)
  /// - [constraints]: Size constraints (defaults to [kDefaultWindowConstraints])
  const WindowWidget({
    super.key,
    this.title,
    this.actions,
    this.content,
    this.titleBarHeight,
    this.resizeThickness,
    bool this.resizable = true,
    bool this.draggable = true,
    bool this.closable = true,
    bool this.maximizable = true,
    bool this.minimizable = true,
    bool this.enableSnapping = true,
    required Rect this.bounds,
    this.maximized,
    bool this.minimized = false,
    BoxConstraints this.constraints = kDefaultWindowConstraints,
  }) : controller = null;

  /// Creates a window with controller-based state management.
  ///
  /// State is managed entirely through the provided [controller]. All state
  /// properties from the default constructor are unavailable and must be
  /// controlled via the controller instead.
  ///
  /// This pattern is recommended when you need:
  /// - Programmatic control over window state
  /// - To listen to state changes
  /// - To share state across multiple widgets
  /// - More reactive state updates
  ///
  /// Parameters:
  /// - [controller]: The window controller (required)
  /// - [title]: Title bar content
  /// - [actions]: Action buttons area content
  /// - [content]: Main window content
  /// - [titleBarHeight]: Custom title bar height (optional)
  /// - [resizeThickness]: Custom resize border thickness (optional)
  ///
  /// Example:
  /// ```dart
  /// final controller = WindowController(
  ///   bounds: Rect.fromLTWH(100, 100, 800, 600),
  /// );
  ///
  /// // Later, programmatically control:
  /// controller.minimized = true;
  /// controller.bounds = Rect.fromLTWH(200, 200, 900, 700);
  /// ```
  const WindowWidget.controlled({
    super.key,
    this.title,
    this.actions,
    this.content,
    required WindowController this.controller,
    this.titleBarHeight,
    this.resizeThickness,
  })  : bounds = null,
        maximized = null,
        minimized = null,
        resizable = null,
        draggable = null,
        closable = null,
        maximizable = null,
        minimizable = null,
        enableSnapping = null,
        constraints = null;

  const WindowWidget._raw({
    super.key,
    this.title,
    this.actions,
    this.content,
    this.resizable = true,
    this.draggable = true,
    this.closable = true,
    this.maximizable = true,
    this.minimizable = true,
    this.enableSnapping = true,
    this.controller,
    this.bounds,
    this.maximized,
    this.minimized,
    this.constraints,
  })  : titleBarHeight = null,
        resizeThickness = null;

  @override
  State<WindowWidget> createState() => _WindowWidgetState();
}

/// Interface for controlling window state and behavior.
///
/// Mixin that provides access to window properties and operations.
/// Implemented by window state classes to manage window lifecycle.
mixin WindowHandle on State<WindowWidget> {
  /// Gets the current window bounds.
  Rect get bounds;

  /// Sets the window bounds.
  set bounds(Rect value);

  /// Gets the maximized bounds, or null if not maximized.
  Rect? get maximized;

  /// Sets the maximized bounds.
  set maximized(Rect? value);

  /// Whether the window is minimized.
  bool get minimized;

  /// Sets the minimized state.
  set minimized(bool value);

  /// Whether the window has focus.
  bool get focused;

  /// Sets the focused state.
  set focused(bool value);

  /// Closes the window.
  void close();

  /// Whether the window stays on top of other windows.
  bool get alwaysOnTop;

  /// Sets the always-on-top state.
  set alwaysOnTop(bool value);

  /// Whether the window can be resized.
  bool get resizable;

  /// Whether the window can be dragged.
  bool get draggable;

  /// Whether the window can be closed.
  bool get closable;

  /// Whether the window can be maximized.
  bool get maximizable;

  /// Whether the window can be minimized.
  bool get minimizable;

  /// Whether window snapping is enabled.
  bool get enableSnapping;

  /// Sets the resizable state.
  set resizable(bool value);

  /// Sets the draggable state.
  set draggable(bool value);

  /// Sets the closable state.
  set closable(bool value);

  /// Sets the maximizable state.
  set maximizable(bool value);

  /// Sets the minimizable state.
  set minimizable(bool value);

  /// Sets the snapping enabled state.
  set enableSnapping(bool value);

  /// Gets the window controller.
  WindowController get controller;
}

class _WindowWidgetState extends State<WindowWidget> with WindowHandle {
  @override
  late WindowController controller;
  late WindowState state;
  WindowViewport? _viewport;
  Window? _entry;
  Alignment? _dragAlignment;

  void _initializeController() {
    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = WindowController(
        bounds: widget.bounds!,
        maximized: widget.maximized,
        minimized: widget.minimized!,
        closable: widget.closable!,
        resizable: widget.resizable!,
        draggable: widget.draggable!,
        maximizable: widget.maximizable!,
        minimizable: widget.minimizable!,
        enableSnapping: widget.enableSnapping!,
        constraints: widget.constraints!,
      );
    }
    controller._attachedState = this;
    state = controller.value;
    controller.addListener(_handleControllerUpdate);
  }

  void _handleControllerUpdate() {
    didControllerUpdate(state);
    state = controller.value;
  }

  void didControllerUpdate(WindowState oldState) {
    if (oldState.alwaysOnTop != state.alwaysOnTop) {
      _viewport?.navigator.setAlwaysOnTop(_entry!, state.alwaysOnTop);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewport = Data.maybeOf<WindowViewport>(context);
    _entry = Data.maybeOf<Window>(context);
  }

  @override
  void didUpdateWidget(covariant WindowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller.removeListener(_handleControllerUpdate);
      controller._attachedState = null;
      WindowState oldState = state;
      _initializeController();
      if (oldState != state) {
        didControllerUpdate(oldState);
      }
    }
  }

  Widget _wrapResizer(
      {required MouseCursor cursor,
      required Rect Function(Rect bounds, Offset delta) onResize,
      required int adjustmentX,
      required int adjustmentY}) {
    return MouseRegion(
      cursor: cursor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (details) {
          if (state.maximized != null || state.minimized) return;
          var newBounds = onResize(bounds, details.delta);
          double deltaXAdjustment = 0;
          double deltaYAdjustment = 0;
          if (newBounds.width < state.constraints.minWidth) {
            deltaXAdjustment = state.constraints.minWidth - newBounds.width;
          } else if (newBounds.width > state.constraints.maxWidth) {
            deltaXAdjustment = state.constraints.maxWidth - newBounds.width;
          }
          if (newBounds.height < state.constraints.minHeight) {
            deltaYAdjustment = state.constraints.minHeight - newBounds.height;
          } else if (newBounds.height > state.constraints.maxHeight) {
            deltaYAdjustment = state.constraints.maxHeight - newBounds.height;
          }
          deltaXAdjustment *= adjustmentX;
          deltaYAdjustment *= adjustmentY;
          if (deltaXAdjustment != 0 || deltaYAdjustment != 0) {
            newBounds =
                onResize(newBounds, Offset(deltaXAdjustment, deltaYAdjustment));
          }
          bounds = newBounds;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Data<WindowHandle>.inherit(
      data: this,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          final compTheme = ComponentTheme.maybeOf<WindowTheme>(context);
          var resizeThickness =
              widget.resizeThickness ?? compTheme?.resizeThickness ?? 8;
          final titleBarHeight =
              (widget.titleBarHeight ?? compTheme?.titleBarHeight ?? 32) *
                  theme.scaling;

          Widget windowClient = Card(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.zero,
            borderRadius: state.maximized != null
                ? BorderRadius.zero
                : theme.borderRadiusMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.title != null || widget.actions != null)
                  ClickDetector(
                    onClick: maximizable
                        ? (details) {
                            if (details.clickCount >= 2) {
                              if (maximized == null) {
                                maximized = const Rect.fromLTWH(0, 0, 1, 1);
                              } else {
                                maximized = null;
                              }
                            }
                          }
                        : null,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        var localPosition = details.localPosition;
                        var bounds = this.bounds;
                        var max = maximized;
                        var size = _viewport?.size;
                        if (max != null && size != null) {
                          bounds = Rect.fromLTWH(
                              max.left * size.width,
                              max.top * size.height,
                              max.width * size.width,
                              max.height * size.height);
                        }
                        var alignX = lerpDouble(
                            -1, 1, (localPosition.dx / bounds.width))!;
                        var alignY = lerpDouble(
                            -1, 1, (localPosition.dy / bounds.height))!;
                        _dragAlignment = Alignment(
                          alignX,
                          alignY,
                        );
                        if (_entry != null) {
                          _viewport?.navigator._state._startDraggingWindow(
                            _entry!,
                            details.globalPosition,
                          );
                        }
                        if (state.maximized != null) {
                          maximized = null;
                          RenderBox? layerRenderBox = _viewport
                              ?.navigator._state.context
                              .findRenderObject() as RenderBox?;
                          if (layerRenderBox != null) {
                            Offset layerLocal = layerRenderBox
                                .globalToLocal(details.globalPosition);
                            Size titleSize =
                                Size(this.bounds.width, titleBarHeight);
                            this.bounds = Rect.fromLTWH(
                              layerLocal.dx - titleSize.width / 2,
                              layerLocal.dy - titleSize.height / 2,
                              this.bounds.width,
                              this.bounds.height,
                            );
                          }
                        }
                      },
                      onPanUpdate: (details) {
                        bounds = bounds.translate(
                          details.delta.dx,
                          details.delta.dy,
                        );
                        if (_entry != null) {
                          _viewport?.navigator._state._updateDraggingWindow(
                            _entry!,
                            details.globalPosition,
                          );
                        }
                      },
                      onPanEnd: (details) {
                        if (_entry != null) {
                          _viewport?.navigator._state._stopDraggingWindow(
                            _entry!,
                          );
                        }
                        _dragAlignment = null;
                      },
                      onPanCancel: () {
                        if (_entry != null) {
                          _viewport?.navigator._state._stopDraggingWindow(
                            _entry!,
                          );
                        }
                        _dragAlignment = null;
                      },
                      child: Container(
                        height: titleBarHeight,
                        padding: EdgeInsets.all(
                          2 * theme.scaling,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8 * theme.scaling,
                                ),
                                child: (_viewport?.focused ?? true)
                                    ? (widget.title ?? const SizedBox())
                                    : (widget.title ?? const SizedBox())
                                        .muted(),
                              ),
                            ),
                            if (widget.actions != null) widget.actions!,
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.content != null)
                  Expanded(
                    child: widget.content!,
                  ),
              ],
            ),
          );
          // add transition
          windowClient = AnimatedValueBuilder(
              initialValue: 0.0,
              value: (_viewport?.closed ?? false) ? 0.0 : 1.0,
              duration: kDefaultDuration,
              onEnd: (value) {
                if (_viewport?.closed ?? false) {
                  _viewport?.navigator.removeWindow(_entry!);
                }
              },
              builder: (context, value, child) {
                return Transform.scale(
                  scale: (_viewport?.closed ?? false)
                      ? lerpDouble(0.8, 1.0, value)!
                      : lerpDouble(0.9, 1.0, value)!,
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: windowClient);
          windowClient = AnimatedScale(
            scale: (_viewport?.minify ?? false) ? 0.65 : 1.0,
            duration: kDefaultDuration,
            alignment: _dragAlignment ?? Alignment.center,
            curve: Curves.easeInOut,
            child: windowClient,
          );
          windowClient = IgnorePointer(
            ignoring: _viewport?.ignorePointer ?? false,
            child: windowClient,
          );
          Widget windowContainer = Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              if (_entry != null) {
                _viewport?.navigator.focusWindow(_entry!);
              }
            },
            child: GroupWidget(
              children: [
                windowClient,
                // Resize regions
                if (resizable &&
                    maximized == null &&
                    _dragAlignment == null) ...[
                  // top left
                  GroupPositioned(
                    top: 0,
                    left: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpLeft,
                      adjustmentX: -1,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + delta,
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // top right
                  GroupPositioned(
                    top: 0,
                    right: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpRight,
                      adjustmentX: 1,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topRight + delta,
                          bounds.bottomLeft,
                        );
                      },
                    ),
                  ),
                  // bottom left
                  GroupPositioned(
                    bottom: 0,
                    left: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeDownLeft,
                      adjustmentX: -1,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomLeft + delta,
                          bounds.topRight,
                        );
                      },
                    ),
                  ),
                  // bottom right
                  GroupPositioned(
                    bottom: 0,
                    right: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeDownRight,
                      adjustmentX: 1,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomRight + delta,
                          bounds.topLeft,
                        );
                      },
                    ),
                  ),
                  // top
                  GroupPositioned(
                    top: 0,
                    left: resizeThickness * theme.scaling,
                    right: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpDown,
                      adjustmentX: 0,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + Offset(0, delta.dy),
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // bottom
                  GroupPositioned(
                    bottom: 0,
                    left: resizeThickness * theme.scaling,
                    right: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpDown,
                      adjustmentX: 0,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomLeft + Offset(0, delta.dy),
                          bounds.topRight,
                        );
                      },
                    ),
                  ),
                  // left
                  GroupPositioned(
                    top: resizeThickness * theme.scaling,
                    left: 0,
                    bottom: resizeThickness * theme.scaling,
                    width: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeLeftRight,
                      adjustmentX: -1,
                      adjustmentY: 0,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + Offset(delta.dx, 0),
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // right
                  GroupPositioned(
                    top: resizeThickness * theme.scaling,
                    right: 0,
                    bottom: resizeThickness * theme.scaling,
                    width: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeLeftRight,
                      adjustmentX: 1,
                      adjustmentY: 0,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topRight + Offset(delta.dx, 0),
                          bounds.bottomLeft,
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
          return AnimatedValueBuilder.raw(
            value: maximized,
            duration: kDefaultDuration,
            curve: Curves.easeInOut,
            lerp: Rect.lerp,
            builder: (context, oldValue, newValue, t, child) {
              var rect = bounds;
              if (newValue != null) {
                var size = _viewport?.size ?? Size.zero;
                var value = Rect.fromLTWH(
                    newValue.left * size.width,
                    newValue.top * size.height,
                    newValue.width * size.width,
                    newValue.height * size.height);
                rect = Rect.lerp(bounds, value, t)!;
              } else if (oldValue != null) {
                var size = _viewport?.size ?? Size.zero;
                var value = Rect.fromLTWH(
                    oldValue.left * size.width,
                    oldValue.top * size.height,
                    oldValue.width * size.width,
                    oldValue.height * size.height);
                rect = Rect.lerp(value, bounds, t)!;
              }
              return GroupPositioned.fromRect(rect: rect, child: child!);
            },
            child: windowContainer,
          );
        },
      ),
    );
  }

  @override
  bool get alwaysOnTop => state.alwaysOnTop;

  @override
  Rect get bounds => state.bounds;

  @override
  bool get closable => state.closable;

  @override
  bool get draggable => state.draggable;

  @override
  bool get enableSnapping => state.enableSnapping;

  @override
  bool get maximizable => state.maximizable;

  @override
  Rect? get maximized => state.maximized;

  @override
  bool get minimizable => state.minimizable;

  @override
  bool get minimized => state.minimized;

  @override
  bool get resizable => state.resizable;

  @override
  bool get focused => state.alwaysOnTop;

  @override
  set alwaysOnTop(bool value) {
    if (value != state.alwaysOnTop) {
      controller.value = state.copyWith(alwaysOnTop: () => value);
    }
  }

  @override
  set bounds(Rect value) {
    if (value != state.bounds) {
      controller.value = state.copyWith(bounds: () => value);
    }
  }

  @override
  set closable(bool value) {
    if (value != state.closable) {
      controller.value = state.copyWith(closable: () => value);
    }
  }

  @override
  void close() {
    _entry?.closed.value = true;
  }

  @override
  set draggable(bool value) {
    if (value != state.draggable) {
      controller.value = state.copyWith(draggable: () => value);
    }
  }

  @override
  set enableSnapping(bool value) {
    if (value != state.enableSnapping) {
      controller.value = state.copyWith(enableSnapping: () => value);
    }
  }

  @override
  set focused(bool value) {
    if (_entry == null) return;
    if (value) {
      _viewport?.navigator.focusWindow(_entry!);
    } else {
      _viewport?.navigator.unfocusWindow(_entry!);
    }
  }

  @override
  set maximizable(bool value) {
    if (value != state.maximizable) {
      controller.value = state.copyWith(maximizable: () => value);
    }
  }

  @override
  set maximized(Rect? value) {
    if (value != state.maximized) {
      controller.value = state.withMaximized(value);
    }
  }

  @override
  set minimizable(bool value) {
    if (value != state.minimizable) {
      controller.value = state.copyWith(minimizable: () => value);
    }
  }

  @override
  set minimized(bool value) {
    if (value != state.minimized) {
      controller.value = state.copyWith(minimized: () => value);
    }
  }

  @override
  set resizable(bool value) {
    if (value != state.resizable) {
      controller.value = state.copyWith(resizable: () => value);
    }
  }
}

/// A widget that manages multiple floating windows.
///
/// Provides a desktop-style window management system where multiple windows
/// can be displayed, dragged, resized, minimized, and maximized.
///
/// Example:
/// ```dart
/// WindowNavigator(
///   initialWindows: [
///     Window(
///       controller: WindowController(bounds: Rect.fromLTWH(100, 100, 400, 300)),
///       child: Text('Window Content'),
///     ),
///   ],
/// )
/// ```
class WindowNavigator extends StatefulWidget {
  /// Initial list of windows to display.
  final List<Window> initialWindows;

  /// Optional background child widget.
  final Widget? child;

  /// Whether to show the top snap bar for window snapping.
  final bool showTopSnapBar;

  /// Creates a [WindowNavigator].
  ///
  /// Parameters:
  /// - [initialWindows] (`List<Window>`, required): Windows to display initially.
  /// - [child] (`Widget?`, optional): Background widget.
  /// - [showTopSnapBar] (`bool`, default: `true`): Show snap bar.
  const WindowNavigator({
    super.key,
    required this.initialWindows,
    this.child,
    this.showTopSnapBar = true,
  });

  @override
  State<WindowNavigator> createState() => _WindowNavigatorState();
}

/// A comprehensive windowing system for creating desktop-like window interfaces.
///
/// **EXPERIMENTAL COMPONENT** - This component is in active development and APIs may change.
///
/// Provides a complete window management solution with draggable, resizable windows
/// that support minimizing, maximizing, and snapping to screen edges. Designed for
/// desktop-style applications requiring multiple simultaneous content areas.
///
/// Core Features:
/// - **Window Management**: Create, control, and destroy floating windows
/// - **Interactive Behaviors**: Drag, resize, minimize, maximize, close operations
/// - **Snapping System**: Intelligent edge snapping and window positioning
/// - **Layering Control**: Always-on-top and z-order management
/// - **Constraint System**: Size and position limits with validation
/// - **Theme Integration**: Full shadcn_flutter theme and styling support
///
/// Architecture:
/// - **Window**: Immutable window configuration and factory
/// - **WindowController**: Reactive state management for window properties
/// - **WindowWidget**: Stateful widget that renders the actual window
/// - **WindowNavigator**: Container managing multiple windows
///
/// The system supports both controlled (external state management) and
/// uncontrolled (internal state management) modes for different use cases.
///
/// Usage Patterns:
/// 1. **Simple Window**: Basic window with default behaviors
/// 2. **Controlled Window**: External state management with WindowController
/// 3. **Window Navigator**: Multiple windows with shared management
///
/// Example:
/// ```dart
/// // Simple window
/// final window = Window(
///   title: Text('My Window'),
///   content: MyContent(),
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
///   resizable: true,
///   draggable: true,
/// );
///
/// // Controlled window
/// final controller = WindowController(initialState);
/// final controlledWindow = Window.controlled(
///   controller: controller,
///   title: Text('Controlled Window'),
///   content: MyContent(),
/// );
/// ```
class Window {
  /// Title widget displayed in the window's title bar.
  final Widget? title;

  /// Custom action widgets displayed in the title bar (e.g., minimize, maximize, close buttons).
  final Widget? actions;

  /// Main content widget displayed in the window body.
  final Widget? content;

  /// Controller for programmatic window management (position, size, state).
  final WindowController? controller;

  /// Initial bounds (position and size) of the window.
  final Rect? bounds;

  /// Bounds when window is in maximized state.
  final Rect? maximized;

  /// Whether the window starts in minimized state.
  final bool? minimized;

  /// Whether the window should always appear on top of other windows.
  final bool? alwaysOnTop;

  /// Whether window snapping is enabled (snap to edges or other windows).
  final bool? enableSnapping;

  /// Whether the window can be resized by dragging edges.
  final bool? resizable;

  /// Whether the window can be dragged by its title bar.
  final bool? draggable;

  /// Whether the window can be closed via the close button.
  final bool? closable;

  /// Whether the window can be maximized.
  final bool? maximizable;

  /// Whether the window can be minimized.
  final bool? minimizable;

  /// Size constraints for the window (min/max width and height).
  final BoxConstraints? constraints;

  final GlobalKey<_WindowWidgetState> _key = GlobalKey<_WindowWidgetState>(
    debugLabel: 'Window',
  );

  /// Notifier that indicates whether the window has been closed.
  ///
  /// External code can listen to this notifier to react to window close events.
  final ValueNotifier<bool> closed = ValueNotifier(false);

  /// Creates a controlled window with behavior managed by a [WindowController].
  ///
  /// This constructor creates a window whose state (position, size, minimized,
  /// maximized) is entirely controlled programmatically through the provided
  /// controller. All state properties are null and managed via the controller.
  ///
  /// Parameters:
  /// - [title] (Widget?): Title widget for the title bar
  /// - [actions] (Widget?): Custom action widgets, defaults to `WindowActions()`
  /// - [content] (Widget?): Main content widget
  /// - [controller] (WindowController, required): Controller for programmatic management
  ///
  /// Example:
  /// ```dart
  /// Window.controlled(
  ///   controller: myWindowController,
  ///   title: Text('Controlled Window'),
  ///   content: MyContentWidget(),
  /// )
  /// ```
  Window.controlled({
    this.title,
    this.actions = const WindowActions(),
    this.content,
    required this.controller,
  })  : bounds = null,
        maximized = null,
        minimized = null,
        alwaysOnTop = null,
        resizable = null,
        draggable = null,
        maximizable = null,
        minimizable = null,
        enableSnapping = null,
        closable = null,
        constraints = null;

  /// Creates a window with explicit state and configuration.
  ///
  /// This constructor creates a window with directly specified state properties
  /// rather than using a controller. The window's initial position, size, and
  /// capabilities are defined through the constructor parameters.
  ///
  /// Parameters:
  /// - [title] (Widget?): Title widget for the title bar
  /// - [actions] (Widget?): Custom action widgets, defaults to `WindowActions()`
  /// - [content] (Widget?): Main content widget
  /// - [resizable] (bool): Whether window can be resized, defaults to true
  /// - [draggable] (bool): Whether window can be dragged, defaults to true
  /// - [closable] (bool): Whether window can be closed, defaults to true
  /// - [maximizable] (bool): Whether window can be maximized, defaults to true
  /// - [minimizable] (bool): Whether window can be minimized, defaults to true
  /// - [enableSnapping] (bool): Whether snapping is enabled, defaults to true
  /// - [bounds] (Rect, required): Initial window bounds (position and size)
  /// - [maximized] (Rect?): Bounds when maximized
  /// - [minimized] (bool): Whether starts minimized, defaults to false
  /// - [alwaysOnTop] (bool): Whether always on top, defaults to false
  /// - [constraints] (BoxConstraints): Size constraints, defaults to `kDefaultWindowConstraints`
  ///
  /// Example:
  /// ```dart
  /// Window(
  ///   title: Text('My Window'),
  ///   bounds: Rect.fromLTWH(100, 100, 400, 300),
  ///   resizable: true,
  ///   content: MyContentWidget(),
  /// )
  /// ```
  Window({
    this.title,
    this.actions = const WindowActions(),
    this.content,
    bool this.resizable = true,
    bool this.draggable = true,
    bool this.closable = true,
    bool this.maximizable = true,
    bool this.minimizable = true,
    bool this.enableSnapping = true,
    required this.bounds,
    this.maximized,
    bool this.minimized = false,
    bool this.alwaysOnTop = false,
    BoxConstraints this.constraints = kDefaultWindowConstraints,
  }) : controller = null;

  /// Gets a handle to the window's internal state.
  ///
  /// Provides access to the window's state for programmatic control.
  /// The window must be mounted (added to the widget tree) before accessing
  /// this handle.
  ///
  /// Throws [AssertionError] if the window is not mounted.
  ///
  /// Returns [WindowHandle] for controlling the window state.
  WindowHandle get handle {
    var currentState = _key.currentState;
    assert(currentState != null, 'Window is not mounted');
    return currentState!;
  }

  /// Indicates whether the window is currently mounted in the widget tree.
  ///
  /// A window is mounted when it has been added to the widget tree and has
  /// an associated build context. Unmounted windows cannot be controlled or
  /// accessed.
  ///
  /// Returns true if window is mounted, false otherwise.
  bool get mounted => _key.currentContext != null;

  Widget _build(
      {required bool focused,
      required WindowNavigatorHandle navigator,
      required bool alwaysOnTop,
      required Size size,
      required bool minifyDragging,
      bool ignorePointer = false}) {
    return ListenableBuilder(
        listenable: closed,
        child: Data.inherit(
          data: this,
          child: WindowWidget._raw(
            key: _key,
            title: title,
            actions: actions,
            content: content,
            resizable: resizable,
            draggable: draggable,
            closable: closable,
            maximizable: maximizable,
            minimizable: minimizable,
            enableSnapping: enableSnapping,
            controller: controller,
            bounds: bounds,
            maximized: maximized,
            minimized: minimized,
            constraints: constraints,
          ),
        ),
        builder: (context, child) {
          return Data.inherit(
            data: WindowViewport(
              ignorePointer: ignorePointer,
              size: size,
              navigator: navigator,
              focused: focused,
              alwaysOnTop: alwaysOnTop,
              closed: closed.value,
              minify: minifyDragging,
            ),
            child: child,
          );
        });
  }
}

/// Mixin providing window management capabilities for WindowNavigator state.
///
/// This mixin defines the interface for managing multiple windows in a
/// window navigator. It provides methods for adding, removing, focusing,
/// and managing window states.
///
/// Implementations must provide these core window management operations:
/// - Adding and removing windows from the navigator
/// - Managing window focus and z-order
/// - Controlling always-on-top behavior
/// - Querying window focus state and window list
///
/// See also:
/// - [WindowNavigator], the widget that uses this mixin
/// - [Window], the window objects being managed
mixin WindowNavigatorHandle on State<WindowNavigator> {
  /// Adds a new window to the navigator.
  ///
  /// The window is added to the navigator's window list and typically
  /// appears at the top of the window stack with focus.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to add
  void pushWindow(Window window);

  /// Brings a window to the front and gives it focus.
  ///
  /// Moves the specified window to the top of the window stack and
  /// sets it as the focused window for keyboard input and user interaction.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to focus
  void focusWindow(Window window);

  /// Removes focus from a window without closing it.
  ///
  /// The window remains in the navigator but loses focus. Another window
  /// may receive focus, or no window may be focused.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to unfocus
  void unfocusWindow(Window window);

  /// Sets whether a window should always appear on top.
  ///
  /// Always-on-top windows remain above other windows even when they
  /// lose focus. Useful for tool palettes and notification windows.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to modify
  /// - [value] (bool, required): True to set always-on-top, false to disable
  void setAlwaysOnTop(Window window, bool value);

  /// Removes a window from the navigator.
  ///
  /// The window is removed from the navigator's window list and destroyed.
  /// If the window was focused, focus may move to another window.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to remove
  void removeWindow(Window window);

  /// Checks if a window is currently focused.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to check
  ///
  /// Returns true if the window is focused, false otherwise.
  bool isFocused(Window window);

  /// Gets the list of all windows in the navigator.
  ///
  /// Returns an ordered list of windows, typically in z-order from
  /// bottom to top.
  List<Window> get windows;

  _WindowNavigatorState get _state {
    return this as _WindowNavigatorState;
  }
}

/// Default size constraints for window components.
///
/// Defines minimum width and height values to ensure windows
/// remain usable and visible.
///
/// The constraints are:
/// - Minimum width: 200 pixels
/// - Minimum height: 200 pixels
const kDefaultWindowConstraints = BoxConstraints(
  minWidth: 200,
  minHeight: 200,
);

class _DraggingWindow {
  final Window window;
  final Offset cursorPosition;

  _DraggingWindow(this.window, this.cursorPosition);
}

class _WindowLayerGroup extends StatelessWidget {
  final BoxConstraints constraints;
  final List<Window> windows;
  final _WindowNavigatorState handle;
  final bool alwaysOnTop;
  final bool showTopSnapBar;

  const _WindowLayerGroup(
      {required this.constraints,
      required this.windows,
      required this.handle,
      required this.alwaysOnTop,
      required this.showTopSnapBar});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createPaneSnapStrategy = handle._createPaneSnapStrategy;
    return GroupWidget(
      children: [
        for (int i = windows.length - 1; i >= 0; i--)
          if (windows[i] != handle._draggingWindow.value?.window)
            windows[i]._build(
                size: constraints.biggest,
                navigator: handle,
                focused: i == 0,
                alwaysOnTop: false,
                ignorePointer: false,
                minifyDragging: handle._snappingStrategy.value != null &&
                    handle._snappingStrategy.value!.shouldMinifyWindow &&
                    handle._draggingWindow.value != null &&
                    handle._draggingWindow.value!.window == windows[i]),
        if (handle._snappingStrategy.value != null &&
            handle._draggingWindow.value != null &&
            handle._draggingWindow.value!.window.alwaysOnTop == alwaysOnTop)
          GroupPositioned.fromRect(
            rect: Rect.fromLTWH(
              handle._snappingStrategy.value!.relativeBounds.left *
                  constraints.biggest.width,
              handle._snappingStrategy.value!.relativeBounds.top *
                  constraints.biggest.height,
              handle._snappingStrategy.value!.relativeBounds.width *
                  constraints.biggest.width,
              handle._snappingStrategy.value!.relativeBounds.height *
                  constraints.biggest.height,
            ),
            child: _BlurContainer(
              key: ValueKey(handle._snappingStrategy.value),
            ),
          ),
        if (showTopSnapBar)
          ListenableBuilder(
              listenable: handle._hoveringTopSnapper,
              builder: (context, _) {
                return GroupPositioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: MouseRegion(
                      onEnter: (_) {
                        handle._hoveringTopSnapper.value = true;
                      },
                      onExit: (_) {
                        handle._hoveringTopSnapper.value = false;
                        handle._snappingStrategy.value = null;
                      },
                      hitTestBehavior: HitTestBehavior.translucent,
                      child: AnimatedValueBuilder(
                        value: handle._draggingWindow.value == null ||
                                handle._draggingWindow.value!.window
                                        .alwaysOnTop !=
                                    alwaysOnTop
                            ? -1.0
                            : handle._hoveringTopSnapper.value
                                ? 0.0
                                : -0.85,
                        duration: handle._hoveringTopSnapper.value
                            ? const Duration(milliseconds: 300)
                            : kDefaultDuration,
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(
                                0,
                                unlerpDouble(value, -1.0, 0.0).clamp(0, 1) *
                                    24),
                            child: FractionalTranslation(
                                translation: Offset(0, value),
                                child: OutlinedContainer(
                                  height: 100,
                                  padding:
                                      const EdgeInsets.all(8) * theme.scaling,
                                  child: Opacity(
                                    opacity: unlerpDouble(value, -0.85, 0.0)
                                        .clamp(0, 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 8 * theme.scaling,
                                      children: [
                                        // 0.5 | 0.5
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 0.5, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0, 0.5, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // 0.7 | 0.3
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 0.7, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.7, 0, 0.3, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // (0.5, 1) | (0.5, 0.5)
                                        //          | (0.5, 0.5)
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0.0, 0.5, 1.0),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0, 0.5, 0.5),
                                                  ),
                                                  bottomLeft: true,
                                                  bottomRight: true,
                                                  topLeft: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0.5, 0.5, 0.5),
                                                  ),
                                                  topLeft: true,
                                                  topRight: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // (0.5, 0.5) | (0.5, 0.5)
                                        // (0.5, 0.5) | (0.5, 0.5)
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 0.5, 0.5),
                                                  ),
                                                  bottomRight: true,
                                                  topRight: true,
                                                  bottomLeft: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0, 0.5, 0.5),
                                                  ),
                                                  bottomLeft: true,
                                                  topLeft: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0.5, 0.5, 0.5),
                                                  ),
                                                  topLeft: true,
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0.5, 0.5, 0.5),
                                                  ),
                                                  topLeft: true,
                                                  topRight: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // 1/3 | 1/3 | 1/3
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 1 / 3, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            1 / 3, 0, 1 / 3, 1),
                                                  ),
                                                  allLeft: true,
                                                  allRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            2 / 3, 0, 1 / 3, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // 2/7 | 3/7 | 2/7
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 2 / 7, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            2 / 7, 0, 3 / 7, 1),
                                                  ),
                                                  allLeft: true,
                                                  allRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            5 / 7, 0, 2 / 7, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
        if (handle._draggingWindow.value != null &&
            handle._draggingWindow.value!.window.alwaysOnTop == alwaysOnTop)
          handle._draggingWindow.value!.window._build(
            size: constraints.biggest,
            navigator: handle,
            focused: true,
            alwaysOnTop: handle._draggingWindow.value!.window.alwaysOnTop ??
                handle._draggingWindow.value!.window.controller?.value
                    .alwaysOnTop ??
                false,
            minifyDragging: handle._snappingStrategy.value != null &&
                handle._snappingStrategy.value!.shouldMinifyWindow,
            ignorePointer: true,
          ),
      ],
    );
  }
}

class _WindowNavigatorState extends State<WindowNavigator>
    with WindowNavigatorHandle {
  late List<Window> _windows;
  late List<Window> _topWindows;
  int _focusLayer = 0; // 0: background, 1: foreground, 2: foremost

  final ValueNotifier<_DraggingWindow?> _draggingWindow =
      ValueNotifier<_DraggingWindow?>(null);
  final ValueNotifier<bool> _hoveringTopSnapper = ValueNotifier(false);
  final ValueNotifier<WindowSnapStrategy?> _snappingStrategy =
      ValueNotifier(null);

  void _startDraggingWindow(Window draggingWindow, Offset cursorPosition) {
    if (_draggingWindow.value != null) return;
    _draggingWindow.value = _DraggingWindow(draggingWindow, cursorPosition);
  }

  void _updateDraggingWindow(Window handle, Offset cursorPosition) {
    if (_draggingWindow.value == null ||
        _draggingWindow.value!.window != handle) {
      return;
    }
    _draggingWindow.value =
        _DraggingWindow(_draggingWindow.value!.window, cursorPosition);
  }

  void _stopDraggingWindow(Window handle) {
    if (_draggingWindow.value == null ||
        _draggingWindow.value!.window != handle) {
      return;
    }
    var snapping = _snappingStrategy.value;
    if (snapping != null && handle.mounted) {
      handle.handle.maximized = snapping.relativeBounds;
    }
    _draggingWindow.value = null;
    _hoveringTopSnapper.value = false;
    _snappingStrategy.value = null;
  }

  @override
  List<Window> get windows => UnmodifiableListView(_windows + _topWindows);

  @override
  void initState() {
    super.initState();
    _windows = [];
    _topWindows = [];
    for (var window in widget.initialWindows) {
      if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
        _topWindows.add(window);
      } else {
        _windows.add(window);
      }
    }
  }

  @override
  bool isFocused(Window window) {
    if (_focusLayer == 0) return false;
    if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
      if (_focusLayer == 1) return false;
      int index = _topWindows.indexOf(window);
      return index == 0;
    } else {
      if (_focusLayer == 2) return false;
      int index = _windows.indexOf(window);
      return index == 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<WindowTheme>(context);
    final titleBarHeight = (compTheme?.titleBarHeight ?? 32) * theme.scaling;
    return LayoutBuilder(builder: (context, constraints) {
      return ListenableBuilder(
          listenable: Listenable.merge([
            _draggingWindow,
            _snappingStrategy,
          ]),
          builder: (context, child) {
            return ClipRect(
              child: GroupWidget(
                children: [
                  Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (_) {
                      if (_focusLayer != 0) {
                        setState(() {
                          _focusLayer = 0;
                        });
                      }
                    },
                    child: widget.child,
                  ),
                  _WindowLayerGroup(
                    constraints: constraints,
                    windows: _windows,
                    handle: this,
                    alwaysOnTop: false,
                    showTopSnapBar: widget.showTopSnapBar,
                  ),
                  _WindowLayerGroup(
                    constraints: constraints,
                    windows: _topWindows,
                    handle: this,
                    alwaysOnTop: true,
                    showTopSnapBar: widget.showTopSnapBar,
                  ),
                  GroupPositioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: titleBarHeight,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0, 0, 1, 1),
                        shouldMinifyWindow: false,
                      ))),
                  GroupPositioned(
                      top: titleBarHeight,
                      bottom: 0,
                      left: 0,
                      width: titleBarHeight,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0, 0, 0.5, 1),
                        shouldMinifyWindow: false,
                      ))),
                  GroupPositioned(
                      top: titleBarHeight,
                      bottom: 0,
                      right: 0,
                      width: titleBarHeight,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0.5, 0, 0.5, 1),
                        shouldMinifyWindow: false,
                      ))),
                ],
              ),
            );
          });
    });
  }

  Widget _createBorderSnapStrategy(WindowSnapStrategy snapStrategy) {
    return MouseRegion(
      opaque: false,
      hitTestBehavior: HitTestBehavior.translucent,
      onHover: (event) {
        _snappingStrategy.value = snapStrategy;
      },
      onEnter: (event) {
        _snappingStrategy.value = snapStrategy;
      },
      onExit: (event) {
        _snappingStrategy.value = null;
      },
    );
  }

  Widget _createPaneSnapStrategy(
      Size size, ThemeData theme, WindowSnapStrategy snapStrategy,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRight = false,
      bool allLeft = false,
      bool allRight = false,
      bool allTop = false,
      bool allBottom = false}) {
    const double gap = 2;
    var left = snapStrategy.relativeBounds.left * size.width;
    var top = snapStrategy.relativeBounds.top * size.height;
    var width = snapStrategy.relativeBounds.width * size.width;
    var height = snapStrategy.relativeBounds.height * size.height;
    if (topLeft && topRight) {
      top += gap;
      height -= gap;
      if (bottomLeft) {
        left += gap;
        width -= gap;
      } else if (bottomRight) {
        width -= gap;
      }
    } else if (bottomLeft && bottomRight) {
      height -= gap;
      if (topLeft) {
        left += gap;
        width -= gap;
      } else if (topRight) {
        width -= gap;
      }
    } else if (topLeft && bottomLeft) {
      left += gap;
      width -= gap;
      if (topRight) {
        top += gap;
        height -= gap;
      } else if (bottomRight) {
        height -= gap;
      }
    } else if (topRight && bottomRight) {
      width -= gap;
      if (topLeft) {
        top += gap;
        height -= gap;
      } else if (bottomLeft) {
        height -= gap;
      }
    } else if (allLeft && allRight) {
      left += gap;
      width -= gap * 2;
      if (allTop) {
        top += gap;
        height -= gap;
      } else if (allBottom) {
        height -= gap;
      }
    } else if (allTop && allBottom) {
      top += gap;
      height -= gap * 2;
      if (allLeft) {
        left += gap;
        width -= gap;
      } else if (allRight) {
        width -= gap;
      }
    }
    return GroupPositioned.fromRect(
      rect: Rect.fromLTWH(
        left,
        top,
        width,
        height,
      ),
      child: _SnapHover(
        topLeft: topLeft || allLeft || allTop,
        topRight: topRight || allRight || allTop,
        bottomLeft: bottomLeft || allLeft || allBottom,
        bottomRight: bottomRight || allRight || allBottom,
        hovering: (value) {
          if (value) {
            _snappingStrategy.value = snapStrategy;
          }
        },
      ),
    );
  }

  @override
  void focusWindow(Window window) {
    if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
      _topWindows.remove(window);
      _topWindows.insert(0, window);
      _focusLayer = 2;
    } else {
      _windows.remove(window);
      _windows.insert(0, window);
      _focusLayer = 1;
    }
    setState(() {});
  }

  @override
  void pushWindow(Window window) {
    setState(() {
      if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
        _topWindows.insert(0, window);
      } else {
        _windows.insert(0, window);
      }
    });
  }

  @override
  void removeWindow(Window window) {
    setState(() {
      _windows.remove(window);
      _topWindows.remove(window);
    });
  }

  @override
  void setAlwaysOnTop(Window window, bool value) {
    if (value && _windows.contains(window)) {
      _windows.remove(window);
      _topWindows.add(window);
    } else if (!value && _topWindows.contains(window)) {
      _topWindows.remove(window);
      _windows.add(window);
    }
  }

  @override
  void unfocusWindow(Window window) {
    _focusLayer = 0;
  }
}

class _SnapHover extends StatefulWidget {
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;
  final ValueChanged<bool> hovering;

  const _SnapHover({
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
    required this.hovering,
  });

  @override
  State<_SnapHover> createState() => _SnapHoverState();
}

class _SnapHoverState extends State<_SnapHover> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
          widget.hovering(true);
        });
      },
      onHover: (_) {
        setState(() {
          _hovering = true;
          widget.hovering(true);
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
          widget.hovering(false);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              _hovering ? theme.colorScheme.secondary : theme.colorScheme.card,
          border: Border.all(
            color: theme.colorScheme.border,
          ),
          borderRadius: BorderRadius.only(
            topLeft:
                widget.topLeft ? theme.radiusSmRadius : theme.radiusLgRadius,
            topRight:
                widget.topRight ? theme.radiusSmRadius : theme.radiusLgRadius,
            bottomLeft:
                widget.bottomLeft ? theme.radiusSmRadius : theme.radiusLgRadius,
            bottomRight: widget.bottomRight
                ? theme.radiusSmRadius
                : theme.radiusLgRadius,
          ),
        ),
      ),
    );
  }
}

/// Data class containing viewport information for a window.
///
/// WindowViewport provides contextual information about a window's current
/// state within the window navigator. This data is made available to child
/// widgets through the Data inheritance mechanism.
///
/// The viewport information includes:
/// - Size of the visible area
/// - Reference to the navigator managing the window
/// - Focus and display state flags
/// - Interaction state (pointer events, minimization)
///
/// This class is typically used internally by the window system to pass
/// state information to window content and decoration widgets.
class WindowViewport {
  /// The size of the window's visible area.
  final Size size;

  /// Reference to the window navigator managing this window.
  final WindowNavigatorHandle navigator;

  /// Whether this window currently has focus.
  final bool focused;

  /// Whether this window is set to always appear on top.
  final bool alwaysOnTop;

  /// Whether this window has been closed.
  final bool closed;

  /// Whether the window is being minimized (transitioning to minimized state).
  final bool minify;

  /// Whether pointer events should be ignored for this window.
  final bool ignorePointer;

  /// Creates a window viewport data object.
  ///
  /// All parameters are required and define the current state of the window
  /// within its viewport context.
  ///
  /// Parameters:
  /// - [size] (Size, required): Visible area size
  /// - [navigator] (WindowNavigatorHandle, required): Managing navigator
  /// - [focused] (bool, required): Focus state
  /// - [alwaysOnTop] (bool, required): Always-on-top state
  /// - [closed] (bool, required): Closed state
  /// - [minify] (bool, required): Minimizing state
  /// - [ignorePointer] (bool, required): Pointer event state
  const WindowViewport({
    required this.size,
    required this.navigator,
    required this.focused,
    required this.alwaysOnTop,
    required this.closed,
    required this.minify,
    required this.ignorePointer,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WindowViewport) return false;
    return size == other.size &&
        navigator == other.navigator &&
        focused == other.focused &&
        alwaysOnTop == other.alwaysOnTop &&
        closed == other.closed &&
        minify == other.minify;
  }

  @override
  int get hashCode =>
      Object.hash(size, navigator, focused, alwaysOnTop, closed, minify);
}

/// Default window actions widget providing minimize, maximize, and close buttons.
///
/// This widget provides the standard set of window control buttons typically
/// found in window title bars. The buttons automatically adapt based on the
/// window's capabilities (minimizable, maximizable, closable).
///
/// The widget retrieves window state from the build context using the Data
/// inheritance mechanism, accessing [WindowHandle] and [WindowViewport] data.
///
/// Buttons included:
/// - Minimize button: Collapses the window (if minimizable)
/// - Maximize/Restore button: Toggles between maximized and normal states (if maximizable)
/// - Close button: Closes the window (if closable)
///
/// Example:
/// ```dart
/// Window(
///   title: Text('My Window'),
///   actions: WindowActions(), // Default window controls
///   content: MyContent(),
/// )
/// ```
class WindowActions extends StatelessWidget {
  /// Creates a default window actions widget.
  ///
  /// This widget automatically displays appropriate control buttons based on
  /// the window's configuration and capabilities.
  const WindowActions({super.key});

  @override
  Widget build(BuildContext context) {
    WindowHandle? handle = Data.maybeOf<WindowHandle>(context);
    WindowViewport? viewport = Data.maybeOf<WindowViewport>(context);
    return Row(
      children: [
        if (handle?.minimizable ?? true)
          IconButton.ghost(
            icon: const Icon(Icons.minimize),
            size: ButtonSize.small,
            onPressed: () {
              handle?.minimized = !handle.minimized;
            },
          ),
        if (handle?.maximizable ?? true)
          IconButton.ghost(
            icon: const Icon(Icons.crop_square),
            size: ButtonSize.small,
            onPressed: () {
              if (handle != null) {
                if (handle.maximized != null) {
                  handle.maximized = null;
                } else {
                  handle.maximized = viewport?.navigator._state
                          ._snappingStrategy.value?.relativeBounds ??
                      const Rect.fromLTWH(0, 0, 1, 1);
                }
              }
            },
          ),
        if (handle?.closable ?? true)
          IconButton.ghost(
            icon: const Icon(Icons.close),
            size: ButtonSize.small,
            onPressed: () {
              handle?.close();
            },
          )
      ],
    );
  }
}

class _BlurContainer extends StatelessWidget {
  const _BlurContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedValueBuilder(
        initialValue: 0.0,
        value: 1.0,
        duration: kDefaultDuration,
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: lerpDouble(0.8, 1.0, value)!,
              child: Padding(
                padding: const EdgeInsets.all(8) * theme.scaling,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.border,
                        ),
                        color: theme.colorScheme.card.withAlpha(100),
                        borderRadius: theme.borderRadiusMd,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
