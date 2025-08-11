import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperTheme {
  final Axis? direction;
  final StepSize? size;
  final StepVariant? variant;

  const StepperTheme({this.direction, this.size, this.variant});

  StepperTheme copyWith({
    ValueGetter<Axis?>? direction,
    ValueGetter<StepSize?>? size,
    ValueGetter<StepVariant?>? variant,
  }) {
    return StepperTheme(
      direction: direction == null ? this.direction : direction(),
      size: size == null ? this.size : size(),
      variant: variant == null ? this.variant : variant(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepperTheme &&
        other.direction == direction &&
        other.size == size &&
        other.variant == variant;
  }

  @override
  int get hashCode => Object.hash(direction, size, variant);
}

enum StepState {
  failed,
}

class StepperValue {
  final Map<int, StepState> stepStates;
  final int currentStep;

  StepperValue({
    required this.stepStates,
    required this.currentStep,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepperValue &&
        mapEquals(other.stepStates, stepStates) &&
        other.currentStep == currentStep;
  }

  @override
  int get hashCode => Object.hash(stepStates, currentStep);

  @override
  String toString() {
    return 'StepperValue{stepStates: $stepStates, currentStep: $currentStep}';
  }
}

class Step {
  final Widget title;
  final WidgetBuilder? contentBuilder;
  final Widget? icon;

  const Step({
    required this.title,
    this.contentBuilder,
    this.icon,
  });
}

typedef StepSizeBuilder = Widget Function(BuildContext context, Widget child);

enum StepSize {
  small(_smallSize, kSmallStepIndicatorSize),
  medium(_mediumSize, kMediumStepIndicatorSize),
  large(_largeSize, kLargeStepIndicatorSize);

  final double size;

  final StepSizeBuilder wrapper;
  const StepSize(this.wrapper, this.size);
}

Widget _smallSize(BuildContext context, Widget child) {
  return child.small().iconSmall();
}

Widget _mediumSize(BuildContext context, Widget child) {
  return child.normal().iconMedium();
}

Widget _largeSize(BuildContext context, Widget child) {
  return child.large().iconLarge();
}

abstract class StepVariant {
  static const StepVariant circle = _StepVariantCircle();
  static const StepVariant circleAlt = _StepVariantCircleAlternative();
  static const StepVariant line = _StepVariantLine();
  const StepVariant();
  Widget build(BuildContext context, StepProperties properties);
}

class _StepVariantCircle extends StepVariant {
  const _StepVariantCircle();

  @override
  Widget build(BuildContext context, StepProperties properties) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    if (properties.direction == Axis.horizontal) {
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        Widget childWidget = Data.inherit(
          data: StepNumberData(stepIndex: i),
          child: Row(
            children: [
              properties[i]?.icon ?? const StepNumber(),
              Gap(8 * scaling),
              properties.size
                  .wrapper(context, properties[i]?.title ?? const SizedBox()),
              if (i != properties.steps.length - 1) ...[
                Gap(8 * scaling),
                Expanded(
                  child: AnimatedBuilder(
                      animation: properties.state,
                      builder: (context, child) {
                        return Divider(
                          thickness: 2 * scaling,
                          color: properties.hasFailure &&
                                  properties.state.value.currentStep <= i
                              ? theme.colorScheme.destructive
                              : properties.state.value.currentStep >= i
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.border,
                        );
                      }),
                ),
                Gap(8 * scaling),
              ],
            ],
          ),
        );
        children.add(
          i == properties.steps.length - 1
              ? childWidget
              : Expanded(
                  child: childWidget,
                ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
          AnimatedBuilder(
              animation: properties.state,
              builder: (context, child) {
                var current = properties.state.value.currentStep;
                return Flexible(
                    child: IndexedStack(
                  index: current < 0 || current >= properties.steps.length
                      ? properties.steps.length // will show the placeholder
                      : current,
                  children: [
                    for (int i = 0; i < properties.steps.length; i++)
                      properties[i]?.contentBuilder?.call(context) ??
                          const SizedBox(),
                    const SizedBox(), // for placeholder
                  ],
                ));
              }),
        ],
      );
    } else {
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        children.add(
          Data.inherit(
            data: StepNumberData(stepIndex: i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    properties.steps[i].icon ?? const StepNumber(),
                    Gap(8 * scaling),
                    properties.size.wrapper(context, properties.steps[i].title),
                  ],
                ),
                Gap(8 * scaling),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 16 * scaling,
                  ),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: properties.size.size,
                          child: i == properties.steps.length - 1
                              ? null
                              : AnimatedBuilder(
                                  animation: properties.state,
                                  builder: (context, child) {
                                    return VerticalDivider(
                                      thickness: 2 * scaling,
                                      color: properties.hasFailure &&
                                              properties.state.value
                                                      .currentStep <=
                                                  i
                                          ? theme.colorScheme.destructive
                                          : properties.state.value
                                                      .currentStep >=
                                                  i
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.border,
                                    );
                                  }),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: properties.state,
                          child:
                              properties.steps[i].contentBuilder?.call(context),
                          builder: (context, child) {
                            return AnimatedCrossFade(
                              firstChild: Container(
                                height: 0,
                              ),
                              secondChild: Container(
                                margin: EdgeInsets.only(
                                  left: properties.size.size,
                                ),
                                child: child!,
                              ),
                              firstCurve: const Interval(0.0, 0.6,
                                  curve: Curves.fastOutSlowIn),
                              secondCurve: const Interval(0.4, 1.0,
                                  curve: Curves.fastOutSlowIn),
                              sizeCurve: Curves.fastOutSlowIn,
                              crossFadeState:
                                  properties.state.value.currentStep == i
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                              duration: kDefaultDuration,
                            );
                          }),
                    ],
                  ),
                ),
                AnimatedBuilder(
                    animation: properties.state,
                    builder: (context, child) {
                      if (i == properties.steps.length - 1) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: 8 * scaling,
                      );
                    }),
              ],
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

