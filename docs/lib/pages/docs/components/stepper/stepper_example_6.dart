import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample6 extends StatefulWidget {
  const StepperExample6({super.key});

  @override
  State<StepperExample6> createState() => _StepperExample6State();
}

class _StepperExample6State extends State<StepperExample6> {
  static const List<StepVariant> _variants = [
    StepVariant.circle,
    StepVariant.circleAlt,
    StepVariant.line,
  ];
  static const List<String> _variantNames = [
    'Circle',
    'Circle Alt',
    'Line',
  ];
  static const List<StepSize> _stepSize = StepSize.values;
  static const List<String> _stepSizeNames = [
    'Small',
    'Medium',
    'Large',
  ];
  final StepperController controller = StepperController();
  int _currentVariant = 0;
  int _currentStepSize = 0;
  Axis direction = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            Toggle(
              value: direction == Axis.horizontal,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    direction = Axis.horizontal;
                  });
                } else {
                  setState(() {
                    direction = Axis.vertical;
                  });
                }
              },
              child: const Text('Horizontal'),
            ),
            Toggle(
              value: direction == Axis.vertical,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    direction = Axis.vertical;
                  });
                } else {
                  setState(() {
                    direction = Axis.horizontal;
                  });
                }
              },
              child: const Text('Vertical'),
            ),
            const VerticalDivider().sized(height: 16),
            for (var i = 0; i < _variants.length; i++)
              Toggle(
                value: _currentVariant == i,
                onChanged: (value) {
                  setState(() {
                    // Choose among visual variants (circle, alt circle, line).
                    _currentVariant = i;
                  });
                },
                child: Text(_variantNames[i]),
              ),
            const VerticalDivider().sized(height: 16),
            for (var i = 0; i < _stepSize.length; i++)
              Toggle(
                value: _currentStepSize == i,
                onChanged: (value) {
                  setState(() {
                    // Pick the step size used by the Stepper.
                    _currentStepSize = i;
                  });
                },
                child: Text(_stepSizeNames[i]),
              ),
            const VerticalDivider().sized(height: 16),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Toggle(
                  value: controller.value.stepStates[1] == StepState.failed,
                  onChanged: (value) {
                    if (value) {
                      // Mark step 2 as failed to demo error state.
                      controller.setStatus(1, StepState.failed);
                    } else {
                      controller.setStatus(1, null);
                    }
                  },
                  child: const Text('Toggle Error'),
                );
              },
            ),
          ],
        ),
        const Gap(16),
        Stepper(
          controller: controller,
          direction: direction,
          // Apply the chosen size and visual variant.
          size: _stepSize[_currentStepSize],
          variant: _variants[_currentVariant],
          steps: [
            Step(
              title: const Text('Step 1'),
              contentBuilder: (context) {
                return StepContainer(
                  actions: [
                    const SecondaryButton(
                      child: Text('Prev'),
                    ),
                    PrimaryButton(
                        child: const Text('Next'),
                        onPressed: () {
                          controller.nextStep();
                        }),
                  ],
                  child: const NumberedContainer(
                    index: 1,
                    height: 200,
                  ),
                );
              },
            ),
            Step(
              title: const StepTitle(
                title: Text('Step 2'),
                subtitle: Text('Optional Step'),
              ),
              contentBuilder: (context) {
                return StepContainer(
                  actions: [
                    SecondaryButton(
                      child: const Text('Prev'),
                      onPressed: () {
                        controller.previousStep();
                      },
                    ),
                    PrimaryButton(
                        child: const Text('Next'),
                        onPressed: () {
                          controller.nextStep();
                        }),
                  ],
                  child: const NumberedContainer(
                    index: 2,
                    height: 200,
                  ),
                );
              },
            ),
            Step(
              title: const Text('Step 3'),
              contentBuilder: (context) {
                return StepContainer(
                  actions: [
                    SecondaryButton(
                      child: const Text('Prev'),
                      onPressed: () {
                        controller.previousStep();
                      },
                    ),
                    PrimaryButton(
                        child: const Text('Finish'),
                        onPressed: () {
                          controller.nextStep();
                        }),
                  ],
                  child: const NumberedContainer(
                    index: 3,
                    height: 200,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
