import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WidgetUsageExample extends StatefulWidget {
  final Widget child;
  final String path;

  const WidgetUsageExample({
    Key? key,
    required this.child,
    required this.path,
  }) : super(key: key);

  @override
  State<WidgetUsageExample> createState() => _WidgetUsageExampleState();
}

class _WidgetUsageExampleState extends State<WidgetUsageExample> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabList(
          index: index,
          children: [
            TabButton(
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              child: Text('Preview').semiBold().textSmall(),
            ),
            TabButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              child: Text('Code').semiBold().textSmall(),
            ),
          ],
        ),
        gap(12),
        index == 0
            ? OutlinedContainer(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  constraints: const BoxConstraints(minHeight: 350),
                  child: Center(
                    child: widget.child,
                  ),
                ),
              )
            : CodeSnippetFutureBuilder(
                path: widget.path,
                mode: 'dart',
              ),
      ],
    );
  }
}

class CodeSnippetFutureBuilder extends StatefulWidget {
  final String path;
  final String mode;

  const CodeSnippetFutureBuilder({
    Key? key,
    required this.path,
    required this.mode,
  }) : super(key: key);

  @override
  State<CodeSnippetFutureBuilder> createState() =>
      _CodeSnippetFutureBuilderState();
}

class _CodeSnippetFutureBuilderState extends State<CodeSnippetFutureBuilder> {
  late Future<String> futureCode;

  void _refresh() {
    //https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/example/lib/pages/docs/layout_page/layout_page_example_1.dart
    String url =
        'https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/example/${widget.path}';
    futureCode =
        http.get(Uri.parse(url)).then((response) => response.body).then((code) {
      try {
        return _formatCode(code);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        return code;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void didUpdateWidget(covariant CodeSnippetFutureBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<String>(
      future: futureCode,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          print(snapshot.stackTrace);
          return CodeSnippet(
            code:
                'Error loading code\n${snapshot.error}\n${snapshot.stackTrace}',
            mode: widget.mode,
            actions: [
              GhostButton(
                padding: Button.iconPadding,
                onPressed: _refresh,
                child: Icon(
                  Icons.refresh,
                  size: 16,
                ),
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return CodeSnippet(
              code: 'No code found',
              mode: widget.mode,
              actions: [
                GhostButton(
                  padding: Button.iconPadding,
                  onPressed: () {
                    // open in new tab
                    //https://github.com/sunarya-thito/shadcn_flutter/blob/master/example/lib/pages/docs/layout_page/layout_page_example_1.dart
                    String url =
                        'https://github.com/sunarya-thito/shadcn_flutter/blob/master/example/${widget.path}';
                    window.open(url, 'blank');
                  },
                  child: Icon(
                    Icons.open_in_new,
                    size: 16,
                  ),
                ),
              ],
            );
          }
          return CodeSnippet(
            code: snapshot.data!,
            mode: widget.mode,
            actions: [
              GhostButton(
                padding: Button.iconPadding,
                onPressed: () {
                  // open in new tab
                  //https://github.com/sunarya-thito/shadcn_flutter/blob/master/example/lib/pages/docs/layout_page/layout_page_example_1.dart
                  String url =
                      'https://github.com/sunarya-thito/shadcn_flutter/blob/master/example/${widget.path}';
                  window.open(url, 'blank');
                },
                child: Icon(
                  Icons.open_in_new,
                  size: 16,
                ),
              )
            ],
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.card,
              border: Border.all(
                color: theme.colorScheme.border,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(theme.radiusLg),
            ),
            height: 350,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

String _formatCode(String code) {
  RegExp exp = RegExp(
    r'return[\s]*(.+)?[\s]*;[\s]*}[\s]*}',
    multiLine: true,
    dotAll: true,
  );
  code = exp.firstMatch(code)!.group(1)!;
  // remove the indentation by one level for each line except the first line
  List<String> lines = code.split('\n');
  String formatted = lines.first + '\n';
  if (lines.length < 2) {
    return code;
  }
  // count the number of spaces in the 2nd line
  int spaces = lines[1].length - lines[1].trimLeft().length;
  // divide floor by 2 because 2
  spaces = (spaces / 2).floor();
  // spaces is now the standard indentation length
  // now replace the indentation with the standard indentation length
  for (int i = 1; i < lines.length; i++) {
    int sub = spaces.clamp(0, lines[i].length);
    formatted += lines[i].substring(sub) + '\n';
  }
  return formatted;
}