class _StepVariantCircleAlternative extends StepVariant {
  const _StepVariantCircleAlternative();
  @override
  Widget build(BuildContext context, StepProperties properties) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final steps = properties.steps;
    if (properties.direction == Axis.horizontal) {
      List<Widget> children = [];
      for (int i = 0; i < steps.length; i++) {
        children.add(
          Data.inherit(
              data: StepNumberData(stepIndex: i),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        i == 0
                            ? const Spacer()
                            : Expanded(
                                child: AnimatedBuilder(
                                    animation: properties.state,
                                    builder: (context, child) {
                                      return Divider(
                                        thickness: 2 * scaling,
                                        color: properties.hasFailure &&
                                                properties.state.value
                                                        .currentStep <=
                                                    i - 1
                                            ? theme.colorScheme.destructive
                                            : properties.state.value
                                                        .currentStep >=
                                                    i - 1
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.border,
                                      );
                                    }),
                              ),
                        Gap(4 * scaling),
                        steps[i].icon ?? const StepNumber(),
                        Gap(4 * scaling),
                        i == steps.length - 1
                            ? const Spacer()
                            : Expanded(
                                child: AnimatedBuilder(
                                    animation: properties.state,
                                    builder: (context, child) {
                                      return Divider(
                                        thickness: 2 * scaling,
                                        color: properties.hasFailure &&
                                                properties.state.value
                                                        .currentStep <=
                                                    i
                                            ? theme.colorScheme.destructive
                                            : properties.state.value
                                                        .currentStep >=
                                                    i
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.border,
                                      );
                                    }),
                              ),
                      ],
                    ),
                    Gap(4 * scaling),
                    Center(
                      child: DefaultTextStyle.merge(
                        textAlign: TextAlign.center,
                        child: properties.size.wrapper(
                          context,
                          steps[i].title,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
          AnimatedBuilder(
              animation: properties.state,
              builder: (context, child) {
                var current = properties.state.value.currentStep;
                return Flexible(
                    child: IndexedStack(
                  index: current < 0 || current >= properties.steps.length
                      ? properties.steps.length // will show the placeholder
                      : current,
                  children: [
                    for (int i = 0; i < properties.steps.length; i++)
                      properties[i]?.contentBuilder?.call(context) ??
                          const SizedBox(),
                    const SizedBox(), // for placeholder
                  ],
                ));
              }),
        ],
      );
    } else {
      // it's just the same as circle variant
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        children.add(
          Data.inherit(
            data: StepNumberData(stepIndex: i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    properties.steps[i].icon ?? const StepNumber(),
                    Gap(8 * scaling),
                    properties.size.wrapper(context, properties.steps[i].title),
                  ],
                ),
                Gap(8 * scaling),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 16 * scaling,
                  ),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: properties.size.size,
                          child: i == properties.steps.length - 1
                              ? null
                              : AnimatedBuilder(
                                  animation: properties.state,
                                  builder: (context, child) {
                                    return VerticalDivider(
                                      thickness: 2 * scaling,
                                      color: properties.hasFailure &&
                                              properties.state.value
                                                      .currentStep <=
                                                  i
                                          ? theme.colorScheme.destructive
                                          : properties.state.value
                                                      .currentStep >=
                                                  i
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.border,
                                    );
                                  }),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: properties.state,
                          child:
                              properties.steps[i].contentBuilder?.call(context),
                          builder: (context, child) {
                            return AnimatedCrossFade(
                              firstChild: Container(
                                height: 0,
                              ),
                              secondChild: Container(
                                margin: EdgeInsets.only(
                                  left: properties.size.size,
                                ),
                                child: child!,
                              ),
                              firstCurve: const Interval(0.0, 0.6,
                                  curve: Curves.fastOutSlowIn),
                              secondCurve: const Interval(0.4, 1.0,
                                  curve: Curves.fastOutSlowIn),
                              sizeCurve: Curves.fastOutSlowIn,
                              crossFadeState:
                                  properties.state.value.currentStep == i
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                              duration: kDefaultDuration,
                            );
                          }),
                    ],
                  ),
                ),
                AnimatedBuilder(
                    animation: properties.state,
                    builder: (context, child) {
                      if (i == properties.steps.length - 1) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: 8 * scaling,
                      );
                    }),
              ],
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

