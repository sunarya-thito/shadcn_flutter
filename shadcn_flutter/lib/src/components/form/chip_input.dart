import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class _ChipInputController extends TextEditingController {
  static const int kObjectReplacementChar = 0xFFFE;
  final Widget Function(int index) chipBuilder;

  _ChipInputController({
    super.text,
    required this.chipBuilder,
  });

  void changeText(TextEditingValue value) {
    var text = value.text;
    var composing = value.composing;
    var selection = value.selection;
    int count = 0;
    for (int i = 0; i < text.length; i++) {
      if (text.codeUnitAt(i) == kObjectReplacementChar) {
        count++;
      } else {
        break;
      }
    }
    String char = String.fromCharCode(kObjectReplacementChar);
    text = char * count + text;
    // composing = TextRange(
    //   start: composing.start + count,
    //   end: composing.end + count,
    // );
    composing = _range(
      composing.start + count,
      composing.end + count,
    );
    selection = TextSelection(
      baseOffset: selection.baseOffset + count,
      extentOffset: selection.extentOffset + count,
    );
    this.value = TextEditingValue(
      text: text,
      composing: composing,
      selection: selection,
    );
  }

  void changeChipCount(int count) {
    var text = value.text;
    var composing = value.composing;
    var selection = value.selection;
    int currentCount = 0;
    for (int i = 0; i < text.length; i++) {
      if (text.codeUnitAt(i) == kObjectReplacementChar) {
        currentCount++;
      } else {
        break;
      }
    }
    if (count > currentCount) {
      String char = String.fromCharCode(kObjectReplacementChar);
      text = char * count + text.substring(currentCount);
      // composing = TextRange(
      //   start: composing.start + count,
      //   end: composing.end + count,
      // );
      composing = _range(
        composing.start + count,
        composing.end + count,
      );
      selection = TextSelection(
        baseOffset: selection.baseOffset + count,
        extentOffset: selection.extentOffset + count,
      );
    } else if (count < currentCount) {
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
    } else {
      return;
    }
    value = TextEditingValue(
      text: text,
      composing: composing,
      selection: selection,
    );
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    var text = value.text;
    int count = 0;
    for (int i = 0; i < text.length; i++) {
      if (text.codeUnitAt(i) == kObjectReplacementChar) {
        count++;
      } else {
        break;
      }
    }
    var composing = value.composing;
    assert(!composing.isValid || !withComposing || value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    text = text.substring(count);
    // composing = TextRange(
    //   start: composing.start - count,
    //   end: composing.end - count,
    // );
    composing = _range(
      composing.start - count,
      composing.end - count,
    );

    if (composingRegionOutOfRange) {
      // return TextSpan(style: style, text: text);
      return TextSpan(
        children: [
          for (int i = 0; i < count; i++)
            WidgetSpan(
              child: chipBuilder(i),
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
            child: chipBuilder(i),
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
      initialValue: widget.initialText,
      onChanged: widget.onTextChanged,
      onSubmitted: (text) {
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
