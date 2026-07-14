import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Function signature for building custom chip widgets in chip input fields.
///
/// Takes a [BuildContext] and chip data of type [T], returning a widget that
/// represents the chip visually. Allows complete customization of chip appearance
/// and behavior within chip input components.
typedef ChipWidgetBuilder<T> = Widget Function(BuildContext context, T chip);

/// An inline span representing a chip value inside a [ChipEditingController].
///
/// Unlike a plain [WidgetSpan], a [ChipSpan] also carries the underlying chip
/// [value]. This lets clipboard operations serialize the actual value instead
/// of the private-use placeholder codepoint that lays the chip out within the
/// editable text.
class ChipSpan<T> extends WidgetSpan {
  /// The value represented by this chip.
  final T value;

  /// Creates a [ChipSpan] wrapping [child] and carrying [value].
  const ChipSpan({
    required this.value,
    required super.child,
    super.alignment = PlaceholderAlignment.middle,
    super.baseline,
    super.style,
  });
}

/// Handles serialization of [ChipInput] content to and from the clipboard.
///
/// When content is copied out of a [ChipInput], the selection is provided as a
/// list of [InlineSpan]s in which chips appear as [ChipSpan]s.
/// [serializeClipboard] turns that into a plain [String] for the system
/// clipboard, and [deserializeClipboard] turns pasted text back into spans so
/// that chips can be reconstructed on paste.
///
/// Note: chips render as [ChipSpan]s (a [WidgetSpan] subclass), so the span
/// lists use [InlineSpan] rather than [TextSpan]; a [ChipSpan] is not a
/// [TextSpan].
abstract class ClipboardHandler<T> {
  /// Const constructor for subclasses.
  const ClipboardHandler();

  /// Converts pasted clipboard [content] into a list of spans to insert.
  ///
  /// Returned [ChipSpan]s are inserted as chips, while [TextSpan]s (and their
  /// text descendants) are inserted as plain text.
  List<InlineSpan> deserializeClipboard(String content);

  /// Converts the selected [content] into a plain string for the clipboard.
  ///
  /// Chips are provided as [ChipSpan]s so [ChipSpan.value] can be serialized
  /// instead of the internal placeholder character.
  String serializeClipboard(List<InlineSpan> content);
}

/// Default [ClipboardHandler] that serializes chips with [chipSerializer] (or
/// [Object.toString]) and pastes clipboard text as plain text.
class DefaultChipClipboardHandler<T> extends ClipboardHandler<T> {
  /// Converts a chip value into its clipboard string representation.
  ///
  /// Falls back to [Object.toString] when null.
  final String Function(T value)? chipSerializer;

  /// Separator inserted between two adjacent chips when serializing.
  final String chipSeparator;

  /// Creates a [DefaultChipClipboardHandler].
  const DefaultChipClipboardHandler({
    this.chipSerializer,
    this.chipSeparator = '',
  });

  @override
  List<InlineSpan> deserializeClipboard(String content) {
    return [TextSpan(text: content)];
  }

  @override
  String serializeClipboard(List<InlineSpan> content) {
    final buffer = StringBuffer();
    InlineSpan? previous;
    for (final span in content) {
      if (span is ChipSpan<T>) {
        if (previous is ChipSpan<T> && chipSeparator.isNotEmpty) {
          buffer.write(chipSeparator);
        }
        buffer.write(chipSerializer?.call(span.value) ?? span.value.toString());
      } else if (span is TextSpan) {
        buffer.write(span.text ?? '');
      }
      previous = span;
    }
    return buffer.toString();
  }
}

/// A [ClipboardHandler] that decorates chips with a [prefix] and/or [suffix].
///
/// On copy, each chip is written as `prefix + value + suffix`. On paste, the
/// same delimiters are detected to reconstruct chips, so tokens such as
/// `@username` (prefix `@`, no suffix) or `${variable}` (prefix `${`, suffix
/// `}`) round-trip as chips instead of plain text.
///
/// When [suffix] is null or empty, a chip token runs from [prefix] up to the
/// start of the next [prefix] (or the end of the string), so chip values may
/// contain whitespace but any plain text following a chip is absorbed into it.
/// When both delimiters are present, a token runs from [prefix] up to the first
/// following [suffix], which unambiguously supports chips mixed with plain text.
///
/// Providing a [delimiter] writes that separator between adjacent chips on copy
/// and treats it as an explicit token boundary on paste. This disambiguates
/// prefix-only mode: e.g. with `prefix: '@'` and `delimiter: ', '`, three chips
/// serialize as `@hello world, @something, @a` and paste back as three chips
/// even though the values contain whitespace.
///
/// Reconstructing chips on paste requires [chipDeserializer] to turn the inner
/// text back into a value of type [T]. When it is null, pasted text is inserted
/// verbatim as plain text (copy still applies the decoration). For string
/// chips, pass `chipDeserializer: (inner) => inner`.
///
/// When [escapeDecoration] is true, occurrences of the [prefix], [suffix] and
/// [escapeCharacter] inside chip values (and inside surrounding plain text) are
/// escaped on copy and unescaped on paste. This avoids ambiguity such as a chip
/// value `@chip` with prefix `@` serializing to `@@chip` and being read back as
/// the plain text `@` followed by a chip `chip`; with escaping it serializes to
/// `@\@chip` and round-trips as the single chip `@chip`.
class DecoratedChipClipboardHandler<T> extends ClipboardHandler<T> {
  /// Text prepended to each chip value when serializing, and used as the
  /// opening delimiter when detecting chips on paste.
  final String? prefix;

