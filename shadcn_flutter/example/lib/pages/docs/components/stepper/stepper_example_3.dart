import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample3 extends StatefulWidget {
  const StepperExample3({super.key});

  @override
  State<StepperExample3> createState() => _StepperExample3State();
}

class _StepperExample3State extends State<StepperExample3> {
  final StepperController controller = StepperController(
    stepStates: {
      1: StepState.failed,
    },
    currentStep: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: controller,
      direction: Axis.horizontal,
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
                ),
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
                ),
                PrimaryButton(
                  child: Text('Next'),
                ),
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
                ),
                PrimaryButton(
                  child: Text('Finish'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
