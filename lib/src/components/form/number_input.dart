import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

@Deprecated('Use TextField with InputFeature.spinner() instead.')
class NumberInput extends StatefulWidget {
  static final _decimalFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^-?[0-9]+\.?[0-9]*$'),
  );
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
  final VoidCallback? onEditingComplete;

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
    this.onEditingComplete,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput>
    with FormValueSupplier<num, NumberInput> {
  late TextEditingController _controller;
  late double _lastValidValue;

  @override
  void initState() {
    super.initState();
    _lastValidValue = widget.initialValue;
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    formValue = _lastValidValue;
  }

  void _onTextChanged() {
    num value = _value;
    formValue = value;
  }

  @override
  void didReplaceFormValue(num value) {
    _lastValidValue = value.toDouble();
    _controller.text = valueToString(value);
  }

  @override
  void didUpdateWidget(covariant NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onTextChanged);
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedContainer(
      borderRadius: theme.borderRadiusMd,
      child: buildTextField(context, theme),
    );
  }

  AbstractButtonStyle get _buttonStyle {
    return widget.buttonStyle ??
        const ButtonStyle.text(
          density: ButtonDensity.compact,
          size: ButtonSize.small,
        );
  }

  Widget buildButton(BuildContext context, ThemeData theme) {
    return SizedBox(
      width: 24 * theme.scaling,
      height: 32 * theme.scaling,
      child: GestureDetector(
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
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Button(
                      style: _buttonStyle,
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
                      child: const Icon(
                        Icons.arrow_drop_up,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Button(
                      style: _buttonStyle,
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
                      child: const Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }

  String valueToString(num value) {
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

  String get _valueAsString => valueToString(_value);

  num get _value {
    if (widget.allowDecimals) {
      return double.tryParse(_controller.text) ?? _lastValidValue;
    } else {
      return int.tryParse(_controller.text) ?? _lastValidValue.toInt();
    }
  }

  Widget buildTextField(BuildContext context, ThemeData theme) {
    final scaling = theme.scaling;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 50 * scaling,
      ),
      child: TextField(
        border: false,
        minLines: 1,
        maxLines: 1,
        leading: widget.leading,
        trailing: Row(
          children: [
            if (widget.trailing != null) widget.trailing!,
            if (widget.showButtons) buildButton(context, theme),
          ],
        ),
        padding: widget.padding ??
            EdgeInsetsDirectional.only(
              start: 10 * scaling,
            ),
        style: widget.style,
        inputFormatters: [
          if (!widget.allowDecimals) FilteringTextInputFormatter.digitsOnly,
          if (widget.allowDecimals) NumberInput._decimalFormatter,
        ],
        controller: _controller,
        onChanged: (_) {
          double value = double.tryParse(_controller.text) ?? _lastValidValue;
          if (widget.min != null && value < widget.min!) {
            value = widget.min!;
          } else if (widget.max != null && value > widget.max!) {
            value = widget.max!;
          }
          _lastValidValue = value;
          widget.onChanged?.call(_lastValidValue);
        },
        onEditingComplete: () {
          double value = double.tryParse(_controller.text) ?? _lastValidValue;
          if (widget.min != null && value < widget.min!) {
            value = widget.min!;
          } else if (widget.max != null && value > widget.max!) {
            value = widget.max!;
          }
          bool needsUpdate = value != _lastValidValue;
          _lastValidValue = value;
          _controller.text = _valueAsString;
          if (needsUpdate) {
            widget.onChanged?.call(_lastValidValue);
          }
          widget.onEditingComplete?.call();
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
