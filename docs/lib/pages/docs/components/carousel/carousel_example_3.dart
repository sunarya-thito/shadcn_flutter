import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

/// Carousel with fading transition and dot indicators.
///
/// Items fade in/out instead of sliding. Draggable is disabled and the
/// [CarouselDotIndicator] syncs with the same [CarouselController].
class CarouselExample3 extends StatefulWidget {
  const CarouselExample3({super.key});

  @override
  State<CarouselExample3> createState() => _CarouselExample3State();
}

class _CarouselExample3State extends State<CarouselExample3> {
  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: Carousel(
              // Use a fading transition instead of sliding.
              transition: const CarouselTransition.fading(),
              controller: controller,
              // Disable gesture dragging; navigation is via controls below.
              draggable: false,
              // Automatically switch items.
              autoplaySpeed: const Duration(seconds: 1),
              itemCount: 5,
              itemBuilder: (context, index) {
                return NumberedContainer(index: index);
              },
              // Fade duration.
              duration: const Duration(seconds: 1),
            ),
          ),
          const Gap(8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dots reflect and control the current index via controller.
              CarouselDotIndicator(itemCount: 5, controller: controller),
              const Spacer(),
              OutlineButton(
                  shape: ButtonShape.circle,
                  onPressed: () {
                    controller
                        .animatePrevious(const Duration(milliseconds: 500));
                  },
                  child: const Icon(Icons.arrow_back)),
              const Gap(8),
              OutlineButton(
                  shape: ButtonShape.circle,
                  onPressed: () {
                    controller.animateNext(const Duration(milliseconds: 500));
                  },
                  child: const Icon(Icons.arrow_forward)),
            ],
          ),
        ],
      ),
    );
  }
}
