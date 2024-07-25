import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample5 extends StatefulWidget {
  const StepperExample5({super.key});

  @override
  State<StepperExample5> createState() => _StepperExample5State();
}

class _StepperExample5State extends State<StepperExample5> {
  final StepperController controller = StepperController();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: controller,
      direction: Axis.horizontal,
      steps: [
        Step(
          title: Text('Step 1'),
          icon: StepNumber(
            icon: Icon(Icons.person),
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
            icon: Icon(Icons.house_outlined),
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
            icon: Icon(Icons.work_outline),
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
