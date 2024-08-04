import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TextArea extends StatefulWidget {
  final TextEditingController? controller;
  final bool filled;
  final String? placeholder;
  final bool border;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final String obscuringCharacter;
  final String? initialValue;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final BorderRadius? borderRadius;
  final TextAlign textAlign;
  final bool expandableHeight;
  final bool expandableWidth;
  final double initialHeight;
  final double initialWidth;
  final ValueChanged<double>? onHeightChanged;
  final ValueChanged<double>? onWidthChanged;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;

  const TextArea({
    super.key,
    this.expandableHeight = false,
    this.expandableWidth = false,
    this.initialHeight = 100,
    this.initialWidth = double.infinity,
    this.onHeightChanged,
    this.onWidthChanged,
    this.controller,
    this.filled = false,
    this.placeholder,
    this.border = true,
    this.leading,
    this.trailing,
    this.padding,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.initialValue,
    this.maxLength,
    this.maxLengthEnforcement,
    this.borderRadius,
    this.textAlign = TextAlign.start,
    this.minWidth = 100,
    this.minHeight = 100,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  });

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  late double _height;
  late double _width;

  @override
  void initState() {
    super.initState();
    _height = widget.initialHeight;
    _width = widget.initialWidth;
  }

  @override
  void didUpdateWidget(covariant TextArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialHeight != oldWidget.initialHeight) {
      _height = widget.initialHeight;
    }
    if (widget.initialWidth != oldWidget.initialWidth) {
      _width = widget.initialWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return SizedBox(
        height: _height,
        width: _width,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned.fill(
              child: TextField(
                expands: true,
                controller: widget.controller,
                onSubmitted: widget.onSubmitted,
                onEditingComplete: widget.onEditingComplete,
                focusNode: widget.focusNode,
                onTap: widget.onTap,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                obscureText: widget.obscureText,
                obscuringCharacter: widget.obscuringCharacter,
                initialValue: widget.initialValue,
                maxLength: widget.maxLength,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                maxLines: null,
                minLines: null,
                textAlign: widget.textAlign,
                border: widget.border,
                filled: widget.filled,
                placeholder: widget.placeholder,
                leading: widget.leading,
                trailing: widget.trailing,
                padding: widget.padding,
                borderRadius: widget.borderRadius,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            Positioned(
              bottom: -1,
              right: -1,
              width: (8 + 8) * scaling,
              height: (8 + 8) * scaling,
              child: MouseRegion(
                hitTestBehavior: HitTestBehavior.translucent,
                cursor: widget.expandableWidth
                    ? widget.expandableHeight
                        ? SystemMouseCursors.resizeDownRight
                        : SystemMouseCursors.resizeLeftRight
                    : widget.expandableHeight
                        ? SystemMouseCursors.resizeUpDown
                        : SystemMouseCursors.basic,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanUpdate: (details) {
                    if (widget.expandableHeight && _height.isFinite) {
                      setState(() {
                        _height += details.delta.dy;
                        _height =
                            _height.clamp(widget.minHeight, widget.maxHeight);
                        widget.onHeightChanged?.call(_height);
                      });
                    }
                    if (widget.expandableWidth && _width.isFinite) {
                      setState(() {
                        _width += details.delta.dx;
                        _width = _width.clamp(widget.minWidth, widget.maxWidth);
                        widget.onWidthChanged?.call(_width);
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.0 * scaling),
                    child: CustomPaint(
                      painter: _TextAreaDragHandlePainter(
                          theme.colorScheme.foreground),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class _TextAreaDragHandlePainter extends CustomPainter {
  final Color color;

  _TextAreaDragHandlePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final start = Offset(size.width, 0);
    final end = Offset(0, size.height);
    final start2 = Offset(size.width, size.height / 2);
    final end2 = Offset(size.width / 2, size.height);
    canvas.drawLine(start, end, paint);
    canvas.drawLine(start2, end2, paint);
  }

  @override
  bool shouldRepaint(covariant _TextAreaDragHandlePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
