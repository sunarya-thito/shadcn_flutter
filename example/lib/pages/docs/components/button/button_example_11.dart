import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample11 extends StatelessWidget {
  const ButtonExample11({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          child: Text('Compact'),
          onPressed: () {},
          density: ButtonDensity.compact,
        ),
        PrimaryButton(
          child: Text('Dense'),
          onPressed: () {},
          density: ButtonDensity.dense,
        ),
        PrimaryButton(
          child: Text('Normal'),
          onPressed: () {},
          density: ButtonDensity.normal,
        ),
        PrimaryButton(
          child: Text('Comfortable'),
          onPressed: () {},
          density: ButtonDensity.comfortable,
        ),
        PrimaryButton(
          child: Text('Icon'),
          onPressed: () {},
          density: ButtonDensity.icon,
        ),
        PrimaryButton(
          child: Text('Icon Comfortable'),
          onPressed: () {},
          density: ButtonDensity.iconComfortable,
        ),
      ],
    );
  }
}
