import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      start: Offset(-100, 0),
      end: Offset(100, 0),
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 2),
      curve: Curves.linear,
      reverseCurve: Curves.easeInOutCubic,
      mode: RepeatMode.pingPong,
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
