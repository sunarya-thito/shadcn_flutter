import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

import '../../shadcn_flutter.dart';

class CodeSnippet extends StatefulWidget {
  final BoxConstraints? constraints;
  final String code;
  final String mode;

  const CodeSnippet({
    Key? key,
    this.constraints,
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
                  padding: const EdgeInsets.symmetric(horizontal: 32),
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
            child: Button(
              size: ButtonSize.icon,
              type: ButtonType.ghost,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.code));
              },
              child: Icon(
                Icons.copy,
                size: 16,
              ),
            ),
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
    'keyword': TextStyle(color: theme.colorScheme.mutedForeground),
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
    'attr': TextStyle(color: theme.colorScheme.mutedForeground),
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
