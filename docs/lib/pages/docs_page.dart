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
    super.key,
    required this.onThisPage,
    required this.child,
  });

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
    super.key,
    required this.name,
    required this.child,
    this.onThisPage = const {},
    this.navigationItems = const [],
    this.scrollable = true,
  });

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
          ShadcnDocsPage('State Management', 'state'),
        ]),
        Icons.book),
    // COMPONENTS BEGIN
    ShadcnDocsSection(
      'Animation',
      [
        ShadcnDocsPage('Animated Value', 'animated_value_builder'),
        // https://nyxbui.design/docs/components/number-ticker
        ShadcnDocsPage('Number Ticker', 'number_ticker'),
        ShadcnDocsPage('Repeated Animation', 'repeated_animation_builder'),
        ShadcnDocsPage('Timeline Animation', 'timeline_animation'),
      ],
    ),
    ShadcnDocsSection('Control', [
      ShadcnDocsPage('Button', 'button'),
      ShadcnDocsPage(
          'Audio Control', 'audio_control', ShadcnFeatureTag.workInProgress),
      ShadcnDocsPage(
          'Video Control', 'video_control', ShadcnFeatureTag.workInProgress),
    ]),
    ShadcnDocsSection(
      'Disclosure',
      [
        ShadcnDocsPage('Accordion', 'accordion'),
        ShadcnDocsPage('Collapsible', 'collapsible'),
      ],
    ),
    ShadcnDocsSection(
      'Display',
      [
        ShadcnDocsPage('Avatar', 'avatar'),
        ShadcnDocsPage('Avatar Group', 'avatar_group'),
        ShadcnDocsPage(
            'Data Table', 'data_table', ShadcnFeatureTag.workInProgress),
        // TODO also make it zoomable like: https://zoom-chart-demo.vercel.app/
        ShadcnDocsPage('Chart', 'chart', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Code Snippet', 'code_snippet'),
        ShadcnDocsPage('Table', 'table', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Tracker', 'tracker'),
      ],
    ),
    ShadcnDocsSection(
      'Feedback',
      [
        ShadcnDocsPage('Alert', 'alert'),
        ShadcnDocsPage('Alert Dialog', 'alert_dialog'),
        ShadcnDocsPage('Circular Progress', 'circular_progress'),
        ShadcnDocsPage('Progress', 'progress'),
        ShadcnDocsPage('Linear Progress', 'linear_progress'),
        ShadcnDocsPage('Skeleton', 'skeleton'),
        ShadcnDocsPage('Toast', 'toast'),
        // TODO: https://www.radix-ui.com/themes/docs/components/spinner
        ShadcnDocsPage('Spinner', 'spinner', ShadcnFeatureTag.workInProgress),
      ],
    ),
    ShadcnDocsSection(
      'Form',
      [
        // mostly same as file input, except it only accepts audio file
        // and adds the ability to play the audio
        // ShadcnDocsPage(
        //     'Audio Input', 'audio_input', ShadcnFeatureTag.workInProgress),
        // update: NVM, merge the component with file input
        // ShadcnDocsPage('Button', 'button'),
        // moved to control
        ShadcnDocsPage('Checkbox', 'checkbox'),
        ShadcnDocsPage('Chip Input', 'chip_input'),
        ShadcnDocsPage('Color Picker', 'color_picker'),
        ShadcnDocsPage('Date Picker', 'date_picker'),
        // TODO: https://file-vault-delta.vercel.app/ also https://uploader.sadmn.com/
        ShadcnDocsPage(
            'File Picker', 'file_picker', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Form', 'form'),
        // TODO: Image Input (with cropper and rotate tool, upload from file or take photo from camera)
        ShadcnDocsPage(
            'Image Input', 'image_input', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Text Input', 'input'),
        // TODO: same as text input, but has dropdown autocomplete like chip input, the difference is, it does not convert
        // the value into chips
        ShadcnDocsPage(
            'AutoComplete', 'autocomplete', ShadcnFeatureTag.newFeature),
        // TODO: same as input, except it only accepts number, and can be increased or decreased
        // using scroll, also has increment and decrement button
        // in between increment and decrement button, theres
        // a divider that can be dragged to increase or decrease the value
        ShadcnDocsPage(
            'Number Input', 'number_input', ShadcnFeatureTag.newFeature),
        ShadcnDocsPage('Input OTP', 'input_otp'),
        ShadcnDocsPage('Phone Input', 'phone_input'),
        ShadcnDocsPage('Radio Group', 'radio_group'),
        //https://www.radix-ui.com/themes/docs/components/radio-cards
        ShadcnDocsPage('Radio Card', 'radio_card'),
        ShadcnDocsPage('Select', 'select'),
        ShadcnDocsPage('Slider', 'slider'),
        ShadcnDocsPage('Star Rating', 'star_rating'),
        ShadcnDocsPage('Switch', 'switch'),
        ShadcnDocsPage('Text Area', 'text_area'),
        ShadcnDocsPage('Time Picker', 'time_picker'),
        ShadcnDocsPage('Toggle', 'toggle'),
        ShadcnDocsPage('Multi Select', 'multiselect'),
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
        ShadcnDocsPage('Sortable', 'sortable', ShadcnFeatureTag.experimental),
        ShadcnDocsPage('Steps', 'steps'),
        ShadcnDocsPage('Stepper', 'stepper'),
        ShadcnDocsPage('Timeline', 'timeline'),
        ShadcnDocsPage('Scaffold', 'scaffold'),
        ShadcnDocsPage('App Bar', 'app_bar'),
        ShadcnDocsPage('Card Image', 'card_image'),
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
        // TODO: like a chrome tab, complete with its view
        ShadcnDocsPage('Tab Pane', 'tab_pane', ShadcnFeatureTag.workInProgress),
        ShadcnDocsPage('Tree', 'tree'),
        // aka Bottom Navigation Bar
        ShadcnDocsPage('Navigation Bar', 'navigation_bar'),
        ShadcnDocsPage('Navigation Rail', 'navigation_rail'),
        ShadcnDocsPage('Expandable Sidebar', 'expandable_sidebar',
            ShadcnFeatureTag.workInProgress),
        // aka Drawer
        ShadcnDocsPage('Navigation Sidebar', 'navigation_sidebar'),
        ShadcnDocsPage('Dot Indicator', 'dot_indicator'),
      ],
    ),
    ShadcnDocsSection(
      'Overlay',
      [
        ShadcnDocsPage('Dialog', 'dialog'),
        ShadcnDocsPage('Drawer', 'drawer'),
        ShadcnDocsPage('Hover Card', 'hover_card'),
        ShadcnDocsPage('Popover', 'popover'),
        ShadcnDocsPage('Sheet', 'sheet'),
        ShadcnDocsPage('Tooltip', 'tooltip'),
        // TODO: window as in like a window in desktop
        ShadcnDocsPage('Window', 'window', ShadcnFeatureTag.workInProgress),
      ],
    ),

    ShadcnDocsSection(
      'Utility',
      [
        ShadcnDocsPage('Badge', 'badge'),
        ShadcnDocsPage('Chip', 'chip'),
        ShadcnDocsPage('Calendar', 'calendar'),
        ShadcnDocsPage('Command', 'command'),
        ShadcnDocsPage('Context Menu', 'context_menu'),
        ShadcnDocsPage('Dropdown Menu', 'dropdown_menu'),
        // TODO https://www.radix-ui.com/themes/docs/components/kbd
        ShadcnDocsPage('Keyboard Display', 'keyboard_display'),
        // TODO: Same progress as image input
        ShadcnDocsPage(
            'Image Tools', 'image_tools', ShadcnFeatureTag.workInProgress),
        // TODO: Mostly same as refresh indicator, but it does not provide indicator
        // the indicator itself is provided by scaffold
        ShadcnDocsPage(
            'Refresh Trigger', 'refresh_trigger', ShadcnFeatureTag.newFeature),
        ShadcnDocsPage('Overflow Marquee', 'overflow_marquee'),
      ],
    ),
    // COMPONENTS END
  ];

  List<String> componentCategories = [
    'Animation',
    'Disclosure',
    'Feedback',
    'Control',
    'Form',
    'Layout',
    'Navigation',
    'Overlay',
    'Display',
    'Utility',
  ];
  bool toggle = false;
  List<OnThisPage> currentlyVisible = [];
  final ScrollController scrollController = ScrollController();

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
    showCommandDialog(
      context: context,
      builder: (context, query) async* {
        for (final section in sections) {
          final List<Widget> resultItems = [];
          for (final page in section.pages) {
            if (query == null ||
                page.title.toLowerCase().contains(query.toLowerCase())) {
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

    var hasOnThisPage = onThisPage.isNotEmpty;
    return ClipRect(
      child: PageStorage(
        bucket: docsBucket,
        child: Builder(builder: (context) {
          return StageContainer(
            builder: (context, padding) {
              return Scaffold(
                headers: [
                  Container(
                    color: theme.colorScheme.background.scaleAlpha(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MediaQueryVisibility(
                          minWidth: breakpointWidth,
                          alternateChild: AppBar(
                            padding: EdgeInsets.symmetric(
                              vertical: 12 * theme.scaling,
                              horizontal: 18 * theme.scaling,
                            ),
                            leading: [
                              GhostButton(
                                density: ButtonDensity.icon,
                                onPressed: () {
                                  _openDrawer(context);
                                },
                                child: const Icon(Icons.menu),
                              ),
                            ],
                            trailing: [
                              GhostButton(
                                density: ButtonDensity.icon,
                                onPressed: () {
                                  openInNewTab(
                                      'https://github.com/sunarya-thito/shadcn_flutter');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.github,
                                  color: theme.colorScheme.secondaryForeground,
                                ).iconLarge(),
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
                                      theme.colorScheme.secondaryForeground,
                                      BlendMode.srcIn,
                                    ),
                                    child: FlutterLogo(
                                      size: 24 * theme.scaling,
                                    ),
                                  )),
                            ],
                            child: Center(
                              child: SizedBox(
                                width: double.infinity,
                                child: OutlineButton(
                                  onPressed: () {
                                    showSearchBar();
                                  },
                                  trailing: const Icon(Icons.search)
                                      .iconSmall()
                                      .iconMutedForeground(),
                                  child: const Text('Search documentation...')
                                      .muted()
                                      .normal(),
                                ),
                              ),
                            ),
                          ),
                          child: MediaQueryVisibility(
                            minWidth: breakpointWidth2,
                            alternateChild: _buildAppBar(
                                padding.copyWith(
                                      top: 12,
                                      bottom: 12,
                                      right: 32,
                                    ) *
                                    theme.scaling,
                                theme),
                            child: _buildAppBar(
                                padding.copyWith(
                                      top: 12,
                                      bottom: 12,
                                    ) *
                                    theme.scaling,
                                theme),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
                child: Row(
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
                                  bottom: 32) *
                              theme.scaling,
                          child: _DocsSidebar(
                              sections: sections, pageName: widget.name),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FocusTraversalGroup(
                        child: widget.scrollable
                            ? SingleChildScrollView(
                                controller: scrollController,
                                clipBehavior: Clip.none,
                                padding: !hasOnThisPage
                                    ? const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 32,
                                        ).copyWith(
                                          right: padding.right + 32,
                                        ) *
                                        theme.scaling
                                    : const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 32,
                                        ).copyWith(right: 24) *
                                        theme.scaling,
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
                                    Gap(16 * theme.scaling),
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
                                          right: padding.right + 32,
                                          bottom: 0,
                                        ) *
                                        theme.scaling
                                    : const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 32,
                                        ).copyWith(
                                          right: 24,
                                          bottom: 0,
                                        ) *
                                        theme.scaling,
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
                                    Gap(16 * theme.scaling),
                                    Expanded(child: widget.child),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    if (hasOnThisPage)
                      MediaQueryVisibility(
                        minWidth: breakpointWidth2,
                        child: _DocsSecondarySidebar(
                          onThisPage: onThisPage,
                          isVisible: isVisible,
                          padding: padding,
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }

  AppBar _buildAppBar(EdgeInsets padding, ThemeData theme) {
    return AppBar(
      // padding: (breakpointWidth2 < mediaQuerySize.width
      //         ? padding * theme.scaling
      //         : padding.copyWith(
      //               right: 32,
      //             ) *
      //             theme.scaling)
      //     .copyWith(
      //   top: 12 * theme.scaling,
      //   bottom: 12 * theme.scaling,
      // ),
      padding: padding,
      title: Basic(
        leading: FlutterLogo(
          size: 32 * theme.scaling,
        ),
        content: const Text(
          'shadcn_flutter',
        ).textLarge().mono(),
      ),
      trailing: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: 320 - 18,
            child: OutlineButton(
              onPressed: () {
                showSearchBar();
              },
              trailing:
                  const Icon(Icons.search).iconSmall().iconMutedForeground(),
              child: const Text('Search documentation...').muted().normal(),
            ),
          ),
        ),
        Gap(8 * theme.scaling),
        GhostButton(
          density: ButtonDensity.icon,
          onPressed: () {
            openInNewTab('https://github.com/sunarya-thito/shadcn_flutter');
          },
          child: FaIcon(FontAwesomeIcons.github,
                  color: theme.colorScheme.secondaryForeground)
              .iconLarge(),
        ),
        // pub.dev icon
        GhostButton(
            density: ButtonDensity.icon,
            onPressed: () {
              openInNewTab('https://pub.dev/packages/shadcn_flutter');
            },
            child: ColorFiltered(
              // turns into white
              colorFilter: ColorFilter.mode(
                theme.colorScheme.secondaryForeground,
                BlendMode.srcIn,
              ),
              child: FlutterLogo(
                size: 24 * theme.scaling,
              ),
            )),
      ],
    );
  }

  void _openDrawer(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    openSheet(
      context: context,
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 400) * scaling,
          padding: const EdgeInsets.only(top: 32) * scaling,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  FlutterLogo(
                    size: 24 * scaling,
                  ),
                  Gap(18 * scaling),
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
              ).withPadding(left: 32 * scaling, right: 32 * scaling),
              Gap(32 * scaling),
              Expanded(
                child: FocusTraversalGroup(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(left: 32, right: 32, bottom: 48) *
                            scaling,
                    key: const PageStorageKey('sidebar'),
                    child: SidebarNav(children: [
                      for (var section in sections)
                        SidebarSection(
                          header: Text(section.title),
                          children: [
                            for (var page in section.pages)
                              DocsNavigationButton(
                                onPressed: () {
                                  if (page.tag ==
                                      ShadcnFeatureTag.workInProgress) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Work in Progress'),
                                          content: const Text(
                                              'This page is still under development. Please come back later.'),
                                          actions: [
                                            PrimaryButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close')),
                                          ],
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
                                  trailingAlignment:
                                      AlignmentDirectional.centerStart,
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

class _DocsSidebar extends StatefulWidget {
  const _DocsSidebar({
    super.key,
    required this.sections,
    required this.pageName,
  });

  final List<ShadcnDocsSection> sections;
  final String pageName;

  @override
  State<_DocsSidebar> createState() => _DocsSidebarState();
}

class _DocsSidebarState extends State<_DocsSidebar> {
  late List<Widget> children;

  @override
  void initState() {
    super.initState();
    children = [
      for (var section in widget.sections)
        _DocsSidebarSection(section: section, pageName: widget.pageName),
    ];
    // do we need didUpdateWidget? nope
    // we don't update the children anyway
  }

  @override
  Widget build(BuildContext context) {
    return SidebarNav(children: children);
  }
}

class _DocsSecondarySidebar extends StatefulWidget {
  final Map<String, OnThisPage> onThisPage;
  final bool Function(OnThisPage) isVisible;
  final EdgeInsets padding;

  const _DocsSecondarySidebar({
    super.key,
    required this.onThisPage,
    required this.isVisible,
    required this.padding,
  });

  @override
  State<_DocsSecondarySidebar> createState() => _DocsSecondarySidebarState();
}

class _DocsSecondarySidebarState extends State<_DocsSecondarySidebar> {
  final List<Widget> _sideChildren = [];
  @override
  void initState() {
    super.initState();
    var side = <Widget>[];
    for (var key in widget.onThisPage.keys) {
      side.add(SidebarButton(
        onPressed: () {
          Scrollable.ensureVisible(widget.onThisPage[key]!.currentContext!,
              duration: kDefaultDuration,
              alignmentPolicy: ScrollPositionAlignmentPolicy.explicit);
        },
        selected: widget.isVisible(widget.onThisPage[key]!),
        child: Text(key),
      ));
    }
    _sideChildren.add(SidebarSection(
      header: const Text('On This Page'),
      children: side,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: (widget.padding.right + 180) * theme.scaling,
      alignment: Alignment.topLeft,
      child: FocusTraversalGroup(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
                top: 32,
                right: 24,
                bottom: 32,
                left: 24,
              ) *
              theme.scaling,
          child: SidebarNav(children: _sideChildren),
        ),
      ),
    );
  }
}

class _DocsSidebarSection extends StatefulWidget {
  const _DocsSidebarSection({
    super.key,
    required this.section,
    required this.pageName,
  });

  final ShadcnDocsSection section;
  final String pageName;

  @override
  State<_DocsSidebarSection> createState() => _DocsSidebarSectionState();
}

class _DocsSidebarSectionState extends State<_DocsSidebarSection> {
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      for (var page in widget.section.pages)
        _DocsSidebarButton(page: page, pageName: widget.pageName),
    ];
    // do we need didUpdateWidget? nope
    // we don't update the pages anyway
  }

  @override
  Widget build(BuildContext context) {
    return SidebarSection(
      header: Text(widget.section.title),
      children: pages,
    );
  }
}

class _DocsSidebarButton extends StatefulWidget {
  const _DocsSidebarButton({
    super.key,
    required this.page,
    required this.pageName,
  });

  final ShadcnDocsPage page;
  final String pageName;

  @override
  State<_DocsSidebarButton> createState() => _DocsSidebarButtonState();
}

class _DocsSidebarButtonState extends State<_DocsSidebarButton> {
  @override
  Widget build(BuildContext context) {
    return DocsNavigationButton(
      onPressed: _onPressed,
      selected: widget.page.name == widget.pageName,
      trailing: DefaultTextStyle.merge(
        style: const TextStyle(
          decoration: TextDecoration.none,
        ),
        child: widget.page.tag?.buildBadge(context) ?? const SizedBox(),
      ),
      child: Text(widget.page.title),
    );
  }

  void _onPressed() {
    if (widget.page.tag == ShadcnFeatureTag.workInProgress) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Work in Progress'),
            content: const Text(
                'This page is still under development. Please come back later.'),
            actions: [
              PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close')),
            ],
          );
        },
      );
      return;
    }
    context.goNamed(widget.page.name);
  }
}
