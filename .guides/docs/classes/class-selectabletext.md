---
title: "Class: SelectableText"
description: "A text widget that supports text selection by users."
---

```dart
/// A text widget that supports text selection by users.
///
/// Displays text (plain or styled) that users can select, copy, and interact with.
/// Provides cursor display, selection highlighting, and context menu support for
/// rich text interaction experiences.
///
/// Features:
/// - **Text Selection**: Click and drag to select text portions
/// - **Copy Support**: Built-in copy functionality via context menu
/// - **Cursor Display**: Optional cursor for indicating selection position
/// - **Rich Text**: Supports styled text via [TextSpan] (use `.rich` constructor)
/// - **Customizable**: Full control over cursor, selection, and interaction behavior
///
/// Usage Patterns:
///
/// **Basic Selectable Text**:
/// ```dart
/// SelectableText(
///   'Select this text!',
///   style: TextStyle(fontSize: 16),
/// )
/// ```
///
/// **Rich Text Selection**:
/// ```dart
/// SelectableText.rich(
///   TextSpan(
///     children: [
///       TextSpan(text: 'Bold ', style: TextStyle(fontWeight: FontWeight.bold)),
///       TextSpan(text: 'and normal text'),
///     ],
///   ),
/// )
/// ```
///
/// **Custom Cursor**:
/// ```dart
/// SelectableText(
///   'Text with custom cursor',
///   showCursor: true,
///   cursorColor: Colors.blue,
///   cursorWidth: 3.0,
/// )
/// ```
///
/// See also:
/// - [Text] for non-selectable text display
/// - [TextField] for editable text input
/// - [SelectableTextTheme] for theming selection appearance
class SelectableText extends StatelessWidget {
  /// Creates selectable text from a plain string.
  ///
  /// The [data] parameter is the text to display. All other parameters
  /// are optional and control various aspects of text rendering and selection.
  ///
  /// Parameters:
  /// - [data]: The text string to display (required)
  /// - [focusNode]: Focus node for keyboard interaction
  /// - [style]: Text style for the content
  /// - [strutStyle]: Strut style for line height
  /// - [textAlign]: How to align text horizontally
  /// - [textDirection]: Text direction (LTR or RTL)
  /// - [textScaler]: Text scaling factor
  /// - [showCursor]: Whether to show the cursor (defaults to `false`)
  /// - [autofocus]: Auto-focus on mount (defaults to `false`)
  /// - [minLines]: Minimum number of lines to occupy
  /// - [maxLines]: Maximum number of lines before scrolling
  /// - [cursorWidth]: Width of cursor (defaults to 2.0)
  /// - [cursorHeight]: Height of cursor (null = line height)
  /// - [cursorRadius]: Cursor corner radius
  /// - [cursorColor]: Cursor color
  /// - [selectionHeightStyle]: Selection box height behavior
  /// - [selectionWidthStyle]: Selection box width behavior
  /// - [dragStartBehavior]: When to start drag gestures
  /// - [enableInteractiveSelection]: Enable selection (defaults to `true`)
  /// - [selectionControls]: Custom selection toolbar controls
  /// - [onTap]: Callback when text is tapped
  /// - [scrollPhysics]: Scroll behavior physics
  /// - [semanticsLabel]: Semantic label for accessibility
  /// - [textHeightBehavior]: How to handle line heights
  /// - [textWidthBasis]: Basis for measuring text width
  /// - [onSelectionChanged]: Callback when selection changes
  /// - [useNativeContextMenu]: Use platform context menu (defaults to `false`)
  /// - [contextMenuBuilder]: Custom context menu builder
  /// - [magnifierConfiguration]: Text magnifier configuration
  const SelectableText(String this.data, {super.key, this.focusNode, this.style, this.strutStyle, this.textAlign, this.textDirection, this.textScaler, this.showCursor = false, this.autofocus = false, this.minLines, this.maxLines, this.cursorWidth = 2.0, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle = ui.BoxHeightStyle.tight, this.selectionWidthStyle = ui.BoxWidthStyle.tight, this.dragStartBehavior = DragStartBehavior.start, this.enableInteractiveSelection = true, this.selectionControls, this.onTap, this.scrollPhysics, this.semanticsLabel, this.textHeightBehavior, this.textWidthBasis, this.onSelectionChanged, this.useNativeContextMenu = false, this.contextMenuBuilder = _defaultContextMenuBuilder, this.magnifierConfiguration});
  /// Creates selectable text from a [TextSpan] for styled/rich text.
  ///
  /// Use this constructor when you need to display text with multiple styles,
  /// inline widgets, or complex formatting. The [textSpan] can contain nested
  /// spans with different styles, colors, and even tap handlers.
  ///
  /// Parameters are identical to the default constructor, except:
  /// - [textSpan]: The styled text span tree to display (required)
  /// - [data] is not available (use [textSpan] instead)
  ///
  /// Example:
  /// ```dart
  /// SelectableText.rich(
  ///   TextSpan(
  ///     text: 'Visit our ',
  ///     children: [
  ///       TextSpan(
  ///         text: 'website',
  ///         style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
  ///       ),
  ///       TextSpan(text: ' for more info'),
  ///     ],
  ///   ),
  /// )
  /// ```
  const SelectableText.rich(TextSpan this.textSpan, {super.key, this.focusNode, this.style, this.strutStyle, this.textAlign, this.textDirection, this.textScaler, this.showCursor = false, this.autofocus = false, this.minLines, this.maxLines, this.cursorWidth = 2.0, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle = ui.BoxHeightStyle.tight, this.selectionWidthStyle = ui.BoxWidthStyle.tight, this.dragStartBehavior = DragStartBehavior.start, this.enableInteractiveSelection = true, this.selectionControls, this.onTap, this.scrollPhysics, this.semanticsLabel, this.textHeightBehavior, this.textWidthBasis, this.onSelectionChanged, this.useNativeContextMenu = false, this.contextMenuBuilder = _defaultContextMenuBuilder, this.magnifierConfiguration});
  /// The plain text string to display.
  ///
  /// Either [data] or [textSpan] must be non-null, but not both.
  /// Used when constructing with the default constructor.
  final String? data;
  /// The styled text span to display.
  ///
  /// Either [data] or [textSpan] must be non-null, but not both.
  /// Used when constructing with the [SelectableText.rich] constructor.
  final TextSpan? textSpan;
  /// Focus node for managing keyboard focus.
  ///
  /// If `null`, a focus node is created internally.
  final FocusNode? focusNode;
  /// Whether to use the platform's native context menu.
  ///
  /// When `true`, uses the operating system's built-in context menu.
  /// When `false`, uses Flutter's custom context menu.
  final bool useNativeContextMenu;
  /// The text style to apply to the text.
  ///
  /// If `null`, uses the default text style from the theme.
  final TextStyle? style;
  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;
  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign? textAlign;
  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;
  /// {@macro flutter.painting.textPainter.textScaler}
  final TextScaler? textScaler;
  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;
  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;
  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;
  /// {@macro flutter.widgets.editableText.showCursor}
  final bool showCursor;
  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;
  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;
  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;
  /// Color of the text cursor.
  ///
  /// If null, defaults to the theme's cursor color.
  final Color? cursorColor;
  /// Defines the height of text selection boxes.
  ///
  /// See [ui.BoxHeightStyle] for available options.
  final ui.BoxHeightStyle selectionHeightStyle;
  /// Defines the width of text selection boxes.
  ///
  /// See [ui.BoxWidthStyle] for available options.
  final ui.BoxWidthStyle selectionWidthStyle;
  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;
  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;
  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;
  /// {@macro flutter.widgets.editableText.selectionEnabled}
  bool get selectionEnabled;
  /// Called when the user taps on this selectable text.
  ///
  /// The selectable text builds a [GestureDetector] to handle input events like tap,
  /// to trigger focus requests, to move the caret, adjust the selection, etc.
  /// Handling some of those events by wrapping the selectable text with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the selectable text's
  /// internal gesture detector, provide this callback.
  ///
  /// To be notified when the text field gains or loses the focus, provide a
  /// [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the
  /// selectable text's internal gesture detector, use a [Listener].
  final GestureTapCallback? onTap;
  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;
  /// {@macro flutter.widgets.Text.semanticsLabel}
  final String? semanticsLabel;
  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;
  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;
  /// {@macro flutter.widgets.editableText.onSelectionChanged}
  final SelectionChangedCallback? onSelectionChanged;
  /// {@macro flutter.widgets.EditableText.contextMenuBuilder}
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  /// The configuration for the magnifier used when the text is selected.
  ///
  /// By default, builds a [CupertinoTextMagnifier] on iOS and [TextMagnifier]
  /// on Android, and builds nothing on all other platforms. To suppress the
  /// magnifier, consider passing [TextMagnifierConfiguration.disabled].
  ///
  /// {@macro flutter.widgets.magnifier.intro}
  final TextMagnifierConfiguration? magnifierConfiguration;
  Widget build(BuildContext context);
}
```
