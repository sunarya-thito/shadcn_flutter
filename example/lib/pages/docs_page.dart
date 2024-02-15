import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DocsPage extends StatefulWidget {
  final String name;
  final Widget child;

  const DocsPage({
    Key? key,
    required this.name,
    required this.child,
  }) : super(key: key);

  @override
  _DocsPageState createState() => _DocsPageState();
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

class _DocsPageState extends State<DocsPage> {
  static const List<ShadcnDocsSection> sections = [
    ShadcnDocsSection('Getting Started', [
      ShadcnDocsPage('Introduction', 'introduction'),
      ShadcnDocsPage('Installation', 'installation'),
      ShadcnDocsPage('Theming', 'theming'),
      ShadcnDocsPage('Typography', 'typography'),
    ]),
    ShadcnDocsSection('Components', [
      ShadcnDocsPage('Accordion', 'accordion'),
      ShadcnDocsPage('Alert', 'alert'),
      ShadcnDocsPage('Alert Dialog', 'alert_dialog'),
      ShadcnDocsPage('Avatar', 'avatar'),
      ShadcnDocsPage('Badge', 'badge'),
      ShadcnDocsPage('Breadcrumb', 'breadcrumb'),
      ShadcnDocsPage('Button', 'button'),
      ShadcnDocsPage('Card', 'card'),
      ShadcnDocsPage('Checkbox', 'checkbox'),
      ShadcnDocsPage('Dialog', 'dialog'),
      ShadcnDocsPage('Hover Card', 'hover_card'),
      ShadcnDocsPage('Popover', 'popover'),
      // TODO: Progress
      ShadcnDocsPage('Radio Group', 'radio_group'),
      ShadcnDocsPage('Select', 'select'),
      ShadcnDocsPage('Separator', 'separator'),
      ShadcnDocsPage('Slider', 'slider'),
      ShadcnDocsPage('Switch', 'switch'),
      ShadcnDocsPage('TextField', 'text_field'),
      ShadcnDocsPage('Toggle', 'toggle'),
      ShadcnDocsPage('Tooltip', 'tooltip'),
    ]),
  ];
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    ShadcnDocsPage? page = sections
        .expand((e) => e.pages)
        .where((e) => e.name == widget.name)
        .firstOrNull;
    return Scaffold(
      scrollable: false,
      body: StageContainer(
        builder: (context, padding) {
          return IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 72,
                ),
                const Divider(),
                Expanded(
                  child: Padding(
                    padding: padding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.only(
                              top: 32, left: 24, bottom: 32),
                          child: SidebarNav(children: [
                            for (var section in sections)
                              SidebarSection(
                                header: Text(section.title),
                                children: [
                                  for (var page in section.pages)
                                    SidebarButton(
                                      child: Text(page.title),
                                      onPressed: () {
                                        context.goNamed(page.name);
                                      },
                                      selected: page.name == widget.name,
                                    ),
                                ],
                              ),
                          ]),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 32,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
