import 'package:example/pages/docs/components/breadcrumb/breadcrumb_example_1.dart';
import 'package:example/pages/docs/components/calendar/calendar_example_2.dart';
import 'package:example/pages/docs/components/card/card_example_1.dart';
import 'package:example/pages/docs/components/carousel/carousel_example_1.dart';
import 'package:example/pages/docs/components/code_snippet/code_snippet_example_1.dart';
import 'package:example/pages/docs/components/color_picker/color_picker_example_1.dart';
import 'package:example/pages/docs/components/command/command_example_1.dart';
import 'package:example/pages/docs/components/date_picker/date_picker_example_1.dart';
import 'package:example/pages/docs/components/divider/divider_example_3.dart';
import 'package:example/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:example/pages/docs_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({Key? key}) : super(key: key);

  @override
  _ComponentsPageState createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  final OnThisPage disclosureKey = OnThisPage();
  final OnThisPage feedbackKey = OnThisPage();
  final OnThisPage formsKey = OnThisPage();
  final OnThisPage layoutKey = OnThisPage();
  final OnThisPage navigationKey = OnThisPage();
  final OnThisPage surfacesKey = OnThisPage();
  final OnThisPage dataDisplayKey = OnThisPage();
  final OnThisPage utilitiesKey = OnThisPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DocsPage(
      name: 'components',
      onThisPage: {
        'Disclosure': disclosureKey,
        'Feedback': feedbackKey,
        'Forms': formsKey,
        'Layout': layoutKey,
        'Navigation': navigationKey,
        'Surfaces': surfacesKey,
        'Data Display': dataDisplayKey,
        'Utilities': utilitiesKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Components').h1(),
          Text('Beautifully designed components from Shadcn/UI is now available for Flutter.')
              .lead(),
          gap(16),
          Align(
            alignment: Alignment.centerLeft,
            child: PrimaryBadge(
              child: Text('Work in Progress'),
            ),
          ),
          gap(32),
          Text('Disclosure').h2().anchored(disclosureKey),
          gap(16),
          wrap(
            children: [
              ComponentCard(
                name: 'accordion',
                title: 'Accordion',
                example: Container(
                  width: 280,
                  child: Card(
                    child: Accordion(
                      items: [
                        AccordionItem(
                          trigger: AccordionTrigger(child: Text('Accordion 1')),
                          content: Text('Content 1'),
                        ),
                        AccordionItem(
                          trigger: AccordionTrigger(child: Text('Accordion 2')),
                          content: Text('Content 2'),
                        ),
                        AccordionItem(
                          trigger: AccordionTrigger(child: Text('Accordion 3')),
                          content: Text('Content 3'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ComponentCard(
                name: 'collapsible',
                title: 'Collapsible',
                reverse: true,
                example: Card(
                  child: Collapsible(
                    children: [
                      CollapsibleTrigger(
                        child: Text('@sunarya-thito starred 3 repositories'),
                      ),
                      OutlinedContainer(
                        child: Text('@sunarya-thito/shadcn_flutter')
                            .small()
                            .mono()
                            .withPadding(horizontal: 16, vertical: 8),
                      ).withPadding(top: 8),
                      CollapsibleContent(
                        child: OutlinedContainer(
                          child: Text('@flutter/flutter')
                              .small()
                              .mono()
                              .withPadding(horizontal: 16, vertical: 8),
                        ).withPadding(top: 8),
                      ),
                      CollapsibleContent(
                        child: OutlinedContainer(
                          child: Text('@dart-lang/sdk')
                              .small()
                              .mono()
                              .withPadding(horizontal: 16, vertical: 8),
                        ).withPadding(top: 8),
                      ),
                      CollapsibleTrigger(
                        child: Text('@flutter starred 1 repository'),
                      ).withPadding(top: 16),
                      OutlinedContainer(
                        child: Text('@sunarya-thito/shadcn_flutter')
                            .small()
                            .mono()
                            .withPadding(horizontal: 16, vertical: 8),
                      ).withPadding(top: 8),
                      CollapsibleContent(
                        child: OutlinedContainer(
                          child: Text('@flutter/flutter')
                              .small()
                              .mono()
                              .withPadding(horizontal: 16, vertical: 8),
                        ).withPadding(top: 8),
                      ),
                      CollapsibleContent(
                        child: OutlinedContainer(
                          child: Text('@dart-lang/sdk')
                              .small()
                              .mono()
                              .withPadding(horizontal: 16, vertical: 8),
                        ).withPadding(top: 8),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Text('Feedback').h2().anchored(feedbackKey),
          gap(16),
          wrap(children: [
            ComponentCard(
              name: 'alert',
              title: 'Alert',
              center: true,
              example: Alert(
                leading: Icon(Icons.info_outline),
                title: Text('Alert'),
                content: Text('This is an alert.'),
              ),
            ),
            ComponentCard(
              name: 'alert_dialog',
              title: 'Alert Dialog',
              center: true,
              example: AlertDialog(
                title: Text('Alert Dialog'),
                content: Text('This is an alert dialog.'),
                actions: [
                  SecondaryButton(
                    onPressed: () {},
                    child: Text('Cancel'),
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
            ComponentCard(
              name: 'circular_progress',
              title: 'Circular Progress',
              center: true,
              example: Transform.scale(
                scale: 3,
                child: CircularProgressIndicator(),
              ),
            ),
            WIPComponentCard(title: 'Progress'),
            WIPComponentCard(title: 'Skeleton'),
            WIPComponentCard(title: 'Sonner'),
            WIPComponentCard(title: 'Toast'),
          ]),
          Text('Forms').h2().anchored(formsKey),
          gap(16),
          wrap(children: [
            ComponentCard(
              name: 'button',
              title: 'Button',
              scale: 1.5,
              example: Container(
                width: 250,
                child: Card(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      PrimaryButton(
                        onPressed: () {},
                        child: Text('Primary'),
                      ),
                      SecondaryButton(
                        onPressed: () {},
                        child: Text('Secondary'),
                      ),
                      OutlineButton(
                        onPressed: () {},
                        child: Text('Outline'),
                      ),
                      GhostButton(
                        onPressed: () {},
                        child: Text('Ghost'),
                      ),
                      DestructiveButton(
                        child: Text('Destructive'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ComponentCard(
              name: 'checkbox',
              title: 'Checkbox',
              example: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 42,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Checkbox(
                              state: CheckboxState.checked,
                              onChanged: null,
                              trailing: Text('Checked'),
                            )),
                      ),
                      Container(
                        height: 42,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Checkbox(
                                state: CheckboxState.indeterminate,
                                onChanged: null,
                                trailing: Text('Indeterminate'))),
                      ),
                      Container(
                        height: 42,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Checkbox(
                                state: CheckboxState.unchecked,
                                onChanged: null,
                                trailing: Text('Unchecked'))),
                      ),
                    ]).gap(16),
              ),
            ),
            ComponentCard(
              name: 'color_picker',
              title: 'Color Picker',
              reverse: true,
              reverseVertical: true,
              example: ColorPickerExample1(),
            ),
            ComponentCard(
              name: 'date_picker',
              title: 'Date Picker',
              horizontalOffset: 70,
              example: CalendarExample2(),
            ),
            ComponentCard(
              name: 'input',
              title: 'Input',
              scale: 2,
              example: Card(
                child: TextField(
                  initialValue: 'Hello World',
                ).sized(width: 250, height: 32),
              ),
            ),
            WIPComponentCard(title: 'Input OTP'),
            ComponentCard(
              name: 'radio_group',
              title: 'Radio Group',
              scale: 2,
              example: Card(
                child: RadioGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioItem(
                        trailing: Text('Option 1'),
                      ),
                      RadioItem(
                        trailing: Text('Option 2'),
                      ),
                      RadioItem(
                        trailing: Text('Option 3'),
                      ),
                    ],
                  ).gap(16),
                ),
              ),
            ),
            ComponentCard(
              name: 'switch',
              title: 'Switch',
              scale: 2,
              center: true,
              example: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            WIPComponentCard(title: 'Text Area'),
          ]),
          Text('Layout').h2().anchored(layoutKey),
          gap(16),
          wrap(children: [
            ComponentCard(
              name: 'card',
              title: 'Card',
              example: CardExample1(),
            ),
            ComponentCard(
              name: 'carousel',
              title: 'Carousel',
              fit: true,
              example:
                  SizedBox(width: 550, height: 200, child: CarouselExample1()),
            ),
            ComponentCard(
              name: 'divider',
              title: 'Divider',
              scale: 1.2,
              example: Card(child: DividerExample3()),
            ),
            WIPComponentCard(title: 'Resizable'),
            ComponentCard(
              name: 'steps',
              title: 'Steps',
              example: Card(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Steps(children: [
                  StepItem(
                    title: Text('Create a project'),
                    content: [
                      Text('Create a new flutter project'),
                    ],
                  ),
                  StepItem(
                    title: Text('Add dependencies'),
                    content: [
                      Text('Add dependencies to pubspec.yaml'),
                    ],
                  ),
                  StepItem(
                    title: Text('Run the project'),
                    content: [
                      Text('Run the project using flutter run'),
                    ],
                  ),
                ]),
              ),
            ),
          ]),
          Text('Navigation').h2().anchored(navigationKey),
          gap(16),
          wrap(children: [
            ComponentCard(
              title: 'Breadcrumb',
              name: 'breadcrumb',
              // scale: 1,
              example: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(child: BreadcrumbExample1()),
                  Card(child: BreadcrumbExample1()),
                  Card(child: BreadcrumbExample1()),
                ],
              ).gap(16),
            ),
            WIPComponentCard(title: 'Menubar'),
            WIPComponentCard(title: 'Navigation Menu'),
            ComponentCard(
              title: 'Pagination',
              name: 'pagination',
              reverse: true,
              example: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(child: PaginationExample1()),
                  Card(child: PaginationExample1()),
                ],
              ).gap(16),
            ),
            WIPComponentCard(title: 'Tabs'),
          ]),
          Text('Surfaces').h2().anchored(surfacesKey),
          gap(16),
          wrap(children: [
            ComponentCard(
                title: 'Dialog',
                name: 'dialog',
                example: AlertDialog(
                  title: Text('Edit profile'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Make changes to your profile here. Click save when you\'re done'),
                      gap(16),
                      Form(
                        child: FormTableLayout(rows: [
                          FormRow<String>(
                            key: FormKey(#name),
                            label: Text('Name'),
                            child: TextField(
                              initialValue: 'Thito Yalasatria Sunarya',
                            ),
                          ),
                          FormRow<String>(
                            key: FormKey(#username),
                            label: Text('Username'),
                            child: TextField(
                              initialValue: '@sunaryathito',
                            ),
                          ),
                        ]),
                      ).withPadding(vertical: 16),
                    ],
                  ),
                  actions: [
                    PrimaryButton(
                      child: Text('Save changes'),
                      onPressed: () {},
                    ),
                  ],
                )),
            WIPComponentCard(title: 'Drawer'),
            WIPComponentCard(title: 'Sheet'),
            ComponentCard(
              name: 'tooltip',
              title: 'Tooltip',
              center: true,
              scale: 1,
              example: Column(
                children: [
                  DestructiveButton(
                    leading: Icon(Icons.delete),
                    child: Text('Delete'),
                    onPressed: () {},
                  ),
                  gap(4),
                  TooltipContainer(
                    child: Text('Click to delete this item'),
                  ),
                ],
              ),
            ),
            ComponentCard(
              name: 'popover',
              title: 'Popover',
              scale: 1,
              example: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DatePickerExample1(),
                    gap(4),
                    CalendarExample2(),
                  ],
                ),
              ),
            ),
          ]),
          Text('Data Display').h2().anchored(dataDisplayKey),
          gap(16),
          wrap(children: [
            ComponentCard(
              name: 'avatar',
              title: 'Avatar',
              scale: 1.5,
              example: Card(
                child: Row(
                  children: [
                    Avatar(
                      initials: Avatar.getInitials('sunarya-thito'),
                      photoUrl:
                          'https://avatars.githubusercontent.com/u/64018564?v=4',
                    ),
                    gap(16),
                    Avatar(
                      initials: Avatar.getInitials('sunarya-thito'),
                    ),
                  ],
                ),
              ),
            ),
            WIPComponentCard(title: 'Data Table'),
            WIPComponentCard(title: 'Chart'),
            ComponentCard(
                name: 'code_snippet',
                title: 'Code Snippet',
                scale: 1.5,
                reverse: true,
                reverseVertical: true,
                example: CodeSnippetExample1()),
            WIPComponentCard(title: 'Table'),
          ]),
          Text('Utilities').h2().anchored(utilitiesKey),
          gap(16),
          wrap(children: [
            ComponentCard(
              name: 'badge',
              title: 'Badge',
              center: true,
              scale: 1.5,
              example: Column(
                children: [
                  PrimaryBadge(child: Text('Primary')),
                  SecondaryBadge(child: Text('Secondary')),
                  DestructiveBadge(child: Text('Destructive')),
                ],
              ).gap(8),
            ),
            ComponentCard(
              name: 'calendar',
              title: 'Calendar',
              scale: 1,
              example: Calendar(
                  view: CalendarView.now(),
                  selectionMode: CalendarSelectionMode.none),
            ),
            ComponentCard(
              name: 'command',
              title: 'Command',
              scale: 1,
              example: CommandExample1(),
            ),
            WIPComponentCard(title: 'Context Menu'),
          ]),
        ],
      ),
    );
  }

  Widget wrap({required List<Widget> children}) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: children,
    );
  }
}

class WIPComponentCard extends StatelessWidget {
  final String title;

  const WIPComponentCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ComponentCard(
        name: '-',
        title: title,
        center: true,
        example: PrimaryBadge(
          child: Text('Work in Progress'),
        ),
      ),
    );
  }
}

