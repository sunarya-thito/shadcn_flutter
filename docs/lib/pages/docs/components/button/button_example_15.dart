import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample15 extends StatelessWidget {
  const ButtonExample15({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      leading: const StatedWidget(
        states: {
          {WidgetState.hovered, WidgetState.focused}:
              Icon(Icons.add_a_photo_rounded),
          WidgetState.hovered: Icon(Icons.add_a_photo),
        },
        child: Icon(Icons.add_a_photo_outlined),
      ),
      onPressed: () {},
      child: const StatedWidget(
        states: {
          'focused': Text('Focused'),
          WidgetState.hovered: Text('Hovered'),
        },
        child: Text('Normal'),
      ),
    );
  }
}
