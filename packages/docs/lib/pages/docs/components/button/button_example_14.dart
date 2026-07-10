import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample14 extends StatelessWidget {
  const ButtonExample14({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonGroup(
      children: [
        ButtonGroupItem(
          // ButtonGroupItem is optional, but allows for paint reordering on focused item
          child: PrimaryButton(
            child: const Text('Primary'),
            onPressed: () {},
          ),
        ),
        ButtonGroupItem(
          child: SecondaryButton(
            child: const Text('Secondary'),
            onPressed: () {},
          ),
        ),
        ButtonGroupItem(
          child: DestructiveButton(
            child: const Text('Destructive'),
            onPressed: () {},
          ),
        ),
        ButtonGroupItem(
          child: OutlineButton(
            child: const Text('Outlined'),
            onPressed: () {},
          ),
        ),
        ButtonGroupItem(
          child: GhostButton(
            child: const Text('Ghost'),
            onPressed: () {},
          ),
        ),
        ButtonGroupItem(
          child: IconButton.primary(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
