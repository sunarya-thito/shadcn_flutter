import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample3 extends StatelessWidget {
  const InputExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          placeholder: Text('Enter your name'),
          features: [
            const InputFeature.clear(),
            InputFeature.hint(
              popupBuilder: (context) {
                return const TooltipContainer(
                    child: Text('This is for your username'));
              },
            ),
            InputFeature.copy(),
            InputFeature.paste(),
          ],
        ),
        const Gap(24),
        const TextField(
          placeholder: Text('Enter your password'),
          features: [
            InputFeature.clear(),
            InputFeature.passwordToggle(mode: PasswordPeekMode.hold),
          ],
        ),
      ],
    );
  }
}
