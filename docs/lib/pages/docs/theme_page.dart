import 'package:docs/code_highlighter.dart';
import 'package:docs/main.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../docs_page.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

// final Map<String, ColorScheme> legacyColorSchemes = {
//   'lightBlue': LegacyColorSchemes.lightBlue(),
//   'darkBlue': LegacyColorSchemes.darkBlue(),
//   'lightGray': LegacyColorSchemes.lightGray(),
//   'darkGray': LegacyColorSchemes.darkGray(),
//   'lightGreen': LegacyColorSchemes.lightGreen(),
//   'darkGreen': LegacyColorSchemes.darkGreen(),
//   'lightNeutral': LegacyColorSchemes.lightNeutral(),
//   'darkNeutral': LegacyColorSchemes.darkNeutral(),
//   'lightOrange': LegacyColorSchemes.lightOrange(),
//   'darkOrange': LegacyColorSchemes.darkOrange(),
//   'lightRed': LegacyColorSchemes.lightRed(),
//   'darkRed': LegacyColorSchemes.darkRed(),
//   'lightRose': LegacyColorSchemes.lightRose(),
//   'darkRose': LegacyColorSchemes.darkRose(),
//   'lightSlate': LegacyColorSchemes.lightSlate(),
//   'darkSlate': LegacyColorSchemes.darkSlate(),
//   'lightStone': LegacyColorSchemes.lightStone(),
//   'darkStone': LegacyColorSchemes.darkStone(),
//   'lightViolet': LegacyColorSchemes.lightViolet(),
//   'darkViolet': LegacyColorSchemes.darkViolet(),
//   'lightYellow': LegacyColorSchemes.lightYellow(),
//   'darkYellow': LegacyColorSchemes.darkYellow(),
//   'lightZinc': LegacyColorSchemes.lightZinc(),
//   'darkZinc': LegacyColorSchemes.darkZinc(),
// };

final Map<String, ColorScheme> colorSchemes = {
  'lightDefaultColor': ColorSchemes.lightDefaultColor,
  'darkDefaultColor': ColorSchemes.darkDefaultColor,
  'lightBlue': ColorSchemes.lightBlue,
  'darkBlue': ColorSchemes.darkBlue,
  'lightGreen': ColorSchemes.lightGreen,
  'darkGreen': ColorSchemes.darkGreen,
  'lightOrange': ColorSchemes.lightOrange,
  'darkOrange': ColorSchemes.darkOrange,
  'lightRed': ColorSchemes.lightRed,
  'darkRed': ColorSchemes.darkRed,
  'lightRose': ColorSchemes.lightRose,
  'darkRose': ColorSchemes.darkRose,
  'lightViolet': ColorSchemes.lightViolet,
  'darkViolet': ColorSchemes.darkViolet,
  'lightYellow': ColorSchemes.lightYellow,
  'darkYellow': ColorSchemes.darkYellow,
};

String? nameFromColorScheme(ColorScheme scheme) {
  return colorSchemes.keys
      .where((key) => colorSchemes[key] == scheme)
      .firstOrNull;
}

class _ThemePageState extends State<ThemePage> {
  late Map<String, Color> colors;
  late double radius;
  late double scaling;
  late double surfaceOpacity;
  late double surfaceBlur;
  late ColorScheme colorScheme;
  bool customColorScheme = false;
  bool applyDirectly = true;

  final OnThisPage customColorSchemeKey = OnThisPage();
  final OnThisPage premadeColorSchemeKey = OnThisPage();
  final OnThisPage radiusKey = OnThisPage();
  final OnThisPage scalingKey = OnThisPage();
  final OnThisPage surfaceOpacityKey = OnThisPage();
  final OnThisPage surfaceBlurKey = OnThisPage();
  final OnThisPage codeKey = OnThisPage();

  @override
  void initState() {
    super.initState();
    colors = LegacyColorSchemes.darkZinc().toColorMap();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyAppState state = Data.of(context);
    colorScheme = state.colorScheme;
    colors = colorScheme.toColorMap();
    radius = state.radius;
    customColorScheme = nameFromColorScheme(colorScheme) == null;
    scaling = state.scaling;
    surfaceOpacity = state.surfaceOpacity;
    surfaceBlur = state.surfaceBlur;
  }

