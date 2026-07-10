import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample3 extends StatelessWidget {
  const InputExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          placeholder: const Text('Enter your name'),
          features: [
            const InputFeature.clear(),
            // Hint shows a small tooltip-like popup for the input field.
            InputFeature.hint(
              popupBuilder: (context) {
                return const TooltipContainer(
                    child: Text('This is for your username'));
              },
            ),
            // Convenience actions for copying/pasting directly from the text field UI.
            const InputFeature.copy(),
            const InputFeature.paste(),
          ],
        ),
        const Gap(24),
        const TextField(
          placeholder: Text('Enter your password'),
          features: [
            InputFeature.clear(
              visibility: InputFeatureVisibility.textNotEmpty,
            ),
            // Password toggle configured with `hold` mode: press-and-hold to peek,
            // release to hide again.
            InputFeature.passwordToggle(mode: PasswordPeekMode.hold),
          ],
        ),
      ],
    );
  }
}
