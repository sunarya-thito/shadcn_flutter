import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Basic Alert example.
///
/// This shows a non-destructive [Alert] with a title, content, and a
/// leading icon. Use alerts to communicate a status or message that
/// doesn't necessarily require immediate user action.
class AlertExample1 extends StatelessWidget {
  const AlertExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // `Alert` supports optional leading/trailing widgets for icons or actions.
    return const Alert(
      title: Text('Alert title'),
      content: Text('This is alert content.'),
      leading: Icon(Icons.info_outline),
    );
  }
}
