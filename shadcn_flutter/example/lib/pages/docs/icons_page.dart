import 'package:example/radix_icons.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../bootstrap_icons.dart';
import '../docs_page.dart';

class IconsPage extends StatefulWidget {
  const IconsPage({Key? key}) : super(key: key);

  @override
  _IconsPageState createState() => _IconsPageState();
}

class _IconsPageState extends State<IconsPage> {
  // this separates "separateByCamelCase" to "separate By Camel Case"
  List<String> _separateByCamelCase(String text) {
    List<String> result = [];
    String current = '';
    for (int i = 0; i < text.length; i++) {
      if (text[i].toUpperCase() == text[i]) {
        result.add(current);
        current = text[i];
      } else {
        current += text[i];
      }
    }
    result.add(current);
    return result;
  }

  List<String> capitalizeWords(List<String> word) {
    // make sure to check the word length
    return word.map((e) {
      if (e.isEmpty) return e;
      if (e.length == 1) return e.toUpperCase();
      return e[0].toUpperCase() + e.substring(1);
    }).toList();
  }

  TextEditingController _controller = TextEditingController();

  void _onTap(String className, MapEntry<String, IconData> entry) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Text(
                capitalizeWords(_separateByCamelCase(entry.key)).join(' ')),
            leading: Icon(entry.value, size: 48),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Use this code to display this icon:'),
                gap(8),
                CodeSnippet(
                  code: 'Icon($className.${entry.key})',
                  mode: 'dart',
                ),
              ],
            ),
            actions: [
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'icons',
      scrollable: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Icons').h1(),
          Text('Use bundled icons in your application').lead(),
          gap(32),
          TextField(
            leading: Icon(Icons.search),
            placeholder: 'Search icons',
            controller: _controller,
          ),
          Expanded(
            child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  List<MapEntry<String, IconData>> filteredRadixIcons = [];
                  List<MapEntry<String, IconData>> filteredBootstrapIcons = [];

                  for (var entry in kRadixIcons.entries) {
                    if (_controller.text.isEmpty) {
                      filteredRadixIcons.add(entry);
                      continue;
                    }
                    String key = entry.key.toLowerCase();
                    if (key.contains(_controller.text.toLowerCase())) {
                      filteredRadixIcons.add(entry);
                    }
                  }
                  for (var entry in kBootstrapIcons.entries) {
                    if (_controller.text.isEmpty) {
                      filteredBootstrapIcons.add(entry);
                      continue;
                    }
                    String key = entry.key.toLowerCase();
                    if (key.contains(_controller.text.toLowerCase())) {
                      filteredBootstrapIcons.add(entry);
                    }
                  }
                  return ListView.separated(
                    itemCount: filteredRadixIcons.length +
                        filteredBootstrapIcons.length +
                        2,
                    padding: EdgeInsets.only(bottom: 32),
                    separatorBuilder: (context, index) {
                      return gap(8);
                    },
                    itemBuilder: (context, index) {
                      if (filteredRadixIcons.isNotEmpty) {
                        if (index == 0) {
                          // the header
                          return const Text('Radix Icons')
                              .h2()
                              .withPadding(bottom: 16);
                        }
                        if (index <= filteredRadixIcons.length) {
                          var e = filteredRadixIcons[index - 1];
                          return OutlineButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(e.value, size: 48),
                                  gap(8),
                                  Text(e.key),
                                ],
                              ),
                              trailing: Icon(Icons.chevron_right),
                              onPressed: () {
                                _onTap('RadixIcons', e);
                              });
                        }
                      }
                      if (filteredBootstrapIcons.isNotEmpty) {
                        if (index == filteredRadixIcons.length + 1) {
                          // the header
                          return const Text('Bootstrap Icons')
                              .h2()
                              .withPadding(bottom: 16);
                        }
                        if (index <=
                            filteredRadixIcons.length +
                                filteredBootstrapIcons.length +
                                1) {
                          var e = filteredBootstrapIcons[
                              index - filteredRadixIcons.length - 2];
                          return OutlineButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(e.value, size: 32),
                                  gap(4),
                                  Text(e.key),
                                ],
                              ),
                              trailing: Icon(Icons.chevron_right),
                              onPressed: () {
                                _onTap('BootstrapIcons', e);
                              });
                        }
                      }
                      return null;
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
