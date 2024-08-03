import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../main.dart';
import 'docs/sidebar_nav.dart';

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
  launchUrlString(url);
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
  final List<Widget> navigationItems;
  final bool scrollable;
  const DocsPage({
    Key? key,
    required this.name,
    required this.child,
    this.onThisPage = const {},
    this.navigationItems = const [],
    this.scrollable = true,
  }) : super(key: key);

  @override
  DocsPageState createState() => DocsPageState();
}

enum ShadcnFeatureTag {
  newFeature,
  updated,
  experimental,
  workInProgress;

  Widget buildBadge(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ThemeData copy;
    String badgeText;
    switch (this) {
      case ShadcnFeatureTag.newFeature:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.green,
          ),
        );
        badgeText = 'New';
        break;
      case ShadcnFeatureTag.updated:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.blue,
          ),
        );
        badgeText = 'Updated';
        break;
      case ShadcnFeatureTag.workInProgress:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.orange,
          ),
        );
        badgeText = 'WIP';
        break;
      case ShadcnFeatureTag.experimental:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
          ),
        );
        badgeText = 'Experimental';
        break;
    }
    return Theme(
      data: copy,
      child: PrimaryBadge(
        child: Text(badgeText),
      ),
    );
  }
}

class ShadcnDocsPage {
  final String title;
  final String name; // name for go_router
  final ShadcnFeatureTag? tag;

  ShadcnDocsPage(this.title, this.name, [this.tag]);
}

class ShadcnDocsSection {
  final String title;
  final List<ShadcnDocsPage> pages;
  final IconData icon;

  ShadcnDocsSection(this.title, this.pages, [this.icon = Icons.book]);
}

