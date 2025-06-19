import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

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
                controller.animatePrevious(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_upward)),
          const Gap(24),
          Expanded(
            child: SizedBox(
              width: 200,
              child: Carousel(
                transition: const CarouselTransition.sliding(gap: 24),
                alignment: CarouselAlignment.center,
                controller: controller,
                direction: Axis.vertical,
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
                controller.animateNext(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_downward)),
        ],
      ),
    );
  }
}
