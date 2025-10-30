import 'package:flutter/services.dart';
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
  /// Whether to render selected items as interactive chip widgets by default.
  ///
  /// When true, selected items appear as dismissible chip widgets with close buttons.
  /// When false, items appear as simple text tokens. Individual [ChipInput] widgets
  /// can override this default behavior.
  final bool? useChips;

  /// The spacing between chips.
  final double? spacing;

  /// Creates a [ChipInputTheme].
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// The theme can be applied globally or to specific chip input instances.
  const ChipInputTheme({
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
      useChips: useChips == null ? this.useChips : useChips(),
      spacing: spacing == null ? this.spacing : spacing(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChipInputTheme &&
        other.useChips == useChips &&
        other.spacing == spacing;
  }

  @override
  int get hashCode => Object.hash(useChips, spacing);
}

/// A text editing controller that supports inline chip widgets.
///
/// Extends [TextEditingController] to manage text with embedded chip objects
/// represented by special Unicode codepoints from the Private Use Area (U+E000-U+F8FF).
/// Each chip is mapped to a unique codepoint allowing up to 6400 chips per controller.
///
/// Use this when you need to display removable tags or tokens within a text field,
/// such as email recipients, keywords, or selected items.
///
/// Example:
/// ```dart
/// final controller = ChipEditingController<String>(
///   initialChips: ['tag1', 'tag2'],
/// );
/// ```
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

  /// Factory constructor creating a chip editing controller.
  ///
  /// Optionally initializes with [text] and [initialChips].
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

  /// Returns an unmodifiable list of all chips in the controller.
  List<T> get chips => List.unmodifiable(_chipMap.values);

  /// Sets the chips in this controller, replacing all existing chips.
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

  /// Removes all chips from the controller, leaving only plain text.
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

  /// Returns the plain text without chip characters.
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

  /// Returns the text at the current cursor position.
  String get textAtCursor {
    final boundaries = _findChipTextBoundaries(selection.baseOffset);
    return value.text.substring(boundaries.start, boundaries.end);
  }

  /// Inserts a chip at the cursor position by converting the text at cursor.
  ///
  /// Uses [chipConverter] to convert the text at cursor to a chip.
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

  /// Clears the text at the current cursor position.
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

  /// Appends a chip at the end of the chip sequence.
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

  /// Appends a chip at the current cursor position.
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

  /// Inserts a chip at a specific position in the text.
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

  /// Removes the specified chip from the controller.
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

/// Callback type for converting text to a chip.
///
/// Takes the chip text and returns a chip object, or null if conversion fails.
typedef ChipSubmissionCallback<T> = T? Function(String chipText);

/// A text input widget that supports inline chip elements.
///
/// Allows users to create chip tokens within a text field, useful for
/// tags, email recipients, or any multi-item input scenario.
class ChipInput<T> extends TextInputStatefulWidget {
  /// Checks if a code unit represents a chip character.
  static bool isChipUnicode(int codeUnit) {
    return codeUnit >= ChipEditingController._chipStart &&
        codeUnit <= ChipEditingController._chipEnd;
  }

  /// Checks if a string character is a chip character.
  static bool isChipCharacter(String character) {
    if (character.isEmpty) return false;
    int codeUnit = character.codeUnitAt(0);
    return isChipUnicode(codeUnit);
  }

  /// Builder function for creating chip widgets.
  final ChipWidgetBuilder<T> chipBuilder;

  /// Callback to convert text into a chip object.
  final ChipSubmissionCallback<T> onChipSubmitted;

  /// Callback invoked when the list of chips changes.
  final ValueChanged<List<T>>? onChipsChanged;

  /// Whether to display items as visual chips (defaults to theme setting).
  final bool? useChips;

  /// Initial chips to display in the input.
  final List<T>? initialChips;

  /// Whether to automatically insert autocomplete suggestions as chips.
  final bool autoInsertSuggestion;

  /// Creates a chip input widget.
  const ChipInput({
    super.key,
    super.groupId,
    ChipEditingController<T>? super.controller,
    super.focusNode,
    super.decoration,
    super.padding,
    super.placeholder,
    super.crossAxisAlignment,
    super.clearButtonSemanticLabel,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly,
    super.showCursor,
    super.autofocus,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onTapOutside,
    super.onTapUpOutside,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorOpacityAnimates,
    super.cursorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.keyboardAppearance,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.dragStartBehavior,
    super.scrollController,
    super.scrollPhysics,
    super.onTap,
    super.autofillHints,
    super.clipBehavior,
    super.restorationId,
    super.stylusHandwritingEnabled,
    super.enableIMEPersonalizedLearning,
    super.contentInsertionConfiguration,
    super.contextMenuBuilder,
    super.initialValue,
    super.hintText,
    super.border,
    super.borderRadius,
    super.filled,
    super.statesController,
    super.magnifierConfiguration,
    super.spellCheckConfiguration,
    super.undoController,
    super.features,
    super.submitFormatters,
    super.skipInputFeatureFocusTraversal,
    required this.chipBuilder,
    required this.onChipSubmitted,
    this.autoInsertSuggestion = true,
    this.onChipsChanged,
    this.useChips,
    this.initialChips,
  });

  @override
  ChipEditingController<T>? get controller =>
      super.controller as ChipEditingController<T>?;

  @override
  State<ChipInput<T>> createState() => ChipInputState();
}

/// State class for [ChipInput].
///
/// Manages the chip input's internal state and chip rendering.
class ChipInputState<T> extends State<ChipInput<T>>
    with FormValueSupplier<List<T>, ChipInput<T>>
    implements _ChipProvider<T> {
  late ChipEditingController<T> _controller;

  @override
  Widget? buildChip(BuildContext context, T chip) {
    return _chipBuilder(chip);
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
    _controller = widget.controller ??
        ChipEditingController<T>(
          initialChips: widget.initialChips,
          text: widget.initialValue ?? '',
        );
    _controller.addListener(_onTextChanged);
    formValue = widget.controller?.chips ?? [];
  }

  void _onTextChanged() {
    formValue = _controller.chips;
  }

  Widget? _chipBuilder(T chip) {
    if (!_useChips) {
      return widget.chipBuilder(context, chip);
    }
    return Chip(
      trailing: ChipButton(
        onPressed: () {
          _controller.removeChip(chip);
          widget.onChipsChanged?.call(_controller.chips);
        },
        child: const Icon(LucideIcons.x),
      ),
      child: widget.chipBuilder(context, chip),
    );
  }

  @override
  void didUpdateWidget(covariant ChipInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onTextChanged);
      _controller = widget.controller ?? ChipEditingController<T>();
      _controller.addListener(_onTextChanged);
      formValue = _controller.chips;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Data<_ChipProvider<T>>.inherit(
        data: this,
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.enter): const ChipSubmitIntent(),
          },
          child: Actions(
            actions: {
              if (widget.autoInsertSuggestion)
                AutoCompleteIntent: Action.overridable(
                  defaultAction: CallbackAction<AutoCompleteIntent>(
                    onInvoke: (intent) {
                      _controller.insertChipAtCursor(
                          (text) => widget.onChipSubmitted(intent.suggestion));
                      widget.onChipsChanged?.call(_controller.chips);
                      return;
                    },
                  ),
                  context: context,
                ),
              ChipSubmitIntent: Action.overridable(
                defaultAction: CallbackAction<ChipSubmitIntent>(
                  onInvoke: (intent) {
                    _controller.insertChipAtCursor(
                        (text) => widget.onChipSubmitted(text));
                    widget.onChipsChanged?.call(_controller.chips);
                    return;
                  },
                ),
                context: context,
              ),
            },
            child: widget.copyWith(
              controller: () => _controller,
              onSubmitted: () => (value) {
                _controller.insertChipAtCursor(widget.onChipSubmitted);
              },
              onChanged: () => (text) {
                widget.onChanged?.call(_controller.plainText);
              },
            ),
          ),
        ));
  }

  @override
  void didReplaceFormValue(List<T> value) {
    widget.onChipsChanged?.call(value);
  }
}

/// Intent for submitting a chip in the chip input.
class ChipSubmitIntent extends Intent {
  /// Creates a chip submit intent.
  const ChipSubmitIntent();
}
