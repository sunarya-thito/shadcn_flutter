import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show FlutterLogo;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

const double breakpointWidth = 768;
const double breakpointWidth2 = 1024;

extension CustomWidgetExtension on Widget {
  Widget anchored(OnThisPage onThisPage) {
    return PageItemWidget(
      onThisPage: onThisPage,
      child: this,
    );
  }
}

void openInNewTab(String url) {
  html.window.open(url, '_blank');
}

class OnThisPage extends LabeledGlobalKey {
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  OnThisPage([super.debugLabel]);
}

class PageItemWidget extends StatelessWidget {
  final OnThisPage onThisPage;
  final Widget child;

  const PageItemWidget({
    Key? key,
    required this.onThisPage,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: onThisPage,
      child: child,
      onVisibilityChanged: (info) {
        onThisPage.isVisible.value = info.visibleFraction >= 1;
      },
    );
  }
}

class DocsPage extends StatefulWidget {
  final String name;
  final Widget child;
  final Map<String, OnThisPage> onThisPage;

  const DocsPage({
    Key? key,
    required this.name,
    required this.child,
    this.onThisPage = const {},
  }) : super(key: key);

  @override
  DocsPageState createState() => DocsPageState();
}

class ShadcnDocsPage {
  final String title;
  final String name; // name for go_router

  const ShadcnDocsPage(this.title, this.name);
}

class ShadcnDocsSection {
  final String title;
  final List<ShadcnDocsPage> pages;

  const ShadcnDocsSection(this.title, this.pages);
}

class DocsPageState extends State<DocsPage> {
  static const List<ShadcnDocsSection> sections = [
    ShadcnDocsSection('Getting Started', [
      ShadcnDocsPage('Introduction', 'introduction'),
      ShadcnDocsPage('Installation', 'installation'),
      ShadcnDocsPage('Theme', 'theme'),
      ShadcnDocsPage('Typography', 'typography'),
      ShadcnDocsPage('Layout', 'layout'),
    ]),
    ShadcnDocsSection('Components', [
      ShadcnDocsPage('Accordion', 'accordion'),
      ShadcnDocsPage('Alert', 'alert'),
      ShadcnDocsPage('Alert Dialog', 'alert_dialog'),
      ShadcnDocsPage('Avatar', 'avatar'),
      ShadcnDocsPage('Badge', 'badge'),
      ShadcnDocsPage('Breadcrumb', 'breadcrumb'),
      ShadcnDocsPage('Button', 'button'),
      ShadcnDocsPage('Calendar', 'calendar'),
      ShadcnDocsPage('Card', 'card'),
      ShadcnDocsPage('Carousel', 'carousel'),
      ShadcnDocsPage('Checkbox', 'checkbox'),
      ShadcnDocsPage('Circular Progress', 'circular_progress'),
      ShadcnDocsPage('Code Snippet', 'code_snippet'),
      ShadcnDocsPage('Collapsible', 'collapsible'),
      ShadcnDocsPage('Color Picker', 'color_picker'),
      ShadcnDocsPage('Combo Box', 'combo_box'),
      ShadcnDocsPage('Command', 'command'),
      ShadcnDocsPage('Dialog', 'dialog'),
      ShadcnDocsPage('Divider', 'divider'),
      ShadcnDocsPage('Drawer', 'drawer'),
      ShadcnDocsPage('Dropdown', 'dropdown'),
      ShadcnDocsPage('Data Table', 'data_table'),
      ShadcnDocsPage('Form', 'form'),
      ShadcnDocsPage('Hover Card', 'hover_card'),
      ShadcnDocsPage('Input', 'input'),
      ShadcnDocsPage('Input OTP', 'input_otp'),
      ShadcnDocsPage('Label', 'label'),
      ShadcnDocsPage('Menubar', 'menubar'),
      ShadcnDocsPage('Navigation Menu', 'navigation_menu'),
      ShadcnDocsPage('Pagination', 'pagination'),
      ShadcnDocsPage('Popover', 'popover'),
      ShadcnDocsPage('Progress', 'progress'),
      ShadcnDocsPage('Radio Group', 'radio_group'),
      ShadcnDocsPage('Resizable', 'resizable'),
      ShadcnDocsPage('Sheet', 'sheet'),
      ShadcnDocsPage('Skeleton', 'skeleton'),
      ShadcnDocsPage('Slider', 'slider'),
      ShadcnDocsPage('Sonner', 'sonner'),
      ShadcnDocsPage('Steps', 'steps'),
      ShadcnDocsPage('Switch', 'switch'),
      ShadcnDocsPage('Table', 'table'),
      ShadcnDocsPage('Tabs', 'tabs'),
      ShadcnDocsPage('Text Area', 'text_area'),
      ShadcnDocsPage('Toast', 'toast'),
      ShadcnDocsPage('Toggle', 'toggle'),
      ShadcnDocsPage('Tooltip', 'tooltip'),
    ]),
  ];
  bool toggle = false;
  List<OnThisPage> currentlyVisible = [];

  @override
  void initState() {
    super.initState();
    for (final child in widget.onThisPage.values) {
      child.isVisible.addListener(_onVisibilityChanged);
    }
  }

