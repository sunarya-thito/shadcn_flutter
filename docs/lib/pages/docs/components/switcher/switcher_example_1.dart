import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitcherExample1 extends StatefulWidget {
  const SwitcherExample1({super.key});

  @override
  State<SwitcherExample1> createState() => _SwitcherExample1State();
}

class _SwitcherExample1State extends State<SwitcherExample1> {
  List<AxisDirection> directions = const [
    AxisDirection.up,
    AxisDirection.down,
    AxisDirection.left,
    AxisDirection.right,
  ];
  List<Size> sizes = const [
    Size(200, 300),
    Size(300, 200),
  ];
  int directionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = sizes[directionIndex % sizes.length];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
            child: const Text('Switch'),
            onPressed: () {
              setState(() {
                directionIndex++;
              });
            }),
        gap(8),
        PrimaryButton(
            child: const Text('Restart'),
            onPressed: () {
              setState(() {
                directionIndex = 0;
              });
            }),
        gap(24),
        ClipRect(
          child: Switcher(
            direction: directions[directionIndex % directions.length],
            onDrag: (context, direction) {
              return NumberedContainer(
                index: directionIndex,
                width: size.width,
                height: size.height,
              );
            },
            child: NumberedContainer(
              index: directionIndex,
              width: size.width,
              height: size.height,
            ),
          ),
        ),
      ],
    );
  }
}
