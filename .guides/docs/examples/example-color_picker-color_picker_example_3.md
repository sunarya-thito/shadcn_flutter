---
title: "Example: components/color_picker/color_picker_example_3.dart"
description: "Component example"
---

Source preview
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
```
