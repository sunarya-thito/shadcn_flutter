// WIP
import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef Predicate<T> = bool Function(T value);

class ResizablePaneController extends ValueNotifier<double> {
  ResizablePaneController(super.value);

  @override
  set value(double newValue) {
    if (newValue < 0) {
      newValue = 0;
    }
    if (value == newValue) {
      return;
    }
    super.value = newValue;
  }
}

class ResizablePane extends StatefulWidget {
  final Widget child;
  final bool resizable;
  final ValueChanged<double>? onResize;
  final double initialSize;
  final double? minSize;
  final double? maxSize;
  final bool collapsible;
  final ResizablePaneController? controller;

  const ResizablePane({
    Key? key,
    this.resizable = true,
    required this.child,
    this.onResize,
    required this.initialSize,
    this.minSize,
    this.maxSize,
    this.collapsible = false,
  })  : controller = null,
        super(key: key);

  ResizablePane._controlled({
    Key? key,
    this.resizable = true,
    required this.child,
    this.onResize,
    this.minSize,
    this.maxSize,
    this.collapsible = false,
    required this.initialSize,
    required this.controller,
  }) : super(key: key);

  factory ResizablePane.controlled({
    Key? key,
    bool resizable = true,
    required Widget child,
    ValueChanged<double>? onResize,
    double? minSize,
    double? maxSize,
    bool collapsible = false,
    required ResizablePaneController controller,
  }) {
    return ResizablePane._controlled(
      key: key,
      resizable: resizable,
      child: child,
      onResize: onResize,
      initialSize: controller.value,
      minSize: minSize,
      maxSize: maxSize,
      collapsible: collapsible,
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
    if (size == _controller.value) {
      return 0;
    }
    double diff = size - _controller.value;
    widget.onResize?.call(size);
    _controller.value = size;
    return diff;
  }

  double get size => _controller.value;

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
        final size = direction == Axis.horizontal
            ? BoxConstraints.tightFor(width: _controller.value)
            : BoxConstraints.tightFor(height: _controller.value);
        return ConstrainedBox(
          constraints: size,
          child: Offstage(
            offstage: _controller.value == 0,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                widget.child,
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Text('Size: ${_controller.value}'),
                ),
              ],
            ),
          ),
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

class _BorrowedSize {
  double size = 0;

  @override
  String toString() {
    return 'BorrowedSize{size: $size}';
  }
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
      onPanEnd: (details) {
        resizablePanelState!._stopDragging();
      },
      onPanCancel: () {
        resizablePanelState!._stopDragging();
      },
      onPanUpdate: (details) {
        var delta = resizablePanelState!.widget.direction == Axis.horizontal
            ? details.delta.dx
            : details.delta.dy;
        resizablePanelState._dragDivider(widget.index, delta, 0);
      },
      child: Data(data: this, child: widget.child),
    );
  }
}

class ResizablePanel extends StatefulWidget {
  static Widget _defaultDividerBuilder(BuildContext context) {
    final resizablePanelState = Data.maybeOf<_ResizablePanelState>(context);
    assert(resizablePanelState != null,
        'ResizableDivider must be a child of ResizablePanel');
    return SizedBox(
      width:
          resizablePanelState!.widget.direction == Axis.horizontal ? 10 : null,
      height: resizablePanelState.widget.direction == Axis.vertical ? 10 : null,
      child: Text(
          Data.of<_ResizableDividerState>(context).widget.index.toString()),
    );
  }

  final List<Widget> children;
  final WidgetBuilder? dividerBuilder;
  final Axis direction;

  const ResizablePanel({
    Key? key,
    required this.children,
    this.direction = Axis.horizontal,
    this.dividerBuilder = _defaultDividerBuilder,
  }) : super(key: key);

  @override
  State<ResizablePanel> createState() => _ResizablePanelState();
}

class _ActivePane {
  final int index;
  _ResizablePaneState? _attachedPane;
  double _sizeBeforeDrag = 0;

  _ActivePane({required this.index});
}

class _ResizablePanelState extends State<ResizablePanel> {
  late List<_ActivePane> _panes;

  @override
  void initState() {
    super.initState();
    _panes = List.generate(
        widget.children.length, (index) => _ActivePane(index: index));
  }

  void _startDragging() {
    List<double> sizes = [];
    for (final pane in _panes) {
      final attachedPane = pane._attachedPane;
      if (attachedPane == null) {
        return;
      }
      var size = attachedPane.size;
      pane._sizeBeforeDrag = size;
      sizes.add(size);
    }
    _sizes = sizes;
  }

  List<double>? _sizes;

  void _stopDragging() {
    _sizes = null;
  }

  int get totalDividerCount =>
      widget.children.length < 2 ? 0 : widget.children.length - 1;

