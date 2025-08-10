import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as m;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template selectable_text_theme}
/// Theme data for [SelectableText] to customize cursor and selection behavior.
/// {@endtemplate}
class SelectableTextTheme {
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle? selectionHeightStyle;
  final ui.BoxWidthStyle? selectionWidthStyle;
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
  int get hashCode => Object.hash(cursorWidth, cursorHeight, cursorRadius,
      cursorColor, selectionHeightStyle, selectionWidthStyle,
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

class SelectableText extends StatelessWidget {
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

  final String? data;

  final TextSpan? textSpan;
  final FocusNode? focusNode;

  final bool useNativeContextMenu;

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

  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
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