  @override
  Widget build(BuildContext context) {
    MyAppState state = Data.of(context);
    return DocsPage(
      name: 'theme',
      onThisPage: {
        'Custom color scheme': customColorSchemeKey,
        'Premade color scheme': premadeColorSchemeKey,
        'Radius': radiusKey,
        'Scaling': scalingKey,
        'Surface opacity': surfaceOpacityKey,
        'Surface blur': surfaceBlurKey,
        'Code': codeKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Theme').h1(),
          const Text('Customize the look and feel of your app.').lead(),
          const Text('Custom color scheme').h2().anchored(customColorSchemeKey),
          // grid color
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      'You can use your own color scheme to customize the look and feel of your app.')),
            ],
          ).p(),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: colors.keys.map(buildGridTile).toList(),
          ).p(),
          const Text('Premade color schemes')
              .h2()
              .anchored(premadeColorSchemeKey),
          // Text('You can also use premade color schemes.').p(),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      'You can also use premade color schemes to customize the look and feel of your app.')),
            ],
          ).p(),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children:
                colorSchemes.keys.map(buildPremadeColorSchemeButton).toList(),
          ).p(),
          const Text('Radius').h2().anchored(radiusKey),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      'You can customize how rounded your app looks by changing the radius.')),
            ],
          ).p(),
          Slider(
            value: SliderValue.single(radius),
            onChanged: (value) {
              setState(() {
                radius = value.value;
                if (applyDirectly) {
                  state.changeRadius(radius);
                }
              });
            },
            min: 0,
            max: 2,
            divisions: 20,
          ).p(),
          const Text('Scaling').h2().anchored(scalingKey),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      'You can customize the scale of shadcn_flutter components by changing the scaling.')),
            ],
          ).p(),
          Slider(
            value: SliderValue.single(scaling),
            onChanged: (value) {
              setState(() {
                scaling = value.value;
                if (applyDirectly) {
                  state.changeScaling(scaling);
                }
              });
            },
            min: 0.5,
            max: 1.5,
            divisions: 20,
          ).p(),
          const Gap(16),
          const Alert(
            leading: Icon(RadixIcons.infoCircled),
            content: Text(
                'This does not scale the entire app. Only shadcn_flutter components are affected.'),
          ),
          const Text('Surface opacity').h2().anchored(surfaceOpacityKey),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      'You can customize the opacity of the surface by changing the surface opacity.')),
            ],
          ).p(),
          Slider(
            value: SliderValue.single(surfaceOpacity),
            onChanged: (value) {
              setState(() {
                surfaceOpacity = value.value;
                if (applyDirectly) {
                  state.changeSurfaceOpacity(surfaceOpacity);
                }
              });
            },
            min: 0,
            max: 1,
            divisions: 20,
          ).p(),
          const Text('Surface blur').h2().anchored(surfaceBlurKey),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      'You can customize the blur of the surface by changing the surface blur.')),
            ],
          ).p(),
          Slider(
            value: SliderValue.single(surfaceBlur),
            onChanged: (value) {
              setState(() {
                surfaceBlur = value.value;
                if (applyDirectly) {
                  state.changeSurfaceBlur(surfaceBlur);
                }
              });
            },
            min: 0,
            max: 20,
            divisions: 20,
          ).p(),

          const Text('Code').h2().anchored(codeKey),
          const Text('Use the following code to apply the color scheme.').p(),
          CodeBlock(
            code: customColorScheme ? buildCustomCode() : buildPremadeCode(),
            mode: 'dart',
          ).p(),
        ],
      ),
    );
  }

  String buildCustomCode() {
    bool isDark = colorScheme.background.computeLuminance() < 0.5;
    String buffer = 'ShadcnApp(';
    buffer += '\n...';
    buffer += '\n\ttheme: ThemeData(';
    buffer += '\n\t\tcolorScheme: ColorScheme(';
    buffer +=
        '\n\t\t\tbrightness: ${isDark ? 'Brightness.dark' : 'Brightness.light'},';
    for (var key in colors.keys) {
      String hex = colorToHex(colors[key]!, true, false);
      buffer += '\n\t\t\t$key: Color(0x$hex),';
    }
    buffer += '\n\t\t),';
    buffer += '\n\t\tradius: $radius,';
    if (surfaceOpacity != 1) {
      buffer += '\n\t\tsurfaceOpacity: $surfaceOpacity,';
    }
    if (surfaceBlur != 0) {
      buffer += '\n\t\tsurfaceBlur: $surfaceBlur,';
    }
    buffer += '\n\t),';
    if (scaling != 1) {
      buffer += '\n\tscaling: const AdaptiveScaling($scaling),';
    }
    buffer += '\n...';
    buffer += '\n)';
    return buffer;
  }

  String buildPremadeCode() {
    // return 'ColorSchemes.${nameFromColorScheme(colorScheme)}()';
    String name = nameFromColorScheme(colorScheme)!;
    String buffer = 'ShadcnApp(';
    buffer += '\n...';
    buffer += '\n\ttheme: ThemeData(';
    buffer += '\n\t\tcolorScheme: ColorSchemes.$name,';
    buffer += '\n\t\tradius: $radius,';
    if (surfaceOpacity != 1) {
      buffer += '\n\t\tsurfaceOpacity: $surfaceOpacity,';
    }
    if (surfaceBlur != 0) {
      buffer += '\n\t\tsurfaceBlur: $surfaceBlur,';
    }
    buffer += '\n\t),';
    if (scaling != 1) {
      buffer += '\n\tscaling: const AdaptiveScaling($scaling),';
    }
    buffer += '\n...';
    buffer += '\n)';
    return buffer;
  }

  Color getInvertedColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  Widget buildPremadeColorSchemeButton(String name) {
    var scheme = colorSchemes[name]!;
    return !customColorScheme && scheme == colorScheme
        ? PrimaryButton(
            onPressed: () {
              setState(() {
                colorScheme = scheme;
                colors = colorScheme.toColorMap();
                customColorScheme = false;
                if (applyDirectly) {
                  MyAppState state = Data.of(context);
                  state.changeColorScheme(colorScheme);
                }
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: scheme.primaryForeground,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                ),
                const Gap(8),
                Text(name),
              ],
            ),
          )
        : OutlineButton(
            onPressed: () {
              setState(() {
                colorScheme = scheme;
                colors = colorScheme.toColorMap();
                customColorScheme = false;
                if (applyDirectly) {
                  MyAppState state = Data.of(context);
                  state.changeColorScheme(colorScheme);
                }
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: scheme.primaryForeground,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                ),
                const Gap(8),
                Text(name),
              ],
            ),
          );
  }

  Widget buildGridTile(String name) {
    final colors = this.colors;
    return Container(
      constraints: const BoxConstraints(
        minWidth: 100,
        minHeight: 100,
      ),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            showPopover(
              context: context,
              alignment: Alignment.topLeft,
              anchorAlignment: Alignment.bottomLeft,
              offset: const Offset(0, 8),
              widthConstraint: PopoverConstraint.intrinsic,
              heightConstraint: PopoverConstraint.intrinsic,
              builder: (context) {
                return SurfaceCard(
                  child: ColorPicker(
                    value: ColorDerivative.fromColor(colors[name]!),
                    onChanging: (value) {
                      setState(() {
                        colors[name] = value.toColor();
                        customColorScheme = true;
                        if (applyDirectly) {
                          MyAppState state = Data.of(context);
                          state.changeColorScheme(ColorScheme.fromColors(
                              colors: colors,
                              brightness: colorScheme.brightness));
                        }
                      });
                    },
                  ),
                );
              },
            );
          },
          child: FocusableActionDetector(
            mouseCursor: SystemMouseCursors.click,
            child: FittedBox(
              child: AnimatedContainer(
                duration: kDefaultDuration,
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors[name],
                ),
                child: Stack(
                  children: [
                    Text(name,
                        style:
                            TextStyle(color: getInvertedColor(colors[name]!))),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Text(
                        colorToHex(colors[name]!),
                        style: TextStyle(
                          color: getInvertedColor(colors[name]!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
