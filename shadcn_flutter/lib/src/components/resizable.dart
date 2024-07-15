// WIP
import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef Predicate<T> = bool Function(T value);

class ResizablePaneValue {
  final double size;
  final bool collapsed;

  const ResizablePaneValue(this.size, this.collapsed);
}

class ResizablePaneController extends ValueNotifier<ResizablePaneValue> {
  ResizablePaneController(double size, {bool collapsed = false})
      : super(ResizablePaneValue(size, collapsed));

  set size(double newValue) {
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
  final double initialSize;
  final bool initialCollapsed;
  final double? minSize;
  final double? maxSize;
  final double? collapsedSize;
  final ResizablePaneController? controller;

  const ResizablePane({
    Key? key,
    this.resizable = true,
    required this.child,
    this.onResize,
    required this.initialSize,
    this.minSize,
    this.maxSize,
    this.collapsedSize,
    this.initialCollapsed = false,
  })  : controller = null,
        super(key: key);

  ResizablePane._controlled({
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
  }) {
    return ResizablePane._controlled(
      key: key,
      resizable: resizable,
      child: child,
      onResize: onResize,
      initialSize: controller.value.size,
      initialCollapsed: controller.value.collapsed,
      minSize: minSize,
      maxSize: maxSize,
      collapsedSize: collapsedSize,
      controller: controller,
    );
  }

  @override
  State<ResizablePane> createState() => _ResizablePaneState();
}

class _ResizablePaneState extends State<ResizablePane> {
  late ResizablePaneController _controller;
  _ActivePane? _activePane;

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
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? ResizablePaneController(widget.initialSize);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newActivePane = Data.maybeOf<_ActivePane>(context);
    if (newActivePane != _activePane) {
      _activePane?._attachedPane = null;
      _activePane = newActivePane;
      _activePane?._attachedPane = this;
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
    final direction = resizablePanelState!.widget.direction;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // final size = direction == Axis.horizontal
        //     ? BoxConstraints.tightFor(width: _controller.value)
        //     : BoxConstraints.tightFor(height: _controller.value);
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
        return ConstrainedBox(
          constraints: size,
          child: Offstage(
              offstage: _controller.value == 0,
              // child: widget.child,
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  widget.child,
                  Positioned(
                    bottom: -(_activePane!.index + 1) * 16,
                    child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Text(
                              'Size: ${_controller.value.collapsed ? widget.collapsedSize : _controller.value.size}');
                        }),
                  ),
                ],
              )),
        );
      },
    );
  }
}

class _ResizableDivider extends StatefulWidget {
  final Widget child;
  final int index;
  const _ResizableDivider({
    Key? key,
    required this.child,
    required this.index,
  }) : super(key: key);

  @override
  State<_ResizableDivider> createState() => _ResizableDividerState();
}

class _ResizableDividerState extends State<_ResizableDivider> {
  @override
  Widget build(BuildContext context) {
    final resizablePanelState = Data.maybeOf<_ResizablePanelState>(context);
    assert(resizablePanelState != null,
        'ResizableDivider must be a child of ResizablePanel');
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        resizablePanelState!._startDragging();
      },
      onPanUpdate: (details) {
        var delta = resizablePanelState!.widget.direction == Axis.horizontal
            ? details.delta.dx
            : details.delta.dy;
        resizablePanelState._dragDivider(widget.index, delta);
      },
      onPanEnd: (details) {
        resizablePanelState!._stopDragging();
      },
      onPanCancel: () {
        resizablePanelState!._stopDragging();
      },
      child: Data(data: this, child: widget.child),
    );
  }
}

class ResizablePanel extends StatefulWidget {
  static Widget _defaultDividerBuilder(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      color: Colors.yellow,
    );
  }

  final List<ResizablePane> children;
  final WidgetBuilder? dividerBuilder;
  final Axis direction;
  final double dividerSize;

  const ResizablePanel({
    Key? key,
    required this.children,
    this.direction = Axis.horizontal,
    this.dividerBuilder = _defaultDividerBuilder,
    this.dividerSize = 10,
  }) : super(key: key);

  @override
  State<ResizablePanel> createState() => _ResizablePanelState();
}

class _ActivePane {
  final int index;
  _ResizablePaneState? _attachedPane;
  double _sizeBeforeDrag = 0;
  double __proposedSize = 0;
  // double _proposedSize = 0;

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

