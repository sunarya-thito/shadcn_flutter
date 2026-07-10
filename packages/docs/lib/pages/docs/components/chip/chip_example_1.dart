import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Chips with trailing remove buttons in different styles.
///
/// Demonstrates how to compose [Chip] with a [ChipButton] trailing action,
/// and how to apply various [ButtonStyle] presets.
class ChipExample1 extends StatelessWidget {
  const ChipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(
          // Trailing action; in real apps you might remove the chip.
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Apple'),
        ),
        Chip(
          // Primary-styled chip.
          style: const ButtonStyle.primary(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Banana'),
        ),
        Chip(
          // Outlined chip.
          style: const ButtonStyle.outline(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Cherry'),
        ),
        Chip(
          // Ghost chip (very subtle background).
          style: const ButtonStyle.ghost(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Durian'),
        ),
        Chip(
          // Destructive-styled chip for warning/critical labels.
          style: const ButtonStyle.destructive(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Elderberry'),
        ),
      ],
    );
  }
}
