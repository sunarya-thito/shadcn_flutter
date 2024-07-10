import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample10 extends StatelessWidget {
  const ButtonExample10({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          child: Text('Extra Small'),
          size: ButtonSize.xSmall,
          onPressed: () {},
        ),
        PrimaryButton(
          child: Text('Small'),
          onPressed: () {},
          size: ButtonSize.small,
        ),
        PrimaryButton(
          child: Text('Normal'),
          size: ButtonSize.normal,
          onPressed: () {},
        ),
        PrimaryButton(
          child: Text('Large'),
          size: ButtonSize.large,
          onPressed: () {},
        ),
        PrimaryButton(
          child: Text('Extra Large'),
          size: ButtonSize.xLarge,
          onPressed: () {},
        ),
      ],
    );
  }
}
