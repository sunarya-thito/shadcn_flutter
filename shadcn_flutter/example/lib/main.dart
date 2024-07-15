import 'dart:convert';

import 'package:example/pages/docs/components/accordion_example.dart';
import 'package:example/pages/docs/components/alert_dialog_example.dart';
import 'package:example/pages/docs/components/alert_example.dart';
import 'package:example/pages/docs/components/animated_value_builder_example.dart';
import 'package:example/pages/docs/components/avatar_example.dart';
import 'package:example/pages/docs/components/calendar_example.dart';
import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:example/pages/docs/components/combobox_example.dart';
import 'package:example/pages/docs/components/date_picker_example.dart';
import 'package:example/pages/docs/components/dialog_example.dart';
import 'package:example/pages/docs/components/divider_example.dart';
import 'package:example/pages/docs/components/drawer_example.dart';
import 'package:example/pages/docs/components/input_example.dart';
import 'package:example/pages/docs/components/input_otp_example.dart';
import 'package:example/pages/docs/components/pagination_example.dart';
import 'package:example/pages/docs/components/popover_example.dart';
import 'package:example/pages/docs/components/progress_example.dart';
import 'package:example/pages/docs/components/radio_group_example.dart';
import 'package:example/pages/docs/components/repeated_animation_builder_example.dart';
import 'package:example/pages/docs/components/resizable_example.dart';
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
import 'package:example/pages/resizable_test.dart';
import 'package:flutter/foundation.dart';
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
      builder: (context, state) => IntroductionPage(),
      // builder: (context, state) => TestWidget(),
      name: 'introduction',
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => ResizableTest(),
      name: 'test',
    ),
    GoRoute(
      path: '/installation',
      builder: (context, state) => InstallationPage(),
      name: 'installation',
    ),
    GoRoute(
      path: '/theme',
      builder: (context, state) => ThemePage(),
      name: 'theme',
    ),
    GoRoute(
      path: '/typography',
      builder: (context, state) => TypographyPage(),
      name: 'typography',
    ),
    GoRoute(
      path: '/layout',
      builder: (context, state) => LayoutPage(),
      name: 'layout',
    ),
    GoRoute(
      path: '/web_preloader',
      name: 'web_preloader',
      builder: (context, state) => WebPreloaderPage(),
    ),
    GoRoute(
        path: '/components',
        name: 'components',
        builder: (context, state) {
          return ComponentsPage();
        },
        routes: [
          GoRoute(
            path: 'accordion',
            builder: (context, state) => AccordionExample(),
            name: 'accordion',
          ),
          GoRoute(
            path: 'alert',
            builder: (context, state) => AlertExample(),
            name: 'alert',
          ),
          GoRoute(
            path: 'alert-dialog',
            builder: (context, state) => AlertDialogExample(),
            name: 'alert_dialog',
          ),
          GoRoute(
            path: 'avatar',
            builder: (context, state) => AvatarExample(),
            name: 'avatar',
          ),
          GoRoute(
            path: 'badge',
            builder: (context, state) => BadgeExample(),
            name: 'badge',
          ),
          GoRoute(
            path: 'breadcrumb',
            builder: (context, state) => BreadcrumbExample(),
            name: 'breadcrumb',
          ),
          GoRoute(
            path: 'button',
            builder: (context, state) => ButtonExample(),
            name: 'button',
          ),
          GoRoute(
            path: 'card',
            builder: (context, state) => CardExample(),
            name: 'card',
          ),
          GoRoute(
            path: 'checkbox',
            builder: (context, state) => CheckboxExample(),
            name: 'checkbox',
          ),
          GoRoute(
            path: 'code-snippet',
            builder: (context, state) => CodeSnippetExample(),
            name: 'code_snippet',
          ),
          GoRoute(
            path: 'circular-progress',
            builder: (context, state) => CircularProgressExample(),
            name: 'circular_progress',
          ),
          GoRoute(
            path: 'color-picker',
            builder: (context, state) => ColorPickerExample(),
            name: 'color_picker',
          ),
          GoRoute(
            path: 'combo-box',
            builder: (context, state) => ComboboxExample(),
            name: 'combo_box',
          ),
          GoRoute(
            path: 'divider',
            builder: (context, state) => DividerExample(),
            name: 'divider',
          ),
          GoRoute(
            path: 'collapsible',
            builder: (context, state) => CollapsibleExample(),
            name: 'collapsible',
          ),
          GoRoute(
            path: 'command',
            builder: (context, state) => CommandExample(),
            name: 'command',
          ),
          GoRoute(
            path: 'form',
            builder: (context, state) => FormExample(),
            name: 'form',
          ),
          GoRoute(
            path: 'carousel',
            builder: (context, state) => CarouselExample(),
            name: 'carousel',
          ),
          GoRoute(
            path: 'calendar',
            builder: (context, state) => CalendarExample(),
            name: 'calendar',
          ),
          GoRoute(
            path: 'date_picker',
            builder: (context, state) => DatePickerExample(),
            name: 'date_picker',
          ),
          GoRoute(
            path: 'dialog',
            builder: (context, state) => DialogExample(),
            name: 'dialog',
          ),
          GoRoute(
            path: 'pagination',
            builder: (context, state) => PaginationExample(),
            name: 'pagination',
          ),
          GoRoute(
            path: 'input',
            builder: (context, state) => InputExample(),
            name: 'input',
          ),
          GoRoute(
            path: 'radio_group',
            builder: (context, state) => RadioGroupExample(),
            name: 'radio_group',
          ),
          GoRoute(
            path: 'switch',
            builder: (context, state) => SwitchExample(),
            name: 'switch',
          ),
          GoRoute(
            path: 'slider',
            builder: (context, state) => SliderExample(),
            name: 'slider',
          ),
          GoRoute(
            path: 'steps',
            builder: (context, state) => StepsExample(),
            name: 'steps',
          ),
          GoRoute(
            path: 'tab_list',
            builder: (context, state) => TabListExample(),
            name: 'tab_list',
          ),
          GoRoute(
            path: 'tooltip',
            name: 'tooltip',
            builder: (context, state) => TooltipExample(),
          ),
          GoRoute(
            path: 'popover',
            name: 'popover',
            builder: (context, state) => PopoverExample(),
          ),
          GoRoute(
            path: 'progress',
            name: 'progress',
            builder: (context, state) => ProgressExample(),
          ),
          GoRoute(
            path: 'tabs',
            name: 'tabs',
            builder: (context, state) => TabsExample(),
          ),
          GoRoute(
            path: 'input_otp',
            builder: (context, state) => InputOTPExample(),
            name: 'input_otp',
          ),
          GoRoute(
            path: 'text_area',
            builder: (context, state) => TextAreaExample(),
            name: 'text_area',
          ),
          GoRoute(
            path: 'animated_value_builder',
            name: 'animated_value_builder',
            builder: (context, state) {
              return AnimatedValueBuilderExample();
            },
          ),
          GoRoute(
              path: 'repeated_animation_builder',
              name: 'repeated_animation_builder',
              builder: (context, state) {
                return RepeatedAnimationBuilderExample();
              }),
          GoRoute(
            path: 'skeleton',
            name: 'skeleton',
            builder: (context, state) {
              return SkeletonExample();
            },
          ),
          GoRoute(
            path: 'toggle',
            name: 'toggle',
            builder: (context, state) {
              return ToggleExample();
            },
          ),
          GoRoute(
            path: 'drawer',
            name: 'drawer',
            builder: (context, state) {
              return DrawerExample();
            },
          ),
          GoRoute(
            path: 'sheet',
            name: 'sheet',
            builder: (context, state) {
              return SheetExample();
            },
          ),
          GoRoute(
              path: 'icons',
              name: 'icons',
              builder: (context, state) {
                return IconsPage();
              }),
          GoRoute(
              path: 'resizable',
              name: 'resizable',
              builder: (context, state) {
                return ResizableExample();
              }),
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
          brightness: Brightness.dark,
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
