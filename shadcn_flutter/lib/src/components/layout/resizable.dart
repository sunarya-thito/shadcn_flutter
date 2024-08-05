// WIP
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef Predicate<T> = bool Function(T value);

const _kDebugResizable = false;

class HorizontalResizableDragger extends StatelessWidget {
  const HorizontalResizableDragger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.border,
          borderRadius: BorderRadius.circular(theme.radiusSm),
        ),
        alignment: Alignment.center,
        width: 3 * 4 * scaling,
        height: 4 * 4 * scaling,
        child: Icon(
          RadixIcons.dragHandleDots2,
          size: 4 * 2.5 * scaling,
        ),
      ),
    );
  }
}

class VerticalResizableDragger extends StatelessWidget {
  const VerticalResizableDragger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.border,
          borderRadius: BorderRadius.circular(theme.radiusSm),
        ),
        alignment: Alignment.center,
        width: 4 * 4 * scaling,
        height: 3 * 4 * scaling,
        child: Transform.rotate(
          angle: pi / 2,
          child: Icon(
            RadixIcons.dragHandleDots2,
            size: 4 * 2.5 * scaling,
          ),
        ),
      ),
    );
  }
}

class ResizablePaneValue {
  final double size;
  final bool collapsed;

  const ResizablePaneValue(this.size, this.collapsed);
}

enum PanelSibling {
  before(-1),
  after(1),
  both(0);

  final int direction;

  const PanelSibling(this.direction);
}

class ResizablePaneController extends ValueNotifier<ResizablePaneValue> {
  _ResizablePaneState? _attachedState;

  ResizablePaneController(double size, {bool collapsed = false})
      : super(ResizablePaneValue(size, collapsed));

  void _attachState(_ResizablePaneState state) {
    _attachedState = state;
  }

  void _detachState(_ResizablePaneState state) {
    _attachedState = null;
  }

  bool trySetSize(double newSize,
      [PanelSibling direction = PanelSibling.both]) {
    if (value.size == newSize) {
      return false;
    }
    if (newSize < 0) {
      newSize = 0;
    }
    double delta = newSize - value.size;
    if (delta == 0) {
      return false;
    }
    return tryExpandSize(delta, direction);
  }

  bool tryExpandSize(double size,
      [PanelSibling direction = PanelSibling.both]) {
    if (size == 0) {
      return false;
    }
    assert(_attachedState != null, 'State is not attached');
    final activePane = _attachedState!._activePane;
    assert(activePane != null, 'ActivePane is not attached');
    return activePane!._containerState
        ._attemptExpand(activePane.index, direction.direction, size);
  }

  bool tryCollapse([PanelSibling direction = PanelSibling.both]) {
    if (value.collapsed) {
      return false;
    }
    assert(_attachedState != null, 'State is not attached');
    final activePane = _attachedState!._activePane;
    assert(activePane != null, 'ActivePane is not attached');
    return activePane!._containerState
        ._attemptCollapse(activePane.index, direction.direction);
  }

  bool tryExpand([PanelSibling direction = PanelSibling.both]) {
    if (!value.collapsed) {
      return false;
    }
    assert(_attachedState != null, 'State is not attached');
    final activePane = _attachedState!._activePane;
    assert(activePane != null, 'ActivePane is not attached');
    return activePane!._containerState
        ._attemptExpandCollapsed(activePane.index, direction.direction);
  }

  set size(double newValue) {
    assert(newValue.isFinite, 'Size must be finite');
    if (newValue < 0) {
      newValue = 0;
    }
    if (value.size == newValue) {
      return;
    }
    super.value = ResizablePaneValue(newValue, value.collapsed);
  }

  double get size => value.size;

  set collapsed(bool newValue) {
    if (value.collapsed == newValue) {
      return;
    }
    super.value = ResizablePaneValue(value.size, newValue);
  }

  bool get collapsed => value.collapsed;
}

class ResizablePane extends StatefulWidget {
  final Widget child;
  final bool resizable;
  final ValueChanged<double>? onResize;
  final double? initialSize;
  final bool initialCollapsed;
  final double? minSize;
  final double? maxSize;
  final double? collapsedSize;
  final ResizablePaneController? controller;
  final double? flex;

  const ResizablePane({
    Key? key,
    this.resizable = true,
    required this.child,
    this.onResize,
    required double initialSize,
    this.minSize,
    this.maxSize,
    this.collapsedSize,
    this.initialCollapsed = false,
  })  : controller = null,
        flex = null,
        initialSize = initialSize,
        super(key: key);

  const ResizablePane.flex({
    Key? key,
    this.resizable = true,
    required this.child,
    this.onResize,
    this.minSize,
    this.maxSize,
    this.collapsedSize,
    this.initialCollapsed = false,
    this.flex = 1,
  })  : controller = null,
        initialSize = null,
        super(key: key);

  const ResizablePane._controlled({
    Key? key,
    this.resizable = true,
    required this.child,
    this.onResize,
    this.minSize,
    this.maxSize,
    this.collapsedSize,
    required this.initialSize,
    required this.controller,
    this.initialCollapsed = false,
    this.flex,
  }) : super(key: key);

  factory ResizablePane.controlled({
    Key? key,
    bool resizable = true,
    required Widget child,
    ValueChanged<double>? onResize,
    double? minSize,
    double? maxSize,
    double? collapsedSize,
    required ResizablePaneController controller,
    double? flex,
  }) {
    return ResizablePane._controlled(
      key: key,
      resizable: resizable,
      onResize: onResize,
      initialSize: controller.value.size,
      initialCollapsed: controller.value.collapsed,
      minSize: minSize,
      maxSize: maxSize,
      collapsedSize: collapsedSize,
      controller: controller,
      flex: flex,
      child: child,
    );
  }

  @override
  State<ResizablePane> createState() => _ResizablePaneState();
}

class ResizableContainerData {
  final double sparedFlexSpaceSize;
  final double flexSpace;
  final double flexCount;

  const ResizableContainerData(
      this.sparedFlexSpaceSize, this.flexSpace, this.flexCount);
}

class _ResizablePaneState extends State<ResizablePane> {
  ResizablePaneController? __controller;
  _ActivePane? _activePane;
  double? _sparedFlexSize;

  ResizablePaneController get _controller {
    assert(__controller != null, 'ResizablePane is not properly initialized');
    return __controller!;
  }

