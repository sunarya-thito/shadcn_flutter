import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample4 extends StatefulWidget {
  const StepperExample4({super.key});

  @override
  State<StepperExample4> createState() => _StepperExample4State();
}

class _StepperExample4State extends State<StepperExample4> {
  final StepperController controller = StepperController();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: controller,
      direction: Axis.vertical,
      steps: [
        Step(
          title: Text('Step 1'),
          icon: StepNumber(
            onPressed: () {
              controller.jumpToStep(0);
            },
          ),
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
          icon: StepNumber(
            onPressed: () {
              controller.jumpToStep(1);
            },
          ),
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
          icon: StepNumber(
            onPressed: () {
              controller.jumpToStep(2);
            },
          ),
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
