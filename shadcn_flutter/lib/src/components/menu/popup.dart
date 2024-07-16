import '../../../shadcn_flutter.dart';

class MenuPopup extends StatelessWidget {
  final List<Widget> children;

  MenuPopup({required this.children});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
