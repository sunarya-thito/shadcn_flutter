import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:docs/pages/docs/components/accordion/accordion_tile.dart';
import 'package:docs/pages/docs/components/alert/alert_tile.dart';
import 'package:docs/pages/docs/components/alert_dialog/alert_dialog_tile.dart';
import 'package:docs/pages/docs/components/animated_value_builder/animated_value_builder_tile.dart';
import 'package:docs/pages/docs/components/avatar/avatar_tile.dart';
import 'package:docs/pages/docs/components/avatar_group/avatar_group_tile.dart';
import 'package:docs/pages/docs/components/badge/badge_tile.dart';
import 'package:docs/pages/docs/components/breadcrumb/breadcrumb_tile.dart';
import 'package:docs/pages/docs/components/button/button_tile.dart';
import 'package:docs/pages/docs/components/calendar/calendar_tile.dart';
import 'package:docs/pages/docs/components/card/card_tile.dart';
import 'package:docs/pages/docs/components/carousel/carousel_tile.dart';
import 'package:docs/pages/docs/components/checkbox/checkbox_tile.dart';
import 'package:docs/pages/docs/components/chip_input/chip_input_tile.dart';
import 'package:docs/pages/docs/components/circular_progress/circular_progress_tile.dart';
import 'package:docs/pages/docs/components/code_snippet/code_snippet_tile.dart';
import 'package:docs/pages/docs/components/collapsible/collapsible_tile.dart';
import 'package:docs/pages/docs/components/color_picker/color_picker_tile.dart';
import 'package:docs/pages/docs/components/command/command_tile.dart';
import 'package:docs/pages/docs/components/context_menu/context_menu_tile.dart';
import 'package:docs/pages/docs/components/date_picker/date_picker_tile.dart';
import 'package:docs/pages/docs/components/dialog/dialog_tile.dart';
import 'package:docs/pages/docs/components/divider/divider_tile.dart';
import 'package:docs/pages/docs/components/drawer/drawer_tile.dart';
import 'package:docs/pages/docs/components/dropdown_menu/dropdown_menu_tile.dart';
import 'package:docs/pages/docs/components/form/form_tile.dart';
import 'package:docs/pages/docs/components/hover_card/hover_card_tile.dart';
import 'package:docs/pages/docs/components/input/input_tile.dart';
import 'package:docs/pages/docs/components/input_otp/input_otp_tile.dart';
import 'package:docs/pages/docs/components/menubar/menubar_tile.dart';
import 'package:docs/pages/docs/components/navigation_menu/navigation_menu_tile.dart';
import 'package:docs/pages/docs/components/number_ticker/number_ticker_tile.dart';
import 'package:docs/pages/docs/components/pagination/pagination_tile.dart';
import 'package:docs/pages/docs/components/phone_input/phone_input_tile.dart';
import 'package:docs/pages/docs/components/popover/popover_tile.dart';
import 'package:docs/pages/docs/components/progress/progress_tile.dart';
import 'package:docs/pages/docs/components/radio_group/radio_group_tile.dart';
import 'package:docs/pages/docs/components/repeated_animation_builder/repeated_animation_builder_tile.dart';
import 'package:docs/pages/docs/components/resizable/resizable_tile.dart';
import 'package:docs/pages/docs/components/select/select_tile.dart';
import 'package:docs/pages/docs/components/sheet/sheet_tile.dart';
import 'package:docs/pages/docs/components/skeleton/skeleton_tile.dart';
import 'package:docs/pages/docs/components/slider/slider_tile.dart';
import 'package:docs/pages/docs/components/star_rating/star_rating_tile.dart';
import 'package:docs/pages/docs/components/stepper/stepper_tile.dart';
import 'package:docs/pages/docs/components/steps/steps_tile.dart';
import 'package:docs/pages/docs/components/switch/switch_tile.dart';
import 'package:docs/pages/docs/components/tab_list/tab_list_tile.dart';
import 'package:docs/pages/docs/components/tabs/tabs_tile.dart';
import 'package:docs/pages/docs/components/text_area/text_area_tile.dart';
import 'package:docs/pages/docs/components/time_picker/time_picker_tile.dart';
import 'package:docs/pages/docs/components/timeline/timeline_tile.dart';
import 'package:docs/pages/docs/components/toast/toast_tile.dart';
import 'package:docs/pages/docs/components/toggle/toggle_tile.dart';
import 'package:docs/pages/docs/components/tooltip/tooltip_tile.dart';
import 'package:docs/pages/docs/components/tracker/tracker_tile.dart';
import 'package:docs/pages/docs/components/tree/tree_tile.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Missing component tiles
import 'components/app_bar/app_bar_tile.dart';
import 'components/autocomplete/autocomplete_tile.dart';
import 'components/card_image/card_image_tile.dart';
import 'components/chip/chip_tile.dart';
import 'components/dot_indicator/dot_indicator_tile.dart';
import 'components/expandable_sidebar/expandable_sidebar_tile.dart';
import 'components/formatted_input/formatted_input_tile.dart';
import 'components/item_picker/item_picker_tile.dart';
import 'components/keyboard_display/keyboard_display_tile.dart';
import 'components/linear_progress/linear_progress_tile.dart';
import 'components/multiselect/multiselect_tile.dart';
import 'components/navigation_bar/navigation_bar_tile.dart';
import 'components/navigation_rail/navigation_rail_tile.dart';
import 'components/navigation_sidebar/navigation_sidebar_tile.dart';
import 'components/number_input/number_input_tile.dart';
import 'components/overflow_marquee/overflow_marquee_tile.dart';
import 'components/radio_card/radio_card_tile.dart';
import 'components/refresh_trigger/refresh_trigger_tile.dart';
import 'components/scaffold/scaffold_tile.dart';
import 'components/sortable/sortable_tile.dart';
import 'components/swiper/swiper_tile.dart';
import 'components/tab_pane/tab_pane_tile.dart';
import 'components/table/table_tile.dart';
import 'components/timeline_animation/timeline_animation_tile.dart';
import 'components/window/window_tile.dart';

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

  @override
  Widget build(BuildContext context) {
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
              const AnimatedValueBuilderTile(),
              const NumberTickerTile(),
              const RepeatedAnimationBuilderTile(),
            ]),
            const Text('Disclosure').h2().anchored(disclosureKey),
            const Gap(16),
            wrap(
              children: [
                const AccordionTile(),
                const CollapsibleTile(),
              ],
            ),
            const Text('Feedback').h2().anchored(feedbackKey),
            const Gap(16),
            wrap(children: [
              const AlertTile(),
              const AlertDialogTile(),
              const CircularProgressTile(),
              const ProgressTile(),
              const SkeletonTile(),
              const ToastTile(),
              const LinearProgressTile(),
            ]),
            const Text('Forms').h2().anchored(formsKey),
            const Gap(16),
            wrap(children: [
              const ButtonTile(),
              const CheckboxTile(),
              const ChipInputTile(),
              const ColorPickerTile(),
              const DatePickerTile(),
              const FormTile(),
              const InputTile(),
              const InputOTPTile(),
              const PhoneInputTile(),
              const RadioGroupTile(),
              const SelectTile(),
              const SliderTile(),
              const StarRatingTile(),
              const SwitchTile(),
              const TextAreaTile(),
              const TimePickerTile(),
              const ToggleTile(),
              const AutocompleteTile(),
              const ChipTile(),
              const FormattedInputTile(),
              const ItemPickerTile(),
              const MultiselectTile(),
              const NumberInputTile(),
              const RadioCardTile(),
              const SortableTile(),
            ]),
            const Text('Layout').h2().anchored(layoutKey),
            const Gap(16),
            wrap(children: [
              const CardTile(),
              const CarouselTile(),
              const DividerTile(),
              const ResizableTile(),
              const StepsTile(),
              const StepperTile(),
              const TimelineTile(),
              const AppBarTile(),
              const ExpandableSidebarTile(),
              const ScaffoldTile(),
              const SwiperTile(),
              const WindowTile(),
            ]),
            const Text('Navigation').h2().anchored(navigationKey),
            const Gap(16),
            wrap(children: [
              const BreadcrumbTile(),
              const MenubarTile(),
              const NavigationMenuTile(),
              const PaginationTile(),
              const TabsTile(),
              const TabListTile(),
              const TreeTile(),
              const NavigationBarTile(),
              const NavigationRailTile(),
              const NavigationSidebarTile(),
              const TabPaneTile(),
            ]),
            const Text('Surfaces').h2().anchored(surfacesKey),
            const Gap(16),
            wrap(children: [
              const DialogTile(),
              const DrawerTile(),
              const HoverCardTile(),
              const SheetTile(),
              const TooltipTile(),
              const PopoverTile(),
            ]),
            const Text('Data Display').h2().anchored(dataDisplayKey),
            const Gap(16),
            wrap(children: [
              const AvatarTile(),
              const AvatarGroupTile(),
              const WIPComponentCard(title: 'Data Table'),
              const WIPComponentCard(title: 'Chart'),
              const CodeSnippetTile(),
              const WIPComponentCard(title: 'Table'),
              const TrackerTile(),
              const DotIndicatorTile(),
              const CardImageTile(),
              const TableTile(),
            ]),
            const Text('Utilities').h2().anchored(utilitiesKey),
            const Gap(16),
            wrap(children: [
              const BadgeTile(),
              const CalendarTile(),
              const CommandTile(),
              const ContextMenuTile(),
              const DropdownMenuTile(),
              const KeyboardDisplayTile(),
              const OverflowMarqueeTile(),
              const RefreshTriggerTile(),
              const TimelineAnimationTile(),
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
        child: WidgetStatesProvider.boundary(
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
                                                          clipBehavior:
                                                              Clip.none,
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
