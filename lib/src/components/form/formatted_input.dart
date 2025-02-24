import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class InputPart {
  const factory InputPart.static(String text) = StaticPart;
  const factory InputPart.editable({
    required int length,
    bool obscureText,
    List<TextInputFormatter> inputFormatters,
    required double width,
  }) = EditablePart;
  Widget build(BuildContext context, FormattedInputData data);
}

class StaticPart implements InputPart {
  final String text;

  const StaticPart(this.text);

  @override
  Widget build(BuildContext context, FormattedInputData data) {
    return _StaticPartWidget(text: text);
  }
}

class _StaticPartWidget extends StatefulWidget {
  final String text;
  const _StaticPartWidget({required this.text});

  @override
  State<_StaticPartWidget> createState() => _StaticPartWidgetState();
}

class _StaticPartWidgetState extends State<_StaticPartWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text).muted().base();
  }
}

class EditablePart implements InputPart {
  final int length;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final double width;
  const EditablePart({
    required this.length,
    this.obscureText = false,
    this.inputFormatters = const [],
    required this.width,
  });

  @override
  Widget build(BuildContext context, FormattedInputData data) {
    return _EditablePartWidget(
      data: data,
      length: length,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      width: width,
    );
  }
}

class _EditablePartController extends TextEditingController {
  final int maxLength;
  final bool obscureText;
  _EditablePartController({required this.maxLength, this.obscureText = false});

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final theme = Theme.of(context);
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      var text = this.text;
      var padding = '_' * max(0, maxLength - text.length);
      return TextSpan(children: [
        TextSpan(
          style: style,
          text: text,
        ),
        TextSpan(
          style: style?.copyWith(color: theme.colorScheme.mutedForeground),
          text: padding,
        ),
      ]);
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    var textBefore = value.composing.textBefore(value.text);
    var textInside = value.composing.textInside(value.text);
    var textAfter = value.composing.textAfter(value.text);
    int totalTextLength =
        textBefore.length + textInside.length + textAfter.length;
    var padding = '_' * max(0, maxLength - totalTextLength);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: textBefore),
        TextSpan(
          style: composingStyle,
          text: textInside,
        ),
        TextSpan(text: textAfter),
        TextSpan(
          style: style?.copyWith(color: theme.colorScheme.mutedForeground),
          text: padding,
        ),
      ],
    );
  }
}

class _EditablePartWidget extends StatefulWidget {
  final FormattedInputData data;
  final int length;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final double width;
  const _EditablePartWidget({
    required this.length,
    required this.data,
    this.obscureText = false,
    this.inputFormatters = const [],
    required this.width,
  });

  @override
  State<_EditablePartWidget> createState() => _EditablePartWidgetState();
}

class _EditablePartWidgetState extends State<_EditablePartWidget>
    with FormattedPartState {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _EditablePartController(
      maxLength: widget.length,
      obscureText: widget.obscureText,
    );
  }

  @override
  void didUpdateWidget(covariant _EditablePartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length ||
        oldWidget.obscureText != widget.obscureText) {
      final oldValue = _controller.value;
      _controller = _EditablePartController(
        maxLength: widget.length,
        obscureText: widget.obscureText,
      );
      _controller.value = oldValue;
    }
  }

  @override
  String get value => _controller.text;

  FormattedInputData get data => widget.data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormEntry(
      key: FormKey(data.partIndex),
      child: SizedBox(
        width: widget.width,
        child: TextField(
          controller: _controller,
          focusNode: data.focusNode,
          maxLength: widget.length,
          style:
              DefaultTextStyle.of(context).style.merge(theme.typography.mono),
          border: false,
          textAlign: TextAlign.center,
          initialValue: data.initialValue,
          maxLines: 1,
          obscureText: widget.obscureText,
          inputFormatters: widget.inputFormatters,
          padding: EdgeInsets.symmetric(
            horizontal: 6 * theme.scaling,
            vertical: 8 * theme.scaling,
          ),
          onChanged: (value) {
            data.onChanged();
          },
        ),
      ),
    );
  }
}

class FormattedValue {
  final List<String> parts;

  const FormattedValue(this.parts);

  @override
  String toString() => parts.join();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormattedValue && listEquals(parts, other.parts);
  }

  @override
  int get hashCode => parts.hashCode;
}

class FormattedInput extends StatefulWidget {
  final List<InputPart> parts;
  final FormattedValue initialValue;
  final ValueChanged<FormattedValue>? onChanged;
  final ValueChanged<FormattedValue>? onSubmitted;
  final TextStyle? style;
  final Widget? leading;
  final Widget? trailing;

  const FormattedInput({
    super.key,
    required this.parts,
    required this.initialValue,
    this.onChanged,
    this.style,
    this.onSubmitted,
    this.leading,
    this.trailing,
  });

  @override
  State<FormattedInput> createState() => _FormattedInputState();
}

class _FormattedInputState extends State<FormattedInput> {
  late List<_FormattedInputChild> _keys;

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _keys =
        List.generate(widget.parts.length, (index) => _FormattedInputChild());
  }

  @override
  void didUpdateWidget(covariant FormattedInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.parts.length != widget.parts.length) {
      _keys = List.generate(widget.parts.length, (index) {
        if (index < oldWidget.parts.length) {
          return _keys[index];
        }
        return _FormattedInputChild();
      });
    }
  }

  Widget _buildPart(int index, InputPart part) {
    var formattedInputData = FormattedInputData(
      partIndex: index,
      initialValue: widget.initialValue.parts[index],
      onChanged: _notifyChanged,
      focusNode: _keys[index].focusNode,
    );
    return part.build(context, formattedInputData);
  }

  void _notifyChanged() {
    if (widget.onChanged != null) {
      List<String> parts = _keys.map((e) {
        Object? currentString = e.key.currentState;
        if (currentString is FormattedPartState) {
          return currentString.value;
        }
        return '';
      }).toList();
      widget.onChanged!(FormattedValue(parts));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicWidth(
      child: TextFieldTapRegion(
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _hasFocus = hasFocus;
            });
          },
          child: OutlinedContainer(
            borderRadius: theme.borderRadiusMd,
            borderColor:
                _hasFocus ? theme.colorScheme.ring : theme.colorScheme.border,
            padding: EdgeInsets.symmetric(
              horizontal: 6 * theme.scaling,
            ),
            child: Form(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leading != null) widget.leading!,
                  for (var i = 0; i < widget.parts.length; i++)
                    _buildPart(i, widget.parts[i]),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormattedInputChild {
  final FocusNode focusNode;
  final GlobalKey key;

  _FormattedInputChild()
      : focusNode = FocusNode(),
        key = GlobalKey();
}

class FormattedInputData {
  final int partIndex;
  final String initialValue;
  final VoidCallback onChanged;
  final FocusNode focusNode;

  FormattedInputData({
    required this.partIndex,
    required this.initialValue,
    required this.onChanged,
    required this.focusNode,
  });
}

mixin FormattedPartState<T extends StatefulWidget> on State<T> {
  String get value;
}
