import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class _ChipInputController extends TextEditingController {
  static const int kObjectReplacementChar = 0xFFFE;
  final Widget Function(int index) chipBuilder;
  final void Function(int index) onChipRemoved;
  int _chipCount = 0;

  _ChipInputController({
    super.text,
    required this.chipBuilder,
    required this.onChipRemoved,
  });

  @override
  set value(TextEditingValue value) {
    // prevent composing from being out of range
    int count = _chipCount;
    var newText = value.text;
    newText =
        newText.replaceAll(String.fromCharCode(kObjectReplacementChar), '');
    newText = String.fromCharCode(kObjectReplacementChar) * count + newText;
    // prevent user from changing the chip count
    var composing = value.composing;
    if (composing.isValid) {
      composing = TextRange(
        start: composing.start.max(count),
        end: composing.end.max(count),
      );
    }
    var selection = value.selection;
    selection = TextSelection(
      baseOffset: selection.baseOffset.max(count),
      extentOffset: selection.extentOffset.max(count),
    );
    super.value = TextEditingValue(
      text: newText,
      composing: composing,
      selection: selection,
    );
  }

  void changeChipCount(int count) {
    _chipCount = count;
    var text = value.text;
    text = text.replaceAll(String.fromCharCode(kObjectReplacementChar), '');
    text = String.fromCharCode(kObjectReplacementChar) * count + text;
    super.value = TextEditingValue(
      text: text,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: count),
    );
  }

  Widget buildChip(int index) {
    return TextFieldTapRegion(
      child: Transform.translate(
        offset: const Offset(-6, 4),
        child: chipBuilder(index).withMargin(right: 2),
      ),
    );
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    var text = value.text;
    int count = _chipCount;
    var composing = value.composing;

    text = text.substring(count);
    composing = _range(
      composing.start - count,
      composing.end - count,
    );

    var newValue = TextEditingValue(
      text: text,
      composing: composing,
      selection: value.selection,
    );

    assert(
        !composing.isValid || !withComposing || newValue.isComposingRangeValid);
    final bool composingRegionOutOfRange =
        !newValue.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      // return TextSpan(style: style, text: text);
      return TextSpan(
        children: [
          for (int i = 0; i < count; i++)
            WidgetSpan(
              child: buildChip(i),
            ),
          TextSpan(
            style: style,
            text: text,
          ),
        ],
      );
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: [
        for (int i = 0; i < count; i++)
          WidgetSpan(
            child: buildChip(i),
          ),
        TextSpan(text: composing.textBefore(text)),
        TextSpan(
          style: composingStyle,
          text: composing.textInside(text),
        ),
        TextSpan(text: composing.textAfter(text)),
      ],
    );
  }
}

TextRange _range(int start, int end) {
  if (start <= -1 && end <= -1) {
    return TextRange.empty;
  }
  start = start.max(0);
  end = end.max(0);
  return TextRange(start: start, end: end);
}

class ChipInput extends StatefulWidget {
  final TextEditingController? controller;
  final BoxConstraints popoverConstraints;
  final UndoHistoryController? undoHistoryController;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<String>? onSubmitted;
  final String? initialText;
  final FocusNode? focusNode;
  final List<Widget> suggestions;
  final List<Widget> chips;
  final void Function(int index)? onChipRemoved;
  const ChipInput({
    Key? key,
    this.controller,
    this.popoverConstraints = const BoxConstraints(
      maxHeight: 300,
    ),
    this.undoHistoryController,
    this.onTextChanged,
    this.initialText,
    this.onSubmitted,
    this.focusNode,
    this.suggestions = const [],
    this.chips = const [],
    this.onChipRemoved,
  }) : super(key: key);

  @override
  State<ChipInput> createState() => ChipInputState();
}

class ChipInputState extends State<ChipInput> {
  late FocusNode _focusNode;
  late _ChipInputController _controller;
  late ValueNotifier<List<Widget>> _suggestions;
  final PopoverController _popoverController = PopoverController();

  bool _isChangingText = false;

