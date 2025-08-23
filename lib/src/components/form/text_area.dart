import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing [TextArea] appearance.
///
/// This class defines the visual properties that can be applied to
/// [TextArea] widgets, including fill state, border appearance, padding,
/// and border radius. These properties can be set at the theme level
/// to provide consistent styling across the application.
class TextAreaTheme {
  /// Whether the text area should have a filled background.
  ///
  /// When true, the text area displays with a background fill color.
  /// When false or null, the text area has a transparent background.
  final bool? filled;
  
  /// The border decoration around the text area.
  ///
  /// Defines the border style, width, and color. If null, uses the
  /// default border from the current theme.
  final Border? border;
  
  /// The internal padding around the text area content.
  ///
  /// Controls the spacing between the border and the text content.
  /// If null, uses the default padding from the current theme.
  final EdgeInsetsGeometry? padding;
  
  /// The border radius for rounded corners.
  ///
  /// Defines how rounded the corners of the text area should be.
  /// If null, uses the default border radius from the current theme.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [TextAreaTheme] with the specified visual properties.
  ///
  /// All parameters are optional and will fall back to theme defaults
  /// when null.
  ///
  /// Parameters:
  /// - [filled] (bool?, optional): Whether to show filled background
  /// - [border] (Border?, optional): Border decoration around the text area
  /// - [padding] (EdgeInsetsGeometry?, optional): Internal content padding
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Corner rounding radius
  const TextAreaTheme({
    this.filled,
    this.border,
    this.padding,
    this.borderRadius,
  });

