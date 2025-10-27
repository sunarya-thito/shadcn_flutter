---
title: "Class: SelectableText"
description: "Reference for SelectableText"
---

```dart
class SelectableText extends StatelessWidget {
  const SelectableText(String this.data, {super.key, this.focusNode, this.style, this.strutStyle, this.textAlign, this.textDirection, this.textScaler, this.showCursor = false, this.autofocus = false, this.minLines, this.maxLines, this.cursorWidth = 2.0, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle = ui.BoxHeightStyle.tight, this.selectionWidthStyle = ui.BoxWidthStyle.tight, this.dragStartBehavior = DragStartBehavior.start, this.enableInteractiveSelection = true, this.selectionControls, this.onTap, this.scrollPhysics, this.semanticsLabel, this.textHeightBehavior, this.textWidthBasis, this.onSelectionChanged, this.useNativeContextMenu = false, this.contextMenuBuilder = _defaultContextMenuBuilder, this.magnifierConfiguration});
  const SelectableText.rich(TextSpan this.textSpan, {super.key, this.focusNode, this.style, this.strutStyle, this.textAlign, this.textDirection, this.textScaler, this.showCursor = false, this.autofocus = false, this.minLines, this.maxLines, this.cursorWidth = 2.0, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle = ui.BoxHeightStyle.tight, this.selectionWidthStyle = ui.BoxWidthStyle.tight, this.dragStartBehavior = DragStartBehavior.start, this.enableInteractiveSelection = true, this.selectionControls, this.onTap, this.scrollPhysics, this.semanticsLabel, this.textHeightBehavior, this.textWidthBasis, this.onSelectionChanged, this.useNativeContextMenu = false, this.contextMenuBuilder = _defaultContextMenuBuilder, this.magnifierConfiguration});
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
