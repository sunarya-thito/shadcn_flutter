import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class AlertDialogTile extends StatelessWidget implements IComponentPage {
  const AlertDialogTile({super.key});

  @override
  String get title => 'Alert Dialog';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'alert_dialog',
      title: 'Alert Dialog',
      center: true,
      example: AlertDialog(
        title: const Text('Alert Dialog'),
        content: const Text('This is an alert dialog.'),
        actions: [
          SecondaryButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
          PrimaryButton(
            onPressed: () {},
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
