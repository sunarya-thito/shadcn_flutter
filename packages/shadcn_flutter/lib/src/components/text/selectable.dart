import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template selectable_text_theme}
/// Theme data for [SelectableText] to customize cursor and selection behavior.
/// {@endtemplate}
class SelectableTextTheme extends ComponentThemeData {
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
    enableInteractiveSelection,
  );

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
class SelectableText extends StatefulWidget {
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
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.magnifierConfiguration,
  }) : assert(maxLines == null || maxLines > 0),
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
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.magnifierConfiguration,
  }) : assert(maxLines == null || maxLines > 0),
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
    BuildContext context,
    EditableTextState editableTextState,
  ) {
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
  State<SelectableText> createState() => _SelectableTextState();
}

/// A read-only controller whose text is fixed to a single [TextSpan].
///
/// [EditableText] drives everything through a [TextEditingController], but a
/// [SelectableText] must not be editable and must still be able to render rich
/// spans. This controller answers with the original span rather than
/// re-deriving one from a plain string, so nested styles survive.
///
/// Ported from Flutter's Material `SelectableText` (BSD-licensed, see the
/// Flutter LICENSE file).
class _TextSpanEditingController extends TextEditingController {
  _TextSpanEditingController({required TextSpan textSpan})
    : _textSpan = textSpan,
      super(text: textSpan.toPlainText(includeSemanticsLabels: false));

  final TextSpan _textSpan;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // This does not care about composing.
    return TextSpan(style: style, children: <TextSpan>[_textSpan]);
  }

  @override
  set text(String? newText) {
    // The text is owned by the widget, so this should never be reached.
    throw UnimplementedError();
  }
}

/// Wires tap and drag selection gestures onto the [EditableText] below.
///
/// Only [onSingleTapUp] is customized, so that [SelectableText.onTap] fires
/// after the selection has been updated.
class _SelectableTextSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _SelectableTextSelectionGestureDetectorBuilder({
    required _SelectableTextState state,
  }) : _state = state,
       super(delegate: state);

  final _SelectableTextState _state;

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    if (!delegate.selectionEnabled) {
      return;
    }
    super.onSingleTapUp(details);
    _state.widget.onTap?.call();
  }
}

