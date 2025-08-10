import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for [TextArea].
class TextAreaTheme {
  final bool? filled;
  final bool? border;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const TextAreaTheme({
    this.filled,
    this.border,
    this.padding,
    this.borderRadius,
  });

  TextAreaTheme copyWith({
    ValueGetter<bool?>? filled,
    ValueGetter<bool?>? border,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return TextAreaTheme(
      filled: filled == null ? this.filled : filled(),
      border: border == null ? this.border : border(),
      padding: padding == null ? this.padding : padding(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextAreaTheme &&
        other.filled == filled &&
        other.border == border &&
        other.padding == padding &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(filled, border, padding, borderRadius);
}

class TextArea extends StatefulWidget {
  final TextEditingController? controller;
  final bool? filled;
  final Widget? placeholder;
  final bool? border;
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
  final BorderRadiusGeometry? borderRadius;
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
  final TextAlignVertical? textAlignVertical;
  final UndoHistoryController? undoController;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final void Function(PointerDownEvent event)? onTapOutside;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Clip clipBehavior;
  final bool autofocus;

  const TextArea({
    super.key,
    this.expandableHeight = false,
    this.expandableWidth = false,
    this.initialHeight = 100,
    this.initialWidth = double.infinity,
    this.onHeightChanged,
    this.onWidthChanged,
    this.controller,
    this.filled,
    this.placeholder,
    this.border,
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
    this.textAlignVertical = TextAlignVertical.top,
    this.undoController,
    this.onChanged,
    this.autofillHints,
    this.onTapOutside,
    this.inputFormatters,
    this.style,
    this.contextMenuBuilder,
    this.keyboardType,
    this.textInputAction,
    this.clipBehavior = Clip.hardEdge,
    this.autofocus = false,
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
    final compTheme = ComponentTheme.maybeOf<TextAreaTheme>(context);
    final filled = styleValue<bool>(
        widgetValue: widget.filled,
        themeValue: compTheme?.filled,
        defaultValue: false);
    final border = styleValue<bool>(
        widgetValue: widget.border,
        themeValue: compTheme?.border,
        defaultValue: true);
    final padding = styleValue<EdgeInsetsGeometry?>(
        widgetValue: widget.padding,
        themeValue: compTheme?.padding,
        defaultValue: null);
    final borderRadius = styleValue<BorderRadiusGeometry?>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: null);
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
                border: border,
                filled: filled,
                placeholder: widget.placeholder,
                leading: widget.leading,
                trailing: widget.trailing,
                padding: padding,
                borderRadius: borderRadius,
                textAlignVertical: widget.textAlignVertical,
                undoController: widget.undoController,
                onChanged: widget.onChanged,
                autofillHints: widget.autofillHints,
                onTapOutside: widget.onTapOutside,
                inputFormatters: widget.inputFormatters,
                style: widget.style,
                contextMenuBuilder: widget.contextMenuBuilder,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                clipBehavior: widget.clipBehavior,
                autofocus: widget.autofocus,
              ),
            ),
            Positioned(
              bottom: -1 * scaling,
              right: -1 * scaling,
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
