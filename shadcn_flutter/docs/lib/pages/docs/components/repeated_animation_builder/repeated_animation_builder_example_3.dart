import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample3 extends StatelessWidget {
  const RepeatedAnimationBuilderExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      start: const Offset(-100, 0),
      end: const Offset(100, 0),
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 2),
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
