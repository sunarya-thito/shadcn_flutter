import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Function signature for building custom chip widgets in chip input fields.
///
/// Takes a [BuildContext] and chip data of type [T], returning a widget that
/// represents the chip visually. Allows complete customization of chip appearance
/// and behavior within chip input components.
typedef ChipWidgetBuilder<T> = Widget Function(BuildContext context, T chip);

/// Theme configuration for [ChipInput] widget styling and behavior.
///
/// Defines visual properties and default behaviors for chip input components
/// including popover constraints and chip rendering preferences. Applied globally
/// through [ComponentTheme] or per-instance for customization.
class ChipInputTheme {
  /// Constraints applied to the suggestion popover container.
  ///
  /// Controls the maximum and minimum dimensions of the autocomplete suggestion
  /// popover that appears during typing. When null, uses framework defaults
  /// with reasonable size limits for suggestion lists.
  final BoxConstraints? popoverConstraints;

  /// Whether to render selected items as interactive chip widgets by default.
  ///
  /// When true, selected items appear as dismissible chip widgets with close buttons.
  /// When false, items appear as simple text tokens. Individual [ChipInput] widgets
  /// can override this default behavior.
  final bool? useChips;

  final double? spacing;

  /// Creates a [ChipInputTheme].
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// The theme can be applied globally or to specific chip input instances.
  const ChipInputTheme({
    this.popoverConstraints,
    this.spacing,
    this.useChips,
  });

  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  ChipInputTheme copyWith({
    ValueGetter<BoxConstraints?>? popoverConstraints,
    ValueGetter<bool?>? useChips,
    ValueGetter<double?>? spacing,
  }) {
    return ChipInputTheme(
      popoverConstraints: popoverConstraints == null
          ? this.popoverConstraints
          : popoverConstraints(),
      useChips: useChips == null ? this.useChips : useChips(),
      spacing: spacing == null ? this.spacing : spacing(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChipInputTheme &&
        other.popoverConstraints == popoverConstraints &&
        other.useChips == useChips &&
        other.spacing == spacing;
  }

  @override
  int get hashCode => Object.hash(popoverConstraints, useChips, spacing);
}

class ChipEditingController<T> extends TextEditingController {
  static const int _chipStart = 0xE000; // Private Use Area start
  static const int _chipEnd = 0xF8FF; // Private Use Area end
  static const int _maxChips = _chipEnd - _chipStart + 1;
  // these codepoints are reserved for chips, so that they don't conflict with normal text
  // there are 6400 codepoints available for chips

  // final List<T> _chips = [];
  final Map<int, T> _chipMap = {};

  int _nextChipIndex = 0;

  int get _nextAvailableChipIndex {
    if (_chipMap.length >= _maxChips) {
      throw Exception('Maximum number of chips reached');
    }
    while (_chipMap.containsKey(_nextChipIndex)) {
      int nextIndex = _nextChipIndex + 1;
      if (nextIndex >= _maxChips) {
        nextIndex = 0;
      }
      _nextChipIndex = nextIndex;
    }
    return _nextChipIndex;
  }

  factory ChipEditingController({String? text, List<T>? initialChips}) {
    StringBuffer buffer = StringBuffer();
    if (initialChips != null) {
      for (int i = 0; i < initialChips.length; i++) {
        buffer.writeCharCode(_chipStart + i);
      }
    }
    if (text != null) {
      buffer.write(text);
    }
    return ChipEditingController._internal(buffer.toString());
  }

  ChipEditingController._internal(String text) : super(text: text);

  @override
  set text(String newText) {
    super.text = newText;
    _updateText(newText);
  }

  @override
  set value(TextEditingValue newValue) {
    super.value = newValue;
    _updateText(newValue.text);
  }

  void _updateText(String newText) {
    for (final entry in _chipMap.entries.toList()) {
      int chipIndex = entry.key;
      int chipCodeUnit = _chipStart + chipIndex;
      if (!newText.contains(String.fromCharCode(chipCodeUnit))) {
        _chipMap.remove(chipIndex);
      }
    }
  }

  List<T> get chips => List.unmodifiable(_chipMap.values);

  set chips(List<T> newChips) {
    String text = value.text;
    // remove chips that are not in newChips
    // add chips that are in newChips but not present, appending them at the last chip position
    StringBuffer buffer = StringBuffer();
    int chipCount = 0;
    for (int i = 0; i < text.length; i++) {
      int codeUnit = text.codeUnitAt(i);
      if (codeUnit >= _chipStart && codeUnit <= _chipEnd) {
        T? existingChip = _chipMap[codeUnit - _chipStart];
        if (existingChip != null && newChips.contains(existingChip)) {
          buffer.writeCharCode(codeUnit);
          chipCount++;
        }
      } else {
        buffer.writeCharCode(codeUnit);
      }
    }
    for (int i = chipCount; i < newChips.length; i++) {
      T chip = newChips[i];
      int chipIndex = _nextAvailableChipIndex;
      buffer.writeCharCode(_chipStart + chipIndex);
      _chipMap[chipIndex] = chip;
    }
    super.value = value.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }

  void removeAllChips() {
    StringBuffer buffer = StringBuffer();
    String text = value.text;
    for (int i = 0; i < text.length; i++) {
      int codeUnit = text.codeUnitAt(i);
      if (codeUnit < _chipStart || codeUnit > _chipEnd) {
        buffer.writeCharCode(codeUnit);
      }
    }
    super.value = value.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
    _chipMap.clear();
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final provider = Data.maybeOf<_ChipProvider<T>>(context);
    final theme = ComponentTheme.maybeOf<ChipInputTheme>(context);
    final spacing = theme?.spacing ?? 4.0;
    if (provider != null) {
      final bool composingRegionOutOfRange =
          !value.isComposingRangeValid || !withComposing;

      if (composingRegionOutOfRange) {
        List<InlineSpan> children = [];
        String text = value.text;
        StringBuffer buffer = StringBuffer();
        for (int i = 0; i < text.length; i++) {
          int codeUnit = text.codeUnitAt(i);
          if (codeUnit >= _chipStart && codeUnit <= _chipEnd) {
            // Flush buffer
            if (buffer.isNotEmpty) {
              children.add(TextSpan(style: style, text: buffer.toString()));
              buffer.clear();
            }
            T? chip = _chipMap[codeUnit - _chipStart];
            Widget? chipWidget =
                chip == null ? null : provider.buildChip(context, chip);
            if (chipWidget != null) {
              bool previousIsChip = i > 0 &&
                  text.codeUnitAt(i - 1) >= _chipStart &&
                  text.codeUnitAt(i - 1) <= _chipEnd;
              bool nextIsChip = i < text.length - 1 &&
                  text.codeUnitAt(i + 1) >= _chipStart &&
                  text.codeUnitAt(i + 1) <= _chipEnd;
              children.add(WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: previousIsChip
                        ? spacing / 2
                        : i == 0
                            ? 0
                            : spacing,
                    right: nextIsChip ? spacing / 2 : spacing,
                  ),
                  child: chipWidget,
                ),
              ));
            }
          } else {
            buffer.writeCharCode(codeUnit);
          }
        }
        // Flush remaining buffer
        if (buffer.isNotEmpty) {
          children.add(TextSpan(style: style, text: buffer.toString()));
        }
        return TextSpan(style: style, children: children);
      }

      final TextStyle composingStyle =
          style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
              const TextStyle(decoration: TextDecoration.underline);
      List<InlineSpan> children = [];
      String text = value.text;
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < text.length; i++) {
        int codeUnit = text.codeUnitAt(i);
        if (codeUnit >= _chipStart && codeUnit <= _chipEnd) {
          // Flush buffer
          if (buffer.isNotEmpty) {
            children.add(TextSpan(style: style, text: buffer.toString()));
            buffer.clear();
          }
          Widget? chipWidget =
              provider.buildChip(context, _chipMap[codeUnit - _chipStart] as T);
          if (chipWidget != null) {
            children.add(WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: chipWidget,
            ));
          }
        } else {
          // Check if current index is within composing range
          if (i >= value.composing.start && i < value.composing.end) {
            // Flush buffer
            if (buffer.isNotEmpty) {
              children.add(TextSpan(style: style, text: buffer.toString()));
              buffer.clear();
            }
            children.add(TextSpan(
                style: composingStyle, text: String.fromCharCode(codeUnit)));
          } else {
            buffer.writeCharCode(codeUnit);
          }
        }
      }
      // Flush remaining buffer
      if (buffer.isNotEmpty) {
        children.add(TextSpan(style: style, text: buffer.toString()));
      }
      return TextSpan(style: style, children: children);
    }
    return super.buildTextSpan(
        context: context, style: style, withComposing: withComposing);
  }

  String get plainText {
    StringBuffer buffer = StringBuffer();
    String text = value.text;
    for (int i = 0; i < text.length; i++) {
      int codeUnit = text.codeUnitAt(i);
      if (codeUnit < _chipStart || codeUnit > _chipEnd) {
        buffer.writeCharCode(codeUnit);
      }
    }
    return buffer.toString();
  }

  void insertChipAtCursor(T? Function(String chipText) chipConverter) {
    final boundaries = _findChipTextBoundaries(selection.baseOffset);
    String chipText = value.text.substring(boundaries.start, boundaries.end);
    T? chip = chipConverter(chipText);
    if (chip != null) {
      int chipIndex = _nextAvailableChipIndex;
      _replaceAsChip(boundaries.start, boundaries.end, chipIndex);
      _chipMap[chipIndex] = chip;
    }
  }

  void clearTextAtCursor() {
    final boundaries = _findChipTextBoundaries(selection.baseOffset);
    String text = value.text;
    StringBuffer buffer = StringBuffer();
    buffer.write(text.substring(0, boundaries.start));
    buffer.write(text.substring(boundaries.end));
    super.value = value.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: boundaries.start),
    );
  }

  void appendChip(T chip) {
    // append chip at the last chip position
    // note: chip position is not always in order
    // sometimes theres chip and then text and then chip
    // so we need to find the last chip position
    String text = value.text;
    int chipIndex = _nextAvailableChipIndex;
    int lastChipIndex = -1;
    for (int i = text.length - 1; i >= 0; i--) {
      int codeUnit = text.codeUnitAt(i);
      if (codeUnit >= _chipStart && codeUnit <= _chipEnd) {
        lastChipIndex = i;
        break;
      }
    }
    String newText = text.replaceRange(lastChipIndex + 1, lastChipIndex + 1,
        String.fromCharCode(_chipStart + chipIndex));
    super.value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: lastChipIndex + 2),
    );
    _chipMap[chipIndex] = chip;
  }

  void appendChipAtCursor(T chip) {
    // append chip at the cursor position
    final boundaries = _findChipTextBoundaries(selection.baseOffset);
    String text = value.text;
    int chipIndex = _nextAvailableChipIndex;
    String newText = text.replaceRange(boundaries.end, boundaries.end,
        String.fromCharCode(_chipStart + chipIndex));
    super.value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: boundaries.end + 1),
    );
    _chipMap[chipIndex] = chip;
  }

  void insertChip(T chip) {
    // insert chip at the start
    int chipIndex = _nextAvailableChipIndex;
    String newText = String.fromCharCode(_chipStart + chipIndex) + value.text;
    super.value = value.copyWith(
      text: newText,
      selection: const TextSelection.collapsed(offset: 1),
    );
    _chipMap[chipIndex] = chip;
  }

  void _replaceAsChip(int start, int end, int index) {
    String text = value.text;
    StringBuffer buffer = StringBuffer();
    buffer.write(text.substring(0, start));
    buffer.writeCharCode(_chipStart + index);
    buffer.write(text.substring(end));
    super.value = value.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: start + 1),
    );
  }

  ({int start, int end}) _findChipTextBoundaries(int cursorPosition) {
    String text = value.text;
    int start = cursorPosition;
    int end = cursorPosition;

    // Move start backward to find the beginning of the chip text
    while (start > 0) {
      int codeUnit = text.codeUnitAt(start - 1);
      if (codeUnit >= _chipStart && codeUnit <= _chipEnd) {
        break;
      }
      start--;
    }

    // Move end forward to find the end of the chip text
    while (end < text.length) {
      int codeUnit = text.codeUnitAt(end);
      if (codeUnit >= _chipStart && codeUnit <= _chipEnd) {
        break;
      }
      end++;
    }

    return (start: start, end: end);
  }

  void removeChip(T chip) {
    int? chipIndex;
    _chipMap.forEach((key, value) {
      if (value == chip) {
        chipIndex = key;
      }
    });
    if (chipIndex != null) {
      String text = value.text;
      StringBuffer buffer = StringBuffer();
      int currentCursorOffset = value.selection.baseOffset;
      int newCursorOffset = currentCursorOffset;

      for (int i = 0; i < text.length; i++) {
        int codeUnit = text.codeUnitAt(i);
        if (codeUnit == _chipStart + chipIndex!) {
          // Found the chip to remove
          // Adjust cursor position if it's after the removed chip
          if (currentCursorOffset > i) {
            newCursorOffset = currentCursorOffset - 1;
          }
          // skip this code unit
          continue;
        }
        buffer.writeCharCode(codeUnit);
      }
      super.value = value.copyWith(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: newCursorOffset),
      );
      _chipMap.remove(chipIndex);
    }
  }
}