  TextAreaTheme copyWith({
    ValueGetter<bool?>? filled,
    ValueGetter<Border?>? border,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return TextAreaTheme(
      filled: filled == null ? this.filled : filled(),
      border: border == null ? this.border : border(),
      padding: padding == null ? this.padding : padding(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextAreaTheme &&
        other.filled == filled &&
        other.border == border &&
        other.padding == padding &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(filled, border, padding, borderRadius);
}

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
class TextArea extends StatefulWidget {
  /// Controller for managing the text area's text content.
  ///
  /// When provided, this controller manages the text area's value externally.
  /// The controller can be used to programmatically set, get, or clear the
  /// text content, and to listen for text changes.
  final TextEditingController? controller;
  
  /// Whether the text area should display with a filled background.
  ///
  /// When true, shows a filled background color. When false or null,
  /// the background is transparent. Overrides the theme's filled setting.
  final bool? filled;
  
  /// Widget to display when the text area is empty.
  ///
  /// Typically a [Text] widget that provides guidance to the user about
  /// what should be entered. The placeholder is only visible when the
  /// text area contains no text.
  final Widget? placeholder;
  
  /// Custom border decoration for the text area.
  ///
  /// Overrides the theme's border setting. If null, uses the border
  /// defined in the current [TextAreaTheme].
  final Border? border;
  
  /// Widget displayed at the start of the text area.
  ///
  /// Positioned before the text content and is useful for icons or
  /// labels that provide context for the input.
  final Widget? leading;
  
  /// Widget displayed at the end of the text area.
  ///
  /// Positioned after the text content and is commonly used for
  /// action buttons, clear buttons, or status indicators.
  final Widget? trailing;
  
  /// Internal padding around the text area content.
  ///
  /// Controls the spacing between the border and the actual text editing area.
  /// Overrides the theme's padding setting when provided.
  final EdgeInsetsGeometry? padding;
  /// Callback invoked when the user submits the text (e.g., presses Enter).
  ///
  /// The callback receives the current text content as a parameter.
  /// This is typically used to handle form submission or trigger actions
  /// when the user finishes entering text.
  final ValueChanged<String>? onSubmitted;
  
  /// Callback invoked when text editing is completed.
  ///
  /// This callback is called when the text area loses focus or when
  /// the user explicitly completes editing. Unlike [onSubmitted],
  /// this doesn't provide the text value.
  final VoidCallback? onEditingComplete;
  
  /// Focus node for controlling keyboard focus.
  ///
  /// When provided, allows external control of the text area's focus state.
  /// Useful for implementing custom focus management or programmatic
  /// focus changes.
  final FocusNode? focusNode;
  
  /// Callback invoked when the text area is tapped.
  ///
  /// Called when the user taps on the text area, even if it's already
  /// focused. Useful for implementing custom behaviors on tap events.
  final VoidCallback? onTap;
  
  /// Whether the text area accepts user input.
  ///
  /// When false, the text area is displayed in a disabled state and
  /// does not respond to user interactions or focus changes.
  final bool enabled;
  
  /// Whether the text area is read-only.
  ///
  /// When true, the text area can receive focus and selection but
  /// does not accept text modifications. The text remains selectable
  /// and copyable.
  final bool readOnly;
  
  /// Whether to obscure the text being edited.
  ///
  /// When true, the text is hidden using the [obscuringCharacter].
  /// This is typically used for password fields or other sensitive input.
  final bool obscureText;
  
  /// Character used to obscure text when [obscureText] is true.
  ///
  /// Default is '•' (bullet character). Only single characters are supported.
  final String obscuringCharacter;
  /// Initial text value when no controller is provided.
  ///
  /// Sets the initial text content of the text area. This value is
  /// ignored if a [controller] is provided. Used for uncontrolled
  /// text area implementations.
  final String? initialValue;
  
  /// Maximum number of characters allowed in the text area.
  ///
  /// When set, limits the text input length. The behavior when the
  /// limit is reached is controlled by [maxLengthEnforcement].
  final int? maxLength;
  
  /// How to handle input when [maxLength] is reached.
  ///
  /// Controls the behavior when the maximum character limit is reached.
  /// Options include enforcing the limit strictly, truncating input,
  /// or allowing overflow with warnings.
  final MaxLengthEnforcement? maxLengthEnforcement;
  
  /// Border radius for rounded corners.
  ///
  /// Overrides the theme's border radius setting. Controls how rounded
  /// the corners of the text area appear.
  final BorderRadiusGeometry? borderRadius;
  
  /// Horizontal alignment of the text within the text area.
  ///
  /// Controls how text is aligned horizontally within the available space.
  /// Options include start, center, end, and justify alignment.
  final TextAlign textAlign;
  
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
  /// Vertical alignment of the text within the text area.
  ///
  /// Controls how text is positioned vertically within the available height.
  /// Options include top, center, and bottom alignment.
  final TextAlignVertical? textAlignVertical;
  
  /// Controller for managing undo/redo operations.
  ///
  /// When provided, enables undo/redo functionality for text editing operations.
  /// Allows users to revert and restore text changes.
  final UndoHistoryController? undoController;
  
  /// Callback invoked when the text content changes.
  ///
  /// Called whenever the text is modified, either by user input or
  /// programmatic changes. The callback receives the new text value.
  final ValueChanged<String>? onChanged;
  
  /// Hints for autofill services.
  ///
  /// Provides suggestions to autofill services about what type of
  /// content this text area expects (e.g., address, email, etc.).
  final Iterable<String>? autofillHints;
  
  /// Callback invoked when the user taps outside the text area.
  ///
  /// Called when a tap occurs outside the text area boundaries while
  /// it has focus. Useful for implementing custom focus loss behaviors.
  final void Function(PointerDownEvent event)? onTapOutside;
  
  /// Input formatters to apply to text input.
  ///
  /// A list of formatters that modify or restrict text input as the user types.
  /// Examples include limiting character types, enforcing formats, etc.
  final List<TextInputFormatter>? inputFormatters;
  
  /// Text style applied to the input text.
  ///
  /// Controls the appearance of the text including font, size, color,
  /// and other typography properties. If null, uses the theme's text style.
  final TextStyle? style;
  
  /// Builder for custom context menus.
  ///
  /// When provided, allows customization of the context menu that appears
  /// on text selection. If null, uses the platform's default context menu.
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  /// The type of keyboard to display for text input.
  ///
  /// Controls which keyboard layout is shown to the user. Options include
  /// text, number, email, URL, and other specialized keyboard types.
  final TextInputType? keyboardType;
  
  /// The action button to display on the keyboard.
  ///
  /// Controls the action button shown on the keyboard (e.g., done, search,
  /// send). This affects both the button's appearance and behavior.
  final TextInputAction? textInputAction;
  
  /// How to clip the text area content.
  ///
  /// Controls how content that exceeds the text area boundaries is clipped.
  /// Options include hard edge, anti-alias, and other clipping behaviors.
  final Clip clipBehavior;
  
  /// Whether the text area should automatically receive focus.
  ///
  /// When true, the text area will request focus when first built, causing
  /// the keyboard to appear automatically.
  final bool autofocus;

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
  const TextArea({
    super.key,
    this.expandableHeight = false,
    this.expandableWidth = false,
    this.initialHeight = 100,
    this.initialWidth = double.infinity,
    this.onHeightChanged,
    this.onWidthChanged,
    this.controller,
    this.filled,
    this.placeholder,
    this.border,
    this.leading,
    this.trailing,
    this.padding,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.initialValue,
    this.maxLength,
    this.maxLengthEnforcement,
    this.borderRadius,
    this.textAlign = TextAlign.start,
    this.minWidth = 100,
    this.minHeight = 100,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    this.textAlignVertical = TextAlignVertical.top,
    this.undoController,
    this.onChanged,
    this.autofillHints,
    this.onTapOutside,
    this.inputFormatters,
    this.style,
    this.contextMenuBuilder,
    this.keyboardType,
    this.textInputAction,
    this.clipBehavior = Clip.hardEdge,
    this.autofocus = false,
  });

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  late double _height;
  late double _width;

  @override
  void initState() {
    super.initState();
    _height = widget.initialHeight;
    _width = widget.initialWidth;
  }

  @override
  void didUpdateWidget(covariant TextArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialHeight != oldWidget.initialHeight) {
      _height = widget.initialHeight;
    }
    if (widget.initialWidth != oldWidget.initialWidth) {
      _width = widget.initialWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TextAreaTheme>(context);
    final filled = styleValue<bool>(
        widgetValue: widget.filled,
        themeValue: compTheme?.filled,
        defaultValue: false);
    final border = styleValue<Border?>(
        widgetValue: widget.border,
        themeValue: compTheme?.border,
        defaultValue: null);
    final padding = styleValue<EdgeInsetsGeometry?>(
        widgetValue: widget.padding,
        themeValue: compTheme?.padding,
        defaultValue: null);
    final borderRadius = styleValue<BorderRadiusGeometry?>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: null);
    return SizedBox(
        height: _height,
        width: _width,
        child: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: TextField(
                expands: true,
                controller: widget.controller,
                onSubmitted: widget.onSubmitted,
                onEditingComplete: widget.onEditingComplete,
                focusNode: widget.focusNode,
                onTap: widget.onTap,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                obscureText: widget.obscureText,
                obscuringCharacter: widget.obscuringCharacter,
                initialValue: widget.initialValue,
                maxLength: widget.maxLength,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                maxLines: null,
                minLines: null,
                textAlign: widget.textAlign,
                border: border,
                filled: filled,
                placeholder: widget.placeholder,
                leading: widget.leading,
                trailing: widget.trailing,
                padding: padding,
                borderRadius: borderRadius,
                textAlignVertical: widget.textAlignVertical,
                undoController: widget.undoController,
                onChanged: widget.onChanged,
                autofillHints: widget.autofillHints,
                onTapOutside: widget.onTapOutside,
                inputFormatters: widget.inputFormatters,
                style: widget.style,
                contextMenuBuilder: widget.contextMenuBuilder,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                clipBehavior: widget.clipBehavior,
                autofocus: widget.autofocus,
              ),
            ),
            Positioned(
              bottom: -1 * scaling,
              right: -1 * scaling,
              width: (8 + 8) * scaling,
              height: (8 + 8) * scaling,
              child: MouseRegion(
                hitTestBehavior: HitTestBehavior.translucent,
                cursor: widget.expandableWidth
                    ? widget.expandableHeight
                        ? SystemMouseCursors.resizeDownRight
                        : SystemMouseCursors.resizeLeftRight
                    : widget.expandableHeight
                        ? SystemMouseCursors.resizeUpDown
                        : SystemMouseCursors.basic,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanUpdate: (details) {
                    if (widget.expandableHeight && _height.isFinite) {
                      setState(() {
                        _height += details.delta.dy;
                        _height =
                            _height.clamp(widget.minHeight, widget.maxHeight);
                        widget.onHeightChanged?.call(_height);
                      });
                    }
                    if (widget.expandableWidth && _width.isFinite) {
                      setState(() {
                        _width += details.delta.dx;
                        _width = _width.clamp(widget.minWidth, widget.maxWidth);
                        widget.onWidthChanged?.call(_width);
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.0 * scaling),
                    child: CustomPaint(
                      painter: _TextAreaDragHandlePainter(
                          theme.colorScheme.foreground),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class _TextAreaDragHandlePainter extends CustomPainter {
  final Color color;

  _TextAreaDragHandlePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final start = Offset(size.width, 0);
    final end = Offset(0, size.height);
    final start2 = Offset(size.width, size.height / 2);
    final end2 = Offset(size.width / 2, size.height);
    canvas.drawLine(start, end, paint);
    canvas.drawLine(start2, end2, paint);
  }

  @override
  bool shouldRepaint(covariant _TextAreaDragHandlePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
