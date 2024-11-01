import 'package:docs/radix_icons.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../bootstrap_icons.dart';
import '../docs_page.dart';

class IconsPage extends StatefulWidget {
  const IconsPage({super.key});

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

  final TextEditingController _controller = TextEditingController();

  void _onTap(String className, MapEntry<String, IconData> entry) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text(capitalizeWords(_separateByCamelCase(entry.key)).join(' ')),
          leading: Icon(entry.value, size: 48),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Use this code to display this icon:'),
              const Gap(8),
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
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'icons',
      scrollable: false,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          final theme = Theme.of(context);
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: theme.colorScheme.background,
              automaticallyImplyLeading: false,
              toolbarHeight: 50,
              collapsedHeight: 50,
              expandedHeight: 255,
              surfaceTintColor: theme.colorScheme.background,
              flexibleSpace: Stack(
                fit: StackFit.passthrough,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ShadcnUI(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Icons').h1(),
                          const Text('Use bundled icons in your application')
                              .lead(),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${kRadixIcons.length}')
                                              .textLarge(),
                                          const Text('Radix Icons')
                                              .muted()
                                              .textSmall(),
                                        ],
                                      ),
                                      Positioned(
                                        right: -32,
                                        bottom: -48,
                                        child: const Icon(
                                          RadixIcons.iconjarLogo,
                                          size: 96,
                                        )
                                            .iconMutedForeground()
                                            .withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${kBootstrapIcons.length}')
                                              .textLarge(),
                                          const Text('Bootstrap Icons')
                                              .muted()
                                              .textSmall(),
                                        ],
                                      ),
                                      Positioned(
                                        right: -32,
                                        bottom: -48,
                                        child: const Icon(
                                          BootstrapIcons.bootstrap,
                                          size: 96,
                                        )
                                            .iconMutedForeground()
                                            .withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).gap(12).p(),
                          const Gap(32),
                          TextField(
                            leading: const Icon(Icons.search),
                            placeholder: const Text('Search icons'),
                            controller: _controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: AnimatedBuilder(
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
              int additionalLength = 0;
              if (filteredRadixIcons.isNotEmpty) {
                additionalLength += 1;
              }
              if (filteredBootstrapIcons.isNotEmpty) {
                additionalLength += 1;
              }
              filteredBootstrapIcons.sort((a, b) => a.key.compareTo(b.key));
              filteredRadixIcons.sort((a, b) => a.key.compareTo(b.key));
              return ListView.separated(
                itemCount: filteredRadixIcons.length +
                    filteredBootstrapIcons.length +
                    additionalLength,
                padding: const EdgeInsets.only(bottom: 32),
                separatorBuilder: (context, index) {
                  return const Gap(8);
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
                          trailing: const Icon(Icons.chevron_right),
                          onPressed: () {
                            _onTap('RadixIcons', e);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedContainer(child: Icon(e.value, size: 48)),
                              const Gap(24),
                              Text(e.key),
                            ],
                          ));
                    }
                    index -= filteredRadixIcons.length + 1;
                  }
                  if (filteredBootstrapIcons.isNotEmpty) {
                    if (index == 0) {
                      // the header
                      return const Text('Bootstrap Icons')
                          .h2()
                          .withPadding(bottom: 16);
                    }
                    if (index <= filteredBootstrapIcons.length) {
                      var e = filteredBootstrapIcons[index - 1];
                      return OutlineButton(
                          trailing: const Icon(Icons.chevron_right),
                          onPressed: () {
                            _onTap('BootstrapIcons', e);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedContainer(child: Icon(e.value, size: 48)),
                              const Gap(24),
                              Text(e.key),
                            ],
                          ));
                    }
                    index -= filteredBootstrapIcons.length + 1;
                  }
                  return null;
                },
              );
            }),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //
      //     Expanded(
      //       child: A
      //     ),
      //   ],
      // ),
    );
  }
}