class _StepVariantLine extends StepVariant {
  const _StepVariantLine();

  @override
  Widget build(BuildContext context, StepProperties properties) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final steps = properties.steps;
    if (properties.direction == Axis.horizontal) {
      List<Widget> children = [];
      for (int i = 0; i < steps.length; i++) {
        children.add(
          Expanded(
            child: Data.inherit(
              data: StepNumberData(stepIndex: i),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                      animation: properties.state,
                      builder: (context, child) {
                        return Divider(
                          thickness: 3 * scaling,
                          color: properties.hasFailure &&
                                  properties.state.value.currentStep <= i
                              ? theme.colorScheme.destructive
                              : properties.state.value.currentStep >= i
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.border,
                        );
                      }),
                  Gap(8 * scaling),
                  properties.size.wrapper(
                    context,
                    steps[i].title,
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ).gap(16 * scaling),
          ),
          AnimatedBuilder(
              animation: properties.state,
              builder: (context, child) {
                var current = properties.state.value.currentStep;
                return Flexible(
                    child: IndexedStack(
                  index: current < 0 || current >= properties.steps.length
                      ? properties.steps.length // will show the placeholder
                      : current,
                  children: [
                    for (int i = 0; i < properties.steps.length; i++)
                      properties[i]?.contentBuilder?.call(context) ??
                          const SizedBox(),
                    const SizedBox(), // for placeholder
                  ],
                ));
              }),
        ],
      );
    } else {
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        children.add(
          Data.inherit(
            data: StepNumberData(stepIndex: i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedBuilder(
                          animation: properties.state,
                          builder: (context, child) {
                            return VerticalDivider(
                              thickness: 3 * scaling,
                              color: properties.hasFailure &&
                                      properties.state.value.currentStep <= i
                                  ? theme.colorScheme.destructive
                                  : properties.state.value.currentStep >= i
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.border,
                            );
                          }),
                      Gap(16 * scaling),
                      properties.size
                          .wrapper(context, properties.steps[i].title)
                          .withPadding(vertical: 8 * scaling),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 16 * scaling,
                  ),
                  child: AnimatedBuilder(
                      animation: properties.state,
                      child: properties.steps[i].contentBuilder?.call(context),
                      builder: (context, child) {
                        return AnimatedCrossFade(
                          firstChild: Container(
                            height: 0,
                          ),
                          secondChild: Container(
                            child: child!,
                          ),
                          firstCurve: const Interval(0.0, 0.6,
                              curve: Curves.fastOutSlowIn),
                          secondCurve: const Interval(0.4, 1.0,
                              curve: Curves.fastOutSlowIn),
                          sizeCurve: Curves.fastOutSlowIn,
                          crossFadeState:
                              properties.state.value.currentStep == i
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          duration: kDefaultDuration,
                        );
                      }),
                ),
                AnimatedBuilder(
                    animation: properties.state,
                    builder: (context, child) {
                      if (i == properties.steps.length - 1) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: 8 * scaling,
                      );
                    }),
              ],
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

const kSmallStepIndicatorSize = 36.0;
const kMediumStepIndicatorSize = 40.0;
const kLargeStepIndicatorSize = 44.0;

class StepProperties {
  final StepSize size;
  final List<Step> steps;
  final ValueListenable<StepperValue> state;
  final Axis direction;

