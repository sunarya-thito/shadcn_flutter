import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as m;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template selectable_text_theme}
/// Theme data for [SelectableText] to customize cursor and selection behavior.
/// {@endtemplate}
class SelectableTextTheme {
  /// Width of the text cursor in logical pixels.
  ///
  /// If `null`, uses the default cursor width from the platform or theme.
  final double? cursorWidth;

  /// Height of the text cursor in logical pixels.
  ///
  /// If `null`, the cursor height matches the line height of the text.
  final double? cursorHeight;

  /// Corner radius of the text cursor.
  ///
  /// If `null`, the cursor has square corners (no rounding).
  final Radius? cursorRadius;

  /// Color of the text cursor.
  ///
  /// If `null`, uses the theme's primary color or platform default.
  final Color? cursorColor;

  /// How tall the selection highlight boxes should be.
  ///
  /// Determines vertical sizing behavior for text selection highlights.
  /// If `null`, uses platform or theme defaults.
  final ui.BoxHeightStyle? selectionHeightStyle;

  /// How wide the selection highlight boxes should be.
  ///
  /// Determines horizontal sizing behavior for text selection highlights.
  /// If `null`, uses platform or theme defaults.
  final ui.BoxWidthStyle? selectionWidthStyle;

  /// Whether to enable interactive text selection (e.g., selecting with mouse/touch).
  ///
  /// When `true`, users can select text by dragging. When `false`, text
  /// selection gestures are disabled. If `null`, uses platform defaults.
  final bool? enableInteractiveSelection;

  /// {@macro selectable_text_theme}
  const SelectableTextTheme({
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle,
    this.selectionWidthStyle,
    this.enableInteractiveSelection,
  });

  /// Creates a copy of this theme with optionally replaced values.
  ///
  /// Uses [ValueGetter] functions to allow nullable value replacement.
  /// Properties not provided retain their current values.
  ///
  /// Parameters:
  /// - [cursorWidth]: Optional getter for new cursor width
  /// - [cursorHeight]: Optional getter for new cursor height
  /// - [cursorRadius]: Optional getter for new cursor radius
  /// - [cursorColor]: Optional getter for new cursor color
  /// - [selectionHeightStyle]: Optional getter for new selection height style
  /// - [selectionWidthStyle]: Optional getter for new selection width style
  /// - [enableInteractiveSelection]: Optional getter for new interactive selection state
  ///
  /// Returns a new [SelectableTextTheme] with updated values.
  SelectableTextTheme copyWith({
    ValueGetter<double?>? cursorWidth,
    ValueGetter<double?>? cursorHeight,
    ValueGetter<Radius?>? cursorRadius,
    ValueGetter<Color?>? cursorColor,
    ValueGetter<ui.BoxHeightStyle?>? selectionHeightStyle,
    ValueGetter<ui.BoxWidthStyle?>? selectionWidthStyle,
    ValueGetter<bool?>? enableInteractiveSelection,
  }) {
    return SelectableTextTheme(
      cursorWidth: cursorWidth == null ? this.cursorWidth : cursorWidth(),
      cursorHeight: cursorHeight == null ? this.cursorHeight : cursorHeight(),
      cursorRadius: cursorRadius == null ? this.cursorRadius : cursorRadius(),
      cursorColor: cursorColor == null ? this.cursorColor : cursorColor(),
      selectionHeightStyle: selectionHeightStyle == null
          ? this.selectionHeightStyle
          : selectionHeightStyle(),
      selectionWidthStyle: selectionWidthStyle == null
          ? this.selectionWidthStyle
          : selectionWidthStyle(),
      enableInteractiveSelection: enableInteractiveSelection == null
          ? this.enableInteractiveSelection
          : enableInteractiveSelection(),
    );
  }

