import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

class CarouselExample1 extends StatefulWidget {
  const CarouselExample1({super.key});

  @override
  State<CarouselExample1> createState() => _CarouselExample1State();
}

class _CarouselExample1State extends State<CarouselExample1> {
  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Row(
        children: [
          OutlineButton(
              shape: ButtonShape.circle,
              onPressed: () {
                controller.animatePrevious(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_back)),
          const Gap(24),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Carousel(
                gap: 24,
                snapAlignment: CarouselAlignment.center,
                controller: controller,
                sizeFactor: 0.8,
                autoplaySpeed: const Duration(seconds: 1),
                itemCount: 5,
                // wrap: false,
                itemBuilder: (context, index) {
                  return NumberedContainer(index: index);
                },
                duration: const Duration(seconds: 2),
              ),
            ),
          ),
          const Gap(24),
          OutlineButton(
              shape: ButtonShape.circle,
              onPressed: () {
                controller.animateNext(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_forward)),
        ],
      ),
    );
  }
}
