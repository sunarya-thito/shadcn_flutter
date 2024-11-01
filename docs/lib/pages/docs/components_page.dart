import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:docs/pages/docs/components/breadcrumb/breadcrumb_example_1.dart';
import 'package:docs/pages/docs/components/calendar/calendar_example_2.dart';
import 'package:docs/pages/docs/components/card/card_example_1.dart';
import 'package:docs/pages/docs/components/carousel/carousel_example_1.dart';
import 'package:docs/pages/docs/components/code_snippet/code_snippet_example_1.dart';
import 'package:docs/pages/docs/components/command/command_example_1.dart';
import 'package:docs/pages/docs/components/divider/divider_example_3.dart';
import 'package:docs/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_3.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_2.dart';
import 'package:docs/pages/docs/components/text_area/text_area_example_3.dart';
import 'package:docs/pages/docs/components/timeline/timeline_example_1.dart';
import 'package:docs/pages/docs/components/toggle/toggle_example_2.dart';
import 'package:docs/pages/docs/components/tree/tree_example_1.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'components/form/form_example_1.dart';
import 'components/input_otp/input_otp_example_2.dart';
import 'components/tracker/tracker_example_1.dart';

const kComponentsMode = ComponentsMode.normal;

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

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

  Widget _buildToast() {
    return Card(
      child: Basic(
        title: const Text('Event has been created'),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: PrimaryButton(
            size: ButtonSize.small,
            onPressed: () {},
            child: const Text('Undo')),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Data.inherit(
      data: kComponentsMode,
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
            const Text('Components').h1(),
            const Text(
                    'Beautifully designed components from Shadcn/UI is now available for Flutter.')
                .lead(),
            const Gap(16),
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: PrimaryBadge(
                child: Text('Work in Progress'),
              ),
            ),
            const Gap(32),
            const Text('Animation').h2().anchored(animationKey),
            const Gap(16),
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
                          duration: const Duration(seconds: 1),
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
                          duration: const Duration(seconds: 1),
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
                name: 'number_ticker',
                title: 'Number Ticker',
                scale: 1.2,
                example: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RepeatedAnimationBuilder(
                      start: 0.0,
                      end: 1234567.0,
                      mode: RepeatMode.pingPong,
                      duration: const Duration(seconds: 5),
                      builder: (context, value, child) {
                        return Text(
                          NumberFormat.compact().format(value),
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Transform.translate(
                      offset: const Offset(0, -16),
                      child: RepeatedAnimationBuilder(
                        start: 1234567.0,
                        end: 0.0,
                        mode: RepeatMode.pingPong,
                        duration: const Duration(seconds: 5),
                        builder: (context, value, child) {
                          return Text(
                            NumberFormat.compact().format(value),
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.mutedForeground,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ComponentCard(
                name: 'repeated_animation_builder',
                title: 'Repeated Animation Builder',
                scale: 2,
                horizontalOffset: 80,
                example: RepeatedAnimationBuilder(
                  duration: const Duration(seconds: 1),
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
            const Text('Disclosure').h2().anchored(disclosureKey),
            const Gap(16),
            wrap(
              children: [
                const ComponentCard(
                  name: 'accordion',
                  title: 'Accordion',
                  example: SizedBox(
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
                        const CollapsibleTrigger(
                          child: Text('@sunarya-thito starred 3 repositories'),
                        ),
                        OutlinedContainer(
                          child: const Text('@sunarya-thito/shadcn_flutter')
                              .small()
                              .mono()
                              .withPadding(horizontal: 16, vertical: 8),
                        ).withPadding(top: 8),
                        CollapsibleContent(
                          child: OutlinedContainer(
                            child: const Text('@flutter/flutter')
                                .small()
                                .mono()
                                .withPadding(horizontal: 16, vertical: 8),
                          ).withPadding(top: 8),
                        ),
                        CollapsibleContent(
                          child: OutlinedContainer(
                            child: const Text('@dart-lang/sdk')
                                .small()
                                .mono()
                                .withPadding(horizontal: 16, vertical: 8),
                          ).withPadding(top: 8),
                        ),
                        const CollapsibleTrigger(
                          child: Text('@flutter starred 1 repository'),
                        ).withPadding(top: 16),
                        OutlinedContainer(
                          child: const Text('@sunarya-thito/shadcn_flutter')
                              .small()
                              .mono()
                              .withPadding(horizontal: 16, vertical: 8),
                        ).withPadding(top: 8),
                        CollapsibleContent(
                          child: OutlinedContainer(
                            child: const Text('@flutter/flutter')
                                .small()
                                .mono()
                                .withPadding(horizontal: 16, vertical: 8),
                          ).withPadding(top: 8),
                        ),
                        CollapsibleContent(
                          child: OutlinedContainer(
                            child: const Text('@dart-lang/sdk')
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
            const Text('Feedback').h2().anchored(feedbackKey),
            const Gap(16),
            wrap(children: [
              const ComponentCard(
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
                  title: const Text('Alert Dialog'),
                  content: const Text('This is an alert dialog.'),
                  actions: [
                    SecondaryButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      child: const Text('OK'),
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
                  child: const CircularProgressIndicator(),
                ),
              ),
              ComponentCard(
                title: 'Progress',
                name: 'progress',
                example: const Progress(
                  progress: 0.75,
                ).sized(width: 200),
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
                        title: const Text('Skeleton Example 1'),
                        content: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        leading: const Avatar(
                          initials: '',
                        ).asSkeleton(),
                        // Note: Avatar and other Image related widget needs its own skeleton
                        trailing: const Icon(Icons.arrow_forward),
                      ).asSkeleton(),
                      const Gap(16),
                      Basic(
                        title: const Text('Skeleton Example 1'),
                        content: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        leading: const Avatar(
                          initials: '',
                        ).asSkeleton(),
                        // Note: Avatar and other Image related widget needs its own skeleton
                        trailing: const Icon(Icons.arrow_forward),
                      ).asSkeleton(),
                      const Gap(16),
                      Basic(
                        title: const Text('Skeleton Example 1'),
                        content: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        leading: const Avatar(
                          initials: '',
                        ).asSkeleton(),
                        // Note: Avatar and other Image related widget needs its own skeleton
                        trailing: const Icon(Icons.arrow_forward),
                      ).asSkeleton(),
                    ],
                  ),
                ).sized(height: 300),
              ),
              ComponentCard(
                title: 'Toast',
                name: 'toast',
                scale: 1.3,
                reverseVertical: true,
                example: Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -24),
                      child: Transform.scale(
                        scale: 0.9 * 0.9,
                        child: Opacity(
                          opacity: 0.5,
                          child: _buildToast(),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -12),
                      child: Transform.scale(
                        scale: 0.9,
                        child: Opacity(
                          opacity: 0.75,
                          child: _buildToast(),
                        ),
                      ),
                    ),
                    _buildToast(),
                  ],
                ),
              ),
            ]),
            const Text('Forms').h2().anchored(formsKey),
            const Gap(16),
            wrap(children: [
              ComponentCard(
                name: 'button',
                title: 'Button',
                scale: 1.5,
                example: SizedBox(
                  width: 250,
                  child: Card(
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        PrimaryButton(
                          onPressed: () {},
                          child: const Text('Primary'),
                        ),
                        SecondaryButton(
                          onPressed: () {},
                          child: const Text('Secondary'),
                        ),
                        OutlineButton(
                          onPressed: () {},
                          child: const Text('Outline'),
                        ),
                        GhostButton(
                          onPressed: () {},
                          child: const Text('Ghost'),
                        ),
                        DestructiveButton(
                          child: const Text('Destructive'),
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
                        trailing: const Text('Checked'),
                        onChanged: (value) {},
                      ),
                      Checkbox(
                        state: CheckboxState.indeterminate,
                        trailing: const Text('Indeterminate'),
                        onChanged: (value) {},
                      ),
                      Checkbox(
                        state: CheckboxState.unchecked,
                        trailing: const Text('Unchecked'),
                        onChanged: (value) {},
                      ),
                    ],
                  ).gap(4).sized(width: 300),
                ),
              ),
              ComponentCard(
                name: 'chip_input',
                title: 'Chip Input',
                scale: 1,
                example: Card(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: OutlinedContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Chip(
                                    trailing:
                                        ChipButton(child: Icon(Icons.close)),
                                    child: Text('Chip 1'),
                                  ),
                                  Chip(
                                    trailing:
                                        ChipButton(child: Icon(Icons.close)),
                                    child: Text('Chip 2'),
                                  ),
                                ],
                              ).gap(4),
                              const Gap(4),
                              Row(
                                children: [
                                  const Chip(
                                    trailing:
                                        ChipButton(child: Icon(Icons.close)),
                                    child: Text('Cool Chip'),
                                  ),
                                  const Gap(4),
                                  const Text('Chip 4'),
                                  VerticalDivider(
                                    color: theme.colorScheme.primary,
                                  ).sized(height: 18),
                                ],
                              ).gap(4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ComponentCard(
                name: 'color_picker',
                title: 'Color Picker',
                reverse: true,
                reverseVertical: true,
                example: Card(
                  child: ColorPickerSet(
                      color: ColorDerivative.fromColor(Colors.blue)),
                ),
              ),
              const ComponentCard(
                name: 'date_picker',
                title: 'Date Picker',
                horizontalOffset: 70,
                example: CalendarExample2(),
              ),
              const ComponentCard(
                name: 'form',
                title: 'Form',
                example: Card(child: FormExample1()),
              ),
              ComponentCard(
                name: 'input',
                title: 'Text Input',
                scale: 2,
                example: Card(
                  child: const TextField(
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
                    const Card(
                      child: InputOTPExample2(),
                    ),
                    const Gap(24),
                    Transform.translate(
                      offset: const Offset(-150, 0),
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
                name: 'phone_input',
                title: 'Phone Input',
                scale: 1.5,
                example: Card(
                  child: const PhoneInput(
                    initialValue: PhoneNumber(Country.indonesia, '81234567890'),
                  ).withAlign(Alignment.topLeft),
                ).sized(height: 300),
              ),
              ComponentCard(
                name: 'radio_group',
                title: 'Radio Group',
                scale: 2,
                example: Card(
                  child: RadioGroup<int>(
                    value: 1,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioItem<int>(
                          trailing: Text('Option 1'),
                          value: 0,
                        ),
                        RadioItem<int>(
                          trailing: Text('Option 2'),
                          value: 1,
                        ),
                        RadioItem<int>(
                          trailing: Text('Option 3'),
                          value: 2,
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
                          placeholder: const Text('Select a fruit'),
                          value: 'Apple',
                          onChanged: (value) {},
                          children: const [
                            SelectItemButton(
                                value: 'Apple', child: Text('Apple')),
                          ],
                        ),
                        SelectPopup(
                          margin: const EdgeInsets.symmetric(vertical: 8) *
                              theme.scaling,
                          borderRadius: theme.borderRadiusXl,
                          value: ValueNotifier(['Apple']),
                          children: ValueNotifier(const [
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
                          ]),
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
                  value: const SliderValue.single(0.75),
                  onChanged: (value) {},
                ).sized(width: 100),
              ),
              const ComponentCard(
                name: 'star_rating',
                title: 'Star Rating',
                scale: 1,
                example: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StarRating(
                      starSize: 64,
                      value: 3.5,
                    ),
                    Gap(16),
                    StarRating(
                      starSize: 64,
                      value: 2.5,
                    ),
                  ],
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
              const ComponentCard(
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
                name: 'time_picker',
                title: 'Time Picker',
                scale: 1.2,
                example: Card(
                  child: TimePickerDialog(
                    use24HourFormat: true,
                    initialValue: TimeOfDay.now(),
                  ).withAlign(Alignment.topLeft),
                ).sized(height: 300),
              ),
              ComponentCard(
                name: 'toggle',
                title: 'Toggle',
                scale: 1.2,
                example: Card(
                  child: const ToggleExample2().withAlign(Alignment.topLeft),
                ).sized(height: 300, width: 300),
              ),
            ]),
            const Text('Layout').h2().anchored(layoutKey),
            const Gap(16),
            wrap(children: [
              const ComponentCard(
                name: 'card',
                title: 'Card',
                example: CardExample1(),
              ),
              const ComponentCard(
                name: 'carousel',
                title: 'Carousel',
                fit: true,
                example: SizedBox(
                    width: 550, height: 200, child: CarouselExample1()),
              ),
              const ComponentCard(
                name: 'divider',
                title: 'Divider',
                scale: 1.2,
                example: Card(child: DividerExample3()),
              ),
              const ComponentCard(
                title: 'Resizable',
                name: 'resizable',
                scale: 1,
                example: ResizableExample3(),
              ),
              const ComponentCard(
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
              ComponentCard(
                name: 'stepper',
                title: 'Stepper',
                scale: 1,
                example: const StepperExample2().sized(width: 400, height: 500),
              ),
              ComponentCard(
                name: 'timeline',
                title: 'Timeline',
                scale: 1,
                example:
                    const TimelineExample1().sized(width: 700, height: 800),
              ),
            ]),
            const Text('Navigation').h2().anchored(navigationKey),
            const Gap(16),
            wrap(children: [
              ComponentCard(
                title: 'Breadcrumb',
                name: 'breadcrumb',
                // scale: 1,
                example: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(child: BreadcrumbExample1()),
                    Card(child: BreadcrumbExample1()),
                    Card(child: BreadcrumbExample1()),
                  ],
                ).gap(16),
              ),
              ComponentCard(
                title: 'Menubar',
                name: 'menubar',
                scale: 1,
                example: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedContainer(
                        borderColor: theme.colorScheme.border,
                        backgroundColor: theme.colorScheme.background,
                        borderRadius: theme.borderRadiusMd,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Button(
                                  onPressed: () {},
                                  style: const ButtonStyle.menubar(),
                                  child: const Text('File'),
                                ),
                                Button(
                                  onPressed: () {},
                                  style: const ButtonStyle.menubar().copyWith(
                                    decoration: (context, states, value) {
                                      return (value as BoxDecoration).copyWith(
                                        color: theme.colorScheme.accent,
                                        borderRadius: BorderRadius.circular(
                                            theme.radiusSm),
                                      );
                                    },
                                  ),
                                  child: const Text('Edit'),
                                ),
                                Button(
                                  onPressed: () {},
                                  style: const ButtonStyle.menubar(),
                                  child: const Text('View'),
                                ),
                                Button(
                                  onPressed: () {},
                                  style: const ButtonStyle.menubar(),
                                  child: const Text('Help'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(4),
                      Container(
                        width: 192,
                        margin: const EdgeInsets.only(left: 48),
                        child: MenuPopup(children: [
                          Button(
                            style: const ButtonStyle.menu(),
                            onPressed: () {},
                            trailing: const MenuShortcut(
                              activator: SingleActivator(
                                  LogicalKeyboardKey.keyZ,
                                  control: true),
                            ),
                            child: const Text('Undo'),
                          ),
                          Button(
                            style: const ButtonStyle.menu().copyWith(
                                decoration: (context, states, value) {
                              return (value as BoxDecoration).copyWith(
                                color: theme.colorScheme.accent,
                                borderRadius:
                                    BorderRadius.circular(theme.radiusSm),
                              );
                            }),
                            onPressed: () {},
                            trailing: const MenuShortcut(
                              activator: SingleActivator(
                                  LogicalKeyboardKey.keyY,
                                  control: true),
                            ),
                            child: const Text('Redo'),
                          ),
                          const MenuDivider(),
                          Button(
                            style: const ButtonStyle.menu(),
                            onPressed: () {},
                            trailing: const MenuShortcut(
                              activator: SingleActivator(
                                  LogicalKeyboardKey.keyX,
                                  control: true),
                            ),
                            child: const Text('Cut'),
                          ),
                          Button(
                            style: const ButtonStyle.menu(),
                            onPressed: () {},
                            trailing: const MenuShortcut(
                              activator: SingleActivator(
                                  LogicalKeyboardKey.keyC,
                                  control: true),
                            ),
                            child: const Text('Copy'),
                          ),
                          Button(
                            style: const ButtonStyle.menu(),
                            onPressed: () {},
                            trailing: const MenuShortcut(
                              activator: SingleActivator(
                                  LogicalKeyboardKey.keyV,
                                  control: true),
                            ),
                            child: const Text('Paste'),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              ComponentCard(
                title: 'Navigation Menu',
                name: 'navigation_menu',
                scale: 1,
                example: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NavigationMenu(
                        children: [
                          Button(
                            onPressed: () {},
                            style: const ButtonStyle.ghost().copyWith(
                              decoration: (context, states, value) {
                                return (value as BoxDecoration).copyWith(
                                  borderRadius:
                                      BorderRadius.circular(theme.radiusMd),
                                  color:
                                      theme.colorScheme.muted.scaleAlpha(0.8),
                                );
                              },
                            ),
                            trailing: const Icon(
                              RadixIcons.chevronUp,
                              size: 12,
                            ),
                            child: const Text('Getting Started'),
                          ),
                          const NavigationItem(
                            content: SizedBox(),
                            child: Text('Components'),
                          ),
                        ],
                      ),
                      const Gap(8),
                      OutlinedContainer(
                        borderRadius: theme.borderRadiusMd,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: NavigationContentList(
                            children: [
                              Button(
                                style: ButtonVariance.ghost.copyWith(
                                  padding: (context, states, value) {
                                    return const EdgeInsets.all(12);
                                  },
                                  decoration: (context, states, value) {
                                    return (value as BoxDecoration).copyWith(
                                      borderRadius:
                                          BorderRadius.circular(theme.radiusMd),
                                      color: theme.colorScheme.muted
                                          .scaleAlpha(0.8),
                                    );
                                  },
                                ),
                                onPressed: () {},
                                alignment: Alignment.topLeft,
                                child: Basic(
                                  title: const Text('Installation').medium(),
                                  content: const Text(
                                          'How to install Shadcn/UI for Flutter')
                                      .muted(),
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                              ).constrained(maxWidth: 16 * 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ComponentCard(
                title: 'Pagination',
                name: 'pagination',
                reverse: true,
                example: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Card(child: PaginationExample1()),
                    Transform.translate(
                        offset: const Offset(250, 0),
                        child: const Card(child: PaginationExample1())),
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
                      Tabs(index: 0, onChanged: (value) {}, tabs: const [
                        Text('Tab 1'),
                        Text('Tab 2'),
                        Text('Tab 3'),
                      ]),
                      Tabs(index: 1, onChanged: (value) {}, tabs: const [
                        Text('Tab 1'),
                        Text('Tab 2'),
                        Text('Tab 3'),
                      ]),
                      Tabs(index: 2, onChanged: (value) {}, tabs: const [
                        Text('Tab 1'),
                        Text('Tab 2'),
                        Text('Tab 3'),
                      ]),
                    ],
                  ).gap(8),
                ),
              ),
              const ComponentCard(
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
              const ComponentCard(
                name: 'tree',
                title: 'Tree',
                scale: 1.5,
                example: TreeExample1(),
              ),
            ]),
            const Text('Surfaces').h2().anchored(surfacesKey),
            const Gap(16),
            wrap(children: [
              ComponentCard(
                  title: 'Dialog',
                  name: 'dialog',
                  example: AlertDialog(
                    barrierColor: Colors.transparent,
                    title: const Text('Edit profile'),
                    content: IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                              'Make changes to your profile here. Click save when you\'re done'),
                          const Gap(16),
                          const Form(
                            child: FormTableLayout(rows: [
                              FormField<String>(
                                key: FormKey(#name),
                                label: Text('Name'),
                                child: TextField(
                                  initialValue: 'Thito Yalasatria Sunarya',
                                ),
                              ),
                              FormField<String>(
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
                    ),
                    actions: [
                      PrimaryButton(
                        child: const Text('Save changes'),
                        onPressed: () {},
                      ),
                    ],
                  )),
              ComponentCard(
                title: 'Drawer',
                name: 'drawer',
                scale: 1,
                example: DrawerWrapper(
                  stackIndex: 0,
                  position: OverlayPosition.bottom,
                  size: const Size(300, 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Drawer!').large().medium(),
                      const Gap(4),
                      const Text(
                              'This is a drawer that you can use to display content')
                          .muted(),
                    ],
                  ).withPadding(horizontal: 32),
                ).sized(width: 300, height: 300),
              ),
              ComponentCard(
                name: 'hover_card',
                title: 'Hover Card',
                scale: 1,
                example: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('@flutter').medium().underline(),
                        const Gap(16),
                        const Card(
                          child: Basic(
                            leading: FlutterLogo(),
                            title: Text('@flutter'),
                            content: Text(
                                'The Flutter SDK provides the tools to build beautiful apps for mobile, web, and desktop from a single codebase.'),
                          ),
                        ).sized(width: 300),
                      ],
                    ),
                    const Positioned(
                      top: 13,
                      left: 160,
                      child: CustomPaint(
                        painter: CursorPainter(),
                      ),
                    ),
                  ],
                ),
              ),
              ComponentCard(
                title: 'Sheet',
                name: 'sheet',
                verticalOffset: 0,
                scale: 1,
                example: SheetWrapper(
                  position: OverlayPosition.right,
                  stackIndex: 0,
                  size: const Size(300, 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sheet!').large().medium(),
                      const Gap(4),
                      const Text(
                              'This is a sheet that you can use to display content')
                          .muted(),
                    ],
                  ).withPadding(horizontal: 32, vertical: 48),
                ).sized(width: 300, height: 300),
              ),
              ComponentCard(
                name: 'tooltip',
                title: 'Tooltip',
                center: true,
                scale: 1,
                example: Stack(
                  children: [
                    Column(
                      children: [
                        DestructiveButton(
                          leading: const Icon(Icons.delete),
                          child: const Text('Delete'),
                          onPressed: () {},
                        ),
                        const Gap(4),
                        const TooltipContainer(
                          child: Text('Click to delete this item'),
                        ),
                      ],
                    ),
                    const Positioned(
                      top: 25,
                      left: 100,
                      child: CustomPaint(
                        painter: CursorPainter(),
                      ),
                    )
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
                      DatePicker(
                        value: DateTime.now(),
                        mode: PromptMode.popover,
                        stateBuilder: (date) {
                          if (date.isAfter(DateTime.now())) {
                            return DateState.disabled;
                          }
                          return DateState.enabled;
                        },
                        onChanged: (value) {},
                      ),
                      const Gap(4),
                      const CalendarExample2(),
                    ],
                  ),
                ),
              ),
            ]),
            const Text('Data Display').h2().anchored(dataDisplayKey),
            const Gap(16),
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
                        provider: const NetworkImage(
                            'https://avatars.githubusercontent.com/u/64018564?v=4'),
                      ),
                      const Gap(16),
                      Avatar(
                        initials: Avatar.getInitials('sunarya-thito'),
                      ),
                    ],
                  ),
                ),
              ),
              ComponentCard(
                name: 'avatar_group',
                title: 'Avatar Group',
                scale: 1.5,
                center: true,
                example: AvatarGroup.toLeft(children: [
                  Avatar(
                    initials: Avatar.getInitials('sunarya-thito'),
                    backgroundColor: Colors.red,
                  ),
                  Avatar(
                    initials: Avatar.getInitials('sunarya-thito'),
                    backgroundColor: Colors.green,
                  ),
                  Avatar(
                    initials: Avatar.getInitials('sunarya-thito'),
                    backgroundColor: Colors.blue,
                  ),
                  Avatar(
                    initials: Avatar.getInitials('sunarya-thito'),
                    backgroundColor: Colors.yellow,
                  ),
                ]),
              ),
              const WIPComponentCard(title: 'Data Table'),
              const WIPComponentCard(title: 'Chart'),
              const ComponentCard(
                  name: 'code_snippet',
                  title: 'Code Snippet',
                  scale: 1.5,
                  reverse: true,
                  reverseVertical: true,
                  example: CodeSnippetExample1()),
              const WIPComponentCard(title: 'Table'),
              ComponentCard(
                name: 'tracker',
                title: 'Tracker',
                scale: 2,
                verticalOffset: 48,
                example: const TrackerExample1().sized(width: 500),
              ),
            ]),
            const Text('Utilities').h2().anchored(utilitiesKey),
            const Gap(16),
            wrap(children: [
              ComponentCard(
                name: 'badge',
                title: 'Badge',
                center: true,
                scale: 1.5,
                example: const Column(
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
              const ComponentCard(
                name: 'command',
                title: 'Command',
                scale: 1,
                example: CommandExample1(),
              ),
              ComponentCard(
                title: 'Context Menu',
                name: 'context_menu',
                scale: 1.2,
                example: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomPaint(
                      painter: CursorPainter(),
                    ),
                    const Gap(24),
                    SizedBox(
                      width: 192,
                      child: MenuPopup(children: [
                        Button(
                          style: const ButtonStyle.menu(),
                          onPressed: () {},
                          trailing: const MenuShortcut(
                            activator: SingleActivator(LogicalKeyboardKey.keyX,
                                control: true),
                          ),
                          child: const Text('Cut'),
                        ),
                        Button(
                          style: const ButtonStyle.menu(),
                          onPressed: () {},
                          trailing: const MenuShortcut(
                            activator: SingleActivator(LogicalKeyboardKey.keyC,
                                control: true),
                          ),
                          child: const Text('Copy'),
                        ),
                        Button(
                          style: const ButtonStyle.menu(),
                          onPressed: () {},
                          trailing: const MenuShortcut(
                            activator: SingleActivator(LogicalKeyboardKey.keyV,
                                control: true),
                          ),
                          child: const Text('Paste'),
                        ),
                        const MenuDivider(),
                        Button(
                          style: const ButtonStyle.menu(),
                          onPressed: () {},
                          trailing: const MenuShortcut(
                            activator:
                                SingleActivator(LogicalKeyboardKey.delete),
                          ),
                          child: const Text('Delete'),
                        ),
                        Button(
                          style: const ButtonStyle.menu(),
                          onPressed: () {},
                          trailing: const MenuShortcut(
                            activator: SingleActivator(LogicalKeyboardKey.keyA,
                                control: true),
                          ),
                          child: const Text('Select All'),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              ComponentCard(
                title: 'Dropdown Menu',
                name: 'dropdown_menu',
                scale: 1,
                example: Stack(
                  children: [
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OutlineButton(
                            onPressed: () {},
                            child: const Text('Options'),
                          ),
                          const Gap(8),
                          SizedBox(
                            width: 192,
                            child: MenuPopup(children: [
                              Button(
                                style: const ButtonStyle.menu(),
                                onPressed: () {},
                                child: const Text('Profile'),
                              ),
                              Button(
                                style: const ButtonStyle.menu().copyWith(
                                    decoration: (context, states, value) {
                                  return (value as BoxDecoration).copyWith(
                                    color: theme.colorScheme.accent,
                                    borderRadius:
                                        BorderRadius.circular(theme.radiusSm),
                                  );
                                }),
                                onPressed: () {},
                                child: const Text('Billing'),
                              ),
                              const MenuDivider(),
                              Button(
                                style: const ButtonStyle.menu(),
                                onPressed: () {},
                                child: const Text('Settings'),
                              ),
                              Button(
                                style: const ButtonStyle.menu(),
                                onPressed: () {},
                                trailing: const MenuShortcut(
                                  activator: SingleActivator(
                                      LogicalKeyboardKey.keyC,
                                      control: true),
                                ),
                                child: const Text('Copy'),
                              ),
                              Button(
                                style: const ButtonStyle.menu(),
                                onPressed: () {},
                                trailing: const MenuShortcut(
                                  activator: SingleActivator(
                                      LogicalKeyboardKey.keyV,
                                      control: true),
                                ),
                                child: const Text('Paste'),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 105,
                      left: 170,
                      child: CustomPaint(
                        painter: CursorPainter(),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget wrap({required List<IComponentPage> children}) {
    children.sort((a, b) => a.title.compareTo(b.title));
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: children,
    );
  }
}

abstract class IComponentPage extends Widget {
  const IComponentPage({super.key});

  String get title;
}

class WIPComponentCard extends StatelessWidget implements IComponentPage {
  @override
  final String title;

  const WIPComponentCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ComponentCard(
        name: '-',
        title: title,
        center: true,
        example: const PrimaryBadge(
          child: Text('Work in Progress'),
        ),
      ),
    );
  }
}

class ComponentCard extends StatefulWidget implements IComponentPage {
  final String name;
  @override
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
    super.key,
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
  });

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
      behavior: HitTestBehavior.translucent,
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
        onPressed: componentsMode == ComponentsMode.normal
            ? () {
                context.pushNamed(widget.name);
              }
            : null,
        child: RepaintBoundary(
          key: repaintKey,
          child: ExcludeFocus(
            child: SizedBox(
              height: 200,
              width: 250,
              child: AnimatedValueBuilder(
                  value: _hovering ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
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
                          const Divider(),
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

// paint a cursor
class CursorPainter extends CustomPainter {
  // <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  // <path d="M4 0l16 12.279-6.951 1.17 4.325 8.817-3.596 1.734-4.35-8.879-5.428 4.702z"/></svg>
  const CursorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(4, 0)
      ..lineTo(20, 12.279)
      ..lineTo(13.049, 13.449)
      ..lineTo(17.374, 22.266)
      ..lineTo(13.778, 24)
      ..lineTo(9.428, 15.121)
      ..lineTo(4, 19.823)
      ..close();
    canvas.drawPath(path, paint);
    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
