# ColorPickerTheme

Theme configuration for [ColorPicker] widget styling and layout.

## Usage

### Color Picker Example
```dart
import 'package:docs/pages/docs/components/color_picker/color_picker_example_2.dart';
import 'package:docs/pages/docs/components/color_picker/color_picker_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'color_picker/color_picker_example_1.dart';

class ColorPickerExample extends StatelessWidget {
  const ColorPickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'color_picker',
      description:
          'A color picker is a widget that allows the user to pick a color.',
      displayName: 'Color Picker',
      children: [
        WidgetUsageExample(
          title: 'Color Input Example',
          path:
              'lib/pages/docs/components/color_picker/color_picker_example_1.dart',
          child: ColorPickerExample1(),
        ),
        WidgetUsageExample(
          path:
              'lib/pages/docs/components/color_picker/color_picker_example_2.dart',
          title: 'Screen Color Picker Example',
          child: ColorPickerExample2(),
        ),
        WidgetUsageExample(
          path:
              'lib/pages/docs/components/color_picker/color_picker_example_3.dart',
          title: 'Color Picker Trigger Example',
          child: ColorPickerExample3(),
        ),
      ],
    );
  }
}

```

### Color Picker Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample1 extends StatefulWidget {
  const ColorPickerExample1({super.key});

  @override
  State<ColorPickerExample1> createState() => _ColorPickerExample1State();
}

class _ColorPickerExample1State extends State<ColorPickerExample1> {
  ColorDerivative color = ColorDerivative.fromColor(Colors.blue);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: ColorInput(
              // A compact square color input that opens a popover prompt.
              value: color,
              orientation: Axis.horizontal,
              promptMode: PromptMode.popover,
              onChanged: (value) {
                setState(() {
                  color = value;
                });
              },
            ),
          ),
          const Gap(16),
          ColorInput(
            value: color,
            // Full dialog mode with a title.
            promptMode: PromptMode.dialog,
            dialogTitle: const Text('Select Color'),
            onChanged: (value) {
              setState(() {
                color = value;
              });
            },
            // Show the textual label/hex alongside the swatch.
            showLabel: true,
          ),
        ],
      ),
    );
  }
}

```

### Color Picker Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample2 extends StatelessWidget {
  const ColorPickerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () async {
        // Screen color picker: lets the user sample any on-screen color.
        final history = ColorHistoryStorage.of(context);
        final result = await pickColorFromScreen(context, history);
        if (result != null && context.mounted) {
          // Show a toast with the hex value and a preview swatch.
          showToast(
            context: context,
            builder: (context, overlay) {
              return SurfaceCard(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Color: ${colorToHex(result)}'),
                  const Gap(16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: result,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ));
            },
          );
        }
      },
      child: const Text('Pick Color'),
    );
  }
}

```

### Color Picker Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample3 extends StatefulWidget {
  const ColorPickerExample3({super.key});

  @override
  State<ColorPickerExample3> createState() => _ColorPickerExample3State();
}

class _ColorPickerExample3State extends State<ColorPickerExample3> {
  final ValueNotifier<ColorDerivative> selectedColorNotifier = ValueNotifier(
    ColorDerivative.fromColor(Colors.blue),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Builder(builder: (context) {
          return PrimaryButton(
            onPressed: () {
              // Show the color picker as a popover anchored to the button.
              showPopover(
                context: context,
                alignment: Alignment.topCenter,
                anchorAlignment: Alignment.bottomCenter,
                widthConstraint: PopoverConstraint.intrinsic,
                heightConstraint: PopoverConstraint.intrinsic,
                offset: const Offset(0, 8),
                builder: (context) {
                  return ListenableBuilder(
                      listenable: selectedColorNotifier,
                      builder: (context, _) {
                        return SurfaceCard(
                          child: ColorPicker(
                            value: selectedColorNotifier.value,
                            orientation: Axis.horizontal,
                            showAlpha: true,
                            onChanged: (value) {
                              setState(() {
                                selectedColorNotifier.value = value;
                              });
                            },
                          ),
                        );
                      });
                },
              );
            },
            child: const Text('Open Color Picker Popover'),
          );
        }),
        const Gap(16),
        PrimaryButton(
          onPressed: () {
            // Show the color picker as a dialog with a title.
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Select Color'),
                  content: ListenableBuilder(
                      listenable: selectedColorNotifier,
                      builder: (context, _) {
                        return ColorPicker(
                          value: selectedColorNotifier.value,
                          orientation: Axis.horizontal,
                          showAlpha: true,
                          onChanged: (value) {
                            setState(() {
                              selectedColorNotifier.value = value;
                            });
                          },
                        );
                      }),
                  actions: [
                    PrimaryButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Open Color Picker Dialog'),
        ),
      ],
    );
  }
}

```

### Color Picker Tile
```dart
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ColorPickerTile extends StatelessWidget implements IComponentPage {
  const ColorPickerTile({super.key});

  @override
  String get title => 'Color Picker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'color_picker',
      title: 'Color Picker',
      reverse: true,
      reverseVertical: true,
      example: Card(
        child: ColorPicker(
          value: ColorDerivative.fromColor(material.Colors.blue),
        ),
      ),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `spacing` | `double?` | Spacing between major color picker sections. |
| `controlSpacing` | `double?` | Spacing between individual controls within sections. |
| `orientation` | `Axis?` | Layout orientation (horizontal or vertical). |
| `enableEyeDropper` | `bool?` | Whether to enable the eye dropper feature. |
| `sliderSize` | `double?` | The size of color sliders. |
