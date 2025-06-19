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
              color: color,
              mode: PromptMode.popover,
              onChanged: (value) {
                setState(() {
                  color = value;
                });
              },
              storage: ColorHistoryStorage.of(context),
            ),
          ),
          const Gap(16),
          ColorInput(
            color: color,
            mode: PromptMode.dialog,
            dialogTitle: const Text('Select Color'),
            onChanged: (value) {
              setState(() {
                color = value;
              });
            },
            showLabel: true,
            storage: ColorHistoryStorage.of(context),
          ),
        ],
      ),
    );
  }
}
