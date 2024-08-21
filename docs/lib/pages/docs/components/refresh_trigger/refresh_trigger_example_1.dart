import 'package:shadcn_flutter/shadcn_flutter.dart';

class RefreshTriggerExample1 extends StatelessWidget {
  const RefreshTriggerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshTrigger(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: SingleChildScrollView(
        child: Container(
            height: 800,
            padding: EdgeInsets.only(top: 32),
            alignment: Alignment.topCenter,
            child: Text('Scroll Me')),
      ),
    );
  }
}
