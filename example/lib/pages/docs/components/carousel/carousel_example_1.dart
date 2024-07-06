import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../carousel_example.dart';

class CarouselExample1 extends StatefulWidget {
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
              child: Icon(Icons.arrow_back),
              shape: ButtonShape.circle,
              onPressed: () {
                controller.animatePrevious(Duration(milliseconds: 500));
              }),
          gap(24),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Carousel(
                gap: 24,
                snapAlignment: CarouselAlignment.center,
                controller: controller,
                sizeFactor: 0.8,
                autoplayDuration: const Duration(seconds: 1),
                itemCount: 5,
                // wrap: false,
                itemBuilder: (context, index) {
                  return CarouselItemWidget(index: index);
                },
                duration: Duration(seconds: 2),
              ),
            ),
          ),
          gap(24),
          OutlineButton(
              child: Icon(Icons.arrow_forward),
              shape: ButtonShape.circle,
              onPressed: () {
                controller.animateNext(Duration(milliseconds: 500));
              }),
        ],
      ),
    );
  }
}