  const StepProperties({
    required this.size,
    required this.steps,
    required this.state,
    required this.direction,
  });

  Step? operator [](int index) {
    if (index < 0 || index >= steps.length) {
      return null;
    }
    return steps[index];
  }

  bool get hasFailure => state.value.stepStates.containsValue(StepState.failed);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepProperties &&
        other.size == size &&
        listEquals(other.steps, steps) &&
        other.state == state &&
        other.direction == direction;
  }

  @override
  int get hashCode => Object.hash(size, steps, state, direction);
}

class StepperController extends ValueNotifier<StepperValue> {
  StepperController({
    Map<int, StepState>? stepStates,
    int? currentStep,
  }) : super(StepperValue(
          stepStates: stepStates ?? {},
          currentStep: currentStep ?? 0,
        ));

  void nextStep() {
    value = StepperValue(
      stepStates: value.stepStates,
      currentStep: value.currentStep + 1,
    );
  }

  void previousStep() {
    value = StepperValue(
      stepStates: value.stepStates,
      currentStep: value.currentStep - 1,
    );
  }

  void setStatus(int step, StepState? state) {
    Map<int, StepState> newStates = Map.from(value.stepStates);
    if (state == null) {
      newStates.remove(step);
    } else {
      newStates[step] = state;
    }
    value = StepperValue(
      stepStates: newStates,
      currentStep: value.currentStep,
    );
  }

  void jumpToStep(int step) {
    value = StepperValue(
      stepStates: value.stepStates,
      currentStep: step,
    );
  }
}

class Stepper extends StatelessWidget {
  final StepperController controller;
  final List<Step> steps;
  final Axis? direction;
  final StepSize? size;
  final StepVariant? variant;

  const Stepper({
    super.key,
    required this.controller,
    required this.steps,
    this.direction,
    this.size,
    this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<StepperTheme>(context);
    final dir = direction ?? compTheme?.direction ?? Axis.horizontal;
    final sz = size ?? compTheme?.size ?? StepSize.medium;
    final varnt = variant ?? compTheme?.variant ?? StepVariant.circle;
    var stepProperties = StepProperties(
        size: sz, steps: steps, state: controller, direction: dir);
    return Data.inherit(
      data: stepProperties,
      child: varnt.build(context, stepProperties),
    );
  }
}

class StepNumberData {
  final int stepIndex;

