import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';

import '../../../shadcn_flutter.dart';

class SliderValue {
  static SliderValue? lerp(SliderValue? a, SliderValue? b, double t) {
    if (a == null || b == null) return null;
    if (a.isRanged && b.isRanged) {
      return SliderValue.ranged(
        lerpDouble(a.start, b.start, t)!,
        lerpDouble(a.end, b.end, t)!,
      );
    } else if (!a.isRanged && !b.isRanged) {
      return SliderValue.single(lerpDouble(a.value, b.value, t)!);
    }
    return null;
  }

  final double?
      _start; // if start is null, it means its not ranged slider, its a single value slider
  // if its a single value slider, then the trackbar is clickable and the thumb can be dragged
  // if its a ranged slider, then the trackbar is not clickable and the thumb can be dragged
  final double _end;
  const SliderValue.single(double value)
      : _start = null,
        _end = value;
  const SliderValue.ranged(double this._start, this._end);

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

  SliderValue roundToDivisions(int divisions) {
    if (!isRanged) {
      return SliderValue.single((_end * divisions).round() / divisions);
    }
    return SliderValue.ranged((_start! * divisions).round() / divisions,
        (_end * divisions).round() / divisions);
  }
}

class IncreaseSliderValue extends Intent {
  const IncreaseSliderValue();
}

class DecreaseSliderValue extends Intent {
  const DecreaseSliderValue();
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
  final double? increaseStep;
  final double? decreaseStep;

