import 'package:example/pages/docs/introduction_page.dart';
import 'package:example/pages/docs_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DocsPage(
        name: 'introduction',
        child: IntroductionPage(),
      ),
      name: 'introduction',
    ),
  ]);
  ColorScheme colorScheme = ColorSchemes.darkZync();
  double radius = 0.5;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      routerConfig: router,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: colorScheme,
        radius: radius,
      ),
    );
  }
}