abstract class _ChipProvider<T> {
  Widget? buildChip(BuildContext context, T chip);
}

typedef ChipSubmissionCallback<T> = T? Function(String chipText);

class ChipInput<T> extends StatefulWidget {
  final ChipEditingController<T>? controller;
  final BoxConstraints? popoverConstraints;
  final UndoHistoryController? undoHistoryController;
  final ChipSubmissionCallback<T> onSubmitted;
  final String? initialText;
  final FocusNode? focusNode;
  final List<T> suggestions;
  final List<TextInputFormatter>? inputFormatters;
  @Deprecated('Use onSuggestionChosen instead')
  final void Function(int index)? onSuggestionChoosen;
  final void Function(int index)? onSuggestionChosen;
  final ValueChanged<List<T>>? onChanged;
  final ChipWidgetBuilder<T> chipBuilder;
  final ChipWidgetBuilder<T>? suggestionBuilder;
  final bool? useChips;
  final TextInputAction? textInputAction;
  final Widget? placeholder;
  final Widget Function(BuildContext, T)? suggestionLeadingBuilder;
  final Widget Function(BuildContext, T)? suggestionTrailingBuilder;
  final Widget? inputTrailingWidget;
  final bool enabled;

  const ChipInput({
    super.key,
    this.controller,
    this.popoverConstraints,
    this.undoHistoryController,
    this.initialText,
    required this.onSubmitted,
    this.focusNode,
    this.suggestions = const [],
    this.inputFormatters,
    @Deprecated('Use onSuggestionChosen instead') this.onSuggestionChoosen,
    this.onSuggestionChosen,
    this.onChanged,
    this.useChips,
    this.suggestionBuilder,
    this.textInputAction,
    this.placeholder,
    this.suggestionLeadingBuilder,
    this.suggestionTrailingBuilder,
    this.inputTrailingWidget,
    required this.chipBuilder,
    this.enabled = true,
  });

