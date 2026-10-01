import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;

/// A controlled shadcn text input whose controller follows remote DataModel
/// updates without moving the caret during local edits.
class BoundShadcnTextInput extends StatefulWidget {
  const BoundShadcnTextInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onSubmitted,
    this.label,
    this.multiline = false,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
  });

  final String value;
  final String? label;
  final bool multiline;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  @override
  State<BoundShadcnTextInput> createState() => _BoundShadcnTextInputState();
}

class _BoundShadcnTextInputState extends State<BoundShadcnTextInput> {
  late final TextEditingController _controller;
  bool _synchronizingController = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(BoundShadcnTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _synchronizingController = true;
      try {
        _controller.value = _controller.value.copyWith(
          text: widget.value,
          selection: TextSelection.collapsed(offset: widget.value.length),
          composing: TextRange.empty,
        );
      } finally {
        _synchronizingController = false;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = widget.label == null ? null : Text(widget.label!);
    if (widget.multiline) {
      return shad.TextArea(
        controller: _controller,
        placeholder: placeholder,
        onChanged: _handleChanged,
      );
    }
    return shad.TextField(
      controller: _controller,
      placeholder: placeholder,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      onChanged: _handleChanged,
      onSubmitted: widget.onSubmitted,
    );
  }

  void _handleChanged(String value) {
    if (!_synchronizingController) widget.onChanged(value);
  }
}
