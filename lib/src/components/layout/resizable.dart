import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/resizer.dart';

/// Theme for [HorizontalResizableDragger] and [VerticalResizableDragger].
class ResizableDraggerTheme {
  /// Background color of the dragger.
  final Color? color;

  /// Border radius of the dragger.
  final double? borderRadius;

  /// Width of the dragger.
  final double? width;

  /// Height of the dragger.
  final double? height;

  /// Icon size inside the dragger.
  final double? iconSize;

  /// Icon color inside the dragger.
  final Color? iconColor;

  /// Creates a [ResizableDraggerTheme].
  const ResizableDraggerTheme({
    this.color,
    this.borderRadius,
    this.width,
    this.height,
    this.iconSize,
    this.iconColor,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ResizableDraggerTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? borderRadius,
    ValueGetter<double?>? width,
    ValueGetter<double?>? height,
    ValueGetter<double?>? iconSize,
    ValueGetter<Color?>? iconColor,
  }) {
    return ResizableDraggerTheme(
      color: color == null ? this.color : color(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      width: width == null ? this.width : width(),
      height: height == null ? this.height : height(),
      iconSize: iconSize == null ? this.iconSize : iconSize(),
      iconColor: iconColor == null ? this.iconColor : iconColor(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResizableDraggerTheme &&
        other.color == color &&
        other.borderRadius == borderRadius &&
        other.width == width &&
        other.height == height &&
        other.iconSize == iconSize &&
        other.iconColor == iconColor;
  }

  @override
  int get hashCode =>
      Object.hash(color, borderRadius, width, height, iconSize, iconColor);
}

/// A Horizontal dragger that can be used as a divider between resizable panes.
class HorizontalResizableDragger extends StatelessWidget {
  /// Creates a [HorizontalResizableDragger].
  const HorizontalResizableDragger({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ResizableDraggerTheme>(context);
    final color = styleValue(
        widgetValue: null,
        themeValue: compTheme?.color,
        defaultValue: theme.colorScheme.border);
    final borderRadius = styleValue(
        widgetValue: null,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.radiusSm);
    final width = styleValue(
        widgetValue: null,
        themeValue: compTheme?.width,
        defaultValue: 3 * 4 * scaling);
    final height = styleValue(
        widgetValue: null,
        themeValue: compTheme?.height,
        defaultValue: 4 * 4 * scaling);
    final iconSize = styleValue(
        widgetValue: null,
        themeValue: compTheme?.iconSize,
        defaultValue: 4 * 2.5 * scaling);
    final iconColor =
        styleValue(themeValue: compTheme?.iconColor, defaultValue: null);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Icon(
          RadixIcons.dragHandleDots2,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

/// A Vertical dragger that can be used as a divider between resizable panes.
class VerticalResizableDragger extends StatelessWidget {
  /// Creates a [VerticalResizableDragger].
  const VerticalResizableDragger({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ResizableDraggerTheme>(context);
    final color = styleValue(
        widgetValue: null,
        themeValue: compTheme?.color,
        defaultValue: theme.colorScheme.border);
    final borderRadius = styleValue(
        widgetValue: null,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.radiusSm);
    final width = styleValue(
        widgetValue: null,
        themeValue: compTheme?.width,
        defaultValue: 4 * 4 * scaling);
    final height = styleValue(
        widgetValue: null,
        themeValue: compTheme?.height,
        defaultValue: 3 * 4 * scaling);
    final iconSize = styleValue(
        widgetValue: null,
        themeValue: compTheme?.iconSize,
        defaultValue: 4 * 2.5 * scaling);
    final iconColor =
        styleValue(themeValue: compTheme?.iconColor, defaultValue: null);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Transform.rotate(
          angle: pi / 2,
          child: Icon(
            RadixIcons.dragHandleDots2,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

/// Represents the position of a panel relative to another panel.
///
/// Used to specify which neighboring panel should be affected when
/// expanding or collapsing a resizable panel.
enum PanelSibling {
  /// The panel before (left/top) the current panel.
  before(-1),

  /// The panel after (right/bottom) the current panel.
  after(1),

  /// Both panels on either side of the current panel.
  both(0);

  /// Direction value used internally for calculations.
  final int direction;

  const PanelSibling(this.direction);
}

/// Mixin for controllers that manage resizable pane sizing.
///
/// Provides methods to resize, collapse, and expand panels programmatically.
/// Implementations include [AbsoluteResizablePaneController] for fixed sizes
/// and [FlexibleResizablePaneController] for flexible/proportional sizes.
mixin ResizablePaneController implements ValueListenable<double> {
  /// Resizes the controller to the given [newSize] within the [paneSize] bounds.
  void resize(double newSize, double paneSize);

  /// Collapses the panel to its minimum size.
  void collapse();

  /// Expands the panel to its maximum or default size.
  void expand();

  /// Computes the actual size based on [paneSize] and optional constraints.
  double computeSize(double paneSize, {double? minSize, double? maxSize});

  /// Whether the panel is currently collapsed.
  bool get collapsed;

  /// Attempts to expand by [size] pixels in the specified [direction].
  ///
  /// Returns `true` if successful, `false` if expansion was blocked.
  bool tryExpandSize(double size,
      [PanelSibling direction = PanelSibling.both]) {
    assert(_paneState != null, 'ResizablePaneController is not attached');
    return _paneState!.tryExpandSize(size, direction);
  }

  /// Attempts to expand the panel in the specified [direction].
  ///
  /// Returns `true` if successful, `false` if expansion was blocked.
  bool tryExpand([PanelSibling direction = PanelSibling.both]) {
    assert(_paneState != null, 'ResizablePaneController is not attached');
    return _paneState!.tryExpand(direction);
  }

  /// Attempts to collapse the panel in the specified [direction].
  ///
  /// Returns `true` if successful, `false` if collapse was blocked.
  bool tryCollapse([PanelSibling direction = PanelSibling.both]) {
    assert(_paneState != null, 'ResizablePaneController is not attached');
    return _paneState!.tryCollapse(direction);
  }

  _ResizablePaneState? _paneState;
  void _attachPaneState(_ResizablePaneState panelData) {
    _paneState = panelData;
  }

  void _detachPaneState(_ResizablePaneState panelData) {
    if (_paneState == panelData) {
      _paneState = null;
    }
  }
}

/// Controller for resizable panes with absolute (fixed) sizing.
///
/// Manages a panel with a specific pixel size that can be adjusted through
/// dragging or programmatic control. Size is maintained as an absolute value.
///
/// Example:
/// ```dart
/// final controller = AbsoluteResizablePaneController(200);
///
/// ResizablePane(
///   controller: controller,
///   child: Container(color: Colors.blue),
/// )
/// ```
class AbsoluteResizablePaneController extends ChangeNotifier
    with ResizablePaneController {
  double _size;
  bool _collapsed = false;

  _ResizablePaneState? _state;

  @override
  _ResizablePaneState? get _paneState => _state;

  @override
  set _paneState(_ResizablePaneState? value) {
    _state = value;
  }

  /// Creates an [AbsoluteResizablePaneController].
  ///
  /// Parameters:
  /// - [_size] (`double`, required): Initial absolute size in pixels.
  /// - [collapsed] (`bool`, default: `false`): Initial collapsed state.
  AbsoluteResizablePaneController(this._size, {bool collapsed = false})
      : _collapsed = collapsed;

  @override
  double get value => _size;

  @override
  bool get collapsed => _collapsed;

  set size(double value) {
    _size = value;
    notifyListeners();
  }

  @override
  void collapse() {
    if (_collapsed) return;
    _collapsed = true;
    notifyListeners();
  }

  @override
  void expand() {
    if (!_collapsed) return;
    _collapsed = false;
    notifyListeners();
  }

  @override
  void resize(double newSize, double paneSize,
      {double? minSize, double? maxSize}) {
    _size = newSize.clamp(minSize ?? 0, maxSize ?? double.infinity);
    notifyListeners();
  }

  @override
  double computeSize(double paneSize, {double? minSize, double? maxSize}) {
    return _size.clamp(minSize ?? 0, maxSize ?? double.infinity);
  }
}

/// Controller for resizable panes with flexible (proportional) sizing.
///
/// Manages a panel whose size is specified as a flex factor relative to
/// the total available space. Similar to Flutter's [Flexible] widget concept.
///
/// Example:
/// ```dart
/// final controller = FlexibleResizablePaneController(1.0);
///
/// ResizablePane(
///   controller: controller,
///   child: Container(color: Colors.red),
/// )
/// ```
class FlexibleResizablePaneController extends ChangeNotifier
    with ResizablePaneController {
  double _flex;
  bool _collapsed = false;

  /// Creates a [FlexibleResizablePaneController].
  ///
  /// Parameters:
  /// - [_flex] (`double`, required): Initial flex factor.
  /// - [collapsed] (`bool`, default: `false`): Initial collapsed state.
  FlexibleResizablePaneController(this._flex, {bool collapsed = false})
      : _collapsed = collapsed;

  @override
  double get value => _flex;

  @override
  bool get collapsed => _collapsed;

  set flex(double value) {
    _flex = value;
    notifyListeners();
  }

  @override
  void collapse() {
    _collapsed = true;
    notifyListeners();
  }

  @override
  void expand() {
    _collapsed = false;
    notifyListeners();
  }

  @override
  void resize(double newSize, double paneSize,
      {double? minSize, double? maxSize}) {
    _flex = newSize.clamp(minSize ?? 0, maxSize ?? double.infinity) / paneSize;
    notifyListeners();
  }

  @override
  double computeSize(double paneSize, {double? minSize, double? maxSize}) {
    return (_flex * paneSize).clamp(minSize ?? 0, maxSize ?? double.infinity);
  }
}

/// A resizable panel that can be part of a [ResizablePanel] layout.
///
/// Represents a single pane in a resizable layout that can be resized by
/// dragging handles between panes. Supports absolute sizing, flex-based sizing,
/// and external controller management.
///
/// Three constructor variants:
/// - Default: Fixed absolute size in pixels
/// - [ResizablePane.flex]: Proportional flex-based sizing
/// - [ResizablePane.controlled]: Externally controlled via [ResizablePaneController]
///
/// Example:
/// ```dart
/// ResizablePanel(
///   children: [
///     ResizablePane(
///       initialSize: 200,
///       minSize: 100,
///       child: Container(color: Colors.blue),
///     ),
///     ResizablePane.flex(
///       initialFlex: 2,
///       child: Container(color: Colors.red),
///     ),
///   ],
/// )
/// ```
class ResizablePane extends StatefulWidget {
  /// Optional external controller for managing this pane's size.
  final ResizablePaneController? controller;

  /// Initial size in pixels (for absolute sizing).
  final double? initialSize;

  /// Initial flex factor (for flexible sizing).
  final double? initialFlex;

  /// Minimum size constraint in pixels.
  final double? minSize;

  /// Maximum size constraint in pixels.
  final double? maxSize;

  /// Size when collapsed (defaults to 0).
  final double? collapsedSize;

  /// Child widget to display in this pane.
  final Widget child;

  /// Callback when resize drag starts.
  final ValueChanged<double>? onSizeChangeStart;

  /// Callback during resize drag.
  final ValueChanged<double>? onSizeChange;

  /// Callback when resize drag ends.
  final ValueChanged<double>? onSizeChangeEnd;

  /// Callback when resize drag is cancelled.
  final ValueChanged<double>? onSizeChangeCancel;

  /// Whether the pane starts collapsed.
  final bool? initialCollapsed;

  /// Creates a [ResizablePane] with absolute pixel sizing.
  const ResizablePane({
    super.key,
    required double this.initialSize,
    this.minSize,
    this.maxSize,
    this.collapsedSize,
    required this.child,
    this.onSizeChangeStart,
    this.onSizeChange,
    this.onSizeChangeEnd,
    this.onSizeChangeCancel,
    bool this.initialCollapsed = false,
  })  : controller = null,
        initialFlex = null;

  /// Creates a [ResizablePane] with flex-based proportional sizing.
  const ResizablePane.flex({
    super.key,
    double this.initialFlex = 1,
    this.minSize,
    this.maxSize,
    this.collapsedSize,
    required this.child,
    this.onSizeChangeStart,
    this.onSizeChange,
    this.onSizeChangeEnd,
    this.onSizeChangeCancel,
    bool this.initialCollapsed = false,
  })  : controller = null,
        initialSize = null;

  /// Creates a [ResizablePane] controlled by an external [controller].
  const ResizablePane.controlled({
    super.key,
    required ResizablePaneController this.controller,
    this.minSize,
    this.maxSize,
    this.collapsedSize,
    required this.child,
    this.onSizeChangeStart,
    this.onSizeChange,
    this.onSizeChangeEnd,
    this.onSizeChangeCancel,
  })  : initialSize = null,
        initialFlex = null,
        initialCollapsed = null;

  @override
  State<ResizablePane> createState() => _ResizablePaneState();
}

class _ResizablePaneState extends State<ResizablePane> {
  late ResizablePaneController _controller;

  _ResizablePanelData? _panelState;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else if (widget.initialSize != null) {
      _controller = AbsoluteResizablePaneController(widget.initialSize!,
          collapsed: widget.initialCollapsed!);
    } else {
      assert(widget.initialFlex != null, 'initalFlex must not be null');
      _controller = FlexibleResizablePaneController(widget.initialFlex!,
          collapsed: widget.initialCollapsed!);
    }
    _controller._attachPaneState(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newPanelState = Data.maybeOf<_ResizablePanelData>(context);
    if (_panelState != newPanelState) {
      _panelState?.detach(_controller);
      _panelState = newPanelState;
      _panelState?.attach(_controller);
    }
  }

  @override
  void didUpdateWidget(covariant ResizablePane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller._detachPaneState(this);
      _panelState?.detach(_controller);
      if (widget.controller != null) {
        _controller = widget.controller!;
      } else if (widget.initialSize != null) {
        if (_controller is! AbsoluteResizablePaneController) {
          _controller = AbsoluteResizablePaneController(widget.initialSize!,
              collapsed: widget.initialCollapsed!);
        }
      } else {
        if (_controller is! FlexibleResizablePaneController) {
          assert(widget.initialFlex != null, 'initalFlex must not be null');
          _controller = FlexibleResizablePaneController(widget.initialFlex!,
              collapsed: widget.initialCollapsed!);
        }
      }
      _panelState?.attach(_controller);
      assert(_panelState != null,
          'ResizablePane must be a child of ResizablePanel');
      _controller._attachPaneState(this);
    }
  }

  bool tryExpand([PanelSibling direction = PanelSibling.both]) {
    if (!_controller.collapsed) {
      return false;
    }
    List<ResizableItem> draggers = _panelState!.state.computeDraggers();
    Resizer resizer = Resizer(draggers);
    bool result =
        resizer.attemptExpandCollapsed(_panelState!.index, direction.direction);
    if (result) {
      _panelState!.state.updateDraggers(resizer.items);
    }
    return result;
  }

  bool tryCollapse([PanelSibling direction = PanelSibling.both]) {
    if (_controller.collapsed) {
      return false;
    }
    List<ResizableItem> draggers = _panelState!.state.computeDraggers();
    Resizer resizer = Resizer(draggers);
    bool result =
        resizer.attemptCollapse(_panelState!.index, direction.direction);
    if (result) {
      _panelState!.state.updateDraggers(resizer.items);
    }
    return result;
  }

  bool tryExpandSize(double size,
      [PanelSibling direction = PanelSibling.both]) {
    List<ResizableItem> draggers = _panelState!.state.computeDraggers();
    Resizer resizer = Resizer(draggers);
    bool result =
        resizer.attemptExpand(_panelState!.index, direction.direction, size);
    if (result) {
      _panelState!.state.updateDraggers(resizer.items);
    }
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    _controller._detachPaneState(this);
    _panelState?.detach(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        double? size;
        double? flex;
        if (_controller is AbsoluteResizablePaneController) {
          final controller = _controller as AbsoluteResizablePaneController;
          if (controller.collapsed) {
            size = widget.collapsedSize;
          } else {
            size = controller.value;
          }
        } else if (_controller is FlexibleResizablePaneController) {
          final controller = _controller as FlexibleResizablePaneController;
          if (controller.collapsed) {
            size = widget.collapsedSize;
          } else {
            flex = controller.value;
          }
        }
        return _ResizableLayoutChild(
          size: size,
          flex: flex,
          child: ClipRect(
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _ResizablePanelData {
  final _ResizablePanelState state;
  final int index;

  _ResizablePanelData(this.state, this.index);

  Axis get direction => state.widget.direction;

  void attach(ResizablePaneController controller) {
    state.attachController(controller);
  }

  void detach(ResizablePaneController controller) {
    state.detachController(controller);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ResizablePanelData &&
        other.state == state &&
        other.index == index;
  }

  @override
  int get hashCode {
    return Object.hash(state, index);
  }
}

/// Builder function that optionally returns a widget.
///
/// Used for conditional widget building where a widget may or may not be created
/// based on runtime conditions.
typedef OptionalWidgetBuilder = Widget? Function(BuildContext context);

/// A container widget that creates resizable panels separated by interactive dividers.
///
/// This widget provides a flexible layout system where multiple child panes
/// can be resized by the user through draggable dividers. It supports both
/// horizontal and vertical orientations, allowing users to adjust the relative
/// sizes of the contained panels by dragging the separators between them.
///
/// Each [ResizablePane] child can have its own sizing constraints, minimum and
/// maximum sizes, and collapse behavior. The panel automatically manages the
/// distribution of available space and handles user interactions for resizing.
///
/// Example:
/// ```dart
/// ResizablePanel.horizontal(
///   children: [
///     ResizablePane(
///       child: Container(color: Colors.red),
///       minSize: 100,
///       defaultSize: 200,
///     ),
///     ResizablePane(
///       child: Container(color: Colors.blue),
///       flex: 1,
///     ),
///     ResizablePane(
///       child: Container(color: Colors.green),
///       defaultSize: 150,
///       maxSize: 300,
///     ),
///   ],
/// );
/// ```
class ResizablePanel extends StatefulWidget {
  /// Default builder for dividers between resizable panes.
  ///
  /// Creates appropriate divider widgets based on the panel orientation:
  /// - Horizontal panels get vertical dividers
  /// - Vertical panels get horizontal dividers
  ///
  /// This is the default value for [dividerBuilder] when none is specified.
  static Widget? defaultDividerBuilder(BuildContext context) {
    final data = Data.of<ResizableData>(context);
    if (data.direction == Axis.horizontal) {
      return const VerticalDivider();
    } else {
      return const Divider();
    }
  }

  /// Default builder for interactive drag handles between resizable panes.
  ///
  /// Creates appropriate dragger widgets based on the panel orientation:
  /// - Horizontal panels get vertical draggers
  /// - Vertical panels get horizontal draggers
  ///
  /// This is the default value for [draggerBuilder] when none is specified.
  static Widget? defaultDraggerBuilder(BuildContext context) {
    final data = Data.of<ResizableData>(context);
    if (data.direction == Axis.horizontal) {
      return const VerticalResizableDragger();
    } else {
      return const HorizontalResizableDragger();
    }
  }

  /// The axis along which the panels are arranged and can be resized.
  ///
  /// When [Axis.horizontal], panels are arranged left-to-right with vertical
  /// dividers between them. When [Axis.vertical], panels are arranged
  /// top-to-bottom with horizontal dividers between them.
  final Axis direction;

  /// The list of resizable panes that make up this panel.
  ///
  /// Each pane can specify its own sizing constraints, default size, and
  /// collapse behavior. At least two panes are typically needed to create
  /// a meaningful resizable interface.
  final List<ResizablePane> children;

  /// Optional builder for creating divider widgets between panes.
  ///
  /// Called to create the visual separator between adjacent panes. If null,
  /// uses [defaultDividerBuilder] to create appropriate dividers based on
  /// the panel orientation.
  final OptionalWidgetBuilder? dividerBuilder;

  /// Optional builder for creating interactive drag handles between panes.
  ///
  /// Called to create draggable resize handles between adjacent panes. These
  /// handles allow users to adjust pane sizes. If null, no drag handles are
  /// displayed but dividers may still be present if [dividerBuilder] is set.
  final OptionalWidgetBuilder? draggerBuilder;

  /// The thickness of the draggable area between panes.
  ///
  /// Controls the size of the interactive region for resizing. A larger value
  /// makes it easier to grab and drag the resize handles, while a smaller
  /// value provides a more compact appearance.
  final double? draggerThickness;

  /// Hides the divider when not hovered or being dragged.
  final bool optionalDivider;

  /// Creates a horizontal resizable panel with panes arranged left-to-right.
  ///
  /// This is a convenience constructor that sets [direction] to [Axis.horizontal]
  /// and provides default builders for dividers and draggers appropriate for
  /// horizontal layouts.
  ///
  /// Parameters:
  /// - [children] (`List<ResizablePane>`, required): The panes to arrange horizontally
  /// - [dividerBuilder] (OptionalWidgetBuilder?, optional): Custom divider builder
  /// - [draggerBuilder] (OptionalWidgetBuilder?, optional): Custom dragger builder
  /// - [draggerThickness] (double?, optional): Size of the draggable resize area
  ///
  /// Example:
  /// ```dart
  /// ResizablePanel.horizontal(
  ///   children: [
  ///     ResizablePane(child: LeftSidebar(), defaultSize: 200),
  ///     ResizablePane(child: MainContent(), flex: 1),
  ///     ResizablePane(child: RightPanel(), defaultSize: 150),
  ///   ],
  /// );
  /// ```
  const ResizablePanel.horizontal({
    super.key,
    required this.children,
    this.dividerBuilder = defaultDividerBuilder,
    this.draggerBuilder,
    this.draggerThickness,
    this.optionalDivider = false,
  }) : direction = Axis.horizontal;

  /// Creates a vertical resizable panel with panes arranged top-to-bottom.
  ///
  /// This is a convenience constructor that sets [direction] to [Axis.vertical]
  /// and provides default builders for dividers and draggers appropriate for
  /// vertical layouts.
  ///
  /// Parameters:
  /// - [children] (`List<ResizablePane>`, required): The panes to arrange vertically
  /// - [dividerBuilder] (OptionalWidgetBuilder?, optional): Custom divider builder
  /// - [draggerBuilder] (OptionalWidgetBuilder?, optional): Custom dragger builder
  /// - [draggerThickness] (double?, optional): Size of the draggable resize area
  ///
  /// Example:
  /// ```dart
  /// ResizablePanel.vertical(
  ///   children: [
  ///     ResizablePane(child: Header(), defaultSize: 60),
  ///     ResizablePane(child: Content(), flex: 1),
  ///     ResizablePane(child: Footer(), defaultSize: 40),
  ///   ],
  /// );
  /// ```
  const ResizablePanel.vertical({
    super.key,
    required this.children,
    this.dividerBuilder = defaultDividerBuilder,
    this.draggerBuilder,
    this.draggerThickness,
    this.optionalDivider = false,
  }) : direction = Axis.vertical;

  /// Creates a resizable panel with the specified direction and configuration.
  ///
  /// This is the general constructor that allows full customization of the
  /// panel orientation and behavior. Use the convenience constructors
  /// [ResizablePanel.horizontal] and [ResizablePanel.vertical] for typical use cases.
  ///
  /// Parameters:
  /// - [direction] (Axis, required): The axis along which panes are arranged
  /// - [children] (`List<ResizablePane>`, required): The panes to arrange
  /// - [dividerBuilder] (OptionalWidgetBuilder?, optional): Custom divider builder
  /// - [draggerBuilder] (OptionalWidgetBuilder?, optional): Custom dragger builder
  /// - [draggerThickness] (double?, optional): Size of the draggable resize area
  ///
  /// Example:
  /// ```dart
  /// ResizablePanel(
  ///   direction: Axis.horizontal,
  ///   draggerThickness: 8.0,
  ///   children: [...],
  ///   draggerBuilder: (context) => CustomDragger(),
  /// );
  /// ```
  const ResizablePanel({
    super.key,
    required this.direction,
    required this.children,
    this.dividerBuilder = defaultDividerBuilder,
    this.draggerBuilder,
    this.draggerThickness,
    this.optionalDivider = false,
  });

  @override
  State<ResizablePanel> createState() => _ResizablePanelState();
}

// extends as ResizableItem, but adds nothing
class _ResizableItem extends ResizableItem {
  _ResizableItem({
    required super.value,
    super.min,
    super.max,
    super.collapsed,
    super.collapsedSize,
    required this.controller,
  });

  final ResizablePaneController controller;
}

class _ResizablePanelState extends State<ResizablePanel> {
  final List<ResizablePaneController> _controllers = [];
  final Set<int> _hoveredDividers = {};
  final Set<int> _draggingDividers = {};
  late double _panelSize;

  List<ResizableItem> computeDraggers() {
    List<ResizableItem> draggers = [];
    List<ResizablePaneController> controllers = _controllers;
    controllers.sort(
      (a, b) {
        var stateA = a._paneState;
        var stateB = b._paneState;
        if (stateA == null || stateB == null) {
          return 0;
        }
        var widgetA = stateA.widget;
        var widgetB = stateB.widget;
        var indexWidgetA = widget.children.indexOf(widgetA);
        var indexWidgetB = widget.children.indexOf(widgetB);
        return indexWidgetA.compareTo(indexWidgetB);
      },
    );
    for (final controller in controllers) {
      double computedSize = controller.computeSize(
        _panelSize,
        minSize:
            controller.collapsed ? null : controller._paneState!.widget.minSize,
        maxSize:
            controller.collapsed ? null : controller._paneState!.widget.maxSize,
      );
      draggers.add(_ResizableItem(
        value: computedSize,
        min: controller._paneState!.widget.minSize ?? 0,
        max: controller._paneState!.widget.maxSize ?? double.infinity,
        controller: controller,
        collapsed: controller.collapsed,
        collapsedSize: controller._paneState!.widget.collapsedSize,
      ));
    }
    return draggers;
  }

  void updateDraggers(List<ResizableItem> draggers) {
    for (var i = 0; i < draggers.length; i++) {
      final item = draggers[i];
      if (item is _ResizableItem) {
        final controller = item.controller;
        if (item.newCollapsed) {
          controller.collapse();
        } else {
          controller.expand();
        }
        controller.resize(item.newValue, _panelSize);
      }
    }
  }

  void attachController(ResizablePaneController controller) {
    _controllers.add(controller);
  }

  void detachController(ResizablePaneController controller) {
    _controllers.remove(controller);
  }

  @override
  void didUpdateWidget(covariant ResizablePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.optionalDivider != oldWidget.optionalDivider) {
      if (!widget.optionalDivider) {
        _hoveredDividers.clear();
        _draggingDividers.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: ResizableData(widget.direction),
      child: Builder(
        builder: _build,
      ),
    );
  }

  Widget _build(BuildContext context) {
    List<Widget> dividers = [];
    if (widget.direction == Axis.horizontal) {
      for (var i = 0; i < widget.children.length - 1; i++) {
        Widget divider =
            widget.dividerBuilder?.call(context) ?? const SizedBox();
        dividers.add(divider);
      }
    } else {
      for (var i = 0; i < widget.children.length - 1; i++) {
        Widget divider =
            widget.dividerBuilder?.call(context) ?? const SizedBox();
        dividers.add(divider);
      }
    }
    List<Widget> children = [];
    for (var i = 0; i < widget.children.length; i++) {
      children.add(Data<_ResizablePanelData>.inherit(
        key: widget.children[i].key,
        data: _ResizablePanelData(this, i),
        child: widget.children[i],
      ));
      if (i < dividers.length) {
        children.add(_ResizableLayoutChild(
          isDivider: true,
          child: widget.optionalDivider
              ? AnimatedOpacity(
                  opacity: _hoveredDividers.contains(i) ||
                          _draggingDividers.contains(i)
                      ? 1.0
                      : 0.0,
                  duration: kDefaultDuration,
                  child: dividers[i],
                )
              : dividers[i],
        ));
      }
    }
    if (widget.draggerBuilder != null) {
      for (var i = 0; i < widget.children.length - 1; i++) {
        children.add(_ResizableLayoutChild(
          index: i,
          isDragger: true,
          // child: widget.draggerBuilder!(context) ?? const SizedBox(),
          child: widget.optionalDivider
              ? AnimatedOpacity(
                  opacity: _hoveredDividers.contains(i) ||
                          _draggingDividers.contains(i)
                      ? 1.0
                      : 0.0,
                  duration: kDefaultDuration,
                  child: widget.draggerBuilder!(context) ?? const SizedBox(),
                )
              : widget.draggerBuilder!(context) ?? const SizedBox(),
        ));
      }
    }
    for (var i = 0; i < widget.children.length - 1; i++) {
      children.add(_ResizableLayoutChild(
        index: i,
        isDragger: false,
        child: MouseRegion(
          onEnter: (_) {
            if (!widget.optionalDivider) return;
            setState(() {
              _hoveredDividers.add(i);
            });
          },
          onExit: (_) {
            if (!widget.optionalDivider) return;
            setState(() {
              _hoveredDividers.remove(i);
            });
          },
          child: _Resizer(
            direction: widget.direction,
            index: i,
            thickness: widget.draggerThickness ?? 8,
            panelState: this,
            onResizeStart: () {
              if (!widget.optionalDivider) return;
              setState(() {
                _draggingDividers.add(i);
              });
            },
            onResizeEnd: () {
              if (!widget.optionalDivider) return;
              setState(() {
                _draggingDividers.remove(i);
              });
            },
          ),
        ),
      ));
    }
    return _ResizableLayout(
      direction: widget.direction,
      onLayout: (panelSize, flexCount) {
        _panelSize = panelSize;
      },
      children: children,
    );
  }
}

/// Data class providing information about a resizable panel's orientation.
///
/// Used internally to pass layout direction information through the widget tree.
class ResizableData {
  /// The axis direction of the resizable panel (horizontal or vertical).
  final Axis direction;

  /// Creates [ResizableData] with the specified [direction].
  ResizableData(this.direction);
}

class _Resizer extends StatefulWidget {
  final Axis direction;
  final int index;
  final double thickness;
  final _ResizablePanelState panelState;
  final VoidCallback? onResizeStart;
  final VoidCallback? onResizeEnd;

  const _Resizer({
    required this.direction,
    required this.index,
    required this.thickness,
    required this.panelState,
    this.onResizeStart,
    this.onResizeEnd,
  });

  @override
  State<_Resizer> createState() => _ResizerState();
}

class _ResizerState extends State<_Resizer> {
  Resizer? _dragSession;

  void _onDragStart(DragStartDetails details) {
    _dragSession = Resizer(
      widget.panelState.computeDraggers(),
    );

    // Call onSizeChangeStart callbacks for affected panes
    _callSizeChangeStartCallbacks();
    widget.onResizeStart?.call();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _dragSession!.dragDivider(widget.index + 1, details.primaryDelta!);
    widget.panelState.updateDraggers(_dragSession!.items);

    // Call onSizeChange callbacks for affected panes
    _callSizeChangeCallbacks();
  }

  void _onDragEnd(DragEndDetails details) {
    // Call onSizeChangeEnd callbacks for affected panes
    _callSizeChangeEndCallbacks();
    _dragSession = null;
    widget.onResizeEnd?.call();
  }

  void _onDragCancel() {
    _dragSession!.reset();
    widget.panelState.updateDraggers(_dragSession!.items);

    // Call onSizeChangeCancel callbacks for affected panes
    _callSizeChangeCancelCallbacks();
    _dragSession = null;
    widget.onResizeEnd?.call();
  }

  void _callSizeChangeStartCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callStartCallbackForPane(
        widget.index, _dragSession!.items[widget.index].value);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callStartCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].value);
    }
  }

  void _callSizeChangeCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callChangeCallbackForPane(
        widget.index, _dragSession!.items[widget.index].newValue);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callChangeCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].newValue);
    }
  }

  void _callSizeChangeEndCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callEndCallbackForPane(
        widget.index, _dragSession!.items[widget.index].newValue);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callEndCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].newValue);
    }
  }

  void _callSizeChangeCancelCallbacks() {
    if (_dragSession == null) return;

    // Call callbacks for the two panes adjacent to this divider
    _callCancelCallbackForPane(
        widget.index, _dragSession!.items[widget.index].newValue);
    if (widget.index + 1 < _dragSession!.items.length) {
      _callCancelCallbackForPane(
          widget.index + 1, _dragSession!.items[widget.index + 1].newValue);
    }
  }

  ResizablePaneController? _getControllerAtIndex(int paneIndex) {
    if (paneIndex < 0 ||
        paneIndex >= widget.panelState.widget.children.length) {
      return null;
    }

    // Find controller by matching the widget at the given index
    final targetWidget = widget.panelState.widget.children[paneIndex];
    for (final controller in widget.panelState._controllers) {
      final paneState = controller._paneState;
      if (paneState?.widget == targetWidget) {
        return controller;
      }
    }
    return null;
  }

  void _callStartCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChangeStart;
    callback?.call(size);
  }

  void _callChangeCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChange;
    callback?.call(size);
  }

  void _callEndCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChangeEnd;
    callback?.call(size);
  }

  void _callCancelCallbackForPane(int paneIndex, double size) {
    final controller = _getControllerAtIndex(paneIndex);
    final callback = controller?._paneState?.widget.onSizeChangeCancel;
    callback?.call(size);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.direction == Axis.horizontal ? widget.thickness : null,
      height: widget.direction == Axis.vertical ? widget.thickness : null,
      child: MouseRegion(
        cursor: widget.direction == Axis.horizontal
            ? SystemMouseCursors.resizeColumn
            : SystemMouseCursors.resizeRow,
        hitTestBehavior: HitTestBehavior.translucent,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragStart:
              widget.direction == Axis.vertical ? _onDragStart : null,
          onHorizontalDragStart:
              widget.direction == Axis.horizontal ? _onDragStart : null,
          onVerticalDragUpdate:
              widget.direction == Axis.vertical ? _onDragUpdate : null,
          onHorizontalDragUpdate:
              widget.direction == Axis.horizontal ? _onDragUpdate : null,
          onVerticalDragEnd:
              widget.direction == Axis.vertical ? _onDragEnd : null,
          onHorizontalDragEnd:
              widget.direction == Axis.horizontal ? _onDragEnd : null,
          onVerticalDragCancel:
              widget.direction == Axis.vertical ? _onDragCancel : null,
          onHorizontalDragCancel:
              widget.direction == Axis.horizontal ? _onDragCancel : null,
        ),
      ),
    );
  }
}

