import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample13 extends StatelessWidget {
  const ButtonExample13({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          child: Icon(Icons.add),
          onPressed: () {},
          shape: ButtonShape.circle,
        ),
        PrimaryButton(
          child: Text('Rectangle'),
          onPressed: () {},
          shape: ButtonShape.rectangle,
        ),
      ],
    );
  }
}