  /// Text appended to each chip value when serializing, and used as the
  /// closing delimiter when detecting chips on paste.
  final String? suffix;

  /// Converts a chip value into the inner text placed between [prefix] and
  /// [suffix]. Falls back to [Object.toString] when null.
  final String Function(T value)? chipSerializer;

  /// Converts the inner text of a detected token back into a chip value.
  ///
  /// When null, paste does not reconstruct chips and inserts plain text.
  final T Function(String inner)? chipDeserializer;

  /// Whether to escape [prefix], [suffix] and [escapeCharacter] occurrences so
  /// that delimiter characters appearing inside values or plain text do not get
  /// mistaken for chip boundaries when deserializing.
  final bool escapeDecoration;

  /// The character sequence used to escape delimiters when [escapeDecoration]
  /// is true. Defaults to a backslash.
  final String escapeCharacter;

  /// Separator written between adjacent chips on copy and consumed as a token
  /// boundary on paste. When null or empty, no separator is used.
  final String? delimiter;

  /// Whether to also escape plain (non-chip) text so that it is not accidentally
  /// split on a [delimiter] or mistaken for a chip because it happens to contain
  /// the [prefix]/[suffix].
  ///
  /// Requires [escapeDecoration]. Defaults to false, in which case plain text is
  /// copied verbatim and delimiter/prefix/suffix sequences appearing in it may
  /// be reinterpreted as chip boundaries on paste.
  final bool escapeNonChip;

  /// Creates a [DecoratedChipClipboardHandler].
  const DecoratedChipClipboardHandler({
    this.prefix,
    this.suffix,
    this.chipSerializer,
    this.chipDeserializer,
    this.escapeDecoration = true,
    this.escapeCharacter = r'\',
    this.delimiter,
    this.escapeNonChip = false,
  });

  /// Escapes [escapeCharacter], [prefix], [suffix] and [delimiter] occurrences
  /// in [value] by prefixing each with [escapeCharacter].
  String _escape(String value, String p, String s) {
    final esc = escapeCharacter;
    if (esc.isEmpty) return value;
    final d = delimiter ?? '';
    final buffer = StringBuffer();
    int i = 0;
    while (i < value.length) {
      if (value.startsWith(esc, i)) {
        buffer.write(esc);
        buffer.write(esc);
        i += esc.length;
      } else if (p.isNotEmpty && value.startsWith(p, i)) {
        buffer.write(esc);
        buffer.write(p);
        i += p.length;
      } else if (s.isNotEmpty && value.startsWith(s, i)) {
        buffer.write(esc);
        buffer.write(s);
        i += s.length;
      } else if (d.isNotEmpty && value.startsWith(d, i)) {
        buffer.write(esc);
        buffer.write(d);
        i += d.length;
      } else {
        buffer.write(value[i]);
        i++;
      }
    }
    return buffer.toString();
  }

  /// Reads the literal value of an escape sequence in [content] starting at
  /// [pos], where [content] starts with [escapeCharacter] at [pos]. Returns the
  /// unescaped literal and the index just past the consumed sequence.
  (String, int) _readEscaped(String content, int pos, String p, String s) {
    final esc = escapeCharacter;
    final d = delimiter ?? '';
    final int i = pos + esc.length;
    if (i >= content.length) {
      // Dangling escape character: drop it.
      return ('', i);
    }
    if (p.isNotEmpty && content.startsWith(p, i)) {
      return (p, i + p.length);
    }
    if (s.isNotEmpty && content.startsWith(s, i)) {
      return (s, i + s.length);
    }
    if (d.isNotEmpty && content.startsWith(d, i)) {
      return (d, i + d.length);
    }
    if (content.startsWith(esc, i)) {
      return (esc, i + esc.length);
    }
    return (content[i], i + 1);
  }

  bool _escaping(String p, String s) =>
      escapeDecoration &&
      escapeCharacter.isNotEmpty &&
      (p.isNotEmpty || s.isNotEmpty);

  @override
  String serializeClipboard(List<InlineSpan> content) {
    final buffer = StringBuffer();
    final p = prefix ?? '';
    final s = suffix ?? '';
    final d = delimiter ?? '';
    final escaping = _escaping(p, s);
    bool previousWasChip = false;
    for (final span in content) {
      if (span is ChipSpan<T>) {
        if (previousWasChip && d.isNotEmpty) {
          buffer.write(d);
        }
        final inner = chipSerializer?.call(span.value) ?? span.value.toString();
        buffer.write(p);
        buffer.write(escaping ? _escape(inner, p, s) : inner);
        buffer.write(s);
        previousWasChip = true;
      } else if (span is TextSpan) {
        final text = span.text ?? '';
        buffer.write(escaping && escapeNonChip ? _escape(text, p, s) : text);
        previousWasChip = false;
      }
    }
    return buffer.toString();
  }

  @override
  List<InlineSpan> deserializeClipboard(String content) {
    final parser = chipDeserializer;
    final p = prefix ?? '';
    final s = suffix ?? '';
    // Without a parser or an opening delimiter there is nothing to detect.
    if (parser == null || p.isEmpty) {
      return [TextSpan(text: content)];
    }
    final String d = delimiter ?? '';
    final bool escaping = _escaping(p, s);
    final List<InlineSpan> spans = [];
    final StringBuffer textBuffer = StringBuffer();

    void flushText() {
      if (textBuffer.isNotEmpty) {
        spans.add(TextSpan(text: textBuffer.toString()));
        textBuffer.clear();
      }
    }

    int i = 0;
    while (i < content.length) {
      // An escaped delimiter at the top level is literal text. Only unescape
      // here when plain text was escaped on copy ([escapeNonChip]); otherwise
      // the escape character is taken literally.
      if (escaping && escapeNonChip && content.startsWith(escapeCharacter, i)) {
        final (literal, next) = _readEscaped(content, i, p, s);
        textBuffer.write(literal);
        i = next;
        continue;
      }
      if (content.startsWith(p, i)) {
        final int innerStart = i + p.length;
        final StringBuffer inner = StringBuffer();
        int j = innerStart;
        bool closed = false;
        while (j < content.length) {
          if (escaping && content.startsWith(escapeCharacter, j)) {
            final (literal, next) = _readEscaped(content, j, p, s);
            inner.write(literal);
            j = next;
            continue;
          }
          if (s.isNotEmpty) {
            if (content.startsWith(s, j)) {
              j += s.length;
              closed = true;
              break;
            }
          } else if (d.isNotEmpty && content.startsWith(d, j)) {
            // No suffix: an explicit delimiter ends the token.
            break;
          } else if (content.startsWith(p, j)) {
            // No suffix: the token also ends at the start of the next prefixed
            // token, so adjacent chips such as `@test@hello@world` split back
            // into separate chips while values may still contain whitespace.
            break;
          }
          inner.write(content[j]);
          j++;
        }
        if (s.isNotEmpty && !closed) {
          // No closing delimiter: treat the prefix as literal text.
          textBuffer.write(p);
          i = innerStart;
          continue;
        }
        final String innerStr = inner.toString();
        if (innerStr.isEmpty) {
          // Empty token, e.g. an isolated delimiter: keep it as literal text.
          textBuffer.write(p);
          i = innerStart;
          continue;
        }
        flushText();
        spans.add(
          ChipSpan<T>(value: parser(innerStr), child: const SizedBox.shrink()),
        );
        i = j;
        // Consume a separator immediately following the chip, if present.
        if (d.isNotEmpty && content.startsWith(d, i)) {
          i += d.length;
        }
      } else {
        textBuffer.write(content[i]);
        i++;
      }
    }
    flushText();
    return spans;
  }
}

/// Theme configuration for [ChipInput] widget styling and behavior.
///
/// Defines visual properties and default behaviors for chip input components
/// including popover constraints and chip rendering preferences. Applied globally
/// through [ComponentTheme] or per-instance for customization.
class ChipInputTheme extends ComponentThemeData {
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
              children.add(ChipSpan<T>(
                value: chip as T,
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
            children.add(ChipSpan<T>(
              value: chip as T,
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

  /// Returns the spans covered by [selection], with chips as [ChipSpan]s.
  ///
  /// Runs of plain text become [TextSpan]s and each chip becomes a
  /// [ChipSpan] carrying its value. Used to serialize a selection to the
  /// clipboard so chips copy as their value instead of their placeholder
  /// codepoint.
  List<InlineSpan> getSelectionSpans(TextSelection selection) {
    final String text = value.text;
    if (!selection.isValid) return const [];
    final int start = selection.start.clamp(0, text.length);
    final int end = selection.end.clamp(0, text.length);
    final List<InlineSpan> spans = [];
    final StringBuffer buffer = StringBuffer();
    for (int i = start; i < end; i++) {
      int codeUnit = text.codeUnitAt(i);
      if (codeUnit >= _chipStart && codeUnit <= _chipEnd) {
        if (buffer.isNotEmpty) {
          spans.add(TextSpan(text: buffer.toString()));
          buffer.clear();
        }
        T? chip = _chipMap[codeUnit - _chipStart];
        if (chip != null) {
          spans.add(ChipSpan<T>(value: chip, child: const SizedBox.shrink()));
        }
      } else {
        buffer.writeCharCode(codeUnit);
      }
    }
    if (buffer.isNotEmpty) {
      spans.add(TextSpan(text: buffer.toString()));
    }
    return spans;
  }

  /// Replaces the current selection with the given [spans].
  ///
  /// [ChipSpan]s are inserted as chips (registered in the chip map), while
  /// [TextSpan]s and their text descendants are inserted as plain text. If the
  /// selection is not valid the spans are appended at the end. Used to
  /// reconstruct pasted content produced by a [ClipboardHandler].
  void replaceSelectionWithSpans(List<InlineSpan> spans) {
    final String text = value.text;
    final TextSelection selection = value.selection;
    final int start = selection.isValid ? selection.start : text.length;
    final int end = selection.isValid ? selection.end : text.length;
    final StringBuffer buffer = StringBuffer();
    buffer.write(text.substring(0, start));
    for (final span in spans) {
      _writeSpan(buffer, span);
    }
    final int newOffset = buffer.length;
    buffer.write(text.substring(end));
    super.value = TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: newOffset),
    );
    _updateText(buffer.toString());
  }

  void _writeSpan(StringBuffer buffer, InlineSpan span) {
    if (span is ChipSpan<T>) {
      int chipIndex = _nextAvailableChipIndex;
      buffer.writeCharCode(_chipStart + chipIndex);
      _chipMap[chipIndex] = span.value;
    } else if (span is TextSpan) {
      if (span.text != null) {
        buffer.write(span.text);
      }
      final children = span.children;
      if (children != null) {
        for (final child in children) {
          _writeSpan(buffer, child);
        }
      }
    }
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

  /// Handles serializing copied chips and deserializing pasted content.
  ///
  /// Defaults to a [DefaultChipClipboardHandler] that copies each chip using
  /// its [Object.toString] and pastes clipboard text as plain text.
  final ClipboardHandler<T>? clipboardHandler;

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
    this.clipboardHandler,
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

  ClipboardHandler<T> get _clipboardHandler =>
      widget.clipboardHandler ?? DefaultChipClipboardHandler<T>();

  void _handleCopySelection(CopySelectionTextIntent intent) {
    final selection = _controller.selection;
    if (!selection.isValid || selection.isCollapsed) {
      return;
    }
    final spans = _controller.getSelectionSpans(selection);
    final serialized = _clipboardHandler.serializeClipboard(spans);
    if (serialized.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: serialized));
    }
    // A collapsing intent (i.e. cut) removes the selection after copying.
    if (intent.collapseSelection) {
      final text = _controller.value.text;
      final newText = selection.textBefore(text) + selection.textAfter(text);
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start),
      );
      widget.onChipsChanged?.call(_controller.chips);
    }
  }

  Future<void> _handlePaste(PasteTextIntent intent) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final content = data?.text;
    if (content == null || content.isEmpty) {
      return;
    }
    if (!mounted) {
      return;
    }
    final spans = _clipboardHandler.deserializeClipboard(content);
    _controller.replaceSelectionWithSpans(spans);
    widget.onChipsChanged?.call(_controller.chips);
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
              CopySelectionTextIntent: CallbackAction<CopySelectionTextIntent>(
                onInvoke: (intent) {
                  _handleCopySelection(intent);
                  return null;
                },
              ),
              PasteTextIntent: CallbackAction<PasteTextIntent>(
                onInvoke: (intent) {
                  _handlePaste(intent);
                  return null;
                },
              ),
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
              // Submitting a chip on a single-line field would otherwise fall
              // back to the default editing-complete behavior, which unfocuses
              // the field. Keep focus so the user can keep adding chips, unless
              // the caller supplied their own onEditingComplete.
              onEditingComplete: () =>
                  widget.onEditingComplete ??
                  () {
                    _controller.clearComposing();
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
