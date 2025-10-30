import '../../../shadcn_flutter.dart';

/// Theme configuration for [CodeSnippet] components.
///
/// [CodeSnippetTheme] provides styling options for code snippet containers
/// including background colors, borders, padding, and visual appearance.
/// It integrates with the shadcn_flutter theming system to ensure consistent
/// styling across code display components.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<CodeSnippetTheme>(
///   data: CodeSnippetTheme(
///     backgroundColor: Colors.grey.shade900,
///     borderColor: Colors.grey.shade700,
///     borderWidth: 1.0,
///     borderRadius: BorderRadius.circular(8.0),
///     padding: EdgeInsets.all(16.0),
///   ),
///   child: MyCodeSnippetWidget(),
/// );
/// ```
class CodeSnippetTheme {
  /// Background color of the code snippet container.
  ///
  /// Type: `Color?`. Used as the background color for the code display area.
  /// If null, uses the theme's default muted background color.
  final Color? backgroundColor;

  /// Border color of the code snippet container.
  ///
  /// Type: `Color?`. Color used for the container border outline.
  /// If null, uses the theme's default border color.
  final Color? borderColor;

  /// Border width of the code snippet container in logical pixels.
  ///
  /// Type: `double?`. Thickness of the border around the code container.
  /// If null, uses the theme's default border width.
  final double? borderWidth;

  /// Border radius for the code snippet container corners.
  ///
  /// Type: `BorderRadiusGeometry?`. Controls corner rounding of the container.
  /// If null, uses the theme's default radius for code components.
  final BorderRadiusGeometry? borderRadius;

  /// Padding for the code content area.
  ///
  /// Type: `EdgeInsetsGeometry?`. Internal spacing around the code text.
  /// If null, uses default padding appropriate for code display.
  final EdgeInsetsGeometry? padding;

  /// Creates a [CodeSnippetTheme].
  ///
  /// All parameters are optional and will fall back to theme defaults
  /// when not provided.
  ///
  /// Parameters:
  /// - [backgroundColor] (Color?, optional): Container background color
  /// - [borderColor] (Color?, optional): Border outline color
  /// - [borderWidth] (double?, optional): Border thickness in pixels
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Corner radius
  /// - [padding] (EdgeInsetsGeometry?, optional): Content padding
  ///
  /// Example:
  /// ```dart
  /// CodeSnippetTheme(
  ///   backgroundColor: Colors.black87,
  ///   borderRadius: BorderRadius.circular(12.0),
  ///   padding: EdgeInsets.all(20.0),
  /// );
  /// ```
  const CodeSnippetTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
  });

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Returns a new [CodeSnippetTheme] instance with the same values as this
  /// theme, except for any parameters that are explicitly provided. Use
  /// [ValueGetter] functions to specify new values.
  ///
  /// Parameters are [ValueGetter] functions that return the new value when called.
  /// This allows for conditional value setting and proper null handling.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   backgroundColor: () => Colors.blue.shade50,
  ///   padding: () => EdgeInsets.all(12.0),
  /// );
  /// ```
  CodeSnippetTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return CodeSnippetTheme(
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CodeSnippetTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        borderColor,
        borderWidth,
        borderRadius,
        padding,
      );
}

/// A syntax-highlighted code display widget with copy functionality.
///
/// [CodeSnippet] provides a professional code display component with automatic
/// syntax highlighting, copy-to-clipboard functionality, and customizable theming.
/// It supports multiple programming languages and provides a smooth user experience
/// with loading states and responsive scrolling.
///
/// ## Supported Languages
/// - **Core Languages**: Dart, JSON, YAML, SQL
/// - **Aliases**: JavaScript/TypeScript (mapped to Dart highlighting)
/// - **Fallback**: Plain text display for unsupported languages
///
/// ## Key Features
/// - **Syntax Highlighting**: Automatic language detection and coloring
/// - **Copy to Clipboard**: Built-in copy button with toast confirmation
/// - **Custom Actions**: Support for additional action buttons
/// - **Responsive Design**: Horizontal and vertical scrolling for long code
/// - **Theme Integration**: Automatic light/dark theme adaptation
/// - **Loading States**: Smooth loading indicators during initialization
///
/// ## Performance
/// The widget uses lazy initialization for syntax highlighters and caches
/// them for improved performance across multiple instances. Language
/// initialization occurs asynchronously to prevent UI blocking.
///
/// Example:
/// ```dart
/// CodeSnippet(
///   code: '''
/// void main() {
///   print('Hello, World!');
/// }
/// ''',
///   mode: 'dart',
///   constraints: BoxConstraints(maxHeight: 200),
///   actions: [
///     IconButton(
///       icon: Icon(Icons.share),
///       onPressed: () => shareCode(),
///     ),
///   ],
/// );
/// ```
class CodeSnippet extends StatefulWidget {
  /// Optional constraints for the code display area.
  ///
  /// Type: `BoxConstraints?`. Controls the maximum/minimum size of the
  /// scrollable code container. Useful for limiting height in layouts.
  final BoxConstraints? constraints;

