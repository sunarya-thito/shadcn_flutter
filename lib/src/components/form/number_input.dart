import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberInput extends StatefulWidget {
  final TextEditingController? controller;
  final double initialValue;
  final Widget? leading;
  final Widget? trailing;
  final double? min;
  final double? max;
  final bool allowDecimals;
  final int? decimalPlaces;
  final bool showButtons;
  final bool? enabled;
  final double step;
  final ValueChanged<double>? onChanged;
  final AbstractButtonStyle? buttonStyle;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const NumberInput({
    super.key,
    this.padding,
    this.controller,
    this.initialValue = 0,
    this.leading,
    this.trailing,
    this.step = 1,
    this.min,
    this.max,
    this.allowDecimals = true,
    this.decimalPlaces,
    this.showButtons = true,
    this.enabled,
    this.onChanged,
    this.buttonStyle,
    this.style,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;
  late double _lastValidValue;

  @override
  void initState() {
    super.initState();
    _lastValidValue = widget.initialValue;
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void didUpdateWidget(covariant NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showButtons) {
      final theme = Theme.of(context);
      return IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(child: buildTextField(context)),
            SizedBox(
              height: 32 * theme.scaling,
              child: buildButton(context, theme),
            ),
          ],
        ),
      );
    }
    return buildTextField(context);
  }

  EdgeInsets _paddingModifier(EdgeInsets value) {
    return value * 0.2;
  }

  AbstractButtonStyle get _buttonStyle {
    return widget.buttonStyle ??
        ButtonStyle.secondary(
          density: ButtonDensity(_paddingModifier),
        );
  }

  Widget buildButton(BuildContext context, ThemeData theme) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy > 0) {
          if (widget.max == null || _lastValidValue < widget.max!) {
            double oldValue = _value.toDouble();
            _lastValidValue = oldValue - widget.step;
            _controller.text = widget.allowDecimals
                ? _lastValidValue.toString()
                : _lastValidValue.toInt().toString();
            widget.onChanged?.call(_lastValidValue);
          }
        } else if (details.delta.dy < 0) {
          if (widget.min == null || _lastValidValue > widget.min!) {
            double oldValue = _value.toDouble();
            _lastValidValue = oldValue + widget.step;
            _controller.text = widget.allowDecimals
                ? _lastValidValue.toString()
                : _lastValidValue.toInt().toString();
            widget.onChanged?.call(_lastValidValue);
          }
        }
      },
      child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            if (event.scrollDelta.dy > 0) {
              if (widget.max == null || _lastValidValue < widget.max!) {
                double oldValue = _value.toDouble();
                _lastValidValue = oldValue - widget.step;
                _controller.text = widget.allowDecimals
                    ? _lastValidValue.toString()
                    : _lastValidValue.toInt().toString();
                widget.onChanged?.call(_lastValidValue);
              }
            } else {
              if (widget.min == null || _lastValidValue > widget.min!) {
                double oldValue = _value.toDouble();
                _lastValidValue = oldValue + widget.step;
                _controller.text = widget.allowDecimals
                    ? _lastValidValue.toString()
                    : _lastValidValue.toInt().toString();
                widget.onChanged?.call(_lastValidValue);
              }
            }
          }
        },
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Button(
                      style: _buttonStyle.copyWith(
                        decoration: (context, states, value) {
                          if (value is BoxDecoration) {
                            return value.copyWith(
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(theme.radiusSm),
                              ),
                            );
                          }
                          return value;
                        },
                      ),
                      enabled: widget.enabled ??
                          (widget.max == null || _lastValidValue < widget.max!),
                      onPressed: () {
                        if (widget.max == null ||
                            _lastValidValue < widget.max!) {
                          double oldValue = _value.toDouble();
                          _lastValidValue = oldValue + widget.step;
                          _controller.text = widget.allowDecimals
                              ? _lastValidValue.toString()
                              : _lastValidValue.toInt().toString();
                          widget.onChanged?.call(_lastValidValue);
                          setState(() {});
                        }
                      },
                      child: const FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Icon(
                          Icons.arrow_drop_up,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Button(
                      style: _buttonStyle.copyWith(
                        decoration: (context, states, value) {
                          if (value is BoxDecoration) {
                            return value.copyWith(
                                borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(theme.radiusSm),
                            ));
                          }
                          return value;
                        },
                      ),
                      enabled: widget.enabled ??
                          (widget.min == null || _lastValidValue > widget.min!),
                      onPressed: () {
                        if (widget.min == null ||
                            _lastValidValue > widget.min!) {
                          double oldValue = _value.toDouble();
                          _lastValidValue = oldValue - widget.step;
                          _controller.text = widget.allowDecimals
                              ? _lastValidValue.toString()
                              : _lastValidValue.toInt().toString();
                          widget.onChanged?.call(_lastValidValue);
                          setState(() {});
                        }
                      },
                      child: const FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned.fill(
              child: Center(
                  child: MouseRegion(
                      cursor: SystemMouseCursors.resizeUpDown,
                      hitTestBehavior: HitTestBehavior.translucent,
                      child: SizedBox(
                        width: double.infinity,
                        height: 8,
                      ))),
            )
          ],
        ),
      ),
    );
  }

  String get _valueAsString {
    if (widget.allowDecimals) {
      double value = double.tryParse(_controller.text) ?? _lastValidValue;
      if (widget.decimalPlaces != null) {
        return value.toStringAsFixed(widget.decimalPlaces!);
      } else {
        return value.toString();
      }
    } else {
      int value = int.tryParse(_controller.text) ?? _lastValidValue.toInt();
      return value.toString();
    }
  }

  num get _value {
    if (widget.allowDecimals) {
      return double.tryParse(_controller.text) ?? _lastValidValue;
    } else {
      return int.tryParse(_controller.text) ?? _lastValidValue.toInt();
    }
  }

  Widget buildTextField(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 50 * scaling,
      ),
      child: TextField(
        expands: true,
        minLines: null,
        maxLines: null,
        leading: widget.leading,
        trailing: widget.trailing == null
            ? null
            : Padding(
                padding: EdgeInsets.only(
                    right: widget.showButtons == false ? 0 : 24 * scaling),
                child: widget.trailing),
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: 10 * scaling,
              vertical: 10 * scaling,
            ),
        style: widget.style,
        inputFormatters: [
          if (!widget.allowDecimals) FilteringTextInputFormatter.digitsOnly,
          if (widget.allowDecimals)
            FilteringTextInputFormatter.allow(
              RegExp(r'^-?[0-9]+\.?[0-9]*$'),
            ),
        ],
        controller: _controller,
        onEditingComplete: () {
          double value = double.tryParse(_controller.text) ?? _lastValidValue;
          if (widget.min != null && value < widget.min!) {
            value = widget.min!;
          } else if (widget.max != null && value > widget.max!) {
            value = widget.max!;
          }
          _lastValidValue = value;
          _controller.text = _valueAsString;
          widget.onChanged?.call(_lastValidValue);
        },
        borderRadius: widget.showButtons
            ? BorderRadiusDirectional.only(
                topStart: Radius.circular(4 * scaling),
                bottomStart: Radius.circular(4 * scaling),
              )
            : BorderRadius.circular(4 * scaling),
        enabled: widget.enabled ?? true,
        initialValue: _valueAsString,
        keyboardType:
            TextInputType.numberWithOptions(decimal: widget.allowDecimals),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