class DocsPageState extends State<DocsPage> {
  static final List<ShadcnDocsSection> sections = [
    ShadcnDocsSection(
        'Getting Started',
        List.unmodifiable([
          ShadcnDocsPage('Introduction', 'introduction'),
          ShadcnDocsPage('Installation', 'installation'),
          ShadcnDocsPage('Theme', 'theme'),
          ShadcnDocsPage('Typography', 'typography'),
          ShadcnDocsPage('Layout', 'layout'),
          ShadcnDocsPage('Web Preloader', 'web_preloader'),
          ShadcnDocsPage('Components', 'components'),
          ShadcnDocsPage('Icons', 'icons'),
          ShadcnDocsPage('Colors', 'colors'),
          ShadcnDocsPage('Material/Cupertino', 'external'),
        ]),
        Icons.book),
    // COMPONENTS BEGIN
    ShadcnDocsSection(
      'Animation',
      [
        ShadcnDocsPage('Animated Value', 'animated_value_builder'),
        // https://nyxbui.design/docs/components/number-ticker
        ShadcnDocsPage(
            'Number Ticker', 'number_ticker', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Repeated Animation', 'repeated_animation_builder'),
      ],
    ),
    ShadcnDocsSection(
      'Disclosure',
      [
        ShadcnDocsPage('Accordion', 'accordion'),
        ShadcnDocsPage('Collapsible', 'collapsible'),
      ],
    ),
    ShadcnDocsSection(
      'Feedback',
      [
        ShadcnDocsPage('Alert', 'alert'),
        ShadcnDocsPage('Alert Dialog', 'alert_dialog'),
        ShadcnDocsPage('Circular Progress', 'circular_progress'),
        ShadcnDocsPage('Progress', 'progress'),
        ShadcnDocsPage('Linear Progress', 'linear_progress',
            ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Skeleton', 'skeleton'),
        ShadcnDocsPage('Toast', 'toast'),
      ],
    ),
    ShadcnDocsSection(
      'Forms',
      [
        ShadcnDocsPage('Button', 'button'),
        ShadcnDocsPage('Checkbox', 'checkbox'),
        ShadcnDocsPage(
            'Chip Input', 'chip_input', ShadcnFeatureTag.experimental),
        ShadcnDocsPage(
            'Color Picker', 'color_picker', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Date Picker', 'date_picker'),
        // TODO: https://file-vault-delta.vercel.app/ also https://uploader.sadmn.com/
        ShadcnDocsPage(
            'File Picker', 'file_picker', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Form', 'form'),
        // TODO: Image Input (with cropper and rotate tool, upload from file or take photo from camera)
        ShadcnDocsPage(
            'Image Input', 'image_input', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Input', 'input'),
        ShadcnDocsPage('Input OTP', 'input_otp'),
        ShadcnDocsPage(
            'Phone Input', 'phone_input', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Radio Group', 'radio_group'),
        ShadcnDocsPage('Select', 'select'),
        ShadcnDocsPage('Slider', 'slider'),
        ShadcnDocsPage(
            'Star Rating', 'star_rating', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Switch', 'switch'),
        ShadcnDocsPage('Text Area', 'text_area'),
        ShadcnDocsPage(
            'Time Picker', 'time_picker', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Toggle', 'toggle'),
      ],
    ),
    ShadcnDocsSection(
      'Layout',
      [
        ShadcnDocsPage('Card', 'card'),
        ShadcnDocsPage('Carousel', 'carousel'),
        ShadcnDocsPage('Divider', 'divider'),
        ShadcnDocsPage('Resizable', 'resizable'),
        // https://nextjs-shadcn-dnd.vercel.app/ (make it headless)
        ShadcnDocsPage('Sortable', 'sortable', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Steps', 'steps'),
        ShadcnDocsPage('Stepper', 'stepper', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Timeline', 'timeline', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Scaffold', 'scaffold', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('App Bar', 'app_bar', ShadcnFeatureTag.workInProgress),
        // aka Bottom Navigation Bar
        ShadcnDocsPage('Navigation Bar', 'navigation_bar',
            ShadcnFeatureTag.workInProgress),
        // aka Sidebar
        ShadcnDocsPage('Navigation Rail', 'navigation_rail',
            ShadcnFeatureTag.workInProgress),
        // aka Drawer
        ShadcnDocsPage('Navigation Drawer', 'navigation_drawer',
            ShadcnFeatureTag.workInProgress),
      ],
    ),
    ShadcnDocsSection(
      'Navigation',
      [
        ShadcnDocsPage('Breadcrumb', 'breadcrumb'),
        ShadcnDocsPage('Menubar', 'menubar'),
        ShadcnDocsPage('Navigation Menu', 'navigation_menu'),
        ShadcnDocsPage('Pagination', 'pagination'),
        ShadcnDocsPage('Tabs', 'tabs'),
        ShadcnDocsPage('Tab List', 'tab_list'),
        ShadcnDocsPage('Tree', 'tree', ShadcnFeatureTag.experimental),
      ],
    ),
    ShadcnDocsSection(
      'Surfaces',
      [
        ShadcnDocsPage('Dialog', 'dialog'),
        ShadcnDocsPage('Drawer', 'drawer'),
        ShadcnDocsPage('Hover Card', 'hover_card'),
        ShadcnDocsPage('Popover', 'popover'),
        ShadcnDocsPage('Sheet', 'sheet'),
        ShadcnDocsPage('Tooltip', 'tooltip'),
      ],
    ),
    ShadcnDocsSection(
      'Data Display',
      [
        ShadcnDocsPage('Avatar', 'avatar'),
        ShadcnDocsPage(
            'Avatar Group', 'avatar_group', ShadcnFeatureTag.experimental),
        ShadcnDocsPage(
            'Data Table', 'data_table', ShadcnFeatureTag.workInProgress),
        // TODO also make it zoomable like: https://zoom-chart-demo.vercel.app/
        ShadcnDocsPage('Chart', 'chart', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Code Snippet', 'code_snippet'),
        ShadcnDocsPage('Table', 'table', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Tracker', 'tracker', ShadcnFeatureTag.experimental),
      ],
    ),
    ShadcnDocsSection(
      'Utilities',
      [
        ShadcnDocsPage('Badge', 'badge'),
        ShadcnDocsPage('Chip', 'chip'),
        ShadcnDocsPage('Calendar', 'calendar'),
        ShadcnDocsPage('Command', 'command'),
        ShadcnDocsPage('Context Menu', 'context_menu'),
        ShadcnDocsPage('Dropdown Menu', 'dropdown_menu'),
        // TODO: Same progress as image input
        ShadcnDocsPage(
            'Image Tools', 'image_tools', ShadcnFeatureTag.workInProgress),
      ],
    ),
    // COMPONENTS END
  ];

  List<String> componentCategories = [
    'Animation',
    'Disclosure',
    'Feedback',
    'Forms',
    'Layout',
    'Navigation',
    'Surfaces',
    'Data Display',
    'Utilities',
  ];
  bool toggle = false;
  List<OnThisPage> currentlyVisible = [];

  @override
  void initState() {
    super.initState();
    for (final child in widget.onThisPage.values) {
      child.isVisible.addListener(_onVisibilityChanged);
    }
    // count compoents
    int count = 0;
    int workInProgress = 0;
    for (var section in sections) {
      if (componentCategories.contains(section.title)) {
        count += section.pages.length;
        for (var page in section.pages) {
          if (page.tag == ShadcnFeatureTag.workInProgress) {
            workInProgress++;
          }
        }
      }
    }
    // sort every components category
    for (var section in sections) {
      if (componentCategories.contains(section.title)) {
        section.pages.sort((a, b) => a.title.compareTo(b.title));
      }
    }
    if (kDebugMode) {
      print('Total components: $count');
      print('Work in Progress: $workInProgress');
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
    if (!mounted) return;
    setState(() {
      currentlyVisible = widget.onThisPage.values
          .where((element) => element.isVisible.value)
          .toList();
    });
  }

  bool isVisible(OnThisPage onThisPage) {
    return currentlyVisible.isNotEmpty && currentlyVisible[0] == onThisPage;
  }

  void showSearchBar() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: 510,
              height: 349,
              child: Command(
                debounceDuration: Duration.zero,
                builder: (context, query) async* {
                  for (final section in sections) {
                    final List<Widget> resultItems = [];
                    for (final page in section.pages) {
                      if (query == null ||
                          page.title
                              .toLowerCase()
                              .contains(query.toLowerCase())) {
                        resultItems.add(CommandItem(
                          title: Text(page.title),
                          trailing: Icon(section.icon),
                          onTap: () {
                            context.goNamed(page.name);
                          },
                        ));
                      }
                    }
                    if (resultItems.isNotEmpty) {
                      yield [
                        CommandCategory(
                          title: Text(section.title),
                          children: resultItems,
                        ),
                      ];
                    }
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, OnThisPage> onThisPage = widget.onThisPage;
    ShadcnDocsPage? page = sections
        .expand((e) => e.pages)
        .where((e) => e.name == widget.name)
        .firstOrNull;

    final theme = Theme.of(context);

    return SafeArea(
      child: ClipRect(
        child: PageStorage(
          bucket: docsBucket,
          child: Builder(builder: (context) {
            return StageContainer(
              builder: (context, padding) {
                return Scaffold(
                  headers: [
                    Container(
                      constraints: BoxConstraints(
                          // maxHeight: 200,
                          ),
                      color: theme.colorScheme.background.withOpacity(0.3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MediaQueryVisibility(
                            minWidth: breakpointWidth,
                            alternateChild: FocusTraversalGroup(
                              child: ClipRect(
                                clipBehavior: Clip.hardEdge,
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    height: 72,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        GhostButton(
                                          density: ButtonDensity.icon,
                                          onPressed: () {
                                            _openDrawer(context);
                                          },
                                          child: const Icon(Icons.menu),
                                        ),
                                        Gap(18),
                                        Expanded(
                                          child: OutlineButton(
                                            onPressed: () {
                                              showSearchBar();
                                            },
                                            trailing: const Icon(Icons.search)
                                                .iconSmall()
                                                .iconMuted(),
                                            child: const Text(
                                                    'Search documentation...')
                                                .muted()
                                                .normal(),
                                          ),
                                        ),
                                        Gap(18),
                                        GhostButton(
                                          density: ButtonDensity.icon,
                                          onPressed: () {
                                            openInNewTab(
                                                'https://github.com/sunarya-thito/shadcn_flutter');
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.github,
                                            color: theme.colorScheme
                                                .secondaryForeground,
                                          ),
                                        ),
                                        // pub.dev icon
                                        GhostButton(
                                            density: ButtonDensity.icon,
                                            onPressed: () {
                                              openInNewTab(
                                                  'https://pub.dev/packages/shadcn_flutter');
                                            },
                                            child: ColorFiltered(
                                              // turns into white
                                              colorFilter: ColorFilter.mode(
                                                theme.colorScheme
                                                    .secondaryForeground,
                                                BlendMode.srcIn,
                                              ),
                                              child: const FlutterLogo(
                                                size: 24,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: FocusTraversalGroup(
                              child: ClipRect(
                                clipBehavior: Clip.hardEdge,
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    height: 72,
                                    padding: padding,
                                    child: Row(
                                      children: [
                                        const FlutterLogo(
                                          size: 32,
                                        ),
                                        Gap(18),
                                        const Text(
                                          'shadcn_flutter',
                                        ).textLarge().mono(),
                                        const Spacer(),
                                        Gap(18),
                                        SizedBox(
                                          width: 320 - 18,
                                          // height: 32,
                                          child: OutlineButton(
                                            onPressed: () {
                                              showSearchBar();
                                            },
                                            trailing: const Icon(Icons.search)
                                                .iconSmall()
                                                .iconMuted(),
                                            child: const Text(
                                                    'Search documentation...')
                                                .muted()
                                                .normal(),
                                          ),
                                        ),
                                        Gap(18),
                                        GhostButton(
                                          density: ButtonDensity.icon,
                                          onPressed: () {
                                            openInNewTab(
                                                'https://github.com/sunarya-thito/shadcn_flutter');
                                          },
                                          child: FaIcon(FontAwesomeIcons.github,
                                              color: theme.colorScheme
                                                  .secondaryForeground),
                                        ),
                                        // pub.dev icon
                                        GhostButton(
                                            density: ButtonDensity.icon,
                                            onPressed: () {
                                              openInNewTab(
                                                  'https://pub.dev/packages/shadcn_flutter');
                                            },
                                            child: ColorFiltered(
                                              // turns into white
                                              colorFilter: ColorFilter.mode(
                                                theme.colorScheme
                                                    .secondaryForeground,
                                                BlendMode.srcIn,
                                              ),
                                              child: const FlutterLogo(
                                                size: 24,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    // ExpandableAppBar(
                    //   child: Container(
                    //     constraints: BoxConstraints(
                    //       minHeight: 100,
                    //       maxHeight: 150,
                    //     ),
                    //     // color: theme.colorScheme.background.withOpacity(0.3),
                    //     color: Colors.blue,
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: [
                    //         Expanded(
                    //           child: MediaQueryVisibility(
                    //             minWidth: breakpointWidth,
                    //             alternateChild: FocusTraversalGroup(
                    //               child: ClipRect(
                    //                 clipBehavior: Clip.hardEdge,
                    //                 child: BackdropFilter(
                    //                   filter: ImageFilter.blur(
                    //                       sigmaX: 10, sigmaY: 10),
                    //                   child: Container(
                    //                     height: 72,
                    //                     padding: const EdgeInsets.symmetric(
                    //                       horizontal: 32,
                    //                       vertical: 8,
                    //                     ),
                    //                     child: Row(
                    //                       children: [
                    //                         GhostButton(
                    //                           density: ButtonDensity.icon,
                    //                           onPressed: () {
                    //                             _openDrawer(context);
                    //                           },
                    //                           child: const Icon(Icons.menu),
                    //                         ),
                    //                         Gap(18),
                    //                         Expanded(
                    //                           child: OutlineButton(
                    //                             onPressed: () {
                    //                               showSearchBar();
                    //                             },
                    //                             trailing:
                    //                                 const Icon(Icons.search)
                    //                                     .iconSmall()
                    //                                     .iconMuted(),
                    //                             child: const Text(
                    //                                     'Search documentation...')
                    //                                 .muted()
                    //                                 .normal(),
                    //                           ),
                    //                         ),
                    //                         Gap(18),
                    //                         GhostButton(
                    //                           density: ButtonDensity.icon,
                    //                           onPressed: () {
                    //                             openInNewTab(
                    //                                 'https://github.com/sunarya-thito/shadcn_flutter');
                    //                           },
                    //                           child: FaIcon(
                    //                             FontAwesomeIcons.github,
                    //                             color: theme.colorScheme
                    //                                 .secondaryForeground,
                    //                           ),
                    //                         ),
                    //                         // pub.dev icon
                    //                         GhostButton(
                    //                             density: ButtonDensity.icon,
                    //                             onPressed: () {
                    //                               openInNewTab(
                    //                                   'https://pub.dev/packages/shadcn_flutter');
                    //                             },
                    //                             child: ColorFiltered(
                    //                               // turns into white
                    //                               colorFilter: ColorFilter.mode(
                    //                                 theme.colorScheme
                    //                                     .secondaryForeground,
                    //                                 BlendMode.srcIn,
                    //                               ),
                    //                               child: const FlutterLogo(
                    //                                 size: 24,
                    //                               ),
                    //                             )),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             child: FocusTraversalGroup(
                    //               child: ClipRect(
                    //                 clipBehavior: Clip.hardEdge,
                    //                 child: BackdropFilter(
                    //                   filter: ImageFilter.blur(
                    //                       sigmaX: 10, sigmaY: 10),
                    //                   child: Container(
                    //                     height: 72,
                    //                     padding: padding,
                    //                     child: Row(
                    //                       children: [
                    //                         const FlutterLogo(
                    //                           size: 32,
                    //                         ),
                    //                         Gap(18),
                    //                         const Text(
                    //                           'shadcn_flutter',
                    //                         ).textLarge().mono(),
                    //                         const Spacer(),
                    //                         Gap(18),
                    //                         SizedBox(
                    //                           width: 320 - 18,
                    //                           // height: 32,
                    //                           child: OutlineButton(
                    //                             onPressed: () {
                    //                               showSearchBar();
                    //                             },
                    //                             trailing:
                    //                                 const Icon(Icons.search)
                    //                                     .iconSmall()
                    //                                     .iconMuted(),
                    //                             child: const Text(
                    //                                     'Search documentation...')
                    //                                 .muted()
                    //                                 .normal(),
                    //                           ),
                    //                         ),
                    //                         Gap(18),
                    //                         GhostButton(
                    //                           density: ButtonDensity.icon,
                    //                           onPressed: () {
                    //                             openInNewTab(
                    //                                 'https://github.com/sunarya-thito/shadcn_flutter');
                    //                           },
                    //                           child: FaIcon(
                    //                               FontAwesomeIcons.github,
                    //                               color: theme.colorScheme
                    //                                   .secondaryForeground),
                    //                         ),
                    //                         // pub.dev icon
                    //                         GhostButton(
                    //                             density: ButtonDensity.icon,
                    //                             onPressed: () {
                    //                               openInNewTab(
                    //                                   'https://pub.dev/packages/shadcn_flutter');
                    //                             },
                    //                             child: ColorFiltered(
                    //                               // turns into white
                    //                               colorFilter: ColorFilter.mode(
                    //                                 theme.colorScheme
                    //                                     .secondaryForeground,
                    //                                 BlendMode.srcIn,
                    //                               ),
                    //                               child: const FlutterLogo(
                    //                                 size: 24,
                    //                               ),
                    //                             )),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         const Divider(),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                  child: Builder(builder: (context) {
                    var hasOnThisPage = onThisPage.isNotEmpty;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MediaQueryVisibility(
                          minWidth: breakpointWidth,
                          child: FocusTraversalGroup(
                            child: SingleChildScrollView(
                              key: const PageStorageKey('sidebar'),
                              padding: EdgeInsets.only(
                                  top: 32, left: 24 + padding.left, bottom: 32),
                              child: SidebarNav(children: [
                                for (var section in sections)
                                  SidebarSection(
                                    header: Text(section.title),
                                    children: [
                                      for (var page in section.pages)
                                        NavigationButton(
                                          onPressed: () {
                                            if (page.tag ==
                                                ShadcnFeatureTag
                                                    .workInProgress) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child: AlertDialog(
                                                      title: const Text(
                                                          'Work in Progress'),
                                                      content: const Text(
                                                          'This page is still under development. Please come back later.'),
                                                      actions: [
                                                        PrimaryButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Close')),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                              return;
                                            }
                                            context.goNamed(page.name);
                                          },
                                          selected: page.name == widget.name,
                                          trailing: DefaultTextStyle.merge(
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                            ),
                                            child:
                                                page.tag?.buildBadge(context) ??
                                                    const SizedBox(),
                                          ),
                                          child: Text(page.title),
                                        ),
                                    ],
                                  ),
                              ]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FocusTraversalGroup(
                            child: widget.scrollable
                                ? SingleChildScrollView(
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
                                            TextButton(
                                              onPressed: () {
                                                context.goNamed('introduction');
                                              },
                                              density: ButtonDensity.compact,
                                              child: const Text('Docs'),
                                            ),
                                            ...widget.navigationItems,
                                            if (page != null) Text(page.title),
                                          ],
                                        ),
                                        Gap(16),
                                        widget.child,
                                      ],
                                    ),
                                  )
                                : Container(
                                    clipBehavior: Clip.none,
                                    padding: !hasOnThisPage
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 40,
                                            vertical: 32,
                                          ).copyWith(
                                            right: padding.right,
                                            bottom: 0,
                                          )
                                        : const EdgeInsets.symmetric(
                                            horizontal: 40,
                                            vertical: 32,
                                          ).copyWith(
                                            right: 24,
                                            bottom: 0,
                                          ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Breadcrumb(
                                          separator: Breadcrumb.arrowSeparator,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                context.goNamed('introduction');
                                              },
                                              density: ButtonDensity.compact,
                                              child: const Text('Docs'),
                                            ),
                                            ...widget.navigationItems,
                                            if (page != null) Text(page.title),
                                          ],
                                        ),
                                        Gap(16),
                                        Expanded(child: widget.child),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        if (hasOnThisPage)
                          MediaQueryVisibility(
                            minWidth: breakpointWidth2,
                            child: Container(
                              width: padding.right + 180,
                              alignment: Alignment.topLeft,
                              child: FocusTraversalGroup(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.only(
                                    top: 32,
                                    right: 24,
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
                              ),
                            ),
                          )
                        else
                          const SizedBox(
                            width: 32,
                          ),
                      ],
                    );
                  }),
                );
                return Stack(
                  fit: StackFit.passthrough,
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
                          const SizedBox(height: 72 + 1),
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
                                    child: FocusTraversalGroup(
                                      child: SingleChildScrollView(
                                        key: const PageStorageKey('sidebar'),
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
                                                  NavigationButton(
                                                    onPressed: () {
                                                      if (page.tag ==
                                                          ShadcnFeatureTag
                                                              .workInProgress) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Center(
                                                              child:
                                                                  AlertDialog(
                                                                title: const Text(
                                                                    'Work in Progress'),
                                                                content: const Text(
                                                                    'This page is still under development. Please come back later.'),
                                                                actions: [
                                                                  PrimaryButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: const Text(
                                                                          'Close')),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        return;
                                                      }
                                                      context
                                                          .goNamed(page.name);
                                                    },
                                                    selected: page.name ==
                                                        widget.name,
                                                    trailing:
                                                        DefaultTextStyle.merge(
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                      child: page.tag
                                                              ?.buildBadge(
                                                                  context) ??
                                                          const SizedBox(),
                                                    ),
                                                    child: Text(page.title),
                                                  ),
                                              ],
                                            ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FocusTraversalGroup(
                                      child: widget.scrollable
                                          ? SingleChildScrollView(
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
                                                    separator: Breadcrumb
                                                        .arrowSeparator,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          context.goNamed(
                                                              'introduction');
                                                        },
                                                        density: ButtonDensity
                                                            .compact,
                                                        child:
                                                            const Text('Docs'),
                                                      ),
                                                      ...widget.navigationItems,
                                                      if (page != null)
                                                        Text(page.title),
                                                    ],
                                                  ),
                                                  Gap(16),
                                                  widget.child,
                                                ],
                                              ),
                                            )
                                          : Container(
                                              clipBehavior: Clip.none,
                                              padding: !hasOnThisPage
                                                  ? const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 32,
                                                    ).copyWith(
                                                      right: padding.right,
                                                      bottom: 0,
                                                    )
                                                  : const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 32,
                                                    ).copyWith(
                                                      right: 24,
                                                      bottom: 0,
                                                    ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Breadcrumb(
                                                    separator: Breadcrumb
                                                        .arrowSeparator,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          context.goNamed(
                                                              'introduction');
                                                        },
                                                        density: ButtonDensity
                                                            .compact,
                                                        child:
                                                            const Text('Docs'),
                                                      ),
                                                      ...widget.navigationItems,
                                                      if (page != null)
                                                        Text(page.title),
                                                    ],
                                                  ),
                                                  Gap(16),
                                                  Expanded(child: widget.child),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                  if (hasOnThisPage)
                                    MediaQueryVisibility(
                                      minWidth: breakpointWidth2,
                                      child: Container(
                                        width: padding.right + 180,
                                        alignment: Alignment.topLeft,
                                        child: FocusTraversalGroup(
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.only(
                                              top: 32,
                                              right: 24,
                                              bottom: 32,
                                              left: 24,
                                            ),
                                            child: SidebarNav(children: [
                                              SidebarSection(
                                                header:
                                                    const Text('On This Page'),
                                                children: [
                                                  for (var key
                                                      in onThisPage.keys)
                                                    SidebarButton(
                                                      onPressed: () {
                                                        Scrollable.ensureVisible(
                                                            onThisPage[key]!
                                                                .currentContext!,
                                                            duration:
                                                                kDefaultDuration,
                                                            alignmentPolicy:
                                                                ScrollPositionAlignmentPolicy
                                                                    .explicit);
                                                      },
                                                      selected: isVisible(
                                                          onThisPage[key]!),
                                                      child: Text(key),
                                                    ),
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(
                                      width: 32,
                                    ),
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
                      child: Container(
                        color: theme.colorScheme.background.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MediaQueryVisibility(
                              minWidth: breakpointWidth,
                              alternateChild: FocusTraversalGroup(
                                child: ClipRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      height: 72,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          GhostButton(
                                            density: ButtonDensity.icon,
                                            onPressed: () {
                                              _openDrawer(context);
                                            },
                                            child: const Icon(Icons.menu),
                                          ),
                                          Gap(18),
                                          Expanded(
                                            child: OutlineButton(
                                              onPressed: () {
                                                showSearchBar();
                                              },
                                              trailing: const Icon(Icons.search)
                                                  .iconSmall()
                                                  .iconMuted(),
                                              child: const Text(
                                                      'Search documentation...')
                                                  .muted()
                                                  .normal(),
                                            ),
                                          ),
                                          Gap(18),
                                          GhostButton(
                                            density: ButtonDensity.icon,
                                            onPressed: () {
                                              openInNewTab(
                                                  'https://github.com/sunarya-thito/shadcn_flutter');
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.github,
                                              color: theme.colorScheme
                                                  .secondaryForeground,
                                            ),
                                          ),
                                          // pub.dev icon
                                          GhostButton(
                                              density: ButtonDensity.icon,
                                              onPressed: () {
                                                openInNewTab(
                                                    'https://pub.dev/packages/shadcn_flutter');
                                              },
                                              child: ColorFiltered(
                                                // turns into white
                                                colorFilter: ColorFilter.mode(
                                                  theme.colorScheme
                                                      .secondaryForeground,
                                                  BlendMode.srcIn,
                                                ),
                                                child: const FlutterLogo(
                                                  size: 24,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              child: FocusTraversalGroup(
                                child: ClipRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      height: 72,
                                      padding: padding,
                                      child: Row(
                                        children: [
                                          const FlutterLogo(
                                            size: 32,
                                          ),
                                          Gap(18),
                                          const Text(
                                            'shadcn_flutter',
                                          ).textLarge().mono(),
                                          const Spacer(),
                                          Gap(18),
                                          SizedBox(
                                            width: 320 - 18,
                                            // height: 32,
                                            child: OutlineButton(
                                              onPressed: () {
                                                showSearchBar();
                                              },
                                              trailing: const Icon(Icons.search)
                                                  .iconSmall()
                                                  .iconMuted(),
                                              child: const Text(
                                                      'Search documentation...')
                                                  .muted()
                                                  .normal(),
                                            ),
                                          ),
                                          Gap(18),
                                          GhostButton(
                                            density: ButtonDensity.icon,
                                            onPressed: () {
                                              openInNewTab(
                                                  'https://github.com/sunarya-thito/shadcn_flutter');
                                            },
                                            child: FaIcon(
                                                FontAwesomeIcons.github,
                                                color: theme.colorScheme
                                                    .secondaryForeground),
                                          ),
                                          // pub.dev icon
                                          GhostButton(
                                              density: ButtonDensity.icon,
                                              onPressed: () {
                                                openInNewTab(
                                                    'https://pub.dev/packages/shadcn_flutter');
                                              },
                                              child: ColorFiltered(
                                                // turns into white
                                                colorFilter: ColorFilter.mode(
                                                  theme.colorScheme
                                                      .secondaryForeground,
                                                  BlendMode.srcIn,
                                                ),
                                                child: const FlutterLogo(
                                                  size: 24,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void _openDrawer(BuildContext context) {
    openSheet(
      context: context,
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const FlutterLogo(
                    size: 24,
                  ),
                  Gap(18),
                  const Text(
                    'shadcn_flutter',
                  ).medium().mono().expanded(),
                  TextButton(
                    density: ButtonDensity.icon,
                    size: ButtonSize.small,
                    onPressed: () {
                      closeDrawer(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ).withPadding(left: 32, right: 32),
              Gap(32),
              Expanded(
                child: FocusTraversalGroup(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(left: 32, right: 32, bottom: 48),
                    key: const PageStorageKey('sidebar'),
                    child: SidebarNav(children: [
                      for (var section in sections)
                        SidebarSection(
                          header: Text(section.title),
                          children: [
                            for (var page in section.pages)
                              NavigationButton(
                                onPressed: () {
                                  if (page.tag ==
                                      ShadcnFeatureTag.workInProgress) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                          child: AlertDialog(
                                            title:
                                                const Text('Work in Progress'),
                                            content: const Text(
                                                'This page is still under development. Please come back later.'),
                                            actions: [
                                              PrimaryButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Close')),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    return;
                                  }
                                  context.goNamed(page.name);
                                },
                                selected: page.name == widget.name,
                                child: Basic(
                                  trailing: page.tag?.buildBadge(context),
                                  trailingAlignment: Alignment.centerLeft,
                                  content: Text(page.title),
                                ),
                              ),
                          ],
                        ),
                    ]),
                  ),
                ),
              )
            ],
          ),
        );
      },
      position: OverlayPosition.left,
    );
  }
}
