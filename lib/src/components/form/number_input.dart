import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberInput extends StatefulWidget {
  final TextEditingController? controller;
  final double initialValue;
  final double? min;
  final double? max;
  final bool allowDecimals;
  final int? decimalPlaces;
  final bool showButtons;
  final bool? enabled;
  final double step;
  final ValueChanged<double>? onChanged;

  const NumberInput({
    Key? key,
    this.controller,
    this.initialValue = 0,
    this.step = 1,
    this.min,
    this.max,
    this.allowDecimals = true,
    this.decimalPlaces,
    this.showButtons = true,
    this.enabled,
    this.onChanged,
  }) : super(key: key);

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
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
      );
    }
    return buildTextField(context);
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

  Widget buildTextField(BuildContext context) {
    return TextField();
  }
}
