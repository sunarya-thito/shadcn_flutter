import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample2 extends StatelessWidget {
  const ColorPickerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () async {
        final history = ColorHistoryStorage.of(context);
        final result = await pickColorFromScreen(context, history);
        if (result != null && context.mounted) {
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
