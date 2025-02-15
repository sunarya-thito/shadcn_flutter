import 'package:http/http.dart' as http;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WidgetUsageExample extends StatefulWidget {
  final String? title;
  final Widget child;
  final String path;
  final bool summarize;

  const WidgetUsageExample({
    super.key,
    this.title,
    required this.child,
    required this.path,
    this.summarize = true,
  });

  @override
  State<WidgetUsageExample> createState() => _WidgetUsageExampleState();
}

class _WidgetUsageExampleState extends State<WidgetUsageExample> {
  int index = 0;
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) Text(widget.title!).h2(),
        if (widget.title != null) const Gap(12),
        TabList(
          index: index,
          onChanged: (value) {
            setState(() {
              index = value;
            });
          },
          children: [
            TabItem(child: const Text('Preview').semiBold().textSmall()),
            TabItem(child: const Text('Code').semiBold().textSmall()),
          ],
        ),
        const Gap(12),
        RepaintBoundary(
          child: Offstage(
            offstage: index != 0,
            child: OutlinedContainer(
              key: _key,
              child: ClipRect(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  constraints: const BoxConstraints(minHeight: 350),
                  child: Center(
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
        RepaintBoundary(
          child: Offstage(
            offstage: index != 1,
            child: CodeSnippetFutureBuilder(
              path: widget.path,
              mode: 'dart',
              summarize: widget.summarize,
            ),
          ),
        )
      ],
    );
  }
}

class CodeSnippetFutureBuilder extends StatefulWidget {
  final String path;
  final String mode;
  final bool summarize;

  const CodeSnippetFutureBuilder({
    super.key,
    required this.path,
    this.mode = 'dart',
    this.summarize = true,
  });

  @override
  State<CodeSnippetFutureBuilder> createState() =>
      _CodeSnippetFutureBuilderState();
}

class _CodeSnippetFutureBuilderState extends State<CodeSnippetFutureBuilder> {
  late Future<String> futureCode;

  void _refresh() {
    //https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs/lib/pages/docs/layout_page/layout_page_example_1.dart
    String url =
        'https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs/${widget.path}';
    futureCode =
        http.get(Uri.parse(url)).then((response) => response.body).then((code) {
      try {
        return widget.summarize ? _formatCode(code) : code;
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
                density: ButtonDensity.icon,
                onPressed: _refresh,
                child: const Icon(
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
                  density: ButtonDensity.icon,
                  onPressed: () {
                    // open in new tab
                    String url =
                        'https://github.com/sunarya-thito/shadcn_flutter/blob/master/docs/${widget.path}';
                    // html.window.open(url, 'blank');
                    launchUrlString(url);
                  },
                  child: const Icon(
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
                density: ButtonDensity.icon,
                onPressed: () {
                  // open in new tab
                  //https://github.com/sunarya-thito/shadcn_flutter/blob/master/docs/lib/pages/docs/layout_page/layout_page_example_1.dart
                  String url =
                      'https://github.com/sunarya-thito/shadcn_flutter/blob/master/docs/${widget.path}';
                  // html.window.open(url, 'blank');
                  launchUrlString(url);
                },
                child: const Icon(
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
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

String _formatCode(String code) {
  // check if code uses stateful widget
  if (code.contains('StatefulWidget')) {
    RegExp exp = RegExp(r'extends[\s]*State<.+?>[\s]*{[\s]*\n(.*)[\s]*}',
        multiLine: true, dotAll: true);
    var firstMatch = exp.firstMatch(code);
    if (firstMatch == null) {
      return code;
    }
    code = firstMatch.group(1)!;
    List<String> lines = code.split('\n');
    String formatted = '';
    // count the number of spaces in the 2nd line
    int spaces = lines.first.length - lines.first.trimLeft().length;
    // spaces is now the standard indentation length
    // now replace the indentation with the standard indentation length
    for (int i = 0; i < lines.length; i++) {
      int sub = spaces.clamp(0, lines[i].length);
      formatted += lines[i].substring(sub);
      if (i < lines.length - 1) {
        formatted += '\n';
      }
    }
    return formatted;
  }
  RegExp exp = RegExp(
    r'return[\s]*(.+)?[\s]*;[\s]*}[\s]*}',
    multiLine: true,
    dotAll: true,
  );
  var firstMatch = exp.firstMatch(code);
  assert(firstMatch != null, 'Code snippet must have a return statement');
  code = firstMatch!.group(1)!;
  // remove the indentation by one level for each line except the first line
  List<String> lines = code.split('\n');
  String formatted = lines.first;
  if (lines.length < 2) {
    return code;
  }
  formatted += '\n';
  // count the number of spaces in the 2nd line
  int spaces = lines[1].length - lines[1].trimLeft().length;
  // divide floor by 2 because 2
  spaces = (spaces / 2).floor() + 1;
  // spaces is now the standard indentation length
  // now replace the indentation with the standard indentation length
  for (int i = 1; i < lines.length; i++) {
    int sub = spaces.clamp(0, lines[i].length);
    formatted += lines[i].substring(sub);
    if (i < lines.length - 1) {
      formatted += '\n';
    }
  }
  return formatted;
}