  double _changeSize(double size) {
    assert(size >= 0, 'Size must be greater than or equal to 0 (size: $size)');
    assert((widget.minSize == null || size >= widget.minSize!) || collapsed,
        'Size must be greater than or equal to minSize (size: $size, minSize: ${widget.minSize})');
    assert(!collapsed || size == (widget.collapsedSize ?? 0),
        'Size must be equal to collapsedSize if collapsed (size: $size, collapsedSize: ${widget.collapsedSize})');
    assert(widget.maxSize == null || size <= widget.maxSize!,
        'Size must be less than or equal to maxSize (size: $size, maxSize: ${widget.maxSize})');
    if (size == _controller.value.size) {
      return 0;
    }
    double diff = size - _controller.value.size;
    widget.onResize?.call(size);
    _controller.size = size;
    return diff;
  }

  double get size => _controller.value.size;

  double get viewSize => _controller.value.collapsed
      ? widget.collapsedSize ?? 0
      : _controller.value.size;

  bool get collapsed => _controller.value.collapsed;

  set collapsed(bool newValue) {
    _controller.collapsed = newValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var containerData = Data.maybeOf<ResizableContainerData>(context);
    assert(widget.flex == null || containerData != null,
        'ResizablePane must be a child of ResizableContainer');
    var newActivePane = Data.maybeOf<_ActivePane>(context);
    assert(
        newActivePane != null, 'ResizablePane must be a child of ActivePane');

    if (newActivePane != _activePane) {
      _activePane?._attachedPane = null;
      _activePane = newActivePane;
      _activePane?._attachedPane = this;
    }

    if (__controller == null) {
      _sparedFlexSize = containerData?.sparedFlexSpaceSize;
      if (widget.flex != null) {
        if (widget.controller == null) {
          __controller = ResizablePaneController(
            (containerData!.sparedFlexSpaceSize *
                    (_activePane!._flex ?? widget.flex!))
                .clamp(widget.minSize ?? 0, widget.maxSize ?? double.infinity),
            collapsed: widget.initialCollapsed,
          );
          __controller!._attachState(this);
        } else {
          __controller = widget.controller;
          __controller!.value = ResizablePaneValue(
            (containerData!.sparedFlexSpaceSize *
                    (_activePane!._flex ?? widget.flex!))
                .clamp(widget.minSize ?? 0, widget.maxSize ?? double.infinity),
            widget.initialCollapsed,
          );
          __controller!._attachState(this);
        }
      } else {
        __controller = widget.controller ??
            ResizablePaneController(
              widget.initialSize!,
              collapsed: widget.initialCollapsed,
            );
        __controller!._attachState(this);
      }
    } else {
      _sparedFlexSize = containerData?.sparedFlexSpaceSize;
      if (widget.flex != null) {
        double newSize =
            (_sparedFlexSize! * (_activePane!._flex ?? widget.flex!))
                .clamp(widget.minSize ?? 0, widget.maxSize ?? double.infinity);
        _controller.size = newSize;
      }
    }
  }

