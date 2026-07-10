import 'package:docs/code_highlighter.dart';
import 'package:docs/radix_icons.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../bootstrap_icons.dart';
import '../../lucide_icons.dart';
import '../docs_page.dart';

class IconsPage extends StatefulWidget {
  const IconsPage({super.key});

  @override
  IconsPageState createState() => IconsPageState();
}

class IconsPageState extends State<IconsPage> {
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
          content: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Use this code to display this icon:'),
                const Gap(8),
                CodeBlock(
                  code: 'Icon($className.${entry.key})',
                  mode: 'dart',
                ),
              ],
            ),
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
    final theme = Theme.of(context);
    return DocsPage(
      name: 'icons',
      scrollable: false,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [];
        },
        body: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              List<MapEntry<String, IconData>> filteredRadixIcons = [];
              List<MapEntry<String, IconData>> filteredBootstrapIcons = [];
              List<MapEntry<String, IconData>> filteredLucideIcons = [];

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
              for (var entry in kLucideIcons.entries) {
                if (_controller.text.isEmpty) {
                  filteredLucideIcons.add(entry);
                  continue;
                }
                String key = entry.key.toLowerCase();
                if (key.contains(_controller.text.toLowerCase())) {
                  filteredLucideIcons.add(entry);
                }
              }
              filteredBootstrapIcons.sort((a, b) => a.key.compareTo(b.key));
              filteredRadixIcons.sort((a, b) => a.key.compareTo(b.key));
              filteredLucideIcons.sort((a, b) => a.key.compareTo(b.key));
              return DefaultTextStyle.merge(
                maxLines: 1,
                child: CustomScrollView(slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: theme.colorScheme.background,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 36,
                    collapsedHeight: 36,
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
                                const Text(
                                        'Use bundled icons in your application')
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
                                                Text('${kLucideIcons.length}')
                                                    .textLarge(),
                                                const Text('Lucide Icons')
                                                    .muted()
                                                    .textSmall(),
                                              ],
                                            ),
                                            Positioned(
                                              right: -32,
                                              bottom: -48,
                                              child: const Icon(
                                                LucideIcons.badgeInfo,
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
                                  placeholder: const Text('Search icons'),
                                  controller: _controller,
                                  features: const [
                                    InputFeature.leading(Icon(Icons.search)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (filteredRadixIcons.isNotEmpty) ...[
                    SliverPersistentHeader(
                      delegate: _Header('Radix Icons'),
                      pinned: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var e = filteredRadixIcons[index];
                            return Tooltip(
                              tooltip: TooltipContainer(
                                child: Text(e.key),
                              ),
                              child: OutlineButton(
                                onPressed: () {
                                  _onTap('RadixIcons', e);
                                },
                                child: Icon(e.value, size: 48),
                              ),
                            );
                          },
                          childCount: filteredRadixIcons.length,
                        ),
                      ),
                    ),
                  ],
                  if (filteredBootstrapIcons.isNotEmpty) ...[
                    SliverPersistentHeader(
                      delegate: _Header('Bootstrap Icons'),
                      pinned: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var e = filteredBootstrapIcons[index];
                            return Tooltip(
                              tooltip: TooltipContainer(
                                child: Text(e.key),
                              ),
                              child: OutlineButton(
                                onPressed: () {
                                  _onTap('BootstrapIcons', e);
                                },
                                child: Icon(e.value, size: 48),
                              ),
                            );
                          },
                          childCount: filteredBootstrapIcons.length,
                        ),
                      ),
                    ),
                  ],
                  if (filteredLucideIcons.isNotEmpty) ...[
                    SliverPersistentHeader(
                      delegate: _Header('Lucide Icons'),
                      pinned: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var e = filteredLucideIcons[index];
                            return Tooltip(
                              tooltip: TooltipContainer(
                                child: Text(e.key),
                              ),
                              child: OutlineButton(
                                onPressed: () {
                                  _onTap('LucideIcons', e);
                                },
                                child: Icon(e.value, size: 48),
                              ),
                            );
                          },
                          childCount: filteredLucideIcons.length,
                        ),
                      ),
                    ),
                  ],
                ]),
              );
            }),
      ),
    );
  }
}

class _Header extends SliverPersistentHeaderDelegate {
  final String text;

  _Header(this.text);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text).x3Large().semiBold(),
          const Gap(8),
          const Divider(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant _Header oldDelegate) {
    return text != oldDelegate.text;
  }
}
