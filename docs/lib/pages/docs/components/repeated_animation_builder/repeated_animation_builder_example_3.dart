import 'package:shadcn_flutter/shadcn_flutter.dart';

class RepeatedAnimationBuilderExample3 extends StatefulWidget {
  const RepeatedAnimationBuilderExample3({super.key});

  @override
  State<RepeatedAnimationBuilderExample3> createState() =>
      _RepeatedAnimationBuilderExample3State();
}

class _RepeatedAnimationBuilderExample3State
    extends State<RepeatedAnimationBuilderExample3> {
  bool play = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RepeatedAnimationBuilder(
          play: play,
          start: const Offset(-100, 0),
          end: const Offset(100, 0),
          duration: const Duration(seconds: 1),
          reverseDuration: const Duration(seconds: 5),
          curve: Curves.linear,
          reverseCurve: Curves.easeInOutCubic,
          mode: RepeatMode.pingPongReverse,
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
        ),
        const Gap(24),
        PrimaryButton(
          onPressed: () {
            setState(() {
              play = !play;
            });
          },
          child: Text(play ? 'Stop' : 'Play'),
        )
      ],
    );
  }
}
