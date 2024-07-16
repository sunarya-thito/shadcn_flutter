import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample6 extends StatefulWidget {
  @override
  State<ResizableExample6> createState() => _ResizableExample6State();
}

class _ResizableExample6State extends State<ResizableExample6> {
  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel(
        direction: Axis.horizontal,
        children: [
          ResizablePane(
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
            initialSize: 100,
            minSize: 40,
          ),
          ResizablePane(
            child: ResizablePanel(
              direction: Axis.vertical,
              children: [
                ResizablePane(
                  child: NumberedContainer(
                    index: 1,
                    fill: false,
                  ),
                  initialSize: 80,
                  minSize: 40,
                ),
                ResizablePane(
                  minSize: 40,
                  child: ResizablePanel(
                    direction: Axis.horizontal,
                    children: [
                      ResizablePane.flex(
                        child: NumberedContainer(
                          index: 2,
                          fill: false,
                        ),
                        minSize: 40,
                      ),
                      ResizablePane.flex(
                        child: NumberedContainer(
                          index: 3,
                          fill: false,
                        ),
                        minSize: 40,
                      ),
                    ],
                  ),
                  initialSize: 120,
                ),
              ],
            ),
            initialSize: 300,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 4,
              height: 200,
              fill: false,
            ),
            initialSize: 100,
            minSize: 40,
          ),
        ],
      ),
    );
  }
}
