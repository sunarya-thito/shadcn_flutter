import '../../../shadcn_flutter.dart';

/// A theme for [Checkbox].
class CheckboxTheme {
  /// The color of the checkbox when checked.
  final Color? activeColor;

  /// The color of the checkbox border when unchecked.
  final Color? borderColor;

  /// The size of the checkbox square.
  final double? size;

  /// The gap between the checkbox and its leading/trailing widgets.
  final double? gap;

  /// The border radius of the checkbox.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [CheckboxTheme].
  const CheckboxTheme({
    this.activeColor,
    this.borderColor,
    this.size,
    this.gap,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  CheckboxTheme copyWith({
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? size,
    ValueGetter<double?>? gap,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return CheckboxTheme(
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      size: size == null ? this.size : size(),
      gap: gap == null ? this.gap : gap(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckboxTheme &&
        other.activeColor == activeColor &&
        other.borderColor == borderColor &&
        other.size == size &&
        other.gap == gap &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        activeColor,
        borderColor,
        size,
        gap,
        borderRadius,
      );
}

class CheckboxController extends ValueNotifier<CheckboxState>
    with ComponentController<CheckboxState> {
  CheckboxController(super.value);

  void check() {
    value = CheckboxState.checked;
  }

  void uncheck() {
    value = CheckboxState.unchecked;
  }

  void indeterminate() {
    value = CheckboxState.indeterminate;
  }

  void toggle() {
    value = value == CheckboxState.checked
        ? CheckboxState.unchecked
        : CheckboxState.checked;
  }

  void toggleTristate() {
    value = value == CheckboxState.checked
        ? CheckboxState.unchecked
        : value == CheckboxState.unchecked
            ? CheckboxState.indeterminate
            : CheckboxState.checked;
  }

  bool get isChecked => value == CheckboxState.checked;
  bool get isUnchecked => value == CheckboxState.unchecked;
  bool get isIndeterminate => value == CheckboxState.indeterminate;
}

class ControlledCheckbox extends StatelessWidget
    with ControlledComponent<CheckboxState> {
  @override
  final CheckboxController? controller;
  @override
  final CheckboxState initialValue;
  @override
  final ValueChanged<CheckboxState>? onChanged;
  @override
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final bool tristate;
  final double? size;
  final double? gap;
  final Color? activeColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;

  const ControlledCheckbox({
    super.key,
    this.controller,
    this.initialValue = CheckboxState.unchecked,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.tristate = false,
    this.size,
    this.gap,
    this.activeColor,
    this.borderColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<CheckboxState>(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Checkbox(
          state: data.value,
          onChanged: data.onChanged,
          leading: leading,
          trailing: trailing,
          enabled: data.enabled,
          tristate: tristate,
          size: size,
          gap: gap,
          activeColor: activeColor,
          borderColor: borderColor,
          borderRadius: borderRadius,
        );
      },
    );
  }
}

enum CheckboxState implements Comparable<CheckboxState> {
  checked,
  unchecked,
  indeterminate;

  @override
  int compareTo(CheckboxState other) {
    return index.compareTo(other.index);
  }
}

class Checkbox extends StatefulWidget {
  final CheckboxState state;
  final ValueChanged<CheckboxState>? onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool tristate;
  final bool? enabled;
  final double? size;
  final double? gap;
  final Color? activeColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;

  const Checkbox({
    super.key,
    required this.state,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.tristate = false,
    this.enabled,
    this.size,
    this.gap,
    this.activeColor,
    this.borderColor,
    this.borderRadius,
  });

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox>
    with FormValueSupplier<CheckboxState, Checkbox> {
  final bool _focusing = false;
  bool _shouldAnimate = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.state;
  }

  void _changeTo(CheckboxState state) {
    if (widget.onChanged != null) {
      widget.onChanged!(state);
    }
  }

  void _tap() {
    if (widget.tristate) {
      switch (widget.state) {
        case CheckboxState.checked:
          _changeTo(CheckboxState.unchecked);
          break;
        case CheckboxState.unchecked:
          _changeTo(CheckboxState.indeterminate);
          break;
        case CheckboxState.indeterminate:
          _changeTo(CheckboxState.checked);
          break;
      }
    } else {
      _changeTo(
        widget.state == CheckboxState.checked
            ? CheckboxState.unchecked
            : CheckboxState.checked,
      );
    }
  }

  @override
  void didReplaceFormValue(CheckboxState value) {
    _changeTo(value);
  }

  @override
  void didUpdateWidget(covariant Checkbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      formValue = widget.state;
      _shouldAnimate = true;
    }
  }

  bool get enabled => widget.enabled ?? widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<CheckboxTheme>(context);
    final size = styleValue(
        widgetValue: widget.size,
        themeValue: compTheme?.size,
        defaultValue: 16 * scaling);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 8 * scaling);
    final activeColor = styleValue(
        widgetValue: widget.activeColor,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final borderColor = styleValue(
        widgetValue: widget.borderColor,
        themeValue: compTheme?.borderColor,
        defaultValue: theme.colorScheme.border);
    final borderRadius = styleValue<BorderRadiusGeometry>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusSm));
    return Clickable(
      enabled: widget.onChanged != null,
      mouseCursor: enabled
          ? const WidgetStatePropertyAll(SystemMouseCursors.click)
          : const WidgetStatePropertyAll(SystemMouseCursors.forbidden),
      onPressed: enabled ? _tap : null,
      enableFeedback: enabled,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) widget.leading!.small().medium(),
          SizedBox(width: gap),
          AnimatedContainer(
            duration: kDefaultDuration,
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: widget.state == CheckboxState.checked
                  ? activeColor
                  : theme.colorScheme.input.scaleAlpha(0.3),
              borderRadius:
                  optionallyResolveBorderRadius(context, borderRadius) ??
                      BorderRadius.circular(theme.radiusSm),
              border: Border.all(
                color: !enabled
                    ? theme.colorScheme.muted
                    : widget.state == CheckboxState.checked
                        ? activeColor
                        : borderColor,
                width: (_focusing ? 2 : 1) * scaling,
              ),
            ),
            child: widget.state == CheckboxState.checked
                ? Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      child: SizedBox(
                        width: scaling * 9,
                        height: scaling * 6.5,
                        child: AnimatedValueBuilder(
                          value: 1.0,
                          initialValue: _shouldAnimate ? 0.0 : null,
                          duration: const Duration(milliseconds: 300),
                          curve: const IntervalDuration(
                            start: Duration(milliseconds: 175),
                            duration: Duration(milliseconds: 300),
                          ),
                          builder: (context, value, child) {
                            return CustomPaint(
                              painter: AnimatedCheckPainter(
                                progress: value,
                                color: theme.colorScheme.primaryForeground,
                                strokeWidth: scaling * 1,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: widget.state == CheckboxState.indeterminate
                          ? scaling * 8
                          : 0,
                      height: widget.state == CheckboxState.indeterminate
                          ? scaling * 8
                          : 0,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(theme.radiusXs),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: gap),
          if (widget.trailing != null) widget.trailing!.small().medium(),
        ],
      ),
    );
  }
}

class AnimatedCheckPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  AnimatedCheckPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path();
    Offset firstStrokeStart = Offset(0, size.height * 0.5);
    Offset firstStrokeEnd = Offset(size.width * 0.35, size.height);
    Offset secondStrokeStart = firstStrokeEnd;
    Offset secondStrokeEnd = Offset(size.width, 0);
    double firstStrokeLength =
        (firstStrokeEnd - firstStrokeStart).distanceSquared;
    double secondStrokeLength =
        (secondStrokeEnd - secondStrokeStart).distanceSquared;
    double totalLength = firstStrokeLength + secondStrokeLength;

    double normalizedFirstStrokeLength = firstStrokeLength / totalLength;
    double normalizedSecondStrokeLength = secondStrokeLength / totalLength;

    double firstStrokeProgress =
        progress.clamp(0.0, normalizedFirstStrokeLength) /
            normalizedFirstStrokeLength;
    double secondStrokeProgress = (progress - normalizedFirstStrokeLength)
            .clamp(0.0, normalizedSecondStrokeLength) /
        normalizedSecondStrokeLength;
    if (firstStrokeProgress <= 0) {
      return;
    }
    Offset currentPoint =
        Offset.lerp(firstStrokeStart, firstStrokeEnd, firstStrokeProgress)!;
    path.moveTo(firstStrokeStart.dx, firstStrokeStart.dy);
    path.lineTo(currentPoint.dx, currentPoint.dy);
    if (secondStrokeProgress <= 0) {
      canvas.drawPath(path, paint);
      return;
    }
    Offset secondPoint = Offset.lerp(
      secondStrokeStart,
      secondStrokeEnd,
      secondStrokeProgress,
    )!;
    path.lineTo(secondPoint.dx, secondPoint.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedCheckPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
