import 'dart:convert';

import 'package:example/pages/docs/installation_page.dart';
import 'package:example/pages/docs/introduction_page.dart';
import 'package:example/pages/docs/theme_page.dart';
import 'package:example/pages/docs/typography_page.dart';
import 'package:example/pages/docs_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      builder: (context, state) => const DocsPage(
        name: 'introduction',
        child: IntroductionPage(),
      ),
      name: 'introduction',
    ),
    GoRoute(
      path: '/installation',
      builder: (context, state) => const DocsPage(
        name: 'installation',
        child: InstallationPage(),
      ),
      name: 'installation',
    ),
    GoRoute(
      path: '/theme',
      builder: (context, state) => const DocsPage(
        name: 'theme',
        child: ThemePage(),
      ),
      name: 'theme',
    ),
    GoRoute(
      path: '/typography',
      builder: (context, state) => const DocsPage(
        name: 'typography',
        child: TypographyPage(),
      ),
      name: 'typography',
    )
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
