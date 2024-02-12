import 'package:example/pages/home.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ColorScheme colorScheme = ColorSchemes.darkZync();
  double radius = 0.5;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      theme: ThemeData(
        colorScheme: colorScheme,
        radius: radius,
        typography: Typography.geist(),
      ),
      child: Home(
        colorScheme: colorScheme,
        radius: radius,
        onColorSchemeChanged: (ColorScheme colorScheme) {
          setState(() {
            this.colorScheme = colorScheme;
          });
        },
        onRadiusChanged: (double radius) {
          setState(() {
            this.radius = radius;
          });
        },
      ),
    );
  }
}
