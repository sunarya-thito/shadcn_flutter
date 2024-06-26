import 'dart:convert';

import 'package:example/pages/docs/components/accordion_example.dart';
import 'package:example/pages/docs/components/alert_dialog_example.dart';
import 'package:example/pages/docs/components/alert_example.dart';
import 'package:example/pages/docs/components/avatar_example.dart';
import 'package:example/pages/docs/components/combobox_example.dart';
import 'package:example/pages/docs/components/divider_example.dart';
import 'package:example/pages/docs/installation_page.dart';
import 'package:example/pages/docs/introduction_page.dart';
import 'package:example/pages/docs/layout_page.dart';
import 'package:example/pages/docs/theme_page.dart';
import 'package:example/pages/docs/typography_page.dart';
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

void main() async {
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
      name: 'introduction',
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
        path: '/components',
        name: 'components',
        redirect: (context, state) {
          if (state.fullPath == '/components') {
            return '/components/accordion';
          }
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

extension Keyed on Widget {
  KeyedSubtree keyed(Key key) {
    return KeyedSubtree(
      key: key,
      child: this,
    );
  }
}
