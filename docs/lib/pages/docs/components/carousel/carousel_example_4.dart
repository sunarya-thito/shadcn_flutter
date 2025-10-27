import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

/// Continuous sliding carousel.
///
/// Uses a sliding transition with a linear curve and `duration: Duration.zero`
/// to produce a smooth, continuous marquee-like movement when combined with
/// `autoplaySpeed`.
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
        // Slide items horizontally with a gap.
        transition: const CarouselTransition.sliding(gap: 24),
        controller: controller,
        // Disable user drag to keep the motion continuous.
        draggable: false,
        // Tick forward every 2 seconds.
        autoplaySpeed: const Duration(seconds: 2),
        // Linear curve keeps velocity constant between ticks.
        curve: Curves.linear,
        itemCount: 5,
        sizeConstraint: const CarouselSizeConstraint.fixed(200),
        itemBuilder: (context, index) {
          return NumberedContainer(index: index);
        },
        // Instant transition per tick for a marquee-like feel.
        duration: Duration.zero,
      ),
    );
  }
}
