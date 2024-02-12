import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class SliderValue {
  final double?
      _start; // if start is null, it means its not ranged slider, its a single value slider
  // if its a single value slider, then the trackbar is clickable and the thumb can be dragged
  // if its a ranged slider, then the trackbar is not clickable and the thumb can be dragged
  final double _end;
  const SliderValue.single(double value)
      : _start = null,
        _end = value;
  const SliderValue.ranged(this._start, this._end);

  bool get isRanged => _start != null;

  double get start => _start ?? _end;
  double get end => _end;
  double get value => _end;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SliderValue && other._start == _start && other._end == _end;
  }

  @override
  int get hashCode => _start.hashCode ^ _end.hashCode;
}

class Slider extends StatefulWidget {
  final SliderValue value;
  final ValueChanged<SliderValue>? onChanged;
  final ValueChanged<SliderValue>? onChangeStart;
  final ValueChanged<SliderValue>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final SliderValue? hintValue;

  const Slider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.hintValue,
  })  : assert(min <= max),
        super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  late SliderValue
      _currentValue; // used for the thumb position (not the trackbar)
  // trackbar position uses the widget.value
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant Slider oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.value != widget.value) {
    //   _currentValue = widget.value;
    // }
  }

  void _dispatchValueChangeStart(SliderValue value) {
    widget.onChangeStart?.call(value);
  }

  void _dispatchValueChange(SliderValue value) {
    widget.onChanged?.call(value);
  }

  void _dispatchValueChangeEnd(SliderValue value) {
    widget.onChangeEnd?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 20,
        minHeight: 16,
        maxHeight: 16,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTapDown: widget.value.isRanged
                ? null
                : (details) {
                    double offset = details.localPosition.dx;
                    double newValue = offset / constraints.maxWidth;
                    newValue = newValue.clamp(0, 1);
                    newValue =
                        newValue * (widget.max - widget.min) + widget.min;
                    SliderValue newSliderValue = SliderValue.single(newValue);
                    _dispatchValueChangeStart(newSliderValue);
                    _dispatchValueChange(newSliderValue);
                    _dispatchValueChangeEnd(newSliderValue);
                    setState(() {
                      _currentValue = newSliderValue;
                    });
                  },
            onHorizontalDragStart: widget.value.isRanged
                ? null
                : (details) {
                    _dragging = true;
                    // widget.onChangeStart?.call(_currentValue);
                    _dispatchValueChangeStart(_currentValue);
                  },
            onHorizontalDragUpdate: widget.value.isRanged
                ? null
                : (details) {
                    setState(() {
                      double offset = details.localPosition.dx;
                      // delta *= widget.max - widget.min;
                      // double newValue = _currentValue.value + delta;
                      // newValue = newValue.clamp(widget.min, widget.max);
                      // _dispatchValueChange(SliderValue.single(newValue));
                      double newValue = offset / constraints.maxWidth;
                      newValue = newValue.clamp(0, 1);
                      newValue =
                          newValue * (widget.max - widget.min) + widget.min;
                      SliderValue newSliderValue = SliderValue.single(newValue);
                      _dispatchValueChange(newSliderValue);
                      _currentValue = newSliderValue;
                    });
                  },
            onHorizontalDragEnd: widget.value.isRanged
                ? null
                : (details) {
                    _dragging = false;
                    _dispatchValueChangeEnd(_currentValue);
                  },
            child: FocusableActionDetector(
                mouseCursor: (widget.onChanged != null ||
                            widget.onChangeStart != null ||
                            widget.onChangeEnd != null) &&
                        !widget.value.isRanged
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: widget.value.isRanged
                    ? buildRangedSlider(context, constraints, theme)
                    : buildSingleSlider(context, constraints, theme)),
          );
        },
      ),
    );
  }

  Widget buildSingleSlider(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildTrackBar(context, constraints, theme),
        if (widget.hintValue != null) buildHint(context, constraints, theme),
        buildThumb(
          context,
          constraints,
          theme,
          _currentValue.value,
          null,
          null,
          null,
        ),
      ],
    );
  }

  Widget buildHint(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    return Positioned(
      top: 0,
      bottom: 0,
      // left: _calculateStart * constraints.maxWidth,
      // right: (1 - _calculateEnd) * constraints.maxWidth,
      child: Container(
        alignment: Alignment.center,
        child: Text(widget.hintValue!.end.toString()),
      ),
    );
  }

  bool get _isRanged => widget.value.isRanged;

  Widget buildTrackBar(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Center(
        child: Container(
          height: 6,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(theme.radiusSm),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: _dragging ? Duration.zero : kDefaultDuration,
                curve: Curves.easeInOut,
                left: !_isRanged
                    ? 0
                    : (widget.value.start - widget.min) /
                        (widget.max - widget.min) *
                        constraints.maxWidth,
                right: (1 -
                        (widget.value.end - widget.min) /
                            (widget.max - widget.min)) *
                    constraints.maxWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildThumb(
      BuildContext context,
      BoxConstraints constraints,
      ThemeData theme,
      double value,
      ValueChanged<double>? onChanged,
      VoidCallback? onChangeStart,
      VoidCallback? onChangeEnd) {
    return AnimatedPositioned(
      duration: _dragging ? Duration.zero : kDefaultDuration,
      curve: Curves.easeInOut,
      left: (value - widget.min) /
              (widget.max - widget.min) *
              constraints.maxWidth -
          8,
      child: GestureDetector(
        onHorizontalDragStart: onChangeStart == null
            ? null
            : (details) {
                onChangeStart();
              },
        onHorizontalDragUpdate: onChanged == null
            ? null
            : (details) {
                double delta = details.delta.dx / constraints.maxWidth;
                double newValue = (value + delta).clamp(0.0, 1.0);
                onChanged(newValue * (widget.max - widget.min) + widget.min);
              },
        onHorizontalDragEnd: onChangeEnd == null
            ? null
            : (details) {
                onChangeEnd();
              },
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRangedSlider(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildTrackBar(context, constraints, theme),
        if (widget.hintValue != null) buildHint(context, constraints, theme),
        // buildThumb(
        //   context,
        //   constraints,
        //   theme,
        //   _calculateStart,
        //   _setStartValue,
        //   _setStartValueStart,
        //   _setStartValueEnd,
        // ),
        // buildThumb(
        //   context,
        //   constraints,
        //   theme,
        //   _calculateEnd,
        //   _setEndValue,
        //   _setEndValueStart,
        //   _setEndValueEnd,
        // ),
      ],
    );
  }
}
