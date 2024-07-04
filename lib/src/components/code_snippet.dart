import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:highlight/highlight.dart';

import '../../shadcn_flutter.dart';

class CodeSnippet extends StatefulWidget {
  final BoxConstraints? constraints;
  final String code;
  final String mode;
  final List<Widget> actions;

  const CodeSnippet({
    Key? key,
    this.constraints,
    this.actions = const [],
    required this.code,
    required this.mode,
  }) : super(key: key);

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();
}

class _CodeSnippetState extends State<CodeSnippet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        border: Border.all(
          color: theme.colorScheme.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(theme.radiusLg),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              child: Container(
                constraints: widget.constraints,
                child: HighlightView(
                  widget.code,
                  tabSize: 2,
                  language: widget.mode,
                  theme: getShadcnCodeSnippetTheme(context),
                  // padding: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.only(left: 32, right: 48),
                  textStyle: TextStyle(
                    fontFamily: 'GeistMono',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Row(
              children: [
                ...widget.actions,
                GhostButton(
                  padding: Button.iconPadding,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.code));
                  },
                  child: Icon(
                    Icons.copy,
                    size: 16,
                  ),
                ),
              ],
            ).gap(4),
          ),
        ],
      ),
    );
  }
}

Map<String, TextStyle> getShadcnCodeSnippetTheme(BuildContext context) {
  final theme = Theme.of(context);
  return {
    'root': TextStyle(
      backgroundColor: Colors.transparent,
      color: theme.colorScheme.mutedForeground,
    ),
    'comment': TextStyle(color: theme.colorScheme.mutedForeground),
    'meta': TextStyle(color: theme.colorScheme.mutedForeground),
    'variable': TextStyle(color: theme.colorScheme.primary),
    'template-variable': TextStyle(color: theme.colorScheme.primary),
    'strong': TextStyle(color: theme.colorScheme.foreground),
    'emphasis': TextStyle(color: theme.colorScheme.foreground),
    'quote': TextStyle(color: theme.colorScheme.mutedForeground),
    'keyword': TextStyle(color: theme.colorScheme.primary),
    'selector-tag': TextStyle(color: theme.colorScheme.mutedForeground),
    'type': TextStyle(color: theme.colorScheme.mutedForeground),
    'literal': TextStyle(color: theme.colorScheme.secondary),
    'symbol': TextStyle(color: theme.colorScheme.secondary),
    'bullet': TextStyle(color: theme.colorScheme.secondary),
    'attribute': TextStyle(color: theme.colorScheme.secondary),
    'section': TextStyle(color: theme.colorScheme.foreground),
    'name': TextStyle(color: theme.colorScheme.mutedForeground),
    'tag': TextStyle(color: theme.colorScheme.foreground),
    'title': TextStyle(color: theme.colorScheme.primary),
    'attr': TextStyle(color: theme.colorScheme.primary),
    'selector-id': TextStyle(color: theme.colorScheme.primary),
    'selector-class': TextStyle(color: theme.colorScheme.primary),
    'selector-attr': TextStyle(color: theme.colorScheme.primary),
    'selector-pseudo': TextStyle(color: theme.colorScheme.primary),
    'addition': TextStyle(
      color: theme.colorScheme.mutedForeground,
      backgroundColor: theme.colorScheme.mutedForeground.withOpacity(0.1),
    ),
    'deletion': TextStyle(
      color: theme.colorScheme.mutedForeground,
      backgroundColor: theme.colorScheme.mutedForeground.withOpacity(0.1),
    ),
    'number': TextStyle(color: theme.colorScheme.primary),
    'string': TextStyle(color: theme.colorScheme.primary),
    'class': TextStyle(color: theme.colorScheme.primary),
    'subst': TextStyle(color: theme.colorScheme.primary),
  };
}

/// Highlight Flutter Widget
class HighlightView extends StatelessWidget {
  /// The original code to be highlighted
  final String source;

  /// Highlight language
  ///
  /// It is recommended to give it a value for performance
  ///
  /// [All available languages](https://github.com/pd4d10/highlight/tree/master/highlight/lib/languages)
  final String? language;

  /// Highlight theme
  ///
  /// [All available themes](https://github.com/pd4d10/highlight/blob/master/flutter_highlight/lib/themes)
  final Map<String, TextStyle> theme;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Text styles
  ///
  /// Specify text styles such as font family and font size
  final TextStyle? textStyle;

  HighlightView(
    String input, {
    this.language,
    this.theme = const {},
    this.padding,
    this.textStyle,
    int tabSize = 8, // TODO: https://github.com/flutter/flutter/issues/50087
  }) : source = input.replaceAll('\t', ' ' * tabSize);

  List<TextSpan> _convert(List<Node> nodes) {
    List<TextSpan> spans = [];
    var currentSpans = spans;
    List<List<TextSpan>> stack = [];

    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null
            ? TextSpan(text: node.value)
            : TextSpan(text: node.value, style: theme[node.className!]));
      } else if (node.children != null) {
        List<TextSpan> tmp = [];
        currentSpans
            .add(TextSpan(children: tmp, style: theme[node.className!]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node.children!.forEach((n) {
          _traverse(n);
          if (n == node.children!.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        });
      }
    }

    for (var node in nodes) {
      _traverse(node);
    }

    return spans;
  }

  static const _rootKey = 'root';
  static const _defaultFontColor = Color(0xff000000);
  static const _defaultBackgroundColor = Color(0xffffffff);

  // TODO: dart:io is not available at web platform currently
  // See: https://github.com/flutter/flutter/issues/39998
  // So we just use monospace here for now
  static const _defaultFontFamily = 'monospace';

  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
      fontFamily: _defaultFontFamily,
      color: theme[_rootKey]?.color ?? _defaultFontColor,
    );
    if (textStyle != null) {
      _textStyle = _textStyle.merge(textStyle);
    }

    return Container(
      color: theme[_rootKey]?.backgroundColor ?? _defaultBackgroundColor,
      padding: padding,
      child: material.SelectableText.rich(
        TextSpan(
          style: _textStyle,
          children:
              _convert(highlight.parse(source, language: language).nodes!),
        ),
      ),
    );
  }
}