  const StepNumberData({
    required this.stepIndex,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepNumberData && other.stepIndex == stepIndex;
  }

  @override
  int get hashCode => stepIndex.hashCode;

  @override
  String toString() {
    return 'StepNumberData{stepIndex: $stepIndex}';
  }
}

class StepNumber extends StatelessWidget {
  final Widget? icon;
  final VoidCallback? onPressed;

  const StepNumber({
    super.key,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final properties = Data.maybeOf<StepProperties>(context);
    final stepNumberData = Data.maybeOf<StepNumberData>(context);
    assert(properties != null, 'StepNumber must be a descendant of Stepper');
    assert(stepNumberData != null,
        'StepNumber must be a descendant of StepNumberData');
    final int stepIndex = stepNumberData!.stepIndex;
    final theme = Theme.of(context);
    return AnimatedBuilder(
        animation: properties!.state,
        builder: (context, child) {
          return properties.size.wrapper(
            context,
            DefaultTextStyle.merge(
              style: TextStyle(
                color: properties.state.value.stepStates[stepIndex] ==
                        StepState.failed
                    ? theme.colorScheme.destructive
                    : theme.colorScheme.primary,
              ).merge(theme.typography.medium),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: properties.state.value.stepStates[stepIndex] ==
                          StepState.failed
                      ? theme.colorScheme.destructive
                      : properties.state.value.currentStep > stepIndex
                          ? theme.colorScheme.background
                          : theme.colorScheme.primary,
                ),
                child: SizedBox(
                  // these sizes are not constant, but the source value is from constant enum value
                  width: properties.size.size * theme.scaling,
                  height: properties.size.size * theme.scaling,
                  child: Clickable(
                    enabled: onPressed != null,
                    onPressed: onPressed,
                    mouseCursor: WidgetStatePropertyAll(
                      onPressed != null
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                    ),
                    decoration: WidgetStateProperty.resolveWith(
                      (states) {
                        return BoxDecoration(
                          shape: theme.radius == 0
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          color: properties.state.value.stepStates[stepIndex] ==
                                  StepState.failed
                              ? theme.colorScheme.destructive
                              : properties.state.value.currentStep > stepIndex
                                  ? theme.colorScheme.primary
                                  : properties.state.value.currentStep ==
                                              stepIndex ||
                                          states
                                              .contains(WidgetState.hovered) ||
                                          states.contains(WidgetState.focused)
                                      ? theme.colorScheme.secondary
                                      : theme.colorScheme.background,
                          border: Border.all(
                            color:
                                properties.state.value.stepStates[stepIndex] ==
                                        StepState.failed
                                    ? theme.colorScheme.destructive
                                    : properties.state.value.currentStep >=
                                            stepIndex
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.border,
                            width: 2 * theme.scaling,
                          ),
                        );
                      },
                    ),
                    child: Center(
                      child: properties.state.value.stepStates[stepIndex] ==
                              StepState.failed
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                            )
                          : properties.state.value.currentStep > stepIndex
                              ? Icon(
                                  Icons.check,
                                  color: theme.colorScheme.background,
                                )
                              : icon ?? Text((stepIndex + 1).toString()),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class StepTitle extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final VoidCallback? onPressed;

  const StepTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Clickable(
      mouseCursor: WidgetStatePropertyAll(
          onPressed == null ? MouseCursor.defer : SystemMouseCursors.click),
      onPressed: onPressed,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            title,
            if (subtitle != null) ...[
              Gap(2 * scaling),
              subtitle!.muted().xSmall(),
            ],
          ],
        ),
      ),
    );
  }
}

class StepContainer extends StatefulWidget {
  final Widget child;
  final List<Widget> actions;

  const StepContainer({
    super.key,
    required this.child,
    required this.actions,
  });

  @override
  State<StepContainer> createState() => _StepContainerState();
}

class _StepContainerState extends State<StepContainer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    if (widget.actions.isEmpty) {
      return widget.child.withPadding(
        vertical: 16 * scaling,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.child,
        Gap(16 * scaling),
        Row(
          children: widget.actions,
        ).gap(8 * scaling),
      ],
    ).withPadding(
      vertical: 16 * scaling,
    );
  }
}