  @override
  State<ChipInput<T>> createState() => ChipInputState();
}

class ChipInputState<T> extends State<ChipInput<T>>
    with FormValueSupplier<List<T>, ChipInput<T>>
    implements _ChipProvider<T> {
  late FocusNode _focusNode;
  late ChipEditingController<T> _controller;
  late ValueNotifier<List<T>> _suggestions;
  final ValueNotifier<int> _selectedSuggestions = ValueNotifier(-1);
  final PopoverController _popoverController = PopoverController();

  @override
  Widget? buildChip(BuildContext context, T chip) {
    return _chipBuilder(chip);
  }

  BoxConstraints get _popoverConstraints {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ChipInputTheme>(context);
    return styleValue<BoxConstraints>(
      widgetValue: widget.popoverConstraints,
      themeValue: compTheme?.popoverConstraints,
      defaultValue: BoxConstraints(maxHeight: 300 * theme.scaling),
    );
  }

  bool get _useChips {
    final compTheme = ComponentTheme.maybeOf<ChipInputTheme>(context);
    return styleValue<bool>(
      widgetValue: widget.useChips,
      themeValue: compTheme?.useChips,
      defaultValue: true,
    );
  }

  @override
  void initState() {
    super.initState();
    _suggestions = ValueNotifier([]);
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? ChipEditingController<T>();
    _suggestions.addListener(_onSuggestionsChanged);
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
    formValue = widget.controller?.chips ?? [];
    if (widget.suggestions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
      });
    }
  }

  void _onTextChanged() {
    formValue = _controller.chips;
  }

  void _onFocusChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _onSuggestionsChanged();
    });
  }

  void _onSuggestionsChanged() {
    if (_suggestions.value.isEmpty || !_focusNode.hasFocus) {
      _popoverController.close();
    } else if (!_popoverController.hasOpenPopover &&
        _suggestions.value.isNotEmpty) {
      _popoverController.show(
        context: context,
        handler: const PopoverOverlayHandler(),
        builder: (context) {
          return buildPopover(context);
        },
        alignment: Alignment.topCenter,
        widthConstraint: PopoverConstraint.anchorFixedSize,
        dismissBackdropFocus: false,
        showDuration: Duration.zero,
        hideDuration: Duration.zero,
        offset: Offset(0, Theme.of(context).scaling * 4),
      );
    }
  }

  Widget? _chipBuilder(T chip) {
    if (!_useChips) {
      return widget.chipBuilder(context, chip);
    }
    return Chip(
      trailing: ChipButton(
        onPressed: () {
          _controller.removeChip(chip);
          widget.onChanged?.call(_controller.chips);
        },
        child: const Icon(LucideIcons.x),
      ),
      child: widget.chipBuilder(context, chip),
    );
  }

  @override
  void didUpdateWidget(covariant ChipInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {}
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
    if (!listEquals(widget.suggestions, _suggestions.value)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _suggestions.value = widget.suggestions;
      });
    }
    // if (!listEquals(widget.chips, oldWidget.chips)) {
    //   formValue = widget.chips;
    // }
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onTextChanged);
      _controller = widget.controller ?? ChipEditingController<T>();
      _controller.addListener(_onTextChanged);
      formValue = _controller.chips;
    }
  }

  Widget buildPopover(BuildContext context) {
    final theme = Theme.of(context);
    return TextFieldTapRegion(
      child: Data.inherit(
        data: this,
        child: ConstrainedBox(
          constraints: _popoverConstraints,
          child: OutlinedContainer(
            child: AnimatedBuilder(
              animation: Listenable.merge([_suggestions, _selectedSuggestions]),
              builder: (context, child) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(theme.scaling * 4),
                  children: [
                    for (int i = 0; i < _suggestions.value.length; i++)
                      SelectedButton(
                        style: const ButtonStyle.ghost(),
                        selectedStyle: const ButtonStyle.secondary(),
                        value: i == _selectedSuggestions.value,
                        onChanged: (value) {
                          if (value) {
                            widget.onSuggestionChosen?.call(i);
                            widget.onSuggestionChoosen?.call(i);
                            _controller.clear();
                            _selectedSuggestions.value = -1;
                            _popoverController.close();
                          }
                        },
                        child: Row(
                          children: [
                            if (widget.suggestionLeadingBuilder != null) ...[
                              widget.suggestionLeadingBuilder!(
                                  context, _suggestions.value[i]),
                              SizedBox(
                                  width:
                                      theme.scaling * 10), // Add spacing here
                            ],
                            Expanded(
                              child: widget.suggestionBuilder
                                      ?.call(context, _suggestions.value[i]) ??
                                  Text(_suggestions.value[i].toString())
                                      .normal()
                                      .small(),
                            ),
                            if (widget.suggestionTrailingBuilder != null) ...[
                              SizedBox(
                                  width:
                                      theme.scaling * 10), // Add spacing here
                              widget.suggestionTrailingBuilder!
                                      (context, _suggestions.value[i])
                                  .normal()
                                  .small(),
                            ],
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _popoverController.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _suggestions.removeListener(_onSuggestionsChanged);
    _controller.removeListener(_onTextChanged);
    super.dispose();
  }

  T? _handleSubmitted(String text) {
    T? result;
    if (_selectedSuggestions.value >= 0 &&
        _selectedSuggestions.value < _suggestions.value.length) {
      // A suggestion is selected, use it
      widget.onSuggestionChoosen?.call(_selectedSuggestions.value);
      widget.onSuggestionChosen?.call(_selectedSuggestions.value);
      result = _suggestions.value[_selectedSuggestions.value];
    } else if (text.isNotEmpty) {
      // No suggestion selected, use the entered text
      // widget.onSubmitted?.call(text);
      result = widget.onSubmitted(text);
    }
    _focusNode.requestFocus();
    _selectedSuggestions.value = -1;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Data<_ChipProvider<T>>.inherit(
      data: this,
      child: ListenableBuilder(
        listenable: _focusNode,
        builder: (context, child) {
          return FocusOutline(
            focused: _focusNode.hasFocus,
            borderRadius: theme.borderRadiusMd,
            child: child!,
          );
        },
        child: GestureDetector(
          onTap: () {
            _focusNode.requestFocus();
          },
          child: FocusableActionDetector(
            mouseCursor: SystemMouseCursors.text,
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.tab):
                  const SelectSuggestionIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowDown):
                  const NextSuggestionIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowUp):
                  const PreviousSuggestionIntent(),
            },
            actions: {
              SelectSuggestionIntent: CallbackAction(
                onInvoke: (intent) {
                  final index = _selectedSuggestions.value;
                  if (index >= 0 && index < _suggestions.value.length) {
                    widget.onSuggestionChosen?.call(index);
                    widget.onSuggestionChoosen?.call(index);
                    _controller.clearTextAtCursor();
                    _selectedSuggestions.value = -1;
                    _popoverController.close();
                    _controller.appendChipAtCursor(_suggestions.value[index]);
                  }
                },
              ),
              NextSuggestionIntent: CallbackAction(
                onInvoke: (intent) {
                  var index = _selectedSuggestions.value;
                  if (index < _suggestions.value.length - 1) {
                    _selectedSuggestions.value = index + 1;
                  } else if (_suggestions.value.isNotEmpty) {
                    _selectedSuggestions.value = 0;
                  }
                  return null;
                },
              ),
              PreviousSuggestionIntent: CallbackAction(
                onInvoke: (intent) {
                  var index = _selectedSuggestions.value;
                  if (index > 0) {
                    _selectedSuggestions.value = index - 1;
                  } else if (_suggestions.value.isNotEmpty) {
                    _selectedSuggestions.value = _suggestions.value.length - 1;
                  }
                  return null;
                },
              ),
            },
            child: ComponentTheme(
              data: const FocusOutlineTheme(
                  border: Border.fromBorderSide(BorderSide.none)),
              child: TextField(
                focusNode: _focusNode,
                initialValue: widget.initialText,
                inputFormatters: widget.inputFormatters,
                textInputAction: widget.textInputAction,
                enabled: widget.enabled,
                maxLines: 1,
                placeholder: widget.placeholder,
                onSubmitted: (value) {
                  _controller.insertChipAtCursor(_handleSubmitted);
                },
                controller: _controller,
                undoController: widget.undoHistoryController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didReplaceFormValue(List<T> value) {
    widget.onChanged?.call(value);
  }
}

class SelectSuggestionIntent extends Intent {
  const SelectSuggestionIntent();
}

class NextSuggestionIntent extends Intent {
  const NextSuggestionIntent();
}

class PreviousSuggestionIntent extends Intent {
  const PreviousSuggestionIntent();
}

// class _ChipSuggestionItem extends StatefulWidget {
//   final Widget suggestion;
//   final Widget? leading;
//   final Widget? trailing;
//   final bool selected;
//   final VoidCallback onSelected;
//
//   const _ChipSuggestionItem({
//     required this.suggestion,
//     this.leading,
//     this.trailing,
//     required this.selected,
//     required this.onSelected,
//   });
//
//   @override
//   State<_ChipSuggestionItem> createState() => _ChipSuggestionItemState();
// }
//
// class _ChipSuggestionItemState extends State<_ChipSuggestionItem> {
//   @override
//   void didUpdateWidget(covariant _ChipSuggestionItem oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selected != widget.selected) {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         if (!mounted) {
//           return;
//         }
//         if (widget.selected) {
//           Scrollable.ensureVisible(context);
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SelectedButton(
//       value: widget.selected,
//       onChanged: (value) {
//         if (value) {
//           widget.onSelected();
//         }
//       },
//       child: Row(
//         children: [
//           if (widget.leading != null) widget.leading!,
//           Expanded(child: widget.suggestion),
//           if (widget.trailing != null) widget.trailing!,
//         ],
//       ),
//     );
//   }
// }
