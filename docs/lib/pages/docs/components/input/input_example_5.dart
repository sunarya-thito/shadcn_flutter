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
          ButtonGroupItem(
            child: SizedBox(
              width: 75,
              child: TextField(placeholder: Text('Red')),
            ),
          ),
          ButtonGroupItem(
            child: SizedBox(
              width: 75,
              child: TextField(placeholder: Text('Green')),
            ),
          ),
          ButtonGroupItem(
            child: SizedBox(
              width: 75,
              child: TextField(placeholder: Text('Blue')),
            ),
          ),
          ButtonGroupItem(
            child: SizedBox(
              width: 75,
              child: TextField(placeholder: Text('Alpha')),
            ),
          ),
        ]),
        ButtonGroup.vertical(
          children: [
            // Its important to set width constraints on the TextFields
            ButtonGroupItem(
              child: SizedBox(
                width: 200,
                child: TextField(placeholder: Text('First Name')),
              ),
            ),
            ButtonGroup.horizontal(
              children: [
                ButtonGroupItem(
                  child: SizedBox(
                    width: 100,
                    child: TextField(placeholder: Text('Middle Name')),
                  ),
                ),
                ButtonGroupItem(
                  child: SizedBox(
                    width: 100,
                    child: TextField(placeholder: Text('Last Name')),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