class ComponentCard extends StatelessWidget {
  final String name;
  final String title;
  final Widget example;
  final bool center;
  final bool fit;
  final bool reverse;
  final bool reverseVertical;
  final double horizontalOffset;
  final double verticalOffset;
  final double scale;
  const ComponentCard({
    Key? key,
    required this.name,
    required this.title,
    required this.example,
    this.center = false,
    this.fit = false,
    this.reverse = false,
    this.reverseVertical = false,
    this.horizontalOffset = 30,
    this.verticalOffset = 20,
    this.scale = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(name);
        },
        child: SizedBox(
          height: 200,
          width: 250,
          child: OutlinedContainer(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: IgnorePointer(
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.accent,
                        ),
                        child: fit
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: example,
                                ),
                              )
                            : center
                                ? Center(
                                    child: Transform.scale(
                                        scale: scale,
                                        child: SingleChildScrollView(
                                          clipBehavior: Clip.none,
                                          child: example,
                                        )),
                                  ).withPadding(all: 24)
                                : Stack(
                                    children: [
                                      Positioned(
                                        top: !reverseVertical
                                            ? verticalOffset
                                            : null,
                                        right:
                                            reverse ? horizontalOffset : null,
                                        bottom: reverseVertical
                                            ? verticalOffset
                                            : null,
                                        left:
                                            !reverse ? horizontalOffset : null,
                                        child: Transform.scale(
                                          scale: scale,
                                          alignment: reverse
                                              ? reverseVertical
                                                  ? Alignment.bottomRight
                                                  : Alignment.topRight
                                              : reverseVertical
                                                  ? Alignment.bottomLeft
                                                  : Alignment.topLeft,
                                          child: example,
                                        ),
                                      ),
                                    ],
                                  )),
                  ),
                ),
                Divider(),
                Text(title).medium().withPadding(vertical: 12, horizontal: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
