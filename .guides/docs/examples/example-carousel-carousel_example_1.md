---
title: "Example: components/carousel/carousel_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

/// Horizontal carousel with manual next/previous controls.
///
/// Uses a [CarouselController] to programmatically navigate slides and
/// a sliding transition with a fixed item size and autoplay.
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
                // Animate to previous slide.
                controller.animatePrevious(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_back)),
          const Gap(24),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Carousel(
                // frameTransform: Carousel.fadingTransform,
                // Slide items with a 24px gap.
                transition: const CarouselTransition.sliding(gap: 24),
                controller: controller,
                // Each item has a fixed dimension of 200.
                sizeConstraint: const CarouselFixedConstraint(200),
                // Automatically advance every 2 seconds.
                autoplaySpeed: const Duration(seconds: 2),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return NumberedContainer(index: index);
                },
                // Duration of the slide transition animation.
                duration: const Duration(seconds: 1),
              ),
            ),
          ),
          const Gap(24),
          OutlineButton(
              shape: ButtonShape.circle,
              onPressed: () {
                // Animate to next slide.
                controller.animateNext(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_forward)),
```