  @override
  void didUpdateWidget(covariant ResizablePane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      __controller?._detachState(this);
      if (widget.flex != null) {
        if (widget.controller == null) {
          __controller = ResizablePaneController(
            (_sparedFlexSize! * widget.flex!)
                .clamp(widget.minSize ?? 0, widget.maxSize ?? double.infinity),
            collapsed: widget.initialCollapsed,
          );
        } else {
          __controller = widget.controller;
          __controller!.value = ResizablePaneValue(
            (_sparedFlexSize! * widget.flex!)
                .clamp(widget.minSize ?? 0, widget.maxSize ?? double.infinity),
            widget.initialCollapsed,
          );
          __controller!._attachState(this);
        }
      } else {
        __controller = widget.controller ??
            ResizablePaneController(
              widget.initialSize!,
              collapsed: widget.initialCollapsed,
            );
        __controller!._attachState(this);
      }
    } else if (widget.flex != oldWidget.flex) {
      double oldFlexedSize = _sparedFlexSize! * oldWidget.flex!;
      double newFlexedSize = _sparedFlexSize! * widget.flex!;
      double diff = newFlexedSize - oldFlexedSize;
      double newSize = _controller.value.size + diff;
      newSize =
          newSize.clamp(widget.minSize ?? 0, widget.maxSize ?? double.infinity);
      _controller.size = newSize;
    }
  }

  @override
  void dispose() {
    _activePane?._attachedPane = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resizablePanelState = Data.maybeOf<_ResizablePanelState>(context);
    assert(resizablePanelState != null,
        'ResizablePane must be a child of ResizablePanel');
    return buildContainer(context, resizablePanelState);
  }

  Widget buildDataBoundary() {
    return Data<_ResizablePaneState>.boundary(
      child: Data<_ActivePane>.boundary(
        child: Data<ResizablePaneController>.boundary(
          child: widget.child,
        ),
      ),
    );
  }

  Widget buildContainer(
      BuildContext context, _ResizablePanelState? resizablePanelState) {
    final direction = resizablePanelState!.widget.direction;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        BoxConstraints size;
        if (collapsed) {
          size = direction == Axis.horizontal
              ? BoxConstraints.tightFor(width: widget.collapsedSize ?? 0)
              : BoxConstraints.tightFor(height: widget.collapsedSize ?? 0);
        } else {
          size = direction == Axis.horizontal
              ? BoxConstraints.tightFor(width: _controller.size)
              : BoxConstraints.tightFor(height: _controller.size);
        }
        return Data(
          data: _controller.value,
          child: ConstrainedBox(
            constraints: size,
            child: Offstage(
                offstage: _controller.value.size == 0,
                // child: widget.child,
                child: _kDebugResizable
                    ? Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.none,
                        children: [
                          buildDataBoundary(),
                          Positioned(
                            bottom: -(_activePane!.index + 1) * 16,
                            child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Text(
                                      'Size: ${_controller.value.collapsed ? widget.collapsedSize : _controller.value.size}\nFlex: ${_activePane?._flex}');
                                }),
                          ),
                        ],
                      )
                    : buildDataBoundary()),
          ),
        );
      },
    );
  }
}
//
// class _ResizableDivider extends StatefulWidget {
//   final Widget child;
//   final int index;
//   const _ResizableDivider({
//     Key? key,
//     required this.child,
//     required this.index,
//   }) : super(key: key);
//
//   @override
//   State<_ResizableDivider> createState() => _ResizableDividerState();
// }
//
// class _ResizableDividerState extends State<_ResizableDivider> {
//   @override
//   Widget build(BuildContext context) {
//     final resizablePanelState = Data.maybeOf<_ResizablePanelState>(context);
//     assert(resizablePanelState != null,
//         'ResizableDivider must be a child of ResizablePanel');
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onPanStart: (details) {
//         resizablePanelState!._startDragging();
//       },
//       onPanUpdate: (details) {
//         var delta = resizablePanelState!.widget.direction == Axis.horizontal
//             ? details.delta.dx
//             : details.delta.dy;
//         resizablePanelState._dragDivider(widget.index, delta);
//       },
//       onPanEnd: (details) {
//         resizablePanelState!._stopDragging();
//       },
//       onPanCancel: () {
//         resizablePanelState!._stopDragging();
//       },
//       child: Data(data: this, child: widget.child),
//     );
//   }
// }

typedef PreferredSizeWidgetBuilder = PreferredSizeWidget Function(
    BuildContext context);

class ResizablePanel extends StatefulWidget {
  // static PreferredSizeWidget _defaultDividerBuilder(BuildContext context) {
  //   final state = Data.maybeOf<_ResizablePanelState>(context);
  //   assert(state != null, 'ResizableDivider must be a child of ResizablePanel');
  //   if (state!.widget.direction == Axis.horizontal) {
  //     return const VerticalDivider();
  //   } else {
  //     return const Divider();
  //   }
  // }

  static Widget _defaultDraggerBuilder(BuildContext context) {
    // return Container(
    //   color: Colors.yellow.withOpacity(0.2),
    // );
    final state = Data.maybeOf<_ResizablePanelState>(context);
    assert(state != null, 'ResizableDivider must be a child of ResizablePanel');
    if (state!.widget.direction == Axis.horizontal) {
      return const SizedBox(
        width: 10,
      );
    } else {
      return const SizedBox(
        height: 10,
      );
    }
  }

  final List<ResizablePane> children;
  final PreferredSizeWidget? divider;
  final WidgetBuilder? draggerBuilder;
  final Axis direction;

  const ResizablePanel({
    Key? key,
    required this.children,
    required this.direction,
    this.divider,
    this.draggerBuilder = _defaultDraggerBuilder,
  }) : super(key: key);

  const ResizablePanel.horizontal({
    Key? key,
    required this.children,
    this.divider = const VerticalDivider(),
    this.draggerBuilder = _defaultDraggerBuilder,
  })  : direction = Axis.horizontal,
        super(key: key);

  const ResizablePanel.vertical({
    Key? key,
    required this.children,
    this.divider = const Divider(),
    this.draggerBuilder = _defaultDraggerBuilder,
  })  : direction = Axis.vertical,
        super(key: key);

  @override
  State<ResizablePanel> createState() => _ResizablePanelState();
}

class _ActivePane {
  final _ResizablePanelState _containerState;
  final GlobalKey _key = GlobalKey();
  final int index;
  _ResizablePaneState? _attachedPane;
  double _sizeBeforeDrag = 0;
  double __proposedSize = 0;
  double? _flex;
  double get _proposedSize => __proposedSize;

  set _proposedSize(double value) {
    assert(value >= 0,
        'Size must be greater than or equal to 0 (size: $value, index: $index)');
    assert(
        (_attachedPane!.widget.minSize == null ||
                value >= _attachedPane!.widget.minSize!) ||
            _attachedPane!.collapsed,
        'Size must be greater than or equal to minSize (size: $value, minSize: ${_attachedPane!.widget.minSize}, index: $index)');
    assert(
        !_attachedPane!.collapsed ||
            value == (_attachedPane!.widget.collapsedSize ?? 0),
        'Size must be equal to collapsedSize if collapsed (size: $value, collapsedSize: ${_attachedPane!.widget.collapsedSize}, index: $index)');
    assert(
        _attachedPane!.widget.maxSize == null ||
            value <= _attachedPane!.widget.maxSize!,
        'Size must be less than or equal to maxSize (size: $value, maxSize: ${_attachedPane!.widget.maxSize}, index: $index)');
    __proposedSize = value;
  }

  _ActivePane(
      {required this.index, required _ResizablePanelState containerState})
      : _containerState = containerState;
}

class _BorrowInfo {
  final double givenSize;
  final int from;

  _BorrowInfo(this.givenSize, this.from);
}

class _ResizablePanelState extends State<ResizablePanel> {
  late List<_ActivePane> _panes;
  late bool _expands;

  @override
  void initState() {
    super.initState();
    _panes = List.generate(widget.children.length,
        (index) => _ActivePane(index: index, containerState: this));
    _checkExpands();
    // Trigger 2nd build to recompute divider size
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _checkExpands() {
    _expands = widget.children.any((pane) => pane.flex != null);
  }

  bool _isDragging = true;
  double _couldNotBorrow = 0;

  void _startDragging() {
    _couldNotBorrow = 0;
    for (final pane in _panes) {
      final attachedPane = pane._attachedPane;
      if (attachedPane == null) {
        return;
      }
      var size = attachedPane.viewSize;
      pane._sizeBeforeDrag = size;
      pane._proposedSize = size;
      // pane._couldNotBorrow = 0;
    }
    _isDragging = true;
  }

  void _stopDragging() {
    _isDragging = false;
  }

  void _resetProposedSizes() {
    for (int i = 0; i < _panes.length; i++) {
      final pane = _panes[i];
      if (pane._attachedPane != null) {
        pane._proposedSize = pane._attachedPane!.viewSize;
      }
    }
  }

  // returns the amount of loan that has been paid
  double _payOffLoanSize(int index, double delta, int direction) {
    if (_kDebugResizable) {
      print('PAYOFFLOAN index: $index delta: $delta direction: $direction');
    }
    if (direction < 0) {
      for (int i = 0; i < index; i++) {
        double borrowedSize =
            _panes[i]._proposedSize - _panes[i]._sizeBeforeDrag;
        // if we have borrowed size, and we currently paying it, then:
        if (borrowedSize < 0 && delta > 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (_kDebugResizable) {
            print('newBorrowedSize: $newBorrowedSize delta: $delta');
          }
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          if (_kDebugResizable) {
            print(
                'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
          }
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (_kDebugResizable) {
            print('newBorrowedSize: $newBorrowedSize delta: $delta');
          }
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          if (_kDebugResizable) {
            print(
                'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
          }
          return delta;
        }
      }
    } else if (direction > 0) {
      for (int i = _panes.length - 1; i > index; i--) {
        double borrowedSize =
            _panes[i]._proposedSize - _panes[i]._sizeBeforeDrag;
        // if we have borrowed size, and we currently paying it, then:
        if (borrowedSize < 0 && delta > 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (_kDebugResizable) {
            print('newBorrowedSize: $newBorrowedSize delta: $delta');
          }
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          if (_kDebugResizable) {
            print(
                'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
          }
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (_kDebugResizable) {
            print('newBorrowedSize: $newBorrowedSize delta: $delta');
          }
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          if (_kDebugResizable) {
            print(
                'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
          }
          return delta;
        }
      }
    }
    if (_kDebugResizable) print('No loan to pay');
    return 0;
  }

  _BorrowInfo _borrowSize(int index, double delta, int until, int direction) {
    assert(direction == -1 || direction == 1, 'Direction must be -1 or 1');
    // assert(
    //     (direction == -1 && index >= until) ||
    //         (direction == 1 && index <= until) ||
    //         (index < 0 || index >= _panes.length) ||
    //         (until < 0 || until >= _panes.length),
    //     'Index must be greater than until if direction is -1, and less than until if direction is 1 (index: $index, until: $until, direction: $direction)');
    if (_kDebugResizable) {
      print(
          '_borrowSize index: $index delta: $delta direction: $direction until: $until');
    }
    // delta in here does not mean direction of the drag!
    final pane = getAt(index);
    if (pane == null) {
      if (_kDebugResizable) print('panel is null: $index');
      return _BorrowInfo(0, index - direction);
    }

    if (index == until + direction) {
      if (_kDebugResizable) print('index == until: $index');
      return _BorrowInfo(0, index);
    }
    var attachedPane = pane._attachedPane;
    if (attachedPane == null) {
      if (_kDebugResizable) print('attachedPane is null: $index');
      return _BorrowInfo(0, index - direction);
    }

    if (!attachedPane.widget.resizable) {
      if (_kDebugResizable) print('not resizable: $index');
      return _BorrowInfo(0, index - direction);
    }

    double minSize = attachedPane.widget.minSize ?? 0;
    double maxSize = attachedPane.widget.maxSize ?? double.infinity;

    if (attachedPane.collapsed) {
      // nope, we're closed, go borrow to another neighbor
      if (_kDebugResizable) print('collapsed: $index');
      // return _borrowSize(index + direction, delta, until, direction);
      if ((direction < 0 && delta < 0) || (direction > 0 && delta > 0)) {
        return _borrowSize(index + direction, delta, until, direction);
      }
      return _BorrowInfo(0, index);
    }

    double newSize = pane._proposedSize + delta; // 98 + 5

    if (newSize < minSize) {
      double overflow = newSize - minSize;
      double given = delta - overflow;

      if (_kDebugResizable) {
        print(
            'minSize: $minSize overflow: $overflow given: $given delta: $delta');
      }

      var borrowSize =
          _borrowSize(index + direction, overflow, until, direction);
      pane._proposedSize = minSize;
      return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
    }

    if (newSize > maxSize) {
      // 103 > 100
      double maxOverflow = newSize - maxSize; // 103 - 100 = 3
      double given = delta - maxOverflow; // 5 - 3 = 2

      if (_kDebugResizable) {
        print(
            'maxSize: $maxSize maxOverflow: $maxOverflow given: $given delta: $delta');
      }

      var borrowSize =
          _borrowSize(index + direction, maxOverflow, until, direction);
      // if (borrowSize != null) {
      //   pane._proposedSize = maxSize;
      //   return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
      // }
      // return null;
      pane._proposedSize = maxSize;
      return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
    }

    if (_kDebugResizable) {
      print('newSize: $newSize index: $index delta: $delta');
    }

    pane._proposedSize = newSize;
    // return delta;
    return _BorrowInfo(delta, index);
    // return delta;
  }

  bool _attemptExpand(int index, int direction, double delta) {
    double currentSize = _panes[index]._attachedPane!.size;
    double minSize = _panes[index]._attachedPane!.widget.minSize ?? 0;
    double maxSize =
        _panes[index]._attachedPane!.widget.maxSize ?? double.infinity;
    double newSize = currentSize + delta;
    double minOverflow = newSize - minSize;
    double maxOverflow = newSize - maxSize;
    // adjust delta if we have overflow
    if (minOverflow < 0 && delta < 0) {
      delta = delta - minOverflow;
    }
    if (maxOverflow > 0 && delta > 0) {
      delta = delta - maxOverflow;
    }
    if (delta == 0) {
      return false;
    }
    _startDragging();
    if (index == 0) {
      direction = 1;
    } else if (index == _panes.length - 1) {
      direction = -1;
    }
    if (direction < 0) {
      // expand to the left
      _BorrowInfo borrowed = _borrowSize(index - 1, -delta, 0, -1);
      if (borrowed.givenSize != -delta) {
        _resetProposedSizes();
        return false;
      }

      _panes[index]._proposedSize =
          (_panes[index]._proposedSize + delta).clamp(minSize, maxSize);
      _applyProposedSizes();
      _stopDragging();
      return true;
    } else if (direction > 0) {
      // expand to the right
      _BorrowInfo borrowed =
          _borrowSize(index + 1, -delta, _panes.length - 1, 1);
      if (borrowed.givenSize != -delta) {
        _resetProposedSizes();
        _stopDragging();
        return false;
      }
      _panes[index]._proposedSize =
          (_panes[index]._proposedSize + delta).clamp(minSize, maxSize);
      _applyProposedSizes();
      _stopDragging();
      return true;
    } else if (direction == 0) {
      // expand to both sides
      double halfDelta = delta / 2;
      _BorrowInfo borrowedLeft = _borrowSize(index - 1, -halfDelta, 0, -1);
      _BorrowInfo borrowedRight =
          _borrowSize(index + 1, -halfDelta, _panes.length - 1, 1);
      if (borrowedLeft.givenSize != -halfDelta ||
          borrowedRight.givenSize != -halfDelta) {
        _resetProposedSizes();
        _stopDragging();
        return false;
      }
      _panes[index]._proposedSize =
          (_panes[index]._proposedSize + delta).clamp(minSize, maxSize);
      _applyProposedSizes();
      _stopDragging();
      return true;
    }
    return false;
  }

  bool _attemptCollapse(int index, int direction) {
    _startDragging();
    if (index == 0) {
      direction = 1;
    } else if (index == _panes.length - 1) {
      direction = -1;
    }
    if (direction < 0) {
      // collapse to the left
      final child = widget.children[index];
      final collapsedSize = child.collapsedSize ?? 0.0;
      final currentSize = _panes[index]._attachedPane!.size;
      final delta = currentSize - collapsedSize;
      _BorrowInfo borrowed = _borrowSize(index - 1, delta, 0, -1);
      if (borrowed.givenSize != delta) {
        _resetProposedSizes();
        _stopDragging();
        return false;
      }
      _applyProposedSizes();
      _panes[index]._attachedPane!.collapsed = true;
      _stopDragging();
      return true;
    } else if (direction > 0) {
      // collapse to the right
      final child = widget.children[index];
      final collapsedSize = child.collapsedSize ?? 0.0;
      final currentSize = _panes[index]._attachedPane!.size;
      final delta = currentSize - collapsedSize;
      _BorrowInfo borrowed =
          _borrowSize(index + 1, delta, _panes.length - 1, 1);
      if (borrowed.givenSize != delta) {
        _resetProposedSizes();
        _stopDragging();
        return false;
      }
      _applyProposedSizes();
      _panes[index]._attachedPane!.collapsed = true;
      _stopDragging();
      return true;
    } else if (direction == 0) {
      // collapse to both sides
      final child = widget.children[index];
      final collapsedSize = child.collapsedSize ?? 0.0;
      final currentSize = _panes[index]._attachedPane!.size;
      final delta = currentSize - collapsedSize;
      double halfDelta = delta / 2;
      _BorrowInfo borrowedLeft = _borrowSize(index - 1, halfDelta, 0, -1);
      _BorrowInfo borrowedRight =
          _borrowSize(index + 1, halfDelta, _panes.length - 1, 1);
      if (borrowedLeft.givenSize != halfDelta ||
          borrowedRight.givenSize != halfDelta) {
        _resetProposedSizes();
        _stopDragging();
        return false;
      }
      _applyProposedSizes();
      _panes[index]._attachedPane!.collapsed = true;
      _stopDragging();
      return true;
    }
    return false;
  }

  bool _attemptExpandCollapsed(int index, int direction) {
    _startDragging();
    if (index == 0) {
      direction = 1;
    } else if (index == _panes.length - 1) {
      direction = -1;
    }
    if (direction < 0) {
      // expand to the left
      final child = widget.children[index];
      final currentSize = _panes[index]._attachedPane!.size;
      final collapsedSize = child.collapsedSize ?? 0.0;
      final delta = collapsedSize - currentSize;
      _BorrowInfo borrowed = _borrowSize(index - 1, delta, 0, -1);
      if (borrowed.givenSize != delta) {
        _resetProposedSizes();
        _stopDragging();
        return false;
      }
      _applyProposedSizes();
      _panes[index]._attachedPane!._controller.value = ResizablePaneValue(
        currentSize,
        false,
      );
      _stopDragging();
      return true;
    } else if (direction > 0) {
      // expand to the right
      final child = widget.children[index];
      final currentSize = _panes[index]._attachedPane!.size;
      final collapsedSize = child.collapsedSize ?? 0.0;
      final delta = collapsedSize - currentSize;
      _BorrowInfo borrowed =
          _borrowSize(index + 1, delta, _panes.length - 1, 1);
      if (borrowed.givenSize != delta) {
        _resetProposedSizes();
        return false;
      }
      _applyProposedSizes();
      _panes[index]._attachedPane!._controller.value = ResizablePaneValue(
        currentSize,
        false,
      );
      _stopDragging();
      return true;
    } else if (direction == 0) {
      // expand to both sides
      final child = widget.children[index];
      final currentSize = _panes[index]._attachedPane!.size;
      final collapsedSize = child.collapsedSize ?? 0.0;
      final delta = collapsedSize - currentSize;
      double halfDelta = delta / 2;
      _BorrowInfo borrowedLeft = _borrowSize(index - 1, halfDelta, 0, -1);
      _BorrowInfo borrowedRight =
          _borrowSize(index + 1, halfDelta, _panes.length - 1, 1);
      if (borrowedLeft.givenSize != halfDelta ||
          borrowedRight.givenSize != halfDelta) {
        _resetProposedSizes();
        _stopDragging();
        return false;
      }
      _applyProposedSizes();
      _panes[index]._attachedPane!._controller.value = ResizablePaneValue(
        currentSize,
        false,
      );
      _stopDragging();
      return true;
    }
    return false;
  }

  void _applyProposedSizes() {
    setState(() {
      for (int i = 0; i < _panes.length; i++) {
        final pane = _panes[i];
        final attachedPane = pane._attachedPane;
        if (attachedPane == null) {
          return;
        }
        attachedPane._changeSize(pane._proposedSize);
      }
      _recomputeFlex();
    });
  }

  void _debugCouldNotBorrow() {
    // if (kDebugResizable) print('Could not borrow: ${_panes.map((e) => e._couldNotBorrow).toList()}');
    // if (kDebugResizable) print('Could not expand: ${_panes.map((e) => e._couldNotExpand).toList()}');
    if (_kDebugResizable) {
      print('Proposed sizes: ${_panes.map((e) => e._proposedSize).toList()}');
    }
  }

  void _dragDivider(int index, double delta) {
    // delta *= 3;
    if (!_isDragging) {
      return;
    }
    if (delta == 0) {
      return;
    }

    if (_kDebugResizable) {
      print('================ DRAG START ==================');
    }

    if (_kDebugResizable) {
      print(
          'Before sizes: ${_panes.map((e) => e._attachedPane?.size ?? 0).toList()}');
    }

    if (_kDebugResizable) print('=== BORROWING LEFT');
    _BorrowInfo borrowedLeft = _borrowSize(index - 1, delta, 0, -1);
    if (_kDebugResizable) print('=== BORROWING RIGHT');
    _BorrowInfo borrowedRight =
        _borrowSize(index, -delta, _panes.length - 1, 1);
    if (_kDebugResizable) print('=== END BORROWING');

    double borrowedRightSize = borrowedRight.givenSize;
    double borrowedLeftSize = borrowedLeft.givenSize;

    double couldNotBorrowRight = borrowedRightSize + delta;
    double couldNotBorrowLeft = borrowedLeftSize - delta;

    //
    if (couldNotBorrowLeft != 0 || couldNotBorrowRight != 0) {
      _couldNotBorrow += delta;
    } else {
      _couldNotBorrow = 0;
    }
    if (_kDebugResizable) {
      print('Temp Sizes: ${_panes.map((e) => e._proposedSize).toList()}');
    }

    double givenBackLeft = 0;
    double givenBackRight = 0;
    if (couldNotBorrowLeft != -couldNotBorrowRight) {
      if (_kDebugResizable) print('=== GIVING BACK');
      givenBackLeft =
          _borrowSize(borrowedRight.from, -couldNotBorrowLeft, index, -1)
              .givenSize;
      if (_kDebugResizable) {
        print('Giving back left from: ${borrowedRight.from} -> $givenBackLeft');
      }
      givenBackRight =
          _borrowSize(borrowedLeft.from, -couldNotBorrowRight, index - 1, 1)
              .givenSize;
      if (_kDebugResizable) {
        print(
            'Giving back right from: ${borrowedLeft.from} -> $givenBackRight');
      }
      if (_kDebugResizable) print('=== END GIVING BACK');
    }

    if (givenBackLeft != -couldNotBorrowLeft ||
        givenBackRight != -couldNotBorrowRight) {
      if (_kDebugResizable) {
        print(
            'RESET SIZES: $givenBackLeft != ${-couldNotBorrowLeft} || $givenBackRight != ${-couldNotBorrowRight} -> ${_panes.map((e) => e._proposedSize).toList()}');
      }
      _resetProposedSizes();
      return;
    }

    if (_kDebugResizable) {
      print(
          'l: $borrowedLeftSize r: $borrowedRightSize d: $delta cb: $_couldNotBorrow cbL: $couldNotBorrowLeft cbR: $couldNotBorrowRight bfL: ${borrowedLeft.from} bfR: ${borrowedRight.from} gbL: $givenBackLeft gbR: $givenBackRight');
    }
    if (_kDebugResizable) {
      print(
          'Loaned Sizes: ${_panes.map((e) => e._sizeBeforeDrag - e._proposedSize).toList()}');
    }
    double payOffLeft = _payOffLoanSize(index - 1, delta, -1);
    double payOffRight = _payOffLoanSize(index, -delta, 1);
    // _panes[index]._proposedSize -= payOffRight;
    // _panes[index - 1]._proposedSize -= payOffLeft;

    double payingBackLeft =
        _borrowSize(index - 1, -payOffLeft, 0, -1).givenSize;
    double payingBackRight =
        _borrowSize(index, -payOffRight, _panes.length - 1, 1).givenSize;

    if (payingBackLeft != -payOffLeft || payingBackRight != -payOffRight) {
      // if somehow the paid and the requesting payment is not the same
      // (meaning that the neighboring panes either being paid too much or less)
      // then we reject the loan and reset the proposed sizes
      if (_kDebugResizable) {
        print(
            'RESET LOAN SIZES: $payingBackLeft != ${-payOffLeft} || $payingBackRight != ${-payOffRight} -> ${_panes.map((e) => e._proposedSize).toList()}');
      }
      _resetProposedSizes();
      return;
    }

    // check if we have collapsible
    if (_couldNotBorrow > 0) {
      int start = borrowedRight.from;
      int endNotCollapsed = _panes.length - 1;
      for (int i = endNotCollapsed; i > start; i--) {
        if (_panes[i]._attachedPane!.collapsed) {
          endNotCollapsed = i;
        } else {
          break;
        }
      }
      if (_kDebugResizable) {
        print('CHECK COLLAPSING $index: $start == $endNotCollapsed');
      }
      if (start == endNotCollapsed) {
        if (_kDebugResizable) print('CHECK COLLAPSIBLE RIGHT $index');
        _checkCollapseUntil(index);
      }
      _checkExpanding(index);
    } else if (_couldNotBorrow < 0) {
      int start = borrowedLeft.from;
      int endNotCollapsed = 0;
      for (int i = endNotCollapsed; i < start; i++) {
        if (_panes[i]._attachedPane!.collapsed) {
          endNotCollapsed = i;
        } else {
          break;
        }
      }
      if (start == endNotCollapsed) {
        if (_kDebugResizable) {
          print('CHECK COLLAPSIBLE LEFT $start -> $endNotCollapsed');
        }
        _checkCollapseUntil(index);
      }
      _checkExpanding(index);
    }

    _debugCouldNotBorrow();

    _applyProposedSizes();
    if (_kDebugResizable) print('================ DRAG END ==================');
    return;
  }

  void _checkCollapseUntil(int index) {
    if (_couldNotBorrow < 0) {
      for (int i = index - 1; i >= 0; i--) {
        final previousPane = getAt(i);
        if (previousPane != null) {
          double? collapsibleSize =
              previousPane._attachedPane!.widget.collapsedSize;
          if (collapsibleSize != null &&
              !previousPane._attachedPane!.collapsed) {
            var minSize = previousPane._attachedPane!.widget.minSize ?? 0;
            double threshold = (collapsibleSize - minSize) / 2;
            if (_kDebugResizable) print('THRESHOLD $threshold');
            if (_couldNotBorrow < threshold) {
              if (_kDebugResizable) print('COLLAPSING $i');
              var toBorrow = minSize - collapsibleSize;
              var borrowed = _borrowSize(index, toBorrow, _panes.length - 1, 1);
              double borrowedSize = borrowed.givenSize;
              if (_kDebugResizable) {
                print(
                    'BORROWED SIZE $borrowedSize ASKING FOR $toBorrow FROM $index ENDS AT ${borrowed.from}');
              }
              if (borrowedSize < toBorrow) {
                _resetProposedSizes();
                continue;
              }
              previousPane._attachedPane!.collapsed = true;
              previousPane._proposedSize =
                  previousPane._attachedPane?.widget.collapsedSize ?? 0;
              previousPane._sizeBeforeDrag = previousPane._proposedSize;
              _couldNotBorrow = 0;
            }
          }
        }
      }
    } else if (_couldNotBorrow > 0) {
      for (int i = index; i < _panes.length; i++) {
        final nextPane = getAt(i);
        if (nextPane != null) {
          double? collapsibleSize =
              nextPane._attachedPane!.widget.collapsedSize;
          if (collapsibleSize != null && !nextPane._attachedPane!.collapsed) {
            var minSize = nextPane._attachedPane!.widget.minSize ?? 0;
            double threshold = (minSize - collapsibleSize) / 2;
            if (_kDebugResizable) print('THRESHOLD $threshold');
            if (_couldNotBorrow > threshold) {
              // disregard the delta here,
              // even tho for example the delta is -10,
              // and the amount of delta needed to collapse is -5,
              // we will still consume the entire delta
              if (_kDebugResizable) print('COLLAPSING $i');
              var toBorrow = minSize - collapsibleSize;
              var borrowed = _borrowSize(index - 1, toBorrow, 0, -1);
              double borrowedSize = borrowed.givenSize;
              if (_kDebugResizable) {
                print(
                    'BORROWED SIZE $borrowedSize ASKING FOR $toBorrow FROM $index ENDS AT ${borrowed.from}');
              }
              if (borrowedSize < toBorrow) {
                _resetProposedSizes();
                continue;
              }
              nextPane._attachedPane!.collapsed = true;
              nextPane._proposedSize =
                  nextPane._attachedPane?.widget.collapsedSize ?? 0;
              nextPane._sizeBeforeDrag = nextPane._proposedSize;
              _couldNotBorrow = 0;
            }
          }
        }
      }
    }
  }

  void _checkExpanding(int index) {
    if (_couldNotBorrow > 0) {
      // check if we can expand from the left side
      int toCheck = index - 1;
      for (; toCheck >= 0; toCheck--) {
        final pane = getAt(toCheck);
        if (pane != null && pane._attachedPane!.collapsed) {
          double? collapsibleSize = pane._attachedPane!.widget.collapsedSize;
          if (collapsibleSize != null) {
            double minSize = pane._attachedPane!.widget.minSize ?? 0;
            double threshold = (minSize - collapsibleSize) / 2;
            if (_kDebugResizable) print('EXPANDING THRESHOLD $threshold');
            if (_couldNotBorrow >= threshold) {
              double toBorrow = collapsibleSize - minSize;
              var borrowed =
                  _borrowSize(toCheck + 1, toBorrow, _panes.length, 1);
              double borrowedSize = borrowed.givenSize;
              if (_kDebugResizable) {
                print(
                    'EXPANDING BORROWED SIZE $borrowedSize ASKING FOR $toBorrow FROM $toCheck ENDS AT ${borrowed.from}');
              }
              if (borrowedSize > toBorrow) {
                // could not expand, not enough space
                _resetProposedSizes();
                continue;
              }
              pane._attachedPane!.collapsed = false;
              pane._proposedSize = minSize;
              pane._sizeBeforeDrag = minSize;
              _couldNotBorrow = 0;
            }
            break;
          }
          // we treat pane with no collapsibleSize as a non-collapsible pane
        }
      }
    } else if (_couldNotBorrow < 0) {
      // check if we can expand from the right side
      int toCheck = index;
      for (; toCheck < _panes.length; toCheck++) {
        final pane = getAt(toCheck);
        if (pane != null && pane._attachedPane!.collapsed) {
          double? collapsibleSize = pane._attachedPane!.widget.collapsedSize;
          if (collapsibleSize != null) {
            double minSize = pane._attachedPane!.widget.minSize ?? 0;
            double threshold = (collapsibleSize - minSize) / 2;
            if (_kDebugResizable) print('EXPANDING THRESHOLD $threshold');
            if (_couldNotBorrow <= threshold) {
              double toBorrow = collapsibleSize - minSize;
              var borrowed = _borrowSize(toCheck - 1, toBorrow, -1, -1);
              double borrowedSize = borrowed.givenSize;
              if (_kDebugResizable) {
                print(
                    'EXPANDING BORROWED SIZE $borrowedSize ASKING FOR $toBorrow FROM $toCheck ENDS AT ${borrowed.from}');
              }
              if (borrowedSize > toBorrow) {
                // could not expand, not enough space
                _resetProposedSizes();
                continue;
              }
              pane._attachedPane!.collapsed = false;
              pane._proposedSize = minSize;
              pane._sizeBeforeDrag = minSize;
              _couldNotBorrow = 0;
            }
            break;
          }
          // we treat pane with no collapsibleSize as a non-collapsible pane
        }
      }
    }
  }

  _ActivePane? getAt(int index) {
    if (index < 0 || index >= _panes.length) {
      return null;
    }
    return _panes[index];
  }

  void _recomputeFlex() {
    double? minSize;
    for (int i = 0; i < widget.children.length; i++) {
      final pane = getAt(i);
      if (pane != null && widget.children[i].flex != null) {
        var viewSize2 = pane._attachedPane!.viewSize;
        if (viewSize2 == 0) {
          continue;
        }
        if (minSize == null) {
          minSize = viewSize2;
        } else {
          minSize = min(minSize, viewSize2);
        }
      }
    }
    if (minSize != null) {
      for (int i = 0; i < widget.children.length; i++) {
        final pane = getAt(i);
        if (pane != null && widget.children[i].flex != null) {
          pane._flex =
              minSize == 0 ? 0 : pane._attachedPane!.viewSize / minSize;
        }
      }
    }
  }

  @override
  void didUpdateWidget(ResizablePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      _panes = List.generate(widget.children.length,
          (index) => _ActivePane(index: index, containerState: this));
      _checkExpands();
    }
  }

  List<Widget> buildChildren(BuildContext context) {
    List<Widget> children = [];
    assert(widget.children.length == _panes.length,
        'Children and panes length mismatch');
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final pane = _panes[i];
      if (i > 0 && widget.divider != null) {
        children.add(widget.divider!);
      }
      children.add(
        Data(
          data: pane,
          child: KeyedSubtree(
            key: _panes[i]._key,
            child: child,
          ),
        ),
      );
    }
    return children;
  }

  Widget buildContainer(BuildContext context) {
    switch (widget.direction) {
      case Axis.horizontal:
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: buildChildren(context),
          ),
        );
      case Axis.vertical:
        return IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: buildChildren(context),
          ),
        );
    }
  }

  Widget buildFlexContainer(BuildContext context, double sparedFlexSize,
      double flexSpace, double flexCount) {
    // print('flex: $flexSpace $flexCount $sparedFlexSize');
    switch (widget.direction) {
      case Axis.horizontal:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children:
              buildFlexChildren(context, sparedFlexSize, flexSpace, flexCount),
        );
      case Axis.vertical:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children:
              buildFlexChildren(context, sparedFlexSize, flexSpace, flexCount),
        );
    }
  }

  List<Widget> buildFlexChildren(BuildContext context, double sparedFlexSize,
      double flexSpace, double flexCount) {
    List<Widget> children = [];
    assert(widget.children.length == _panes.length,
        'Children and panes length mismatch');
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final pane = _panes[i];
      if (i > 0 && widget.divider != null) {
        children.add(
          widget.divider!,
        );
      }
      children.add(
        Data(
          data: pane,
          child: Data(
            data: ResizableContainerData(sparedFlexSize, flexSpace, flexCount),
            child: KeyedSubtree(
              key: _panes[i]._key,
              child: child,
            ),
          ),
        ),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    double dividerSize;
    if (widget.direction == Axis.horizontal) {
      dividerSize = widget.divider?.preferredSize.width ?? 0;
    } else {
      dividerSize = widget.divider?.preferredSize.height ?? 0;
    }
    // create dividers
    if (_expands) {
      return Data(
        data: this,
        child: LayoutBuilder(builder: (context, constraints) {
          double nonFlexSpace = 0;
          double flexCount = 0;
          double minSizeFlex = double.infinity;
          for (int i = 0; i < widget.children.length; i++) {
            final child = widget.children[i];
            if (child.flex == null) {
              assert(
                  child.initialSize != null, 'Initial size must not be null');
              nonFlexSpace += _panes[i]._attachedPane?.viewSize ??
                  (child.initialCollapsed
                      ? (child.collapsedSize ?? 0)
                      : (child.initialSize ?? 0));
            } else {
              double currentSize = _panes[i]._attachedPane?.viewSize ??
                  (child.initialCollapsed
                      ? (child.collapsedSize ?? 0)
                      : (child.initialSize ?? 0));
              minSizeFlex = min(minSizeFlex, currentSize);
            }
            if (i >= widget.children.length - 1) {
              continue;
            }
            nonFlexSpace += dividerSize;
          }

          for (int i = 0; i < widget.children.length; i++) {
            final child = widget.children[i];
            if (child.flex != null) {
              final attachedPane = _panes[i]._attachedPane;
              if (minSizeFlex == double.infinity ||
                  attachedPane == null ||
                  minSizeFlex == 0) {
                flexCount += _panes[i]._flex ?? child.flex!;
              } else {
                flexCount += attachedPane.viewSize / minSizeFlex;
              }
            }
          }
          if (flexCount.isNaN || flexCount.isInfinite) {
            flexCount = 0;
          }
          double containerSize = widget.direction == Axis.horizontal
              ? constraints.maxWidth
              : constraints.maxHeight;
          double flexSpace = containerSize - nonFlexSpace;
          double spacePerFlex = flexCount == 0 ? 0 : flexSpace / flexCount;

          List<Widget> draggers = [];
          double offset = 0;
          for (int i = 0; i < widget.children.length - 1; i++) {
            final child = widget.children[i];
            double size = (_panes[i]._attachedPane?.collapsed ??
                    child.initialCollapsed)
                ? (child.collapsedSize ?? 0)
                : (child.flex != null
                    ? ((_panes[i]._flex ?? child.flex)! * spacePerFlex).clamp(
                        child.minSize ?? 0, child.maxSize ?? double.infinity)
                    : (_panes[i]._attachedPane?.viewSize ??
                        child.initialSize ??
                        0));

            offset += size + dividerSize;
            Widget? dragger;
            bool leftRightCanDrag = widget.children[i].resizable &&
                widget.children[i + 1].resizable;
            if (widget.direction == Axis.horizontal && leftRightCanDrag) {
              dragger = Positioned(
                left: offset,
                top: 0,
                bottom: 0,
                child: FractionalTranslation(
                  translation: const Offset(-0.5, 0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        _startDragging();
                      },
                      onPanUpdate: (details) {
                        _dragDivider(i + 1, details.delta.dx);
                      },
                      onPanEnd: (details) {
                        _stopDragging();
                      },
                      child: Builder(
                        builder: (context) {
                          return widget.draggerBuilder!(context);
                        },
                      ),
                    ),
                  ),
                ),
              );
            } else if (leftRightCanDrag) {
              dragger = Positioned(
                top: offset,
                left: 0,
                right: 0,
                child: FractionalTranslation(
                  translation: const Offset(0, -0.5),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        _startDragging();
                      },
                      onPanUpdate: (details) {
                        _dragDivider(i + 1, details.delta.dy);
                      },
                      onPanEnd: (details) {
                        _stopDragging();
                      },
                      child: Builder(
                        builder: (context) {
                          return widget.draggerBuilder!(context);
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
            if (dragger != null) {
              draggers.add(dragger);
            }
          }
          return Stack(
            fit: StackFit.passthrough,
            clipBehavior: Clip.none,
            children: [
              buildFlexContainer(context, spacePerFlex, flexSpace, flexCount),
              ...draggers,
              if (_kDebugResizable)
                Positioned(
                  top: -16,
                  child: RepeatedAnimationBuilder(
                    duration: const Duration(milliseconds: 1),
                    start: 0.0,
                    end: 1.0,
                    builder: (context, value, child) {
                      return Text(
                          'Sum Sizes: ${_panes.map((e) => e._attachedPane?.viewSize ?? 0).fold(0.0, (a, b) => a + b)}');
                    },
                  ),
                )
            ],
          );
        }),
      );
    }

    List<Widget> draggers = [];
    var containerChildren = buildContainer(context);
    double offset = 0;
    for (int i = 0; i < widget.children.length - 1; i++) {
      final child = widget.children[i];
      double currentSize = _panes[i]._attachedPane?.viewSize ??
          (child.initialCollapsed
              ? (child.collapsedSize ?? 0)
              : (child.initialSize ?? 0));
      offset += currentSize + dividerSize;
      Widget dragger;
      if (widget.direction == Axis.horizontal) {
        dragger = Positioned(
          left: offset,
          top: 0,
          bottom: 0,
          child: FractionalTranslation(
            translation: const Offset(-0.5, 0),
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (details) {
                  _startDragging();
                },
                onPanUpdate: (details) {
                  _dragDivider(i + 1, details.delta.dx);
                },
                onPanEnd: (details) {
                  _stopDragging();
                },
                child: Builder(
                  builder: (context) {
                    return widget.draggerBuilder!(context);
                  },
                ),
              ),
            ),
          ),
        );
      } else {
        dragger = Positioned(
          top: offset,
          left: 0,
          right: 0,
          child: FractionalTranslation(
            translation: const Offset(0, -0.5),
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeUpDown,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (details) {
                  _startDragging();
                },
                onPanUpdate: (details) {
                  _dragDivider(i + 1, details.delta.dy);
                },
                onPanEnd: (details) {
                  _stopDragging();
                },
                child: Builder(
                  builder: (context) {
                    return widget.draggerBuilder!(context);
                  },
                ),
              ),
            ),
          ),
        );
      }
      draggers.add(dragger);
    }

    return Data(
      data: this,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          containerChildren,
          ...draggers,
          if (_kDebugResizable)
            Positioned(
              top: -16,
              child: RepeatedAnimationBuilder(
                duration: const Duration(milliseconds: 1),
                start: 0.0,
                end: 1.0,
                builder: (context, value, child) {
                  return Text(
                      'Sum Sizes: ${_panes.map((e) => e._attachedPane?.viewSize ?? 0).fold(0.0, (a, b) => a + b)}');
                },
              ),
            )
        ],
      ),
    );
  }
}
