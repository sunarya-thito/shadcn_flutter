import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:example/pages/docs/components/breadcrumb/breadcrumb_example_1.dart';
import 'package:example/pages/docs/components/calendar/calendar_example_2.dart';
import 'package:example/pages/docs/components/card/card_example_1.dart';
import 'package:example/pages/docs/components/carousel/carousel_example_1.dart';
import 'package:example/pages/docs/components/code_snippet/code_snippet_example_1.dart';
import 'package:example/pages/docs/components/color_picker/color_picker_example_1.dart';
import 'package:example/pages/docs/components/command/command_example_1.dart';
import 'package:example/pages/docs/components/date_picker/date_picker_example_1.dart';
import 'package:example/pages/docs/components/divider/divider_example_3.dart';
import 'package:example/pages/docs/components/form/form_example_1.dart';
import 'package:example/pages/docs/components/input_otp/input_otp_example_2.dart';
import 'package:example/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:example/pages/docs/components/text_area/text_area_example_3.dart';
import 'package:example/pages/docs/components/toggle/toggle_example_2.dart';
import 'package:example/pages/docs_page.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({Key? key}) : super(key: key);

  @override
  _ComponentsPageState createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  final OnThisPage animationKey = OnThisPage();
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
    return Data(
      data: ComponentsMode.normal,
      child: DocsPage(
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
            Text('Animation').h2().anchored(animationKey),
            gap(16),
            wrap(children: [
              ComponentCard(
                name: 'animated_value_builder',
                title: 'Animated Value Builder',
                scale: 2,
                example: SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Positioned.fill(
                        child: RepeatedAnimationBuilder(
                          start: Colors.red,
                          end: Colors.blue,
                          lerp: Color.lerp,
                          duration: Duration(seconds: 1),
                          mode: RepeatMode.pingPong,
                          builder: (context, value, child) {
                            return Container(
                              color: value,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 16,
                        child: RepeatedAnimationBuilder(
                          start: 0.0,
                          end: 1.0,
                          mode: RepeatMode.pingPong,
                          duration: Duration(seconds: 1),
                          builder: (context, value, child) {
                            // 0.0 - 0.5 = 0
                            // 0.5 - 1.0 = 1
                            return Text(value.round().toString())
                                .x3Large()
                                .bold();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ComponentCard(
                name: 'repeated_animation_builder',
                title: 'Repeated Animation Builder',
                scale: 2,
                horizontalOffset: 80,
                example: RepeatedAnimationBuilder(
                  duration: Duration(seconds: 1),
                  start: 0.0,
                  end: 90.0,
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: pi / 180 * value,
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ]),
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
                            trigger:
                                AccordionTrigger(child: Text('Accordion 1')),
                            content: Text('Content 1'),
                          ),
                          AccordionItem(
                            trigger:
                                AccordionTrigger(child: Text('Accordion 2')),
                            content: Text('Content 2'),
                          ),
                          AccordionItem(
                            trigger:
                                AccordionTrigger(child: Text('Accordion 3')),
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
              ComponentCard(
                title: 'Progress',
                name: 'progress',
                example: Progress(
                  progress: 0.75,
                ),
                center: true,
              ),
              ComponentCard(
                title: 'Skeleton',
                name: 'skeleton',
                scale: 1,
                example: Card(
                  child: Column(
                    children: [
                      Basic(
                        title: Text('Skeleton Example 1'),
                        content: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        leading: Avatar(
                          initials: '',
                        ).asSkeleton(),
                        // Note: Avatar and other Image related widget needs its own skeleton
                        trailing: Icon(Icons.arrow_forward),
                      ).asSkeleton(),
                      gap(16),
                      Basic(
                        title: Text('Skeleton Example 1'),
                        content: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        leading: Avatar(
                          initials: '',
                        ).asSkeleton(),
                        // Note: Avatar and other Image related widget needs its own skeleton
                        trailing: Icon(Icons.arrow_forward),
                      ).asSkeleton(),
                      gap(16),
                      Basic(
                        title: Text('Skeleton Example 1'),
                        content: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        leading: Avatar(
                          initials: '',
                        ).asSkeleton(),
                        // Note: Avatar and other Image related widget needs its own skeleton
                        trailing: Icon(Icons.arrow_forward),
                      ).asSkeleton(),
                    ],
                  ),
                ).sized(height: 300),
              ),
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
                scale: 1.8,
                example: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        state: CheckboxState.checked,
                        trailing: Text('Checked'),
                        onChanged: (value) {},
                      ),
                      Checkbox(
                        state: CheckboxState.indeterminate,
                        trailing: Text('Indeterminate'),
                        onChanged: (value) {},
                      ),
                      Checkbox(
                        state: CheckboxState.unchecked,
                        trailing: Text('Unchecked'),
                        onChanged: (value) {},
                      ),
                    ],
                  ).gap(4).sized(width: 300),
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
                name: 'form',
                title: 'Form',
                example: Card(child: FormExample1()),
              ),
              ComponentCard(
                name: 'input',
                title: 'Input',
                scale: 2,
                example: Card(
                  child: TextField(
                    initialValue: 'Hello World',
                    leading: Icon(Icons.edit),
                  ).sized(width: 250, height: 32),
                ).sized(height: 400),
              ),
              ComponentCard(
                title: 'Input OTP',
                name: 'input_otp',
                scale: 1,
                example: Column(
                  children: [
                    Card(
                      child: InputOTPExample2(),
                    ),
                    gap(24),
                    Transform.translate(
                      offset: Offset(-150, 0),
                      child: Card(
                        child: InputOTP(
                          initialValue: '123456'.codeUnits,
                          children: [
                            InputOTPChild.character(
                                allowDigit: true, obscured: true),
                            InputOTPChild.character(
                                allowDigit: true, obscured: true),
                            InputOTPChild.character(
                                allowDigit: true, obscured: true),
                            InputOTPChild.separator,
                            InputOTPChild.character(
                                allowDigit: true, obscured: true),
                            InputOTPChild.character(
                                allowDigit: true, obscured: true),
                            InputOTPChild.character(
                                allowDigit: true, obscured: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    ).gap(4),
                  ).sized(width: 300),
                ),
              ),
              ComponentCard(
                name: 'select',
                title: 'Select',
                scale: 1.2,
                example: Card(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Select<String>(
                          itemBuilder: (context, item) {
                            return Text(item);
                          },
                          placeholder: Text('Select a fruit'),
                          value: 'Apple',
                          children: [
                            SelectItemButton(
                                value: 'Apple', child: Text('Apple')),
                          ],
                        ),
                        SelectPopup(
                          value: 'Apple',
                          children: [
                            SelectItemButton(
                              value: 'Apple',
                              child: Text('Apple'),
                            ),
                            SelectItemButton(
                              value: 'Banana',
                              child: Text('Banana'),
                            ),
                            SelectItemButton(
                              value: 'Lemon',
                              child: Text('Lemon'),
                            ),
                            SelectItemButton(
                              value: 'Tomato',
                              child: Text('Tomato'),
                            ),
                            SelectItemButton(
                              value: 'Cucumber',
                              child: Text('Cucumber'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).sized(height: 300, width: 200),
              ),
              ComponentCard(
                name: 'slider',
                title: 'Slider',
                center: true,
                scale: 2,
                example: Slider(
                  value: SliderValue.single(0.75),
                  onChanged: (value) {},
                ).sized(width: 100),
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
              ComponentCard(
                  title: 'Text Area',
                  name: 'text_area',
                  scale: 1.2,
                  example: Column(
                    children: [
                      Card(child: TextAreaExample3()),
                      Card(child: TextAreaExample3()),
                    ],
                  )),
              ComponentCard(
                name: 'toggle',
                title: 'Toggle',
                scale: 1.2,
                example: Card(
                  child: ToggleExample2().withAlign(Alignment.topLeft),
                ).sized(height: 300, width: 300),
              ),
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
                example: SizedBox(
                    width: 550, height: 200, child: CarouselExample1()),
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
                    Transform.translate(
                        offset: Offset(250, 0),
                        child: Card(child: PaginationExample1())),
                  ],
                ).gap(16),
              ),
              ComponentCard(
                title: 'Tabs',
                name: 'tabs',
                scale: 1.2,
                example: Card(
                  child: Column(
                    children: [
                      Tabs(index: 0, onChanged: (value) {}, tabs: [
                        Text('Tab 1'),
                        Text('Tab 2'),
                        Text('Tab 3'),
                      ]),
                      Tabs(index: 1, onChanged: (value) {}, tabs: [
                        Text('Tab 1'),
                        Text('Tab 2'),
                        Text('Tab 3'),
                      ]),
                      Tabs(index: 2, onChanged: (value) {}, tabs: [
                        Text('Tab 1'),
                        Text('Tab 2'),
                        Text('Tab 3'),
                      ]),
                    ],
                  ).gap(8),
                ),
              ),
              ComponentCard(
                name: 'tab_list',
                title: 'Tab List',
                scale: 1,
                reverseVertical: true,
                verticalOffset: 60,
                example: TabList(
                  index: 0,
                  children: [
                    TabButton(child: Text('Preview')),
                    TabButton(child: Text('Code')),
                    TabButton(child: Text('Design')),
                    TabButton(child: Text('Settings')),
                  ],
                ),
              ),
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
              ComponentCard(
                title: 'Drawer',
                name: 'drawer',
                scale: 1,
                example: DrawerWrapper(
                  position: OverlayPosition.bottom,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Drawer!').large().medium(),
                      gap(4),
                      Text('This is a drawer that you can use to display content')
                          .muted(),
                    ],
                  ).withPadding(horizontal: 32),
                  size: Size(300, 300),
                ).sized(width: 300, height: 300),
              ),
              ComponentCard(
                title: 'Sheet',
                name: 'sheet',
                verticalOffset: 0,
                scale: 1,
                example: SheetWrapper(
                  position: OverlayPosition.right,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sheet!').large().medium(),
                      gap(4),
                      Text('This is a sheet that you can use to display content')
                          .muted(),
                    ],
                  ).withPadding(horizontal: 32, vertical: 48),
                  size: Size(300, 300),
                ).sized(width: 300, height: 300),
              ),
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
              WIPComponentCard(title: 'Dropdown Menu'),
            ]),
          ],
        ),
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

class ComponentCard extends StatefulWidget {
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
  State<ComponentCard> createState() => _ComponentCardState();
}

enum ComponentsMode { normal, capture }

class _ComponentCardState extends State<ComponentCard> {
  bool _hovering = false;
  final GlobalKey repaintKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentsMode = Data.of<ComponentsMode>(context);
    return GestureDetector(
      onTap: componentsMode == ComponentsMode.normal
          ? null
          : () {
              final render = repaintKey.currentContext!.findRenderObject()
                  as RenderRepaintBoundary;
              render.toImage().then(
                (value) async {
                  var byteData =
                      (await value.toByteData(format: ImageByteFormat.png))!;
                  value.dispose();
                  final list = byteData.buffer.asUint8List();
                  // convert to base64 image
                  final base64Image = base64.encode(list);
                  final String baseImage = 'data:image/png;base64,$base64Image';
                  launchUrlString(baseImage,
                      mode: LaunchMode.externalApplication);
                },
              );
            },
      child: Clickable(
        enabled: componentsMode == ComponentsMode.normal,
        mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
        onHover: (value) {
          setState(() {
            _hovering = value;
          });
        },
        onPressed: () {
          context.pushNamed(widget.name);
        },
        child: RepaintBoundary(
          key: repaintKey,
          child: ExcludeFocus(
            child: SizedBox(
              height: 200,
              width: 250,
              child: AnimatedValueBuilder(
                  value: _hovering ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    final borderColor = Color.lerp(theme.colorScheme.border,
                        theme.colorScheme.ring, value);
                    return OutlinedContainer(
                      clipBehavior: Clip.antiAlias,
                      borderColor: borderColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: IgnorePointer(
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.accent,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(theme.radiusMd + 3),
                                      topRight:
                                          Radius.circular(theme.radiusMd + 3),
                                    ),
                                  ),
                                  child: Transform.scale(
                                    scale: 1 + 0.3 * value,
                                    child: Transform.rotate(
                                      angle: pi / 180 * 10 * value,
                                      child: widget.fit
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: widget.example,
                                              ),
                                            )
                                          : widget.center
                                              ? Center(
                                                  child: Transform.scale(
                                                      scale: widget.scale,
                                                      child:
                                                          SingleChildScrollView(
                                                        clipBehavior: Clip.none,
                                                        child: widget.example,
                                                      )),
                                                ).withPadding(all: 24)
                                              : Stack(
                                                  children: [
                                                    Positioned(
                                                      top: !widget
                                                              .reverseVertical
                                                          ? widget
                                                              .verticalOffset
                                                          : null,
                                                      right: widget.reverse
                                                          ? widget
                                                              .horizontalOffset
                                                          : null,
                                                      bottom: widget
                                                              .reverseVertical
                                                          ? widget
                                                              .verticalOffset
                                                          : null,
                                                      left: !widget.reverse
                                                          ? widget
                                                              .horizontalOffset
                                                          : null,
                                                      child: Transform.scale(
                                                        scale: widget.scale,
                                                        alignment: widget
                                                                .reverse
                                                            ? widget
                                                                    .reverseVertical
                                                                ? Alignment
                                                                    .bottomRight
                                                                : Alignment
                                                                    .topRight
                                                            : widget
                                                                    .reverseVertical
                                                                ? Alignment
                                                                    .bottomLeft
                                                                : Alignment
                                                                    .topLeft,
                                                        child: widget.example,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                    ),
                                  )),
                            ),
                          ),
                          Divider(),
                          Text(widget.title)
                              .medium()
                              .withPadding(vertical: 12, horizontal: 16),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
