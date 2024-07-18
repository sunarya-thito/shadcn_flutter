import 'dart:convert';

import 'package:example/pages/docs/components/accordion_example.dart';
import 'package:example/pages/docs/components/alert_dialog_example.dart';
import 'package:example/pages/docs/components/alert_example.dart';
import 'package:example/pages/docs/components/animated_value_builder_example.dart';
import 'package:example/pages/docs/components/avatar_example.dart';
import 'package:example/pages/docs/components/calendar_example.dart';
import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:example/pages/docs/components/context_menu_example.dart';
import 'package:example/pages/docs/components/date_picker_example.dart';
import 'package:example/pages/docs/components/dialog_example.dart';
import 'package:example/pages/docs/components/divider_example.dart';
import 'package:example/pages/docs/components/drawer_example.dart';
import 'package:example/pages/docs/components/dropdown_menu_example.dart';
import 'package:example/pages/docs/components/input_example.dart';
import 'package:example/pages/docs/components/input_otp_example.dart';
import 'package:example/pages/docs/components/material_example.dart';
import 'package:example/pages/docs/components/menubar_example.dart';
import 'package:example/pages/docs/components/navigation_menu_example.dart';
import 'package:example/pages/docs/components/pagination_example.dart';
import 'package:example/pages/docs/components/popover_example.dart';
import 'package:example/pages/docs/components/progress_example.dart';
import 'package:example/pages/docs/components/radio_group_example.dart';
import 'package:example/pages/docs/components/repeated_animation_builder_example.dart';
import 'package:example/pages/docs/components/resizable_example.dart';
import 'package:example/pages/docs/components/select_example.dart';
import 'package:example/pages/docs/components/sheet_example.dart';
import 'package:example/pages/docs/components/skeleton_example.dart';
import 'package:example/pages/docs/components/slider_example.dart';
import 'package:example/pages/docs/components/steps_example.dart';
import 'package:example/pages/docs/components/switch_example.dart';
import 'package:example/pages/docs/components/tab_list_example.dart';
import 'package:example/pages/docs/components/tabs_example.dart';
import 'package:example/pages/docs/components/text_area_example.dart';
import 'package:example/pages/docs/components/toggle_example.dart';
import 'package:example/pages/docs/components/tooltip_example.dart';
import 'package:example/pages/docs/components_page.dart';
import 'package:example/pages/docs/icons_page.dart';
import 'package:example/pages/docs/installation_page.dart';
import 'package:example/pages/docs/introduction_page.dart';
import 'package:example/pages/docs/layout_page.dart';
import 'package:example/pages/docs/theme_page.dart';
import 'package:example/pages/docs/typography_page.dart';
import 'package:example/pages/docs/web_preloader_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/docs/components/badge_example.dart';
import 'pages/docs/components/breadcrumb_example.dart';
import 'pages/docs/components/button_example.dart';
import 'pages/docs/components/card_example.dart';
import 'pages/docs/components/checkbox_example.dart';
import 'pages/docs/components/circular_progress_example.dart';
import 'pages/docs/components/code_snippet_example.dart';
import 'pages/docs/components/collapsible_example.dart';
import 'pages/docs/components/color_picker_example.dart';
import 'pages/docs/components/command_example.dart';
import 'pages/docs/components/form_example.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  final prefs = await SharedPreferences.getInstance();
  var colorScheme = prefs.getString('colorScheme');
  // ColorScheme? initialColorScheme =
  //     colorSchemes[colorScheme ?? 'darkZync'];
  ColorScheme? initialColorScheme;
  if (colorScheme != null) {
    if (colorScheme.startsWith('{')) {
      initialColorScheme = ColorScheme.fromMap(jsonDecode(colorScheme));
    } else {
      initialColorScheme = colorSchemes[colorScheme];
    }
  }
  double initialRadius = prefs.getDouble('radius') ?? 0.5;
  runApp(MyApp(
    initialColorScheme: initialColorScheme ?? colorSchemes['darkZync']!,
    initialRadius: initialRadius,
  ));
}

