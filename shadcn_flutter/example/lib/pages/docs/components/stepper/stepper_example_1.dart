import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample1 extends StatefulWidget {
  const StepperExample1({super.key});

  @override
  State<StepperExample1> createState() => _StepperExample1State();
}

class _StepperExample1State extends State<StepperExample1> {
  final StepperController controller = StepperController();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: controller,
      direction: Axis.vertical,
      steps: [
        Step(
          title: Text('Step 1'),
          contentBuilder: (context) {
            return StepContainer(
              child: NumberedContainer(
                index: 1,
                height: 200,
              ),
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                ),
                PrimaryButton(
                    child: Text('Next'),
                    onPressed: () {
                      controller.nextStep();
                    }),
              ],
            );
          },
        ),
        Step(
          title: Text('Step 2'),
          contentBuilder: (context) {
            return StepContainer(
              child: NumberedContainer(
                index: 2,
                height: 200,
              ),
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                  onPressed: () {
                    controller.previousStep();
                  },
                ),
                PrimaryButton(
                    child: Text('Next'),
                    onPressed: () {
                      controller.nextStep();
                    }),
              ],
            );
          },
        ),
        Step(
          title: Text('Step 3'),
          contentBuilder: (context) {
            return StepContainer(
              child: NumberedContainer(
                index: 3,
                height: 200,
              ),
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                  onPressed: () {
                    controller.previousStep();
                  },
                ),
                PrimaryButton(
                    child: Text('Finish'),
                    onPressed: () {
                      controller.nextStep();
                    }),
              ],
            );
          },
        ),
      ],
    );
  }
}
