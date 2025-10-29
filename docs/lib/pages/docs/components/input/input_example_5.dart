import 'package:shadcn_flutter/shadcn_flutter.dart';

/// This example demonstrates grouping multiple input fields together
/// using the `ButtonGroup` component.

class InputExample5 extends StatelessWidget {
  const InputExample5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        ButtonGroup(children: [
          // Its important to set width constraints on the TextFields
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Red')),
          ),
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Green')),
          ),
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Blue')),
          ),
          SizedBox(
            width: 75,
            child: TextField(placeholder: Text('Alpha')),
          ),
        ]),
        ButtonGroup.vertical(
          children: [
            // Its important to set width constraints on the TextFields
            SizedBox(
              width: 200,
              child: TextField(placeholder: Text('First Name')),
            ),
            ButtonGroup.horizontal(
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(placeholder: Text('Middle Name')),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(placeholder: Text('Last Name')),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
