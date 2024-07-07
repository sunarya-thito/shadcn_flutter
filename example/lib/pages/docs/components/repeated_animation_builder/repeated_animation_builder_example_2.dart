import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      start: Offset(-100, 0),
      end: Offset(100, 0),
      duration: Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
      mode: RepeatMode.reverse,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