class _ResizableLayoutParentData extends ContainerBoxParentData<RenderBox> {
  // if index is null, then its an overlay that handle the resize dragger (on the border/edge)
  int? index;
  // if isDragger is true, then its a dragger that should be placed above "index" panel right border
  bool? isDragger;
  // there are total "totalPanes" - 1 of dragger
  bool? isDivider;

  double? size;
  double? flex;
}

class _ResizableLayoutChild
    extends ParentDataWidget<_ResizableLayoutParentData> {
  final int? index;
  final bool? isDragger;
  final bool? isDivider;
  final double? size;
  final double? flex;

  const _ResizableLayoutChild({
    this.index,
    this.isDragger,
    this.isDivider,
    this.size,
    this.flex,
    required super.child,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as _ResizableLayoutParentData;
    bool needsLayout = false;

    if (parentData.index != index) {
      parentData.index = index;
      needsLayout = true;
    }

    if (parentData.isDragger != isDragger) {
      parentData.isDragger = isDragger;
      needsLayout = true;
    }

    if (parentData.isDivider != isDivider) {
      parentData.isDivider = isDivider;
      needsLayout = true;
    }

    if (parentData.size != size) {
      parentData.size = size;
      needsLayout = true;
    }

    if (parentData.flex != flex) {
      parentData.flex = flex;
      needsLayout = true;
    }

    if (needsLayout) {
      final targetParent = renderObject.parent;
      targetParent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => _ResizableLayout;
}

typedef _ResizableLayoutCallback = void Function(
    double panelSize, double flexCount);

class _ResizableLayout extends MultiChildRenderObjectWidget {
  final Axis direction;
  final _ResizableLayoutCallback onLayout;

  const _ResizableLayout({
    required this.direction,
    required super.children,
    required this.onLayout,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderResizableLayout(direction, onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderResizableLayout renderObject) {
    bool needsLayout = false;
    if (renderObject.direction != direction) {
      renderObject.direction = direction;
      needsLayout = true;
    }
    if (renderObject.onLayout != onLayout) {
      renderObject.onLayout = onLayout;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}

class _RenderResizableLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ResizableLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ResizableLayoutParentData> {
  Axis direction;
  _ResizableLayoutCallback onLayout;

  _RenderResizableLayout(this.direction, this.onLayout);

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ResizableLayoutParentData) {
      child.parentData = _ResizableLayoutParentData();
    }
  }

  double _getSizeExtent(Size size) {
    return direction == Axis.horizontal ? size.width : size.height;
  }

  Offset _createOffset(double main, double cross) {
    return direction == Axis.horizontal
        ? Offset(main, cross)
        : Offset(cross, main);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void performLayout() {
    final constraints = this.constraints;

    double mainOffset = 0;

    double intrinsicCross = 0;
    bool hasInfiniteCross = direction == Axis.horizontal
        ? !constraints.hasBoundedHeight
        : !constraints.hasBoundedWidth;
    if (hasInfiniteCross) {
      RenderBox? child = firstChild;
      while (child != null) {
        final childParentData = child.parentData as _ResizableLayoutParentData;
        if (childParentData.isDragger != true &&
            childParentData.index == null) {
          if (direction == Axis.horizontal) {
            intrinsicCross = max(
                intrinsicCross, child.getMaxIntrinsicHeight(double.infinity));
          } else {
            intrinsicCross = max(
                intrinsicCross, child.getMaxIntrinsicWidth(double.infinity));
          }
        }
        child = childParentData.nextSibling;
      }
    } else {
      intrinsicCross = direction == Axis.horizontal
          ? constraints.maxHeight
          : constraints.maxWidth;
    }

    // lay out the dividers
    double flexCount = 0;
    List<double> dividerSizes = [];
    RenderBox? child = firstChild;
    double panelSize = 0;
    List<double> dividerOffsets = [];
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;
      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider == true) {
          BoxConstraints childConstraints;
          if (direction == Axis.horizontal) {
            childConstraints = BoxConstraints(
              minWidth: 0,
              maxWidth: constraints.maxWidth,
              minHeight: intrinsicCross,
              maxHeight: intrinsicCross,
            );
          } else {
            childConstraints = BoxConstraints(
              minWidth: intrinsicCross,
              maxWidth: intrinsicCross,
              minHeight: 0,
              maxHeight: constraints.maxHeight,
            );
          }
          child.layout(childConstraints, parentUsesSize: true);
          Size childSize = child.size;
          var sizeExtent = _getSizeExtent(childSize);
          dividerSizes.add(sizeExtent);
          mainOffset += sizeExtent;
        } else if (childParentData.flex != null) {
          flexCount += childParentData.flex!;
        } else if (childParentData.size != null) {
          panelSize += childParentData.size!;
        }
      }
      child = childParentData.nextSibling;
    }
    double totalDividerSize = mainOffset;
    mainOffset = 0;
    // lay out the panes
    child = firstChild;
    // List<double> sizes = [];
    double parentSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double remainingSpace = parentSize - (panelSize + totalDividerSize);
    double flexSpace = remainingSpace / flexCount;
    onLayout(flexSpace, flexCount);
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;
      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider != true) {
          BoxConstraints childConstraints;
          double childExtent;
          if (childParentData.flex != null) {
            childExtent = flexSpace * childParentData.flex!;
          } else {
            childExtent = childParentData.size!;
          }
          if (direction == Axis.horizontal) {
            childConstraints = BoxConstraints(
              minWidth: childExtent,
              maxWidth: childExtent,
              minHeight: intrinsicCross,
              maxHeight: intrinsicCross,
            );
          } else {
            childConstraints = BoxConstraints(
              minWidth: intrinsicCross,
              maxWidth: intrinsicCross,
              minHeight: childExtent,
              maxHeight: childExtent,
            );
          }
          child.layout(childConstraints, parentUsesSize: true);
          Size childSize = child.size;
          var sizeExtent = _getSizeExtent(childSize);
          // sizes.add(sizeExtent);
          childParentData.offset = _createOffset(mainOffset, 0);
          mainOffset += sizeExtent;
        } else {
          childParentData.offset = _createOffset(mainOffset, 0);
          dividerOffsets.add(mainOffset + _getSizeExtent(child.size) / 2);
          mainOffset += _getSizeExtent(child.size);
        }
      }
      child = childParentData.nextSibling;
    }

    // layout the rest
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;
      if (childParentData.isDragger == true || childParentData.index != null) {
        // total offset = sum of sizes from 0 to index
        double minExtent = 0;
        if (childParentData.index != null) {
          minExtent = dividerSizes[childParentData.index!];
        }
        double intrinsicExtent = 0;
        if (direction == Axis.horizontal) {
          intrinsicExtent = child.getMaxIntrinsicWidth(double.infinity);
        } else {
          intrinsicExtent = child.getMaxIntrinsicHeight(double.infinity);
        }
        minExtent += intrinsicExtent;
        BoxConstraints draggerConstraints;
        if (direction == Axis.horizontal) {
          draggerConstraints = BoxConstraints(
            minWidth: minExtent,
            maxWidth: double.infinity,
            minHeight: intrinsicCross,
            maxHeight: intrinsicCross,
          );
        } else {
          draggerConstraints = BoxConstraints(
            minWidth: intrinsicCross,
            maxWidth: intrinsicCross,
            minHeight: minExtent,
            maxHeight: double.infinity,
          );
        }
        child.layout(draggerConstraints, parentUsesSize: true);
        Size draggerSize = child.size;
        // align at center
        var sizeExtent = _getSizeExtent(draggerSize);
        childParentData.offset = _createOffset(
            dividerOffsets[childParentData.index!] - sizeExtent / 2, 0);
        // childParentData.offset =
        //     _createOffset(draggerOffset - sizeExtent / 2 + dividerOffset, 0);
        // dividerOffset += sizeExtent;
      }
      child = childParentData.nextSibling;
    }

    Size size;
    if (direction == Axis.horizontal) {
      size = Size(mainOffset, intrinsicCross);
    } else {
      size = Size(intrinsicCross, mainOffset);
    }
    this.size = constraints.constrain(size);
  }

  /// Helper method to compute intrinsic sizes based on children
  double _computeIntrinsicMainSize(double extent) {
    double totalSize = 0;

    // First pass: calculate fixed sizes and total flex
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;

      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider == true) {
          // Add divider intrinsic size
          if (direction == Axis.horizontal) {
            totalSize += child.getMinIntrinsicWidth(extent);
          } else {
            totalSize += child.getMinIntrinsicHeight(extent);
          }
        } else if (childParentData.size != null) {
          // Fixed size pane
          totalSize += childParentData.size!;
        } else if (childParentData.flex != null) {
          // Add minimum intrinsic size for flex children
          if (direction == Axis.horizontal) {
            totalSize += child.getMinIntrinsicWidth(extent);
          } else {
            totalSize += child.getMinIntrinsicHeight(extent);
          }
        }
      }

      child = childParentData.nextSibling;
    }

    return totalSize;
  }

  double _computeIntrinsicCrossSize(double extent) {
    double maxCrossSize = 0;

    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;

      if (childParentData.isDragger != true && childParentData.index == null) {
        double childCrossSize;
        if (direction == Axis.horizontal) {
          childCrossSize = child.getMinIntrinsicHeight(extent);
        } else {
          childCrossSize = child.getMinIntrinsicWidth(extent);
        }
        maxCrossSize = max(maxCrossSize, childCrossSize);
      }

      child = childParentData.nextSibling;
    }

    return maxCrossSize;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (direction == Axis.horizontal) {
      return _computeIntrinsicMainSize(height);
    } else {
      return _computeIntrinsicCrossSize(height);
    }
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (direction == Axis.horizontal) {
      return _computeIntrinsicMainSize(height);
    } else {
      return _computeIntrinsicCrossSize(height);
    }
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (direction == Axis.vertical) {
      return _computeIntrinsicMainSize(width);
    } else {
      return _computeIntrinsicCrossSize(width);
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (direction == Axis.vertical) {
      return _computeIntrinsicMainSize(width);
    } else {
      return _computeIntrinsicCrossSize(width);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    double mainOffset = 0;

    // Calculate cross axis size
    double intrinsicCross = 0;
    bool hasInfiniteCross = direction == Axis.horizontal
        ? !constraints.hasBoundedHeight
        : !constraints.hasBoundedWidth;

    if (hasInfiniteCross) {
      intrinsicCross = direction == Axis.horizontal
          ? computeMinIntrinsicHeight(constraints.maxWidth)
          : computeMinIntrinsicWidth(constraints.maxHeight);
    } else {
      intrinsicCross = direction == Axis.horizontal
          ? constraints.maxHeight
          : constraints.maxWidth;
    }

    // Calculate main axis sizes - similar to performLayout but without actual layout
    double flexCount = 0;
    double panelSize = 0;
    double totalDividerSize = 0;

    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;

      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider == true) {
          // Calculate divider size
          Size childSize;
          if (direction == Axis.horizontal) {
            childSize = child.getDryLayout(BoxConstraints(
              minWidth: 0,
              maxWidth: constraints.maxWidth,
              minHeight: intrinsicCross,
              maxHeight: intrinsicCross,
            ));
          } else {
            childSize = child.getDryLayout(BoxConstraints(
              minWidth: intrinsicCross,
              maxWidth: intrinsicCross,
              minHeight: 0,
              maxHeight: constraints.maxHeight,
            ));
          }
          totalDividerSize += _getSizeExtent(childSize);
        } else if (childParentData.flex != null) {
          flexCount += childParentData.flex!;
        } else if (childParentData.size != null) {
          panelSize += childParentData.size!;
        }
      }

      child = childParentData.nextSibling;
    }

    // Calculate remaining space for flex children
    double parentSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double remainingSpace = parentSize - (panelSize + totalDividerSize);
    double flexSpace = flexCount > 0 ? remainingSpace / flexCount : 0;

    // Calculate total main axis size
    mainOffset = panelSize + totalDividerSize + (flexSpace * flexCount);

    Size size;
    if (direction == Axis.horizontal) {
      size = Size(mainOffset, intrinsicCross);
    } else {
      size = Size(intrinsicCross, mainOffset);
    }

    return constraints.constrain(size);
  }
}
