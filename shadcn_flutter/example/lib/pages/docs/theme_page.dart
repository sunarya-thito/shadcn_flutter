import 'package:example/main.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../docs_page.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

final Map<String, ColorScheme> colorSchemes = {
  'lightBlue': ColorSchemes.lightBlue(),
  'darkBlue': ColorSchemes.darkBlue(),
  'lightGray': ColorSchemes.lightGray(),
  'darkGray': ColorSchemes.darkGray(),
  'lightGreen': ColorSchemes.lightGreen(),
  'darkGreen': ColorSchemes.darkGreen(),
  'lightNeutral': ColorSchemes.lightNeutral(),
  'darkNeutral': ColorSchemes.darkNeutral(),
  'lightOrange': ColorSchemes.lightOrange(),
  'darkOrange': ColorSchemes.darkOrange(),
  'lightRed': ColorSchemes.lightRed(),
  'darkRed': ColorSchemes.darkRed(),
  'lightRose': ColorSchemes.lightRose(),
  'darkRose': ColorSchemes.darkRose(),
  'lightSlate': ColorSchemes.lightSlate(),
  'darkSlate': ColorSchemes.darkSlate(),
  'lightStone': ColorSchemes.lightStone(),
  'darkStone': ColorSchemes.darkStone(),
  'lightViolet': ColorSchemes.lightViolet(),
  'darkViolet': ColorSchemes.darkViolet(),
  'lightYellow': ColorSchemes.lightYellow(),
  'darkYellow': ColorSchemes.darkYellow(),
  'lightZync': ColorSchemes.lightZync(),
  'darkZync': ColorSchemes.darkZync(),
};

String? nameFromColorScheme(ColorScheme scheme) {
  return colorSchemes.keys
      .where((key) => colorSchemes[key] == scheme)
      .firstOrNull;
}

class _ThemePageState extends State<ThemePage> {
  late Map<String, Color> colors;
  late double radius;
  late ColorScheme colorScheme;
  bool customColorScheme = false;
  bool applyDirectly = true;

  final OnThisPage customColorSchemeKey = OnThisPage();
  final OnThisPage premadeColorSchemeKey = OnThisPage();
  final OnThisPage radiusKey = OnThisPage();
  // final OnThisPage previewKey = OnThisPage();
  final OnThisPage codeKey = OnThisPage();

  @override
  void initState() {
    super.initState();
    colors = ColorSchemes.darkZync().toColorMap();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyAppState state = Data.of(context);
    colorScheme = state.colorScheme;
    colors = colorScheme.toColorMap();
    radius = state.radius;
    customColorScheme = nameFromColorScheme(colorScheme) == null;
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
        // 'Preview': previewKey,
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
              // Checkbox(
              //     state: applyDirectly
              //         ? CheckboxState.checked
              //         : CheckboxState.unchecked,
              //     onChanged: (value) {
              //       setState(() {
              //         applyDirectly = value == CheckboxState.checked;
              //         if (applyDirectly) {
              //           state.changeRadius(radius);
              //           if (customColorScheme) {
              //             state.changeColorScheme(
              //                 ColorScheme.fromColors(colors: colors));
              //           } else {
              //             state.changeColorScheme(colorScheme);
              //           }
              //         }
              //       });
              //     },
              //     trailing: Text('Apply directly')),
            ],
          ).p(),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: colors.keys.map(buildGridTile).toList(),
          ).p(),
          const Text('Premade color schemes').h2().anchored(premadeColorSchemeKey),
          // Text('You can also use premade color schemes.').p(),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      'You can also use premade color schemes to customize the look and feel of your app.')),
              // apply directly
              // Checkbox(
              //     state: applyDirectly
              //         ? CheckboxState.checked
              //         : CheckboxState.unchecked,
              //     onChanged: (value) {
              //       setState(() {
              //         applyDirectly = value == CheckboxState.checked;
              //         if (applyDirectly) {
              //           state.changeRadius(radius);
              //           if (customColorScheme) {
              //             state.changeColorScheme(
              //                 ColorScheme.fromColors(colors: colors));
              //           } else {
              //             state.changeColorScheme(colorScheme);
              //           }
              //         }
              //       });
              //     },
              //     trailing: Text('Apply directly')),
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
              // Checkbox(
              //     state: applyDirectly
              //         ? CheckboxState.checked
              //         : CheckboxState.unchecked,
              //     onChanged: (value) {
              //       setState(() {
              //         applyDirectly = value == CheckboxState.checked;
              //         if (applyDirectly) {
              //           state.changeRadius(radius);
              //           // state.changeColorScheme(colorScheme);
              //           if (customColorScheme) {
              //             state.changeColorScheme(
              //                 ColorScheme.fromColors(colors: colors));
              //           } else {
              //             state.changeColorScheme(colorScheme);
              //           }
              //         }
              //       });
              //     },
              //     trailing: Text('Apply directly')),
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
          // Text('Preview').h2().anchored(previewKey),
          // Text('Preview the color scheme.').p(),
          // // TODO: add preview
          const Text('Code').h2().anchored(codeKey),
          const Text('Use the following code to apply the color scheme.').p(),
          CodeSnippet(
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
      String hex = colors[key]!.value.toRadixString(16);
      buffer += '\n\t\t\t$key: Color(0x$hex),';
    }
    buffer += '\n\t\t),';
    buffer += '\n\t\tradius: $radius,';
    buffer += '\n\t),';
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
    buffer += '\n\t\tcolorScheme: ColorSchemes.$name(),';
    buffer += '\n\t\tradius: $radius,';
    buffer += '\n\t),';
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
                gap(8),
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
                gap(8),
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
            showColorPicker(
              context: context,
              color: HSVColor.fromColor(colors[name]!),
              offset: const Offset(0, 8),
            ).then(
              (value) {
                if (value != null) {
                  setState(() {
                    colors[name] = value.toColor();
                    customColorScheme = true;
                    if (applyDirectly) {
                      MyAppState state = Data.of(context);
                      state.changeColorScheme(ColorScheme.fromColors(
                          colors: colors, brightness: colorScheme.brightness));
                    }
                  });
                }
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
                        colors[name]!.value.toRadixString(16),
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
