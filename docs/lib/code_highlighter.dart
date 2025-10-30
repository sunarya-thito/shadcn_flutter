import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeHighlighter extends StatefulWidget {
  final String code;
  final String mode;

  const CodeHighlighter({
    super.key,
    required this.code,
    required this.mode,
  });

  @override
  State<CodeHighlighter> createState() => _CodeHighlighterState();
}

class _CodeHighlighterState extends State<CodeHighlighter> {
  static final Map<String, FutureOr<bool>> _initializedLanguages = {};
  static final Map<Brightness, FutureOr<HighlighterTheme>> _initializedThemes =
      {};

  static FutureOr<bool> initializeLanguage(String mode) {
    final current = _initializedLanguages[mode];
    if (current != null) {
      return current;
    }
    final future = Highlighter.initialize([mode]).then((_) {
      _initializedLanguages[mode] = true;
      return true;
    });
    _initializedLanguages[mode] = future;
    return future;
  }

  static FutureOr<HighlighterTheme> initializeTheme(Brightness brightness) {
    final current = _initializedThemes[brightness];
    if (current != null) {
      return current;
    }
    final future = HighlighterTheme.loadForBrightness(brightness).then(
      (value) {
        _initializedThemes[brightness] = value;
        return value;
      },
    );
    _initializedThemes[brightness] = future;
    return future;
  }

  FutureOr<HighlighterTheme> _request() {
    var brightness = Theme.of(context).brightness;
    return initializeLanguage(widget.mode).then((_) {
      return initializeTheme(brightness);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureOrBuilder(
      future: _request().catchError((err, stackTrace) {
        if (kDebugMode) {
          print(err);
          print(stackTrace);
        }
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        if (snapshot.hasData) {
          return SelectableText.rich(
              Highlighter(language: widget.mode, theme: snapshot.requireData)
                  .highlight(widget.code));
        }
        return const Text('Empty');
      },
    );
  }
}

class CodeBlock extends StatelessWidget {
  final String code;
  final String mode;
  final List<Widget> actions;

  const CodeBlock({
    super.key,
    required this.code,
    required this.mode,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return CodeSnippet(
      code: CodeHighlighter(code: code, mode: mode),
      actions: [
        ...actions,
        IconButton.ghost(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: code)).then((_) {
              if (context.mounted) {
                showToast(
                  context: context,
                  builder: (context, overlay) {
                    return const Card(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          Icon(Icons.check),
                          Text('Copied to clipboard'),
                        ],
                      ),
                    );
                  },
                );
              }
            });
          },
          icon: const Icon(
            Icons.copy,
            size: 16,
          ),
        ),
      ],
    );
  }
}