  @override
  void didUpdateWidget(covariant DocsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!mapEquals(oldWidget.onThisPage, widget.onThisPage)) {
      for (final child in widget.onThisPage.values) {
        child.isVisible.addListener(_onVisibilityChanged);
      }
    }
  }

  @override
  void dispose() {
    for (final child in widget.onThisPage.values) {
      child.isVisible.removeListener(_onVisibilityChanged);
    }
    super.dispose();
  }

  void _onVisibilityChanged() {
    setState(() {
      currentlyVisible = widget.onThisPage.values
          .where((element) => element.isVisible.value)
          .toList();
    });
  }

  bool isVisible(OnThisPage onThisPage) {
    return currentlyVisible.isNotEmpty && currentlyVisible[0] == onThisPage;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, OnThisPage> onThisPage = widget.onThisPage;
    ShadcnDocsPage? page = sections
        .expand((e) => e.pages)
        .where((e) => e.name == widget.name)
        .firstOrNull;

    final theme = Theme.of(context);

    return Scaffold(
      scrollable: false,
      body: StageContainer(
        builder: (context, padding) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 72 + 1),
                    Expanded(
                      child: Builder(builder: (context) {
                        var hasOnThisPage = onThisPage.isNotEmpty;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MediaQueryVisibility(
                              minWidth: breakpointWidth,
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    top: 32,
                                    left: 24 + padding.left,
                                    bottom: 32),
                                child: SidebarNav(children: [
                                  for (var section in sections)
                                    SidebarSection(
                                      header: Text(section.title),
                                      children: [
                                        for (var page in section.pages)
                                          SidebarButton(
                                            onPressed: () {
                                              context.goNamed(page.name);
                                            },
                                            selected: page.name == widget.name,
                                            child: Text(page.title),
                                          ),
                                      ],
                                    ),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                padding: !hasOnThisPage
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 32,
                                      ).copyWith(
                                        right: padding.right,
                                      )
                                    : const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 32,
                                      ).copyWith(right: 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Breadcrumb(
                                      separator: Breadcrumb.arrowSeparator,
                                      children: [
                                        Text('Docs'),
                                        if (page != null) Text(page.title),
                                      ],
                                    ),
                                    gap(16),
                                    widget.child,
                                  ],
                                ),
                              ),
                            ),
                            if (hasOnThisPage)
                              MediaQueryVisibility(
                                minWidth: breakpointWidth2,
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                    top: 32,
                                    right: 24 + padding.right,
                                    bottom: 32,
                                    left: 24,
                                  ),
                                  child: SidebarNav(children: [
                                    SidebarSection(
                                      header: const Text('On This Page'),
                                      children: [
                                        for (var key in onThisPage.keys)
                                          SidebarButton(
                                            onPressed: () {
                                              Scrollable.ensureVisible(
                                                  onThisPage[key]!
                                                      .currentContext!,
                                                  duration: kDefaultDuration,
                                                  alignmentPolicy:
                                                      ScrollPositionAlignmentPolicy
                                                          .explicit);
                                            },
                                            selected:
                                                isVisible(onThisPage[key]!),
                                            child: Text(key),
                                          ),
                                      ],
                                    ),
                                  ]),
                                ),
                              )
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 72 + 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MediaQueryVisibility(
                      minWidth: breakpointWidth,
                      alternateChild: ClipRect(
                        clipBehavior: Clip.hardEdge,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 72,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                            ),
                            child: Row(
                              children: [
                                GhostButton(
                                  padding: Button.iconPadding,
                                  onPressed: () {
                                    context.goNamed('home');
                                  },
                                  child: Icon(Icons.menu),
                                ),
                                Spacer(),
                                GhostButton(
                                  padding: Button.iconPadding,
                                  onPressed: () {
                                    openInNewTab(
                                        'https://github.com/sunarya-thito/shadcn_flutter');
                                  },
                                  child: FaIcon(FontAwesomeIcons.github),
                                ),
                                // pub.dev icon
                                GhostButton(
                                    padding: Button.iconPadding,
                                    onPressed: () {
                                      openInNewTab(
                                          'https://pub.dev/packages/shadcn_flutter');
                                    },
                                    child: ColorFiltered(
                                      // turns into white
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.primary,
                                        BlendMode.srcIn,
                                      ),
                                      child: FlutterLogo(
                                        size: 24,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: ClipRect(
                        clipBehavior: Clip.hardEdge,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 72,
                            padding: padding,
                            child: Row(
                              children: [
                                FlutterLogo(
                                  size: 32,
                                ),
                                gap(18),
                                Text('Shadcn Flutter').textLarge(),
                                Spacer(),
                                GhostButton(
                                  padding: Button.iconPadding,
                                  onPressed: () {
                                    openInNewTab(
                                        'https://github.com/sunarya-thito/shadcn_flutter');
                                  },
                                  child: FaIcon(FontAwesomeIcons.github),
                                ),
                                // pub.dev icon
                                GhostButton(
                                    padding: Button.iconPadding,
                                    onPressed: () {
                                      openInNewTab(
                                          'https://pub.dev/packages/shadcn_flutter');
                                    },
                                    child: ColorFiltered(
                                      // turns into white
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.primary,
                                        BlendMode.srcIn,
                                      ),
                                      child: FlutterLogo(
                                        size: 24,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
