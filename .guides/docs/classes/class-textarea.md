---
title: "Class: TextArea"
description: "A multi-line text input widget with resizable dimensions and comprehensive styling."
---

```dart
/// A multi-line text input widget with resizable dimensions and comprehensive styling.
///
/// [TextArea] provides an enhanced text editing experience with support for
/// multi-line input, dynamic resizing capabilities, and extensive customization
/// options. It supports both expandable height and width modes, allowing users
/// to adjust the text area size by dragging resize handles.
///
/// Key features:
/// - Multi-line text editing with optional height/width expansion
/// - Configurable minimum and maximum dimensions
/// - Support for leading and trailing widgets
/// - Comprehensive text formatting and input validation
/// - Integration with Flutter's text editing ecosystem
/// - Customizable appearance through theming
///
/// The widget can operate in several resize modes:
/// - Fixed size: When both [expandableHeight] and [expandableWidth] are false
/// - Expandable height: When [expandableHeight] is true, allows vertical resizing
/// - Expandable width: When [expandableWidth] is true, allows horizontal resizing
/// - Fully expandable: When both expansion modes are enabled
///
/// Example:
/// ```dart
/// TextArea(
///   placeholder: Text('Enter your message...'),
///   expandableHeight: true,
///   minHeight: 100,
///   maxHeight: 300,
///   onChanged: (text) => print('Text: $text'),
/// );
/// ```
class TextArea extends TextInputStatefulWidget {
  /// Whether the text area can be resized vertically by the user.
  ///
  /// When true, displays a resize handle that allows users to adjust
  /// the height of the text area within the specified min/max constraints.
  final bool expandableHeight;
  /// Whether the text area can be resized horizontally by the user.
  ///
  /// When true, displays a resize handle that allows users to adjust
  /// the width of the text area within the specified min/max constraints.
  final bool expandableWidth;
  /// Initial height of the text area in logical pixels.
  ///
  /// Sets the starting height when the text area is first displayed.
  /// If [expandableHeight] is true, users can resize from this initial value.
  final double initialHeight;
  /// Initial width of the text area in logical pixels.
  ///
  /// Sets the starting width when the text area is first displayed.
  /// If [expandableWidth] is true, users can resize from this initial value.
  final double initialWidth;
  /// Callback invoked when the text area height changes.
  ///
  /// Called when the user resizes the text area vertically. The callback
  /// receives the new height value in logical pixels.
  final ValueChanged<double>? onHeightChanged;
  /// Callback invoked when the text area width changes.
  ///
  /// Called when the user resizes the text area horizontally. The callback
  /// receives the new width value in logical pixels.
  final ValueChanged<double>? onWidthChanged;
  /// Minimum allowed width in logical pixels.
  ///
  /// Prevents the text area from being resized below this width value.
  /// Only applies when [expandableWidth] is true.
  final double minWidth;
  /// Minimum allowed height in logical pixels.
  ///
  /// Prevents the text area from being resized below this height value.
  /// Only applies when [expandableHeight] is true.
  final double minHeight;
  /// Maximum allowed width in logical pixels.
  ///
  /// Prevents the text area from being resized above this width value.
  /// Only applies when [expandableWidth] is true.
  final double maxWidth;
  /// Maximum allowed height in logical pixels.
  ///
  /// Prevents the text area from being resized above this height value.
  /// Only applies when [expandableHeight] is true.
  final double maxHeight;
  /// Creates a [TextArea] with comprehensive configuration options.
  ///
  /// The text area supports both controlled and uncontrolled modes. Use
  /// [controller] for controlled mode or [initialValue] for uncontrolled mode.
  /// The text area can be configured for resizing, styling, and various
  /// text input behaviors.
  ///
  /// Parameters:
  /// - [expandableHeight] (bool, default: false): Enable vertical resizing
  /// - [expandableWidth] (bool, default: false): Enable horizontal resizing
  /// - [initialHeight] (double, default: 100): Starting height in pixels
  /// - [initialWidth] (double, default: double.infinity): Starting width in pixels
  /// - [enabled] (bool, default: true): Whether the text area accepts input
  /// - [readOnly] (bool, default: false): Whether the text is read-only
  /// - [obscureText] (bool, default: false): Whether to hide the text
  /// - [obscuringCharacter] (String, default: '•'): Character for hiding text
  /// - [textAlign] (TextAlign, default: TextAlign.start): Horizontal text alignment
  /// - [minWidth] (double, default: 100): Minimum width constraint
  /// - [minHeight] (double, default: 100): Minimum height constraint
  /// - [maxWidth] (double, default: double.infinity): Maximum width constraint
  /// - [maxHeight] (double, default: double.infinity): Maximum height constraint
  /// - [textAlignVertical] (TextAlignVertical, default: top): Vertical text alignment
  /// - [clipBehavior] (Clip, default: Clip.hardEdge): Content clipping behavior
  /// - [autofocus] (bool, default: false): Whether to auto-focus on creation
  ///
  /// Example:
  /// ```dart
  /// TextArea(
  ///   placeholder: Text('Enter your message'),
  ///   expandableHeight: true,
  ///   minHeight: 100,
  ///   maxHeight: 300,
  ///   onChanged: (text) => _handleTextChange(text),
  /// );
  /// ```
  const TextArea({super.key, super.groupId, super.controller, super.focusNode, super.decoration, super.padding, super.placeholder, super.crossAxisAlignment, super.clearButtonSemanticLabel, super.keyboardType, super.textInputAction, super.textCapitalization, super.style, super.strutStyle, super.textAlign, super.textAlignVertical, super.textDirection, super.readOnly, super.showCursor, super.autofocus, super.obscuringCharacter, super.obscureText, super.autocorrect, super.smartDashesType, super.smartQuotesType, super.enableSuggestions, super.maxLines, super.minLines, super.expands, super.maxLength, super.maxLengthEnforcement, super.onChanged, super.onEditingComplete, super.onSubmitted, super.onTapOutside, super.onTapUpOutside, super.inputFormatters, super.enabled, super.cursorWidth, super.cursorHeight, super.cursorRadius, super.cursorOpacityAnimates, super.cursorColor, super.selectionHeightStyle, super.selectionWidthStyle, super.keyboardAppearance, super.scrollPadding, super.enableInteractiveSelection, super.selectionControls, super.dragStartBehavior, super.scrollController, super.scrollPhysics, super.onTap, super.autofillHints, super.clipBehavior, super.restorationId, super.stylusHandwritingEnabled, super.enableIMEPersonalizedLearning, super.contentInsertionConfiguration, super.contextMenuBuilder, super.initialValue, super.hintText, super.border, super.borderRadius, super.filled, super.statesController, super.magnifierConfiguration, super.spellCheckConfiguration, super.undoController, super.features, super.submitFormatters, super.skipInputFeatureFocusTraversal, this.expandableHeight = false, this.expandableWidth = false, this.initialHeight = 100, this.initialWidth = double.infinity, this.onHeightChanged, this.onWidthChanged, this.minWidth = 100, this.minHeight = 100, this.maxWidth = double.infinity, this.maxHeight = double.infinity});
  State<TextArea> createState();
}
```