  bool _dragDivider(int index, double delta, int stackDepth,
      [int? originalIndex]) {
    originalIndex ??= index;
    if (_sizes == null) {
      return false;
    }
    if (stackDepth > 100) {
      _sizes = null;
      throw Exception('Max sibling check exceeded');
    }

    if (delta == 0) {
      return false;
    }

    {
      print('at index $index');
      // max sibling check is 100 times
      final nextSibling = getAt(index);
      final previousSibling = getAt(index - 1);
      if (nextSibling == null || previousSibling == null) {
        print('no next or previous sibling');
        return false;
      }
      if (delta == 0) {
        return false;
      }
      final nextSiblingPane = nextSibling._attachedPane;
      final previousSiblingPane = previousSibling._attachedPane;
      if (nextSiblingPane == null || previousSiblingPane == null) {
        print('no next or previous sibling pane');
        return false;
      }

      final previousSize = _sizes![index - 1];
      final nextSize = _sizes![index];
      var previousMinSize = previousSiblingPane.widget.minSize ?? 0;
      var nextMinSize = nextSiblingPane.widget.minSize ?? 0;

      final previousMaxSize =
          previousSiblingPane.widget.maxSize ?? double.infinity;
      final nextMaxSize = nextSiblingPane.widget.maxSize ?? double.infinity;

      double overflow = 0;
      double maxOverflow = 0;

      if (nextSize - delta < nextMinSize) {
        overflow = nextMinSize - (nextSize - delta);
      }

      if (previousSize + delta < previousMinSize) {
        overflow = previousSize + delta - previousMinSize;
      }

      if (previousSize + delta > previousMaxSize) {
        maxOverflow = previousSize + delta - previousMaxSize;
      }

      if (nextSize - delta > nextMaxSize) {
        maxOverflow = nextMaxSize - (nextSize - delta);
      }

      var newNextSize = nextSize - delta;
      var newPreviousSize = previousSize + delta;

      _sizes![index - 1] = newPreviousSize;
      _sizes![index] = newNextSize;

      print(
          '$index: overflow: $overflow, maxOverflow: $maxOverflow delta: $delta sizes: $_sizes borrow: ');

      bool shouldChange = true;

      if (overflow < 0) {
        if (index - 1 > 0) {
          if (!_dragDivider(index - 1, delta, stackDepth + 1, index)) {
            print('SHOULD NOT CHANGE A');
            shouldChange = false;
          }
        } else {
          print('SHOULD NOT CHANGE B');
          shouldChange = false;
        }
      } else if (overflow > 0) {
        if (index + 1 <= totalDividerCount) {
          if (!_dragDivider(index + 1, delta, stackDepth + 1, index)) {
            print('SHOULD NOT CHANGE C');
            shouldChange = false;
          }
        } else {
          print('SHOULD NOT CHANGE D');
          shouldChange = false;
        }
      }

      if (maxOverflow > 0) {
        if (index - 1 > 0) {
          if (!_dragDivider(index - 1, delta, stackDepth + 1, index)) {
            shouldChange = false;
            print('SHOULD NOT CHANGE 1');
          }
        } else {
          shouldChange = false;
          print('SHOULD NOT CHANGE 2');
        }
      } else if (maxOverflow < 0) {
        if (index + 1 <= totalDividerCount) {
          if (!_dragDivider(index + 1, delta, stackDepth + 1, index)) {
            shouldChange = false;
            print('SHOULD NOT CHANGE 3');
          }
        } else {
          // shouldChange = false;
          shouldChange = false;
          print('SHOULD NOT CHANGE 4');
        }
      }

      List<double> sizeDiffs = List.generate(_sizes!.length,
          (index) => _sizes![index] - _panes[index]._sizeBeforeDrag);
      print('size diffs: $sizeDiffs');

      if (!shouldChange) {
        // reset
        if (stackDepth == 0) {
          List<double> sizes = [];
          for (int i = 0; i < _sizes!.length; i++) {
            final pane = getAt(i);
            final attachedPane = pane!._attachedPane;
            sizes.add(attachedPane!.size.clamp(
              attachedPane.widget.minSize ?? 0,
              attachedPane.widget.maxSize ?? double.infinity,
            ));
          }
          _sizes = sizes;
        }
        print('reset sizes: $_sizes');
        return false;
      }

      // return diff != 0 || diffNext != 0;
      if (stackDepth == 0) {
        for (int i = 0; i < _sizes!.length; i++) {
          final pane = getAt(i);
          if (pane == null) {
            return false;
          }
          final attachedPane = pane._attachedPane;
          if (attachedPane == null) {
            return false;
          }
          attachedPane._changeSize(_sizes![i]);
        }
      }
      return delta != 0;
    }
    return false;
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
    return Data(
      data: this,
      child: buildContainer(context),
    );
  }
}