class MyApp extends StatefulWidget {
  final ColorScheme initialColorScheme;
  final double initialRadius;
  const MyApp(
      {super.key,
      required this.initialColorScheme,
      required this.initialRadius});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IntroductionPage(),
      // builder: (context, state) => TestWidget(),
      name: 'introduction',
    ),
    GoRoute(
      path: '/installation',
      builder: (context, state) => const InstallationPage(),
      name: 'installation',
    ),
    GoRoute(
      path: '/theme',
      builder: (context, state) => const ThemePage(),
      name: 'theme',
    ),
    GoRoute(
      path: '/typography',
      builder: (context, state) => const TypographyPage(),
      name: 'typography',
    ),
    GoRoute(
      path: '/layout',
      builder: (context, state) => const LayoutPage(),
      name: 'layout',
    ),
    GoRoute(
        path: '/external',
        builder: (context, state) => const MaterialExample(),
        name: 'external'),
    GoRoute(
      path: '/web_preloader',
      name: 'web_preloader',
      builder: (context, state) => const WebPreloaderPage(),
    ),
    GoRoute(
        path: '/components',
        name: 'components',
        builder: (context, state) {
          return const ComponentsPage();
        },
        routes: [
          GoRoute(
            path: 'accordion',
            builder: (context, state) => const AccordionExample(),
            name: 'accordion',
          ),
          GoRoute(
            path: 'alert',
            builder: (context, state) => const AlertExample(),
            name: 'alert',
          ),
          GoRoute(
            path: 'alert-dialog',
            builder: (context, state) => const AlertDialogExample(),
            name: 'alert_dialog',
          ),
          GoRoute(
            path: 'avatar',
            builder: (context, state) => const AvatarExample(),
            name: 'avatar',
          ),
          GoRoute(
            path: 'badge',
            builder: (context, state) => const BadgeExample(),
            name: 'badge',
          ),
          GoRoute(
            path: 'breadcrumb',
            builder: (context, state) => const BreadcrumbExample(),
            name: 'breadcrumb',
          ),
          GoRoute(
            path: 'button',
            builder: (context, state) => const ButtonExample(),
            name: 'button',
          ),
          GoRoute(
            path: 'card',
            builder: (context, state) => const CardExample(),
            name: 'card',
          ),
          GoRoute(
            path: 'checkbox',
            builder: (context, state) => const CheckboxExample(),
            name: 'checkbox',
          ),
          GoRoute(
            path: 'code-snippet',
            builder: (context, state) => const CodeSnippetExample(),
            name: 'code_snippet',
          ),
          GoRoute(
            path: 'circular-progress',
            builder: (context, state) => const CircularProgressExample(),
            name: 'circular_progress',
          ),
          GoRoute(
            path: 'color-picker',
            builder: (context, state) => const ColorPickerExample(),
            name: 'color_picker',
          ),
          GoRoute(
            path: 'select',
            builder: (context, state) => const SelectExample(),
            name: 'select',
          ),
          GoRoute(
            path: 'divider',
            builder: (context, state) => const DividerExample(),
            name: 'divider',
          ),
          GoRoute(
            path: 'collapsible',
            builder: (context, state) => const CollapsibleExample(),
            name: 'collapsible',
          ),
          GoRoute(
            path: 'command',
            builder: (context, state) => const CommandExample(),
            name: 'command',
          ),
          GoRoute(
            path: 'form',
            builder: (context, state) => const FormExample(),
            name: 'form',
          ),
          GoRoute(
            path: 'carousel',
            builder: (context, state) => const CarouselExample(),
            name: 'carousel',
          ),
          GoRoute(
            path: 'calendar',
            builder: (context, state) => const CalendarExample(),
            name: 'calendar',
          ),
          GoRoute(
            path: 'date_picker',
            builder: (context, state) => const DatePickerExample(),
            name: 'date_picker',
          ),
          GoRoute(
            path: 'dialog',
            builder: (context, state) => const DialogExample(),
            name: 'dialog',
          ),
          GoRoute(
            path: 'pagination',
            builder: (context, state) => const PaginationExample(),
            name: 'pagination',
          ),
          GoRoute(
            path: 'input',
            builder: (context, state) => const InputExample(),
            name: 'input',
          ),
          GoRoute(
            path: 'radio_group',
            builder: (context, state) => const RadioGroupExample(),
            name: 'radio_group',
          ),
          GoRoute(
            path: 'switch',
            builder: (context, state) => const SwitchExample(),
            name: 'switch',
          ),
          GoRoute(
            path: 'slider',
            builder: (context, state) => const SliderExample(),
            name: 'slider',
          ),
          GoRoute(
            path: 'steps',
            builder: (context, state) => const StepsExample(),
            name: 'steps',
          ),
          GoRoute(
            path: 'tab_list',
            builder: (context, state) => const TabListExample(),
            name: 'tab_list',
          ),
          GoRoute(
            path: 'tooltip',
            name: 'tooltip',
            builder: (context, state) => const TooltipExample(),
          ),
          GoRoute(
            path: 'popover',
            name: 'popover',
            builder: (context, state) => const PopoverExample(),
          ),
          GoRoute(
            path: 'progress',
            name: 'progress',
            builder: (context, state) => const ProgressExample(),
          ),
          GoRoute(
            path: 'tabs',
            name: 'tabs',
            builder: (context, state) => const TabsExample(),
          ),
          GoRoute(
            path: 'input_otp',
            builder: (context, state) => const InputOTPExample(),
            name: 'input_otp',
          ),
          GoRoute(
            path: 'text_area',
            builder: (context, state) => const TextAreaExample(),
            name: 'text_area',
          ),
          GoRoute(
            path: 'animated_value_builder',
            name: 'animated_value_builder',
            builder: (context, state) {
              return const AnimatedValueBuilderExample();
            },
          ),
          GoRoute(
              path: 'repeated_animation_builder',
              name: 'repeated_animation_builder',
              builder: (context, state) {
                return const RepeatedAnimationBuilderExample();
              }),
          GoRoute(
            path: 'skeleton',
            name: 'skeleton',
            builder: (context, state) {
              return const SkeletonExample();
            },
          ),
          GoRoute(
            path: 'toggle',
            name: 'toggle',
            builder: (context, state) {
              return const ToggleExample();
            },
          ),
          GoRoute(
            path: 'drawer',
            name: 'drawer',
            builder: (context, state) {
              return const DrawerExample();
            },
          ),
          GoRoute(
            path: 'sheet',
            name: 'sheet',
            builder: (context, state) {
              return const SheetExample();
            },
          ),
          GoRoute(
              path: 'icons',
              name: 'icons',
              builder: (context, state) {
                return const IconsPage();
              }),
          GoRoute(
              path: 'resizable',
              name: 'resizable',
              builder: (context, state) {
                return const ResizableExample();
              }),
          GoRoute(
            path: 'menubar',
            name: 'menubar',
            builder: (context, state) {
              return const MenubarExample();
            },
          ),
          GoRoute(
            path: 'context_menu',
            name: 'context_menu',
            builder: (context, state) {
              return const ContextMenuExample();
            },
          ),
          GoRoute(
            path: 'dropdown_menu',
            name: 'dropdown_menu',
            builder: (context, state) {
              return const DropdownMenuExample();
            },
          ),
          GoRoute(
            path: 'navigation_menu',
            name: 'navigation_menu',
            builder: (context, state) {
              return const NavigationMenuExample();
            },
          ),
        ]),
  ]);
  // ColorScheme colorScheme = ColorSchemes.darkZync();
  // double radius = 0.5;
  late ColorScheme colorScheme;
  late double radius;

  @override
  void initState() {
    super.initState();
    colorScheme = widget.initialColorScheme;
    radius = widget.initialRadius;
  }
  // This widget is the root of your application.

  void changeColorScheme(ColorScheme colorScheme) {
    setState(() {
      this.colorScheme = colorScheme;
      SharedPreferences.getInstance().then((prefs) {
        // prefs.setString('colorScheme', nameFromColorScheme(colorScheme));
        String? name = nameFromColorScheme(colorScheme);
        if (name != null) {
          prefs.setString('colorScheme', name);
        } else {
          String jsonized = jsonEncode(colorScheme.toMap());
          prefs.setString('colorScheme', jsonized);
        }
      });
    });
  }

  void changeRadius(double radius) {
    setState(() {
      this.radius = radius;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setDouble('radius', radius);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Data(
      data: this,
      child: ShadcnApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'shadcn/ui Flutter',
        theme: ThemeData(
          colorScheme: colorScheme,
          radius: radius,
        ),
      ),
    );
  }
}

final PageStorageBucket docsBucket = PageStorageBucket();

extension Keyed on Widget {
  KeyedSubtree keyed(Key key) {
    return KeyedSubtree(
      key: key,
      child: this,
    );
  }
}