  const Slider({
    super.key,
    required this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.hintValue,
    this.increaseStep,
    this.decreaseStep,
  }) : assert(min <= max);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> with FormValueSupplier {
  late SliderValue
      _currentValue; // used for the thumb position (not the trackbar)
  // trackbar position uses the widget.value
  bool _dragging = false;
  bool _moveStart = false;

  bool _focusing = false;
  bool _focusingEnd = false;

  @override
  void initState() {
    super.initState();
    if (widget.value.isRanged) {
      var start = (widget.value.start - widget.min) / (widget.max - widget.min);
      var end = (widget.value.end - widget.min) / (widget.max - widget.min);
      var newStart = min(start, end);
      var newEnd = max(start, end);
      _currentValue = SliderValue.ranged(newStart, newEnd);
    } else {
      var value = (widget.value.value - widget.min) / (widget.max - widget.min);
      _currentValue = SliderValue.single(value);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(widget.value, (newValue) {
      if (newValue != widget.value) {
        widget.onChanged?.call(newValue);
        widget.onChangeEnd?.call(newValue);
      }
    });
  }

  void _dispatchValueChangeStart(SliderValue value) {
    if (widget.divisions != null) {
      value = value.roundToDivisions(widget.divisions!);
    }
    widget.onChangeStart?.call(value);
  }

  void _dispatchValueChange(SliderValue value) {
    if (widget.divisions != null) {
      value = value.roundToDivisions(widget.divisions!);
    }
    if (value != widget.value) {
      widget.onChanged?.call(value);
    }
  }

  void _dispatchValueChangeEnd(SliderValue value) {
    if (widget.divisions != null) {
      value = value.roundToDivisions(widget.divisions!);
    }
    if (value != widget.value) {
      widget.onChangeEnd?.call(value);
    }
  }

  @override
  void didUpdateWidget(covariant Slider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && !_dragging) {
      if (widget.value.isRanged) {
        var start =
            (widget.value.start - widget.min) / (widget.max - widget.min);
        var end = (widget.value.end - widget.min) / (widget.max - widget.min);
        var newStart = min(start, end);
        var newEnd = max(start, end);
        _currentValue = SliderValue.ranged(newStart, newEnd);
      } else {
        var value =
            (widget.value.value - widget.min) / (widget.max - widget.min);
        _currentValue = SliderValue.single(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Container(
      constraints: BoxConstraints(
        minWidth: 20 * scaling,
        minHeight: 16 * scaling,
        maxHeight: 16 * scaling,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0 * scaling),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTapDown: widget.value.isRanged
                  ? (details) {
                      // _moveStart to true if the tap is closer to the start thumb
                      double offset = details.localPosition.dx;
                      double newValue = offset / constraints.maxWidth;
                      double start = _currentValue.start;
                      double end = _currentValue.end;
                      if (widget.divisions != null) {
                        start = (start * widget.divisions!).round() /
                            widget.divisions!;
                        end = (end * widget.divisions!).round() /
                            widget.divisions!;
                      }
                      _moveStart =
                          (start - newValue).abs() < (end - newValue).abs();
                      // find the closest thumb and move it to the tap position
                      if (_moveStart) {
                        if (widget.divisions != null) {
                          double deltaValue = newValue - start;
                          if (deltaValue >= 0 &&
                              deltaValue < 0.5 / widget.divisions!) {
                            newValue += 0.5 / widget.divisions!;
                          } else if (deltaValue < 0 &&
                              deltaValue > -0.5 / widget.divisions!) {
                            newValue -= 0.5 / widget.divisions!;
                          }
                        }
                        SliderValue newSliderValue =
                            SliderValue.ranged(newValue, widget.value.end);
                        _dispatchValueChangeStart(newSliderValue);
                        _dispatchValueChange(newSliderValue);
                        _dispatchValueChangeEnd(newSliderValue);
                        setState(() {
                          _currentValue = SliderValue.ranged(newValue, end);
                        });
                      } else {
                        if (widget.divisions != null) {
                          double deltaValue = newValue - end;
                          if (deltaValue >= 0 &&
                              deltaValue < 0.5 / widget.divisions!) {
                            newValue += 0.5 / widget.divisions!;
                          } else if (deltaValue < 0 &&
                              deltaValue > -0.5 / widget.divisions!) {
                            newValue -= 0.5 / widget.divisions!;
                          }
                        }
                        SliderValue newSliderValue =
                            SliderValue.ranged(widget.value.start, newValue);
                        _dispatchValueChangeStart(newSliderValue);
                        _dispatchValueChange(newSliderValue);
                        _dispatchValueChangeEnd(newSliderValue);
                        setState(() {
                          _currentValue = SliderValue.ranged(start, newValue);
                        });
                      }
                    }
                  : (details) {
                      double offset = details.localPosition.dx;
                      double newValue = offset / constraints.maxWidth;
                      newValue = newValue.clamp(0, 1);
                      if (widget.divisions != null) {
                        double deltaValue = newValue - _currentValue.value;
                        if (deltaValue >= 0 &&
                            deltaValue < 0.5 / widget.divisions!) {
                          newValue += 0.5 / widget.divisions!;
                        } else if (deltaValue < 0 &&
                            deltaValue > -0.5 / widget.divisions!) {
                          newValue -= 0.5 / widget.divisions!;
                        }
                        newValue = (newValue * widget.divisions!).round() /
                            widget.divisions!;
                      }
                      SliderValue newSliderValue = SliderValue.single(
                          newValue * (widget.max - widget.min) + widget.min);
                      _dispatchValueChangeStart(newSliderValue);
                      _dispatchValueChange(newSliderValue);
                      _dispatchValueChangeEnd(newSliderValue);
                      setState(() {
                        _currentValue = SliderValue.single(newValue);
                      });
                    },
              onHorizontalDragStart: (details) {
                _dragging = true;
                if (_currentValue.isRanged) {
                  // change _moveStart to true if the tap is closer to the start thumb
                  double offset = details.localPosition.dx;
                  double newValue = offset / constraints.maxWidth;
                  double start = _currentValue.start;
                  double end = _currentValue.end;
                  if (widget.divisions != null) {
                    start =
                        (start * widget.divisions!).round() / widget.divisions!;
                    end = (end * widget.divisions!).round() / widget.divisions!;
                  }
                  _moveStart =
                      (start - newValue).abs() < (end - newValue).abs();
                  var startValue =
                      start * (widget.max - widget.min) + widget.min;
                  var endValue = end * (widget.max - widget.min) + widget.min;
                  var newStartValue = min(startValue, endValue);
                  var newEndValue = max(startValue, endValue);
                  SliderValue newSliderValue =
                      SliderValue.ranged(newStartValue, newEndValue);
                  _dispatchValueChangeStart(newSliderValue);
                } else {
                  double value = _currentValue.value;
                  if (widget.divisions != null) {
                    value =
                        (value * widget.divisions!).round() / widget.divisions!;
                  }
                  SliderValue newSliderValue = SliderValue.single(
                      value * (widget.max - widget.min) + widget.min);
                  _dispatchValueChangeStart(newSliderValue);
                }
              },
              onHorizontalDragUpdate: widget.value.isRanged
                  ? (details) {
                      // drag the closest thumb to the drag position
                      // but use delta to calculate the new value
                      double delta =
                          details.primaryDelta! / constraints.maxWidth;
                      if (_moveStart) {
                        var newStart = _currentValue.start + delta;
                        var newEnd = _currentValue.end;
                        newStart = newStart.clamp(0, 1);
                        newEnd = newEnd.clamp(0, 1);
                        var newInternalSliderValue =
                            SliderValue.ranged(newStart, newEnd);
                        if (newInternalSliderValue == _currentValue) {
                          return;
                        }
                        var sliderStart = newStart;
                        var sliderEnd = newEnd;
                        if (widget.divisions != null) {
                          sliderStart =
                              (sliderStart * widget.divisions!).round() /
                                  widget.divisions!;
                          sliderEnd = (sliderEnd * widget.divisions!).round() /
                              widget.divisions!;
                        }
                        var startSliderValue =
                            sliderStart * (widget.max - widget.min) +
                                widget.min;
                        var endSliderValue =
                            sliderEnd * (widget.max - widget.min) + widget.min;
                        var newSliderValue = SliderValue.ranged(
                            min(startSliderValue, endSliderValue),
                            max(startSliderValue, endSliderValue));
                        _dispatchValueChange(newSliderValue);
                        setState(() {
                          _currentValue = SliderValue.ranged(newStart, newEnd);
                        });
                      } else {
                        var newStart = _currentValue.start;
                        var newEnd = _currentValue.end + delta;
                        newStart = newStart.clamp(0, 1);
                        newEnd = newEnd.clamp(0, 1);
                        var newInternalSliderValue =
                            SliderValue.ranged(newStart, newEnd);
                        if (newInternalSliderValue == _currentValue) {
                          return;
                        }
                        var sliderStart = newStart;
                        var sliderEnd = newEnd;
                        if (widget.divisions != null) {
                          sliderStart =
                              (sliderStart * widget.divisions!).round() /
                                  widget.divisions!;
                          sliderEnd = (sliderEnd * widget.divisions!).round() /
                              widget.divisions!;
                        }
                        var startSliderValue =
                            sliderStart * (widget.max - widget.min) +
                                widget.min;
                        var endSliderValue =
                            sliderEnd * (widget.max - widget.min) + widget.min;
                        var newSliderValue = SliderValue.ranged(
                            min(startSliderValue, endSliderValue),
                            max(startSliderValue, endSliderValue));
                        _dispatchValueChange(newSliderValue);
                        setState(() {
                          _currentValue = SliderValue.ranged(newStart, newEnd);
                        });
                      }
                    }
                  : (details) {
                      double delta =
                          details.primaryDelta! / constraints.maxWidth;
                      double newValue = _currentValue.value + delta;
                      newValue = newValue.clamp(0, 1);
                      var sliderValue = newValue;
                      if (widget.divisions != null) {
                        sliderValue =
                            (sliderValue * widget.divisions!).round() /
                                widget.divisions!;
                      }
                      var newSliderValue = SliderValue.single(
                          sliderValue * (widget.max - widget.min) + widget.min);
                      _dispatchValueChange(newSliderValue);
                      setState(() {
                        _currentValue = SliderValue.single(newValue);
                      });
                    },
              onHorizontalDragEnd: (details) {
                _dragging = false;
                if (_currentValue.isRanged) {
                  var start = _currentValue.start;
                  var end = _currentValue.end;
                  var newStart = min(start, end);
                  var newEnd = max(start, end);
                  _dispatchValueChangeEnd(SliderValue.ranged(
                      (newStart * (widget.max - widget.min) + widget.min),
                      (newEnd * (widget.max - widget.min) + widget.min)));
                } else {
                  _dispatchValueChangeEnd(SliderValue.single(
                      (_currentValue.value * (widget.max - widget.min) +
                          widget.min)));
                }
                setState(() {});
              },
              child: MouseRegion(
                  cursor: (widget.onChanged != null ||
                          widget.onChangeStart != null ||
                          widget.onChangeEnd != null)
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
                  child: widget.value.isRanged
                      ? buildRangedSlider(context, constraints, theme)
                      : buildSingleSlider(context, constraints, theme)),
            );
          },
        ),
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
        buildTrackValue(context, constraints, theme),
        buildThumb(
          context,
          constraints,
          theme,
          _currentValue.value,
          _focusing,
          (focusing) {
            setState(() {
              _focusing = focusing;
            });
          },
          // on increase uses increaseStep or divisions or 1
          // and so decrease
          () {
            var value = _currentValue.value;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.increaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value + step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = SliderValue.single(
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = SliderValue.single(value);
            });
          },
          () {
            var value = _currentValue.value;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.decreaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value - step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = SliderValue.single(
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = SliderValue.single(value);
            });
          },
        ),
      ],
    );
  }

  Widget buildHint(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    return AnimatedValueBuilder(
        value: widget.hintValue,
        duration: _dragging ? Duration.zero : kDefaultDuration,
        curve: Curves.easeInOut,
        lerp: SliderValue.lerp,
        builder: (context, hintValue, _) {
          var start = hintValue!.start;
          var end = hintValue.end;
          var newStart = min(start, end);
          var newEnd = max(start, end);
          var left = (newStart - widget.min) /
              (widget.max - widget.min) *
              constraints.maxWidth;
          var right = (1 - (newEnd - widget.min) / (widget.max - widget.min)) *
              constraints.maxWidth;
          return Positioned(
            left: !_isRanged ? 0 : left,
            right: right,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 6 * scaling,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.scaleAlpha(0.2),
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                ),
              ),
            ),
          );
        });
  }

  bool get _isRanged => widget.value.isRanged;

  Widget buildTrackValue(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var value = widget.value;
    var start = value.start;
    var end = value.end;
    if (widget.divisions != null) {
      var normalizedStart = (start - widget.min) / (widget.max - widget.min);
      var normalizedEnd = (end - widget.min) / (widget.max - widget.min);
      normalizedStart =
          (normalizedStart * widget.divisions!).round() / widget.divisions!;
      normalizedEnd =
          (normalizedEnd * widget.divisions!).round() / widget.divisions!;
      start = normalizedStart * (widget.max - widget.min) + widget.min;
      end = normalizedEnd * (widget.max - widget.min) + widget.min;
    }
    var newStart = min(start, end);
    var newEnd = max(start, end);

    return AnimatedValueBuilder(
        value: Offset(newStart, newEnd),
        duration: _dragging && widget.divisions == null
            ? Duration.zero
            : kDefaultDuration,
        curve: Curves.easeInOut,
        lerp: Offset.lerp,
        builder: (context, value, _) {
          var newStart = value!.dx;
          var newEnd = value.dy;
          var left = (newStart - widget.min) /
              (widget.max - widget.min) *
              constraints.maxWidth;
          var right = (1 - (newEnd - widget.min) / (widget.max - widget.min)) *
              constraints.maxWidth;
          return Positioned(
            left: !_isRanged ? 0 : left,
            right: right,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 6 * scaling,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                ),
              ),
            ),
          );
        });
  }

  Widget buildTrackBar(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Center(
        child: Container(
          height: 6 * scaling,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.scaleAlpha(0.2),
            borderRadius: BorderRadius.circular(theme.radiusSm),
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
      bool focusing,
      ValueChanged<bool> onFocusing,
      VoidCallback onIncrease,
      VoidCallback onDecrease) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    if (widget.divisions != null) {
      value = (value * widget.divisions!).round() / widget.divisions!;
    }
    return AnimatedValueBuilder(
        duration: _dragging && widget.divisions == null
            ? Duration.zero
            : kDefaultDuration,
        curve: Curves.easeInOut,
        lerp: lerpDouble,
        value: value,
        builder: (context, value, _) {
          return Positioned(
            left: value! * constraints.maxWidth - 8 * scaling,
            child: FocusableActionDetector(
              onShowFocusHighlight: (showHighlight) {
                onFocusing(showHighlight);
              },
              shortcuts: {
                LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                    const DecreaseSliderValue(),
                LogicalKeySet(LogicalKeyboardKey.arrowRight):
                    const IncreaseSliderValue(),
                LogicalKeySet(LogicalKeyboardKey.arrowUp):
                    const IncreaseSliderValue(),
                LogicalKeySet(LogicalKeyboardKey.arrowDown):
                    const DecreaseSliderValue(),
              },
              actions: {
                IncreaseSliderValue: CallbackAction(
                  onInvoke: (e) {
                    onIncrease();
                    return true;
                  },
                ),
                DecreaseSliderValue: CallbackAction(
                  onInvoke: (e) {
                    onDecrease();
                    return true;
                  },
                ),
              },
              child: Container(
                width: 16 * scaling,
                height: 16 * scaling,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  shape: BoxShape.circle,
                  border: focusing
                      ? Border.all(
                          color: theme.colorScheme.primary,
                          width: 2 * scaling,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      : Border.all(
                          color: theme.colorScheme.primary.scaleAlpha(0.5),
                          width: 1 * scaling,
                        ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildRangedSlider(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildTrackBar(context, constraints, theme),
        if (widget.hintValue != null) buildHint(context, constraints, theme),
        buildTrackValue(context, constraints, theme),
        buildThumb(
          context,
          constraints,
          theme,
          min(_currentValue.start, _currentValue.end),
          _focusing,
          (focusing) {
            setState(() {
              _focusing = focusing;
            });
          },
          () {
            var value = _currentValue.start;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.increaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value + step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = SliderValue.ranged(
                sliderValue * (widget.max - widget.min) + widget.min,
                _currentValue.end * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = SliderValue.ranged(value, _currentValue.end);
            });
          },
          () {
            var value = _currentValue.start;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.decreaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value - step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = SliderValue.ranged(
                sliderValue * (widget.max - widget.min) + widget.min,
                _currentValue.end * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = SliderValue.ranged(value, _currentValue.end);
            });
          },
        ),
        buildThumb(
          context,
          constraints,
          theme,
          max(_currentValue.start, _currentValue.end),
          _focusingEnd,
          (focusing) {
            setState(() {
              _focusingEnd = focusing;
            });
          },
          () {
            var value = _currentValue.end;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.increaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value + step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = SliderValue.ranged(
                _currentValue.start * (widget.max - widget.min) + widget.min,
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = SliderValue.ranged(_currentValue.start, value);
            });
          },
          () {
            var value = _currentValue.end;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.decreaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value - step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = SliderValue.ranged(
                _currentValue.start * (widget.max - widget.min) + widget.min,
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = SliderValue.ranged(_currentValue.start, value);
            });
          },
        ),
      ],
    );
  }
}
