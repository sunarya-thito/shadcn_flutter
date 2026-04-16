# CarouselSizeConstraint

Size constraint for the carousel.

## Usage

### Carousel Example
```dart
import 'package:docs/pages/docs/components/carousel/carousel_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'carousel/carousel_example_2.dart';
import 'carousel/carousel_example_3.dart';
import 'carousel/carousel_example_4.dart';

class CarouselExample extends StatelessWidget {
  const CarouselExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'carousel',
      description:
          'A carousel slider widget, support infinite scroll and custom child widget.',
      displayName: 'Carousel',
      children: [
        WidgetUsageExample(
          title: 'Horizontal Carousel Example',
          path: 'lib/pages/docs/components/carousel/carousel_example_1.dart',
          child: CarouselExample1(),
        ),
        WidgetUsageExample(
          title: 'Vertical Carousel Example',
          path: 'lib/pages/docs/components/carousel/carousel_example_2.dart',
          child: CarouselExample2(),
        ),
        WidgetUsageExample(
          title: 'Fading Carousel Example',
          path: 'lib/pages/docs/components/carousel/carousel_example_3.dart',
          child: CarouselExample3(),
        ),
        WidgetUsageExample(
          title: 'Continuous Sliding Carousel Example',
          path: 'lib/pages/docs/components/carousel/carousel_example_4.dart',
          child: CarouselExample4(),
        ),
      ],
    );
  }
}

class NumberedContainer extends StatelessWidget {
  final int index;
  final double? width;
  final double? height;
  final bool fill;
  const NumberedContainer({
    super.key,
    required this.index,
    this.width,
    this.height,
    this.fill = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: fill
            ? Colors.primaries[
                (Colors.primaries.length - 1 - index) % Colors.primaries.length]
            : null,
        borderRadius: theme.borderRadiusMd,
      ),
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

```

### Carousel Example 1
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
        ],
      ),
    );
  }
}

```

### Carousel Example 2
```dart
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

```

### Carousel Example 3
```dart
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

```

### Carousel Example 4
```dart
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

```

### Carousel Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../carousel/carousel_example_1.dart';

class CarouselTile extends StatelessWidget implements IComponentPage {
  const CarouselTile({super.key});

  @override
  String get title => 'Carousel';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'carousel',
      title: 'Carousel',
      fit: true,
      example: SizedBox(width: 550, height: 200, child: CarouselExample1()),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |

