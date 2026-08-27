---
title: "Class: DecoratedChipClipboardHandler"
description: "A [ClipboardHandler] that decorates chips with a [prefix] and/or [suffix].   On copy, each chip is written as `prefix + value + suffix`. On paste, the  same delimiters are detected to reconstruct chips, so tokens such as  `@username` (prefix `@`, no suffix) or `${variable}` (prefix `${`, suffix  `}`) round-trip as chips instead of plain text.   When [suffix] is null or empty, a chip token runs from [prefix] up to the  start of the next [prefix] (or the end of the string), so chip values may  contain whitespace but any plain text following a chip is absorbed into it.  When both delimiters are present, a token runs from [prefix] up to the first  following [suffix], which unambiguously supports chips mixed with plain text.   Providing a [delimiter] writes that separator between adjacent chips on copy  and treats it as an explicit token boundary on paste. This disambiguates  prefix-only mode: e.g. with `prefix: '@'` and `delimiter: ', '`, three chips  serialize as `@hello world, @something, @a` and paste back as three chips  even though the values contain whitespace.   Reconstructing chips on paste requires [chipDeserializer] to turn the inner  text back into a value of type [T]. When it is null, pasted text is inserted  verbatim as plain text (copy still applies the decoration). For string  chips, pass `chipDeserializer: (inner) => inner`.   When [escapeDecoration] is true, occurrences of the [prefix], [suffix] and  [escapeCharacter] inside chip values (and inside surrounding plain text) are  escaped on copy and unescaped on paste. This avoids ambiguity such as a chip  value `@chip` with prefix `@` serializing to `@@chip` and being read back as  the plain text `@` followed by a chip `chip`; with escaping it serializes to  `@\\@chip` and round-trips as the single chip `@chip`."
---

```dart
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
  const DecoratedChipClipboardHandler({this.prefix, this.suffix, this.chipSerializer, this.chipDeserializer, this.escapeDecoration = true, this.escapeCharacter = r'\', this.delimiter, this.escapeNonChip = false});
  String serializeClipboard(List<InlineSpan> content);
  List<InlineSpan> deserializeClipboard(String content);
}
```
