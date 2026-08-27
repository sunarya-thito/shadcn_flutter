import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample15 extends StatelessWidget {
  const ButtonExample15({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      leading: const StatedWidget.map(
        states: {
          'disabled': Icon(LucideIcons.x),
          {WidgetState.hovered, WidgetState.focused}:
              Icon(LucideIcons.camera),
          WidgetState.hovered: Icon(LucideIcons.camera),
        },
        child: Icon(LucideIcons.camera),
      ),
      onPressed: () {},
      child: const StatedWidget(
        focused: Text('Focused'),
        hovered: Text('Hovered'),
        pressed: Text('Pressed'),
        child: Text('Normal'),
      ),
    );
  }
}