/// Drives a read-only [EditableText] to render selectable text.
///
/// Ported from Flutter's Material `_SelectableTextState` (BSD-licensed, see the
/// Flutter LICENSE file), with the Material and Cupertino theme lookups
/// replaced by shadcn_flutter's [ThemeData] and [SelectableTextTheme], and with
/// the per-platform selection controls replaced by the single handle-less
/// [shadcnTextSelectionHandleControls].
class _SelectableTextState extends State<SelectableText>
    implements TextSelectionGestureDetectorBuilderDelegate {
  EditableTextState? get _editableText => editableTextKey.currentState;

  late _TextSpanEditingController _controller;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode(skipTraversal: true));

  bool _showSelectionHandles = false;

  late _SelectableTextSelectionGestureDetectorBuilder
  _selectionGestureDetectorBuilder;

  // API for TextSelectionGestureDetectorBuilderDelegate.
  @override
  late bool forcePressEnabled;

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => widget.selectionEnabled;
  // End of API for TextSelectionGestureDetectorBuilderDelegate.

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _SelectableTextSelectionGestureDetectorBuilder(state: this);
    _controller = _TextSpanEditingController(
      textSpan: widget.textSpan ?? TextSpan(text: widget.data),
    );
    _controller.addListener(_onControllerChanged);
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(SelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data ||
        widget.textSpan != oldWidget.textSpan) {
      _controller.removeListener(_onControllerChanged);
      _controller.dispose();
      _controller = _TextSpanEditingController(
        textSpan: widget.textSpan ?? TextSpan(text: widget.data),
      );
      _controller.addListener(_onControllerChanged);
    }
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    _showSelectionHandles =
        !(_effectiveFocusNode.hasFocus && _controller.selection.isCollapsed);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    final bool showSelectionHandles =
        !_effectiveFocusNode.hasFocus || !_controller.selection.isCollapsed;
    if (showSelectionHandles == _showSelectionHandles) {
      return;
    }
    setState(() {
      _showSelectionHandles = showSelectionHandles;
    });
  }

  void _handleFocusChanged() {
    if (!_effectiveFocusNode.hasFocus &&
        SchedulerBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      // Only clear the selection when this SelectableText loses focus while the
      // application is actually running. On desktop, clicking another window
      // makes the application inactive without the user having dismissed the
      // selection, and it should still be there when they come back.
      _controller.value = TextEditingValue(text: _controller.value.text);
    }
  }

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    widget.onSelectionChanged?.call(selection, cause);

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.base);
        }
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      // Do nothing.
      // Flutter forks might add platforms to TargetPlatform.
      // ignore: unreachable_switch_default
      default:
      // Do nothing.
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (_controller.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text is activated by something that doesn't trigger the
    // selection overlay, the handles shouldn't show either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }
    if (_controller.selection.isCollapsed) {
      return false;
    }
    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }
    if (cause == SelectionChangedCause.longPress) {
      return true;
    }
    return _controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasDirectionality(context));
    assert(
      !(widget.style != null &&
          !widget.style!.inherit &&
          (widget.style!.fontSize == null ||
              widget.style!.textBaseline == null)),
      'inherit false style must supply fontSize and textBaseline',
    );

    final ThemeData theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<SelectableTextTheme>(context);
    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(
      context,
    );
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    final double cursorWidth = compTheme?.cursorWidth ?? widget.cursorWidth;
    final double? cursorHeight = compTheme?.cursorHeight ?? widget.cursorHeight;
    final Radius? cursorRadius = compTheme?.cursorRadius ?? widget.cursorRadius;
    final ui.BoxHeightStyle selectionHeightStyle =
        compTheme?.selectionHeightStyle ?? widget.selectionHeightStyle;
    final ui.BoxWidthStyle selectionWidthStyle =
        compTheme?.selectionWidthStyle ?? widget.selectionWidthStyle;
    final bool enableSelection =
        compTheme?.enableInteractiveSelection ??
        widget.enableInteractiveSelection;

    final Color cursorColor =
        widget.cursorColor ??
        compTheme?.cursorColor ??
        selectionStyle.cursorColor ??
        theme.colorScheme.primary;
    final Color selectionColor =
        selectionStyle.selectionColor ??
        theme.colorScheme.primary.scaleAlpha(0.2);

    // Only iOS promotes a hard press into a word selection; every other
    // platform treats it as an ordinary press.
    forcePressEnabled = theme.platform == TargetPlatform.iOS;

    TextStyle? effectiveTextStyle = widget.style;
    if (effectiveTextStyle == null || effectiveTextStyle.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(
        widget.style ?? _controller._textSpan.style,
      );
    }

    final Widget child = RepaintBoundary(
      child: EditableText(
        key: editableTextKey,
        style: effectiveTextStyle,
        readOnly: true,
        textWidthBasis:
            widget.textWidthBasis ?? defaultTextStyle.textWidthBasis,
        textHeightBehavior:
            widget.textHeightBehavior ?? defaultTextStyle.textHeightBehavior,
        showSelectionHandles: _showSelectionHandles,
        showCursor: widget.showCursor,
        controller: _controller,
        focusNode: _effectiveFocusNode,
        strutStyle: widget.strutStyle ?? const StrutStyle(),
        textAlign:
            widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
        textDirection: widget.textDirection,
        textScaler: widget.textScaler,
        autofocus: widget.autofocus,
        forceLine: false,
        minLines: widget.minLines,
        maxLines: widget.maxLines ?? defaultTextStyle.maxLines,
        selectionColor: selectionColor,
        selectionControls: enableSelection
            ? (widget.selectionControls ?? shadcnTextSelectionHandleControls)
            : null,
        onSelectionChanged: _handleSelectionChanged,
        onSelectionHandleTapped: _handleSelectionHandleTapped,
        rendererIgnoresPointer: true,
        cursorWidth: cursorWidth,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        selectionHeightStyle: selectionHeightStyle,
        selectionWidthStyle: selectionWidthStyle,
        cursorOpacityAnimates: false,
        paintCursorAboveText: true,
        backgroundCursorColor: theme.colorScheme.border,
        enableInteractiveSelection: enableSelection,
        magnifierConfiguration:
            widget.magnifierConfiguration ?? const TextMagnifierConfiguration(),
        dragStartBehavior: widget.dragStartBehavior,
        scrollPhysics: widget.scrollPhysics,
        autofillHints: null,
        contextMenuBuilder: widget.contextMenuBuilder,
      ),
    );

    return Semantics(
      label: widget.semanticsLabel,
      excludeSemantics: widget.semanticsLabel != null,
      onLongPress: () {
        _effectiveFocusNode.requestFocus();
      },
      child: _selectionGestureDetectorBuilder.buildGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: child,
      ),
    );
  }
}
