---
title: "Extension: TextExtension"
description: "Extension providing text styling modifiers for widgets."
---

```dart
/// Extension providing text styling modifiers for widgets.
///
/// This extension adds a fluent API for applying text styles to widgets.
/// Each property returns a [TextModifier] that can be further chained.
///
/// Example:
/// ```dart
/// Text('Hello').sans.large.bold.muted
/// ```
extension TextExtension on Widget {
  /// Applies sans-serif font family.
  TextModifier get sans;
  /// Applies monospace font family.
  TextModifier get mono;
  /// Applies extra-small font size.
  TextModifier get xSmall;
  /// Applies small font size.
  TextModifier get small;
  /// Applies base (default) font size.
  TextModifier get base;
  /// Applies large font size.
  TextModifier get large;
  /// Applies extra-large font size.
  TextModifier get xLarge;
  /// Applies 2x large font size.
  TextModifier get x2Large;
  /// Applies 3x large font size.
  TextModifier get x3Large;
  /// Applies 4x large font size.
  TextModifier get x4Large;
  /// Applies 5x large font size.
  TextModifier get x5Large;
  /// Applies 6x large font size.
  TextModifier get x6Large;
  /// Applies 7x large font size.
  TextModifier get x7Large;
  /// Applies 8x large font size.
  TextModifier get x8Large;
  /// Applies 9x large font size.
  TextModifier get x9Large;
  /// Applies thin font weight (100).
  TextModifier get thin;
  /// Applies extra-light font weight (200).
  TextModifier get extraLight;
  /// Applies light font weight (300).
  TextModifier get light;
  /// Applies normal font weight (400).
  TextModifier get normal;
  /// Applies medium font weight (500).
  TextModifier get medium;
  /// Applies semi-bold font weight (600).
  TextModifier get semiBold;
  /// Applies bold font weight (700).
  TextModifier get bold;
  /// Applies extra-bold font weight (800).
  TextModifier get extraBold;
  /// Applies black font weight (900).
  TextModifier get black;
  /// Applies italic font style.
  TextModifier get italic;
  /// Applies underline text decoration.
  TextModifier get underline;
  /// Applies muted foreground color.
  TextModifier get muted;
  /// Applies primary foreground color.
  TextModifier get primaryForeground;
  /// Applies secondary foreground color.
  TextModifier get secondaryForeground;
  /// Applies heading 1 style.
  TextModifier get h1;
  /// Applies heading 2 style with bottom border.
  TextModifier get h2;
  /// Applies heading 3 style.
  TextModifier get h3;
  /// Applies heading 4 style.
  TextModifier get h4;
  /// Applies paragraph style with top spacing.
  TextModifier get p;
  /// Applies paragraph style for the first paragraph (no top spacing).
  TextModifier get firstP;
  /// Applies block quote style with left border.
  TextModifier get blockQuote;
  /// Applies list item style with bullet point.
  ///
  /// Automatically adds a bullet point and indents nested list items.
  TextModifier get li;
  /// Applies inline code style with background and padding.
  TextModifier get inlineCode;
  /// Applies lead paragraph style with muted color.
  TextModifier get lead;
  /// Applies large text style.
  TextModifier get textLarge;
  /// Applies small text style.
  TextModifier get textSmall;
  /// Applies muted text style with muted color.
  TextModifier get textMuted;
  /// Constrains text to a single line without wrapping.
  TextModifier get singleLine;
  /// Applies ellipsis overflow to text.
  TextModifier get ellipsis;
  /// Centers text horizontally.
  TextModifier get textCenter;
  /// Right-aligns text.
  TextModifier get textRight;
  /// Left-aligns text.
  TextModifier get textLeft;
  /// Justifies text alignment.
  TextModifier get textJustify;
  /// Aligns text to the start (left in LTR, right in RTL).
  TextModifier get textStart;
  /// Aligns text to the end (right in LTR, left in RTL).
  TextModifier get textEnd;
  /// Applies primary foreground color modifier.
  TextModifier get modify;
  /// Applies standard foreground color.
  TextModifier get foreground;
  /// Appends an inline span to the current text widget.
  ///
  /// Allows chaining multiple text spans together. Works with [Text],
  /// [SelectableText], and [RichText] widgets.
  ///
  /// Parameters:
  /// - [span] (`InlineSpan`, required): The span to append.
  ///
  /// Returns: `Widget` — a rich text widget with the appended span.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello ').then(TextSpan(text: 'World'))
  /// ```
  Widget then(InlineSpan span);
  /// Appends a text span to the current text widget.
  ///
  /// Convenience method for appending plain text.
  ///
  /// Parameters:
  /// - [text] (`String`, required): Text to append.
  ///
  /// Returns: `Widget` — a rich text widget with the appended text.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello ').thenText('World')
  /// ```
  Widget thenText(String text);
  /// Appends inline code to the current text widget.
  ///
  /// The appended text is styled as inline code with background.
  ///
  /// Parameters:
  /// - [text] (`String`, required): Code text to append.
  ///
  /// Returns: `Widget` — a rich text widget with the appended code.
  ///
  /// Example:
  /// ```dart
  /// Text('Use ').thenInlineCode('myFunction()')
  /// ```
  Widget thenInlineCode(String text);
  /// Appends a button widget to the current text widget.
  ///
  /// Creates an inline button within the text flow.
  ///
  /// Parameters:
  /// - [onPressed] (`VoidCallback`, required): Button press handler.
  /// - [child] (`Widget`, required): Button content.
  ///
  /// Returns: `Widget` — a rich text widget with the appended button.
  ///
  /// Example:
  /// ```dart
  /// Text('Click ').thenButton(
  ///   onPressed: () => print('clicked'),
  ///   child: Text('here'),
  /// )
  /// ```
  Widget thenButton({required VoidCallback onPressed, required Widget child});
}
```
