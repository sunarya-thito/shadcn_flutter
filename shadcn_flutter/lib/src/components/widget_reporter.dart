import 'package:flutter/widgets.dart';

// report the child global position and size changes
class WidgetReporter extends StatefulWidget {
  final Widget child;
  final void Function(Offset? globalPosition)? onGlobalPositionChanged;
  final void Function(Size? size)? onSizeChanged;

  const WidgetReporter({
    Key? key,
    required this.child,
    this.onGlobalPositionChanged,
    this.onSizeChanged,
  }) : super(key: key);

  @override
  State<WidgetReporter> createState() => _WidgetReporterState();
}

class _WidgetReporterState extends State<WidgetReporter> {
  final GlobalKey _key = GlobalKey();
  Offset? _globalPosition;
  Size? _size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reportGlobalPosition();
      _reportSize();
    });
  }

  @override
  void didUpdateWidget(covariant WidgetReporter oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reportGlobalPosition();
      _reportSize();
    });
  }

  void _reportGlobalPosition() {
    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final Offset globalPosition = renderBox.localToGlobal(Offset.zero);
      if (_globalPosition != globalPosition) {
        setState(() {
          _globalPosition = globalPosition;
        });
        widget.onGlobalPositionChanged?.call(globalPosition);
      }
    }
  }

  void _reportSize() {
    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final Size size = renderBox.size;
      if (_size != size) {
        setState(() {
          _size = size;
        });
        widget.onSizeChanged?.call(size);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _key,
      child: widget.child,
    );
  }
}
