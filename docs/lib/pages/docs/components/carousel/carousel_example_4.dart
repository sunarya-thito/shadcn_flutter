import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

class CarouselExample4 extends StatefulWidget {
  const CarouselExample4({super.key});

  @override
  State<CarouselExample4> createState() => _CarouselExample4State();
}

class _CarouselExample4State extends State<CarouselExample4> {
  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      height: 200,
      child: Carousel(
        transition: const CarouselTransition.sliding(gap: 24),
        controller: controller,
        draggable: false,
        autoplaySpeed: const Duration(seconds: 2),
        curve: Curves.linear,
        itemCount: 5,
        sizeConstraint: const CarouselSizeConstraint.fixed(200),
        itemBuilder: (context, index) {
          return NumberedContainer(index: index);
        },
        duration: Duration.zero,
      ),
    );
  }
}