  _ActivePane({required this.index});
}

class _BorrowInfo {
  final double givenSize;
  final int from;

  _BorrowInfo(this.givenSize, this.from);
}

class _ResizablePanelState extends State<ResizablePanel> {
  late List<_ActivePane> _panes;

  @override
  void initState() {
    super.initState();
    _panes = List.generate(
        widget.children.length, (index) => _ActivePane(index: index));
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
      pane._proposedSize = pane._attachedPane!.viewSize;
    }
  }

  // returns the amount of loan that has been paid
  double _payOffLoanSize(int index, double delta, int direction) {
    print('PAYOFFLOAN index: $index delta: $delta direction: $direction');
    if (direction < 0) {
      for (int i = 0; i < index; i++) {
        double borrowedSize =
            _panes[i]._proposedSize - _panes[i]._sizeBeforeDrag;
        // if we have borrowed size, and we currently paying it, then:
        if (borrowedSize < 0 && delta > 0) {
          double newBorrowedSize = borrowedSize + delta;
          print('newBorrowedSize: $newBorrowedSize delta: $delta');
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          print(
              'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          print('newBorrowedSize: $newBorrowedSize delta: $delta');
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          print(
              'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
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
          print('newBorrowedSize: $newBorrowedSize delta: $delta');
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          print(
              'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          print('newBorrowedSize: $newBorrowedSize delta: $delta');
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          _panes[i]._proposedSize = _panes[i]._sizeBeforeDrag + newBorrowedSize;
          print(
              'borrowedSize: $borrowedSize delta: $delta newBorrowedSize: $newBorrowedSize proposedSize: ${_panes[i]._proposedSize}');
          return delta;
        }
      }
    }
    print('No loan to pay');
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
    print(
        '_borrowSize index: $index delta: $delta direction: $direction until: $until');
    // delta in here does not mean direction of the drag!
    final pane = getAt(index);
    if (pane == null) {
      print('panel is null: $index');
      return _BorrowInfo(0, index - direction);
    }

    if (index == until + direction) {
      print('index == until: $index');
      return _BorrowInfo(0, index);
    }
    var attachedPane = pane._attachedPane;
    if (attachedPane == null) {
      print('attachedPane is null: $index');
      return _BorrowInfo(0, index - direction);
    }
    double minSize = attachedPane.widget.minSize ?? 0;
    double maxSize = attachedPane.widget.maxSize ?? double.infinity;

    if (attachedPane.collapsed) {
      // nope, we're closed, go borrow to another neighbor
      print('collapsed: $index');
      return _borrowSize(index + direction, delta, until, direction);
    }

    double newSize = pane._proposedSize + delta; // 98 + 5

    if (newSize < minSize) {
      double overflow = newSize - minSize;
      double given = delta - overflow;

      print(
          'minSize: $minSize overflow: $overflow given: $given delta: $delta');

      var borrowSize =
          _borrowSize(index + direction, overflow, until, direction);
      pane._proposedSize = minSize;
      return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
    }

    if (newSize > maxSize) {
      // 103 > 100
      double maxOverflow = newSize - maxSize; // 103 - 100 = 3
      double given = delta - maxOverflow; // 5 - 3 = 2

      print(
          'maxSize: $maxSize maxOverflow: $maxOverflow given: $given delta: $delta');

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

    print('newSize: $newSize index: $index delta: $delta');

    pane._proposedSize = newSize;
    // return delta;
    return _BorrowInfo(delta, index);
    // return delta;
  }

  void _applyProposedSizes() {
    for (int i = 0; i < _panes.length; i++) {
      final pane = _panes[i];
      final attachedPane = pane._attachedPane;
      if (attachedPane == null) {
        return;
      }
      attachedPane._changeSize(pane._proposedSize);
      // pane._couldNotBorrow = 0;
    }
  }

  void _debugCouldNotBorrow() {
    // print('Could not borrow: ${_panes.map((e) => e._couldNotBorrow).toList()}');
    // print('Could not expand: ${_panes.map((e) => e._couldNotExpand).toList()}');
    print('Proposed sizes: ${_panes.map((e) => e._proposedSize).toList()}');
  }

  void _dragDivider(int index, double delta) {
    // delta *= 3;
    if (!_isDragging) {
      return;
    }
    if (delta == 0) {
      return;
    }

    print('================ DRAG START ==================');

    print(
        'Before sizes: ${_panes.map((e) => e._attachedPane?.size ?? 0).toList()}');

    print('=== BORROWING LEFT');
    _BorrowInfo borrowedLeft = _borrowSize(index - 1, delta, 0, -1);
    print('=== BORROWING RIGHT');
    _BorrowInfo borrowedRight =
        _borrowSize(index, -delta, _panes.length - 1, 1);
    print('=== END BORROWING');

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
    print('Temp Sizes: ${_panes.map((e) => e._proposedSize).toList()}');

    double givenBackLeft = 0;
    double givenBackRight = 0;
    if (couldNotBorrowLeft != -couldNotBorrowRight) {
      print('=== GIVING BACK');
      givenBackLeft =
          _borrowSize(borrowedRight.from, -couldNotBorrowLeft, index, -1)
              .givenSize;
      print('Giving back left from: ${borrowedRight.from} -> $givenBackLeft');
      givenBackRight =
          _borrowSize(borrowedLeft.from, -couldNotBorrowRight, index - 1, 1)
              .givenSize;
      print('Giving back right from: ${borrowedLeft.from} -> $givenBackRight');
      print('=== END GIVING BACK');
    }

    if (givenBackLeft != -couldNotBorrowLeft ||
        givenBackRight != -couldNotBorrowRight) {
      print(
          'RESET SIZES: $givenBackLeft != ${-couldNotBorrowLeft} || $givenBackRight != ${-couldNotBorrowRight} -> ${_panes.map((e) => e._proposedSize).toList()}');
      _resetProposedSizes();
      return;
    }

    print(
        'l: $borrowedLeftSize r: $borrowedRightSize d: $delta cb: $_couldNotBorrow cbL: $couldNotBorrowLeft cbR: $couldNotBorrowRight bfL: ${borrowedLeft.from} bfR: ${borrowedRight.from} gbL: $givenBackLeft gbR: $givenBackRight');
    double payOffLeft = _payOffLoanSize(index - 1, delta, -1);
    double payOffRight = _payOffLoanSize(index, -delta, 1);
    // _panes[index]._proposedSize -= payOffRight;
    // _panes[index - 1]._proposedSize -= payOffLeft;
    double payingBackLeft =
        _borrowSize(index - 1, -payOffRight, 0, -1).givenSize;
    double payingBackRight =
        _borrowSize(index, payOffLeft, _panes.length - 1, 1).givenSize;
    print(
        'payOffLeft: $payOffLeft payOffRight: $payOffRight payingBackLeft: $payingBackLeft payingBackRight: $payingBackRight');

    if (payingBackLeft != -payOffRight || payingBackRight != -payOffLeft) {
      print(
          'RESET SIZES: $payingBackLeft != ${-payOffRight} || $payingBackRight != ${-payOffLeft} -> ${_panes.map((e) => e._proposedSize).toList()}');
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
      print('CHECK COLLAPSING $index: $start == $endNotCollapsed');
      if (start == endNotCollapsed) {
        print('CHECK COLLAPSIBLE RIGHT $index');
        _checkCollapseUntil(index, _couldNotBorrow);
      }
      int startExpanding = borrowedLeft.from;
      int endCollapsed = 0;
      for (int i = endCollapsed; i > startExpanding; i--) {
        if (!_panes[i]._attachedPane!.collapsed) {
          endCollapsed = i;
        } else {
          break;
        }
      }
      print('CHECK EXPANDING LEFT $index: $startExpanding == $endCollapsed');
      if (startExpanding == endCollapsed) {
        print('CHECK EXPANDING LEFT $startExpanding -> $endCollapsed');
      }
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
        print('CHECK COLLAPSIBLE LEFT $start -> $endNotCollapsed');
        _checkCollapseUntil(index, _couldNotBorrow);
      }
      int startExpanding = borrowedRight.from;
      int endCollapsed = _panes.length - 1;
      for (int i = endCollapsed; i < startExpanding; i++) {
        if (!_panes[i]._attachedPane!.collapsed) {
          endCollapsed = i;
        } else {
          break;
        }
      }
      if (startExpanding == endCollapsed) {
        print('CHECK EXPANDING RIGHT $startExpanding -> $endCollapsed');
      }
    }

    _debugCouldNotBorrow();

    // if (couldNotBorrowLeft != 0 && couldNotBorrowRight != 0) {
    //   _resetProposedSizes();
    //   return;
    // }
    _applyProposedSizes();
    print('================ DRAG END ==================');
    return;
  }

  void _checkCollapseUntil(int index, double couldNotBorrow) {
    if (couldNotBorrow < 0) {
      for (int i = index - 1; i >= 0; i--) {
        final previousPane = getAt(i);
        if (previousPane != null) {
          double? collapsibleSize =
              previousPane._attachedPane!.widget.collapsedSize;
          if (collapsibleSize != null &&
              !previousPane._attachedPane!.collapsed) {
            var minSize = previousPane._attachedPane!.widget.minSize ?? 0;
            double threshold = (collapsibleSize - minSize) / 2;
            print('THRESHOLD $threshold');
            if (couldNotBorrow < threshold) {
              print('COLLAPSING $i');
              var toBorrow = minSize - collapsibleSize;
              var borrowed = _borrowSize(index, toBorrow, _panes.length - 1, 1);
              double borrowedSize = borrowed.givenSize;
              print(
                  'BORROWED SIZE $borrowedSize ASKING FOR $toBorrow FROM ${index} ENDS AT ${borrowed.from}');
              if (borrowedSize < toBorrow) {
                _resetProposedSizes();
                continue;
              }
              previousPane._attachedPane!.collapsed = true;
              previousPane._proposedSize =
                  previousPane._attachedPane?.widget.collapsedSize ?? 0;
              previousPane._sizeBeforeDrag = previousPane._proposedSize;
              couldNotBorrow += borrowedSize;
              _applyProposedSizes();
              if (couldNotBorrow >= 0) {
                break;
              }
            }
          }
        }
      }
    } else if (couldNotBorrow > 0) {
      for (int i = index; i < _panes.length; i++) {
        final nextPane = getAt(i);
        if (nextPane != null) {
          double? collapsibleSize =
              nextPane._attachedPane!.widget.collapsedSize;
          if (collapsibleSize != null && !nextPane._attachedPane!.collapsed) {
            var minSize = nextPane._attachedPane!.widget.minSize ?? 0;
            double threshold = (minSize - collapsibleSize) / 2;
            print('THRESHOLD $threshold');
            if (couldNotBorrow > threshold) {
              print('COLLAPSING $i');
              var toBorrow = minSize - collapsibleSize;
              var borrowed = _borrowSize(index - 1, toBorrow, 0, -1);
              double borrowedSize = borrowed.givenSize;
              print(
                  'BORROWED SIZE $borrowedSize ASKING FOR $toBorrow FROM ${index} ENDS AT ${borrowed.from}');
              if (borrowedSize < toBorrow) {
                _resetProposedSizes();
                continue;
              }
              nextPane._attachedPane!.collapsed = true;
              nextPane._proposedSize =
                  nextPane._attachedPane?.widget.collapsedSize ?? 0;
              nextPane._sizeBeforeDrag = nextPane._proposedSize;
              couldNotBorrow += borrowedSize;
              _applyProposedSizes();
              if (couldNotBorrow <= 0) {
                break;
              }
            }
          }
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

  @override
  void didUpdateWidget(ResizablePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      _panes = List.generate(
          widget.children.length, (index) => _ActivePane(index: index));
    }
  }

  List<Widget> buildChildren(BuildContext context) {
    List<Widget> children = [];
    assert(widget.children.length == _panes.length,
        'Children and panes length mismatch');
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final pane = _panes[i];
      if (i > 0) {
        children.add(
          _ResizableDivider(
            index: i,
            child: Builder(
              builder: (context) {
                return widget.dividerBuilder!(context);
              },
            ),
          ),
        );
      }
      children.add(
        Data(
          data: pane,
          child: KeyedSubtree(
            key: ValueKey(i),
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

  @override
  Widget build(BuildContext context) {
    List<Widget> dividers = [];
    for (int i = 0; i < widget.children.length; i++) {}
    return Data(
      data: this,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          buildContainer(context),
          ...dividers,
          Positioned(
            top: -16,
            child: RepeatedAnimationBuilder(
              duration: Duration(milliseconds: 1),
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
