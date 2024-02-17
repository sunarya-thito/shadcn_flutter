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
      ShadcnDocsPage('Card', 'card'),
      ShadcnDocsPage('Checkbox', 'checkbox'),
      ShadcnDocsPage('Collapsible', 'collapsible'),
      ShadcnDocsPage('Color Picker', 'color_picker'),
      ShadcnDocsPage('ComboBox', 'combo_box'),
      ShadcnDocsPage('Command', 'command'),
      ShadcnDocsPage('Dialog', 'dialog'),
      ShadcnDocsPage('Divider', 'divider'),
      ShadcnDocsPage('Drawer', 'drawer'),
      ShadcnDocsPage('Dropdown', 'dropdown'),
      ShadcnDocsPage('Data Table', 'data_table'),
      ShadcnDocsPage('Form', 'form'),
      ShadcnDocsPage('Hover Card', 'hover_card'),
      ShadcnDocsPage('Popover', 'popover'),
      ShadcnDocsPage('Progress', 'progress'),
      ShadcnDocsPage('Radio Group', 'radio_group'),
      ShadcnDocsPage('Select', 'select'),
      ShadcnDocsPage('Separator', 'separator'),
      ShadcnDocsPage('Slider', 'slider'),
      ShadcnDocsPage('Steps', 'steps'),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(
                            top: 32, left: 24 + padding.left, bottom: 32),
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
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 32,
                          ).copyWith(
                            right: padding.right,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
