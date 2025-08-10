import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import '../../../shadcn_flutter.dart';

/// Theme for [CodeSnippet].
class CodeSnippetTheme {
  /// Background color of the snippet container.
  final Color? backgroundColor;

  /// Border color of the snippet container.
  final Color? borderColor;

  /// Border width of the snippet container.
  final double? borderWidth;

  /// Border radius of the snippet container.
  final BorderRadiusGeometry? borderRadius;

  /// Padding for the code content.
  final EdgeInsetsGeometry? padding;

  /// Creates a [CodeSnippetTheme].
  const CodeSnippetTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
  });

  /// Creates a copy of this theme with the given values replaced.
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

class CodeSnippet extends StatefulWidget {
  final BoxConstraints? constraints;
  final String code;
  final String mode;
  final List<Widget> actions;

  const CodeSnippet({
    super.key,
    this.constraints,
    this.actions = const [],
    required this.code,
    required this.mode,
  });

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();
}

class _CodeSnippetState extends State<CodeSnippet> {
  static const Set<String> _supportedLanguages = {
    'json',
    'yaml',
    'dart',
    'sql',
  };
  static const Map<String, String> _languageAlias = {
    'yml': 'yaml',
    // since its similar to dart, temporarily use dart as fallback to js and ts
    'js': 'dart',
    'ts': 'dart',
    'javascript': 'dart',
    //
  };
  static final Map<String, Future<void>> _initializedLanguages = {};
  static final Map<Brightness, Future<HighlighterTheme>> _initializedThemes =
      {};
  static Future<String?> _initializeLanguage(String mode) {
    // check for alias
    if (_languageAlias.containsKey(mode)) {
      mode = _languageAlias[mode]!;
    }
    if (!_supportedLanguages.contains(mode)) {
      return Future.value(null);
    }
    if (_initializedLanguages.containsKey(mode)) {
      _initializedLanguages[mode]!;
      return Future.value(mode);
    }
    final future = Highlighter.initialize([mode]);
    _initializedLanguages[mode] = future;
    return future.then((_) => mode);
  }

  static Future<HighlighterTheme> _initializeTheme(Brightness brightness) {
    if (_initializedThemes.containsKey(brightness)) {
      return _initializedThemes[brightness]!;
    }
    final future = HighlighterTheme.loadForBrightness(brightness);
    _initializedThemes[brightness] = future;
    return future;
  }

  late Future<Highlighter?> _highlighter;
  Brightness? _brightness;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newBrightness = Theme.of(context).brightness;
    if (_brightness != newBrightness) {
      _brightness = newBrightness;
      _highlighter = _initializeHighlighter();
    }
  }

  @override
  void didUpdateWidget(covariant CodeSnippet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) {
      _highlighter = _initializeHighlighter();
    }
  }

  Future<Highlighter?> _initializeHighlighter() async {
    String mode = widget.mode;
    String? language = await _initializeLanguage(mode);
    if (language == null) {
      return null;
    }
    final themeData = await _initializeTheme(_brightness ?? Brightness.light);
    return Highlighter(language: language, theme: themeData);
  }

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
          FutureBuilder(
              future: _highlighter,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: const CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data;
                return Container(
                  constraints: widget.constraints,
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: padding,
                      child: data == null
                          ? SelectableText(widget.code).muted().mono().small()
                          : SelectableText.rich(
                              data.highlight(widget.code),
                            ).mono().small(),
                    ),
                  ),
                );
              }),
          Positioned(
            right: 8,
            top: 8,
            child: Row(
              children: [
                ...widget.actions,
                GhostButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.code))
                        .then((value) {
                      if (context.mounted) {
                        showToast(
                          context: context,
                          showDuration: const Duration(seconds: 2),
                          builder: (context, overlay) {
                            final localizations =
                                ShadcnLocalizations.of(context);
                            return Alert(
                              leading: const Icon(
                                LucideIcons.copyCheck,
                              ).iconSmall(),
                              title: Text(localizations.toastSnippetCopied),
                            );
                          },
                        );
                      }
                    });
                  },
                  child: const Icon(LucideIcons.copy).iconSmall(),
                ),
              ],
            ).gap(4),
          ),
        ],
      ),
    );
  }
}
