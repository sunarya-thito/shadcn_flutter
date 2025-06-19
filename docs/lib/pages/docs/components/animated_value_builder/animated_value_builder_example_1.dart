import 'package:shadcn_flutter/shadcn_flutter.dart';

class AnimatedValueBuilderExample1 extends StatefulWidget {
  const AnimatedValueBuilderExample1({super.key});

  @override
  State<AnimatedValueBuilderExample1> createState() =>
      _AnimatedValueBuilderExample1State();
}

class _AnimatedValueBuilderExample1State
    extends State<AnimatedValueBuilderExample1> {
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedValueBuilder(
          value: colors[index],
          duration: const Duration(seconds: 1),
          lerp: Color.lerp,
          builder: (context, value, child) {
            return Container(
              width: 100,
              height: 100,
              color: value,
            );
          },
        ),
        const Gap(32),
        PrimaryButton(
          onPressed: () {
            setState(() {
              index = (index + 1) % colors.length;
            });
          },
          child: const Text('Change Color'),
        ),
      ],
    );
  }
}
