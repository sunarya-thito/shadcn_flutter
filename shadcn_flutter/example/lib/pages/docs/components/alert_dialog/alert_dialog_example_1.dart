import 'package:shadcn_flutter/shadcn_flutter.dart';

class AlertDialogExample1 extends StatelessWidget {
  const AlertDialogExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      child: Text('Click Here'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                title: Text('Alert title'),
                content: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                actions: [
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  PrimaryButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
