---
title: "Class: TextField"
description: "A highly customizable single-line text input widget with extensive feature support."
---

```dart
/// A highly customizable single-line text input widget with extensive feature support.
///
/// [TextField] provides a comprehensive text editing experience with support for
/// a wide range of input types, validation, formatting, and interactive features.
/// It serves as the foundation for most text input scenarios in the shadcn_flutter
/// design system, offering both basic text input and advanced capabilities through
/// its feature system.
///
/// Key features:
/// - Comprehensive text input with platform-native behavior
/// - Extensive customization through [InputFeature] system
/// - Built-in support for validation and formatting
/// - Configurable appearance with theming support
/// - Context menu customization and clipboard operations
/// - Keyboard shortcuts and accessibility support
/// - Form integration with automatic value management
///
/// The widget supports various input modes:
/// - Single-line text input (default)
/// - Obscured text for passwords
/// - Formatted input with custom formatters
/// - Auto-completion and suggestions
/// - Numeric input with spinners
///
/// Input features can be added to enhance functionality:
/// - Clear button for easy text clearing
/// - Password visibility toggle
/// - Copy/paste operations
/// - Auto-complete suggestions
/// - Validation indicators
/// - Custom leading/trailing widgets
///
/// Example:
/// ```dart
/// TextField(
///   hintText: 'Enter your email',
///   keyboardType: TextInputType.emailAddress,
///   features: [
///     InputClearFeature(),
///     InputRevalidateFeature(),
///   ],
///   onChanged: (text) => _handleTextChange(text),
/// );
/// ```
class TextField extends TextInputStatefulWidget {
  /// Returns a native platform context menu builder.
  ///
  /// Uses the platform's default text selection toolbar.
  static EditableTextContextMenuBuilder nativeContextMenuBuilder();
  /// Returns a Cupertino-style context menu builder.
  ///
  /// Uses iOS-style text selection toolbar.
  static EditableTextContextMenuBuilder cupertinoContextMenuBuilder();
  /// Returns a Material Design context menu builder.
  ///
  /// Uses Material Design text selection toolbar.
  static EditableTextContextMenuBuilder materialContextMenuBuilder();
  /// Creates a text input field widget.
  ///
  /// A comprehensive text field implementation with support for various input
  /// types, validation, formatting, and interactive features. All parameters
  /// are forwarded to the parent [TextInputStatefulWidget] constructor.
  ///
  /// This constructor provides extensive customization options matching Flutter's
  /// [EditableText] while adding custom features like input decorations, features,
  /// and form integration.
  ///
  /// Example:
  /// ```dart
  /// TextField(
  ///   controller: myController,
  ///   hintText: 'Enter text',
  ///   keyboardType: TextInputType.text,
  ///   maxLines: 3,
  ///   onChanged: (value) => print(value),
  /// )
  /// ```
  ///
  /// See [TextInputStatefulWidget] and [TextInput] for parameter details.
  const TextField({super.key, super.groupId, super.controller, super.initialValue, super.focusNode, super.undoController, super.decoration, super.padding, super.placeholder, super.crossAxisAlignment, super.clearButtonSemanticLabel, super.keyboardType, super.textInputAction, super.textCapitalization, super.style, super.strutStyle, super.textAlign, super.textAlignVertical, super.textDirection, super.readOnly, super.showCursor, super.autofocus, super.obscuringCharacter, super.obscureText, super.autocorrect, super.smartDashesType, super.smartQuotesType, super.enableSuggestions, super.maxLines, super.minLines, super.expands, super.maxLength, super.maxLengthEnforcement, super.onChanged, super.onEditingComplete, super.onSubmitted, super.onTapOutside, super.onTapUpOutside, super.inputFormatters, super.enabled, super.cursorWidth, super.cursorHeight, super.cursorRadius, super.cursorOpacityAnimates, super.cursorColor, super.selectionHeightStyle, super.selectionWidthStyle, super.keyboardAppearance, super.scrollPadding, super.enableInteractiveSelection, super.selectionControls, super.dragStartBehavior, super.scrollController, super.scrollPhysics, super.onTap, super.autofillHints, super.clipBehavior, super.restorationId, super.stylusHandwritingEnabled, super.enableIMEPersonalizedLearning, super.contentInsertionConfiguration, super.contextMenuBuilder = defaultContextMenuBuilder, super.hintText, super.border, super.borderRadius, super.filled, super.statesController, super.magnifierConfiguration, super.spellCheckConfiguration, super.features, super.submitFormatters, super.skipInputFeatureFocusTraversal});
  /// Default context menu builder for editable text.
  ///
  /// Builds the standard context menu for text selection operations.
  static Widget defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState);
  /// Default spell check suggestions toolbar builder.
  ///
  /// Builds the toolbar showing spell check suggestions.
  static Widget defaultSpellCheckSuggestionsToolbarBuilder(BuildContext context, EditableTextState editableTextState);
  State<TextField> createState();
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
