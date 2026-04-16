# StepperTheme

Theme configuration for [Stepper] components.

## Usage

### Stepper Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_1.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_2.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_3.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_4.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_5.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_6.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample extends StatelessWidget {
  const StepperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'stepper',
      description: 'A stepper is a fundamental part of material design '
          'guidelines. Steppers convey progress through numbered steps.',
      displayName: 'Stepper',
      children: [
        WidgetUsageExample(
          title: 'Vertical Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_1.dart',
          child: StepperExample1(),
        ),
        WidgetUsageExample(
          title: 'Horizontal Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_2.dart',
          child: StepperExample2(),
        ),
        WidgetUsageExample(
          title: 'Failed Step Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_3.dart',
          child: StepperExample3(),
        ),
        WidgetUsageExample(
          title: 'Clickable Step Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_4.dart',
          child: StepperExample4(),
        ),
        WidgetUsageExample(
          title: 'Custom Icon Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_5.dart',
          child: StepperExample5(),
        ),
        WidgetUsageExample(
          title: 'Variants Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_6.dart',
          child: StepperExample6(),
        ),
      ],
    );
  }
}

```

### Stepper Example 1
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
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
      // Vertical layout with 3 steps and Next/Prev actions.
      direction: Axis.vertical,
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
                      // Advance to the next step.
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
          title: const Text('Step 2'),
          contentBuilder: (context) {
            return StepContainer(
              actions: [
                SecondaryButton(
                  child: const Text('Prev'),
                  onPressed: () {
                    // Move back one step.
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
    );
  }
}

```

### Stepper Example 2
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample2 extends StatefulWidget {
  const StepperExample2({super.key});

  @override
  State<StepperExample2> createState() => _StepperExample2State();
}

class _StepperExample2State extends State<StepperExample2> {
  final StepperController controller = StepperController();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: controller,
      // Horizontal layout using the same 3-step flow.
      direction: Axis.horizontal,
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
          title: const Text('Step 2'),
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
    );
  }
}

```

### Stepper Example 3
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
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
          title: const Text('Step 1'),
          contentBuilder: (context) {
            return const StepContainer(
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                ),
                PrimaryButton(
                  child: Text('Next'),
                ),
              ],
              child: NumberedContainer(
                index: 1,
                height: 200,
              ),
            );
          },
        ),
        Step(
          title: const Text('Step 2'),
          contentBuilder: (context) {
            return const StepContainer(
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                ),
                PrimaryButton(
                  child: Text('Next'),
                ),
              ],
              child: NumberedContainer(
                index: 2,
                height: 200,
              ),
            );
          },
        ),
        Step(
          title: const Text('Step 3'),
          contentBuilder: (context) {
            return const StepContainer(
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                ),
                PrimaryButton(
                  child: Text('Finish'),
                ),
              ],
              child: NumberedContainer(
                index: 3,
                height: 200,
              ),
            );
          },
        ),
      ],
    );
  }
}

```

### Stepper Example 4
```dart
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
          title: const Text('Step 1'),
          icon: StepNumber(
            onPressed: () {
              // Tap on the step icon to jump directly to the step.
              controller.jumpToStep(0);
            },
          ),
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
          title: const Text('Step 2'),
          icon: StepNumber(
            onPressed: () {
              controller.jumpToStep(1);
            },
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
          icon: StepNumber(
            onPressed: () {
              controller.jumpToStep(2);
            },
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
    );
  }
}

```

### Stepper Example 5
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
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
          title: const Text('Step 1'),
          icon: const StepNumber(
            // You can customize the step icon, e.g., use a person icon.
            icon: Icon(Icons.person),
          ),
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
          title: const Text('Step 2'),
          icon: const StepNumber(
            // Another custom icon for the second step.
            icon: Icon(Icons.house_outlined),
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
          icon: const StepNumber(
            // And a briefcase icon for the third.
            icon: Icon(Icons.work_outline),
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
    );
  }
}

```

### Stepper Example 6
```dart
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

```

### Stepper Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_2.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperTile extends StatelessWidget implements IComponentPage {
  const StepperTile({super.key});

  @override
  String get title => 'Stepper';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'stepper',
      title: 'Stepper',
      scale: 1,
      example: const StepperExample2().sized(width: 400, height: 500),
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
| `direction` | `Axis?` | Layout direction for the stepper. |
| `size` | `StepSize?` | Size variant for step indicators. |
| `variant` | `StepVariant?` | Visual variant for step presentation. |
