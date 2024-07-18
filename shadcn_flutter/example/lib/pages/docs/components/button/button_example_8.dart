import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample8 extends StatelessWidget {
  const ButtonExample8({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Icon(Icons.add),
        ),
        SecondaryButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Icon(Icons.add),
        ),
        OutlineButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Icon(Icons.add),
        ),
        GhostButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Icon(Icons.add),
        ),
        TextButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Icon(Icons.add),
        ),
        DestructiveButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
