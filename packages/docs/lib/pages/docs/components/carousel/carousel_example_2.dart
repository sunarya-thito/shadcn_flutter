import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

/// Vertical carousel centered in a column with manual controls.
///
/// Demonstrates changing [direction] to [Axis.vertical] and centering items
/// using [CarouselAlignment.center].
class CarouselExample2 extends StatefulWidget {
  const CarouselExample2({super.key});

  @override
  State<CarouselExample2> createState() => _CarouselExample2State();
}

class _CarouselExample2State extends State<CarouselExample2> {
  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlineButton(
              shape: ButtonShape.circle,
              onPressed: () {
                // Move to previous item (upwards).
                controller.animatePrevious(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_upward)),
          const Gap(24),
          Expanded(
            child: SizedBox(
              width: 200,
              child: Carousel(
                transition: const CarouselTransition.sliding(gap: 24),
                // Center the visible item.
                alignment: CarouselAlignment.center,
                controller: controller,
                // Rotate layout to vertical flow.
                direction: Axis.vertical,
                // Fix item extent to 200.
                sizeConstraint: const CarouselFixedConstraint(200),
                itemBuilder: (context, index) {
                  return NumberedContainer(index: index);
                },
              ),
            ),
          ),
          const Gap(24),
          OutlineButton(
              shape: ButtonShape.circle,
              onPressed: () {
                // Move to next item (downwards).
                controller.animateNext(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_downward)),
        ],
      ),
    );
  }
}