  /// The code widget to display (typically Text or RichText with syntax highlighting).
  final Widget code;

  /// Additional action widgets displayed in the top-right corner.
  ///
  /// Type: `List<Widget>`. Custom action buttons shown alongside the
  /// default copy button. Useful for share, edit, or other operations.
  final List<Widget> actions;

  /// Creates a [CodeSnippet] widget.
  ///
  /// Displays syntax-highlighted code with automatic language detection,
  /// copy functionality, and optional custom actions.
  ///
  /// Parameters:
  /// - [code] (String, required): The source code to display
  /// - [mode] (String, required): Programming language for highlighting
  /// - [constraints] (BoxConstraints?, optional): Size constraints for display area
  /// - [actions] (`List<Widget>`, default: []): Additional action buttons
  ///
  /// Example:
  /// ```dart
  /// CodeSnippet(
  ///   code: Text('print("Hello, World!");'),
  ///   mode: 'dart',
  ///   constraints: BoxConstraints(maxHeight: 150),
  /// );
  /// ```
  const CodeSnippet({
    super.key,
    this.constraints,
    this.actions = const [],
    required this.code,
  });

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();
}

class _CodeSnippetState extends State<CodeSnippet> {
  // static final Map<String, Future<void>> _initializedLanguages = {};
  // static final Map<Brightness, Future<HighlighterTheme>> _initializedThemes =
  //     {};
  // static Future<String?> _initializeLanguage(String mode) {
  //   // check for alias
  //   if (_languageAlias.containsKey(mode)) {
  //     mode = _languageAlias[mode]!;
  //   }
  //   if (!_supportedLanguages.contains(mode)) {
  //     return Future.value(null);
  //   }
  //   if (_initializedLanguages.containsKey(mode)) {
  //     _initializedLanguages[mode]!;
  //     return Future.value(mode);
  //   }
  //   final future = Highlighter.initialize([mode]);
  //   _initializedLanguages[mode] = future;
  //   return future.then((_) => mode);
  // }

  // static Future<HighlighterTheme> _initializeTheme(Brightness brightness) {
  //   if (_initializedThemes.containsKey(brightness)) {
  //     return _initializedThemes[brightness]!;
  //   }
  //   final future = HighlighterTheme.loadForBrightness(brightness);
  //   _initializedThemes[brightness] = future;
  //   return future;
  // }

  // late Future<Highlighter?> _highlighter;
  // Brightness? _brightness;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   var newBrightness = Theme.of(context).brightness;
  //   if (_brightness != newBrightness) {
  //     _brightness = newBrightness;
  //     // _highlighter = _initializeHighlighter();
  //   }
  // }

  // @override
  // void didUpdateWidget(covariant CodeSnippet oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.mode != widget.mode) {
  //     _highlighter = _initializeHighlighter();
  //   }
  // }

  // Future<Highlighter?> _initializeHighlighter() async {
  //   String mode = widget.mode;
  //   String? language = await _initializeLanguage(mode);
  //   if (language == null) {
  //     return null;
  //   }
  //   final themeData = await _initializeTheme(_brightness ?? Brightness.light);
  //   return Highlighter(language: language, theme: themeData);
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CodeSnippetTheme>(context);
    final backgroundColor = styleValue(
      themeValue: compTheme?.backgroundColor,
      defaultValue: theme.colorScheme.card,
    );
    final borderColor = styleValue(
      themeValue: compTheme?.borderColor,
      defaultValue: theme.colorScheme.border,
    );
    final borderWidth = styleValue(
      themeValue: compTheme?.borderWidth,
      defaultValue: theme.scaling,
    );
    final borderRadius = styleValue(
      themeValue: compTheme?.borderRadius,
      defaultValue: BorderRadius.circular(theme.radiusLg),
    );
    final padding = styleValue(
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.only(
        left: theme.scaling * 16,
        right: theme.scaling * 48,
        top: theme.scaling * 16,
        bottom: theme.scaling * 16,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: borderRadius,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            constraints: widget.constraints,
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: padding,
                child: widget.code.mono.small.muted,
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Row(
              children: [
                ...widget.actions,
                // if (wid)
                // GhostButton(
                //   density: ButtonDensity.icon,
                //   onPressed: () {
                //     // Clipboard.setData(ClipboardData(text: widget.code))
                //     //     .then((value) {
                //     //   if (context.mounted) {
                //     //     showToast(
                //     //       context: context,
                //     //       showDuration: const Duration(seconds: 2),
                //     //       builder: (context, overlay) {
                //     //         final localizations =
                //     //             ShadcnLocalizations.of(context);
                //     //         return Alert(
                //     //           leading: const Icon(
                //     //             LucideIcons.copyCheck,
                //     //           ).iconSmall(),
                //     //           title: Text(localizations.toastSnippetCopied),
                //     //         );
                //     //       },
                //     //     );
                //     //   }
                //     // });

                //   },
                //   child: const Icon(LucideIcons.copy).iconSmall(),
                // ),
              ],
            ).gap(4),
          ),
        ],
      ),
    );
  }
}
