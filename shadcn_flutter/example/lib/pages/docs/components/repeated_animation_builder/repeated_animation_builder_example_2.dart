import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample2 extends StatelessWidget {
  const RepeatedAnimationBuilderExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      start: const Offset(-100, 0),
      end: const Offset(100, 0),
      duration: const Duration(seconds: 1),
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