  @override
  int get hashCode => Object.hash(
      cursorWidth,
      cursorHeight,
      cursorRadius,
      cursorColor,
      selectionHeightStyle,
      selectionWidthStyle,
      enableInteractiveSelection);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectableTextTheme &&
        other.cursorWidth == cursorWidth &&
        other.cursorHeight == cursorHeight &&
        other.cursorRadius == cursorRadius &&
        other.cursorColor == cursorColor &&
        other.selectionHeightStyle == selectionHeightStyle &&
        other.selectionWidthStyle == selectionWidthStyle &&
        other.enableInteractiveSelection == enableInteractiveSelection;
  }

  @override
  String toString() {
    return 'SelectableTextTheme(cursorWidth: $cursorWidth, cursorHeight: $cursorHeight, cursorRadius: $cursorRadius, cursorColor: $cursorColor, selectionHeightStyle: $selectionHeightStyle, selectionWidthStyle: $selectionWidthStyle, enableInteractiveSelection: $enableInteractiveSelection)';
  }
}

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
  const SelectableText(
    String this.data, {
    super.key,
    this.focusNode,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.showCursor = false,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.scrollPhysics,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
    this.useNativeContextMenu = false,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.magnifierConfiguration,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        textSpan = null;

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
  const SelectableText.rich(
    TextSpan this.textSpan, {
    super.key,
    this.focusNode,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.showCursor = false,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.scrollPhysics,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
    this.useNativeContextMenu = false,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.magnifierConfiguration,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        data = null;

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
  bool get selectionEnabled => enableInteractiveSelection;

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

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return buildEditableTextContextMenu(context, editableTextState);
  }

  /// The configuration for the magnifier used when the text is selected.
  ///
  /// By default, builds a [CupertinoTextMagnifier] on iOS and [TextMagnifier]
  /// on Android, and builds nothing on all other platforms. To suppress the
  /// magnifier, consider passing [TextMagnifierConfiguration.disabled].
  ///
  /// {@macro flutter.widgets.magnifier.intro}
  final TextMagnifierConfiguration? magnifierConfiguration;

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<SelectableTextTheme>(context);
    final cursorWidth = compTheme?.cursorWidth ?? this.cursorWidth;
    final cursorHeight = compTheme?.cursorHeight ?? this.cursorHeight;
    final cursorRadius = compTheme?.cursorRadius ?? this.cursorRadius;
    final cursorColor = compTheme?.cursorColor ?? this.cursorColor;
    final selectionHeightStyle =
        compTheme?.selectionHeightStyle ?? this.selectionHeightStyle;
    final selectionWidthStyle =
        compTheme?.selectionWidthStyle ?? this.selectionWidthStyle;
    final enableSelection =
        compTheme?.enableInteractiveSelection ?? enableInteractiveSelection;

    if (data == null) {
      return m.SelectableText.rich(
        textSpan!,
        focusNode: focusNode,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textHeightBehavior: textHeightBehavior,
        textWidthBasis: textWidthBasis,
        showCursor: showCursor,
        autofocus: autofocus,
        minLines: minLines,
        maxLines: maxLines,
        cursorWidth: cursorWidth,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        selectionHeightStyle: selectionHeightStyle,
        selectionWidthStyle: selectionWidthStyle,
        enableInteractiveSelection: enableSelection,
        selectionControls: selectionControls,
        onTap: onTap,
        scrollPhysics: scrollPhysics,
        semanticsLabel: semanticsLabel,
        onSelectionChanged: onSelectionChanged,
        contextMenuBuilder: useNativeContextMenu
            ? (context, editableTextState) {
                return m.AdaptiveTextSelectionToolbar.editableText(
                  editableTextState: editableTextState,
                );
              }
            : contextMenuBuilder,
        magnifierConfiguration: magnifierConfiguration,
      );
    } else {
      return m.SelectableText(
        data!,
        focusNode: focusNode,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textHeightBehavior: textHeightBehavior,
        textWidthBasis: textWidthBasis,
        showCursor: showCursor,
        autofocus: autofocus,
        minLines: minLines,
        maxLines: maxLines,
        cursorWidth: cursorWidth,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        selectionHeightStyle: selectionHeightStyle,
        selectionWidthStyle: selectionWidthStyle,
        enableInteractiveSelection: enableSelection,
        selectionControls: selectionControls,
        onTap: onTap,
        scrollPhysics: scrollPhysics,
        semanticsLabel: semanticsLabel,
        onSelectionChanged: onSelectionChanged,
        contextMenuBuilder: useNativeContextMenu
            ? (context, editableTextState) {
                return m.AdaptiveTextSelectionToolbar.editableText(
                  editableTextState: editableTextState,
                );
              }
            : contextMenuBuilder,
        magnifierConfiguration: magnifierConfiguration,
      );
    }
  }
}