  @override
  void initState() {
    super.initState();
    _suggestions = ValueNotifier(widget.suggestions);
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = _ChipInputController(
      chipBuilder: _chipBuilder,
      onChipRemoved: (index) {
        widget.onChipRemoved?.call(index);
      },
    );
    if (widget.controller != null) {
      _syncController();
    } else if (widget.initialText != null) {
      var text = widget.initialText!;
      var char =
          String.fromCharCode(_ChipInputController.kObjectReplacementChar);
      text = char * widget.chips.length + text;
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    } else {
      var text = '';
      var char =
          String.fromCharCode(_ChipInputController.kObjectReplacementChar);
      text = char * widget.chips.length + text;
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
    _controller.addListener(_onControllerChanged);
  }

  Widget _chipBuilder(int index) {
    return widget.chips[index];
  }

  void _syncController() {
    var controller = widget.controller!;
    var value = controller.value;
    var text = value.text;
    var char = String.fromCharCode(_ChipInputController.kObjectReplacementChar);
    text = char * widget.chips.length + text;
    var composing = value.composing;
    var selection = value.selection;
    _controller.value = TextEditingValue(
      text: text,
      composing: composing.isCollapsed
          ? TextRange.empty
          : _range(
              composing.start + widget.chips.length,
              composing.end + widget.chips.length,
            ),
      selection: selection.copyWith(
        baseOffset: selection.baseOffset + widget.chips.length,
        extentOffset: selection.extentOffset + widget.chips.length,
      ),
    );
    controller.addListener(_onExternalControllerChanged);
  }

  @override
  void didUpdateWidget(covariant ChipInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onExternalControllerChanged);
      if (widget.controller != null) {
        _syncController();
      }
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (!listEquals(widget.suggestions, oldWidget.suggestions)) {
      _suggestions.value = widget.suggestions;
    }
    if (!listEquals(widget.chips, oldWidget.chips)) {
      _controller.changeChipCount(widget.chips.length);
    }
  }

  void _onExternalControllerChanged() {
    var externalController = widget.controller;
    if (externalController == null) {
      return;
    }
    if (_isChangingText) {
      return;
    }
    _isChangingText = true;
    var value = externalController.value;
    var text = value.text;
    var composing = value.composing;
    var selection = value.selection;
    _controller.value = TextEditingValue(
      text: text,
      composing: composing,
      selection: selection,
    );
    _isChangingText = false;
  }

  void _onControllerChanged() {
    var externalController = widget.controller;
    if (externalController == null) {
      return;
    }
    if (_isChangingText) {
      return;
    }
    _isChangingText = true;
    var value = _controller.value;
    var text = value.text;
    var composing = value.composing;
    var selection = value.selection;
    int count = 0;
    for (int i = 0; i < text.length; i++) {
      if (text.codeUnitAt(i) == _ChipInputController.kObjectReplacementChar) {
        count++;
      } else {
        break;
      }
    }
    text = text.substring(count);
    // composing = TextRange(
    //   start: composing.start - count,
    //   end: composing.end - count,
    // );
    composing = _range(
      composing.start - count,
      composing.end - count,
    );
    selection = TextSelection(
      baseOffset: selection.baseOffset - count,
      extentOffset: selection.extentOffset - count,
    );
    externalController.value = TextEditingValue(
      text: text,
      composing: composing,
      selection: selection,
    );
    _isChangingText = false;
  }

  Widget buildPopover(BuildContext context) {
    return Data(
      data: this,
      child: AnimatedBuilder(
          animation: _suggestions,
          builder: (context, child) {
            return ListView(
              shrinkWrap: true,
              children: _suggestions.value,
            );
          }),
    );
  }

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      initialValue: widget.initialText,
      onChanged: widget.onTextChanged,
      onSubmitted: (text) {
        _focusNode.requestFocus();
        int count = 0;
        for (int i = 0; i < text.length; i++) {
          if (text.codeUnitAt(i) ==
              _ChipInputController.kObjectReplacementChar) {
            count++;
          } else {
            break;
          }
        }
        text = text.substring(count);
        widget.onSubmitted?.call(text);
      },
      controller: _controller,
      undoController: widget.undoHistoryController,
    );
  }
}
