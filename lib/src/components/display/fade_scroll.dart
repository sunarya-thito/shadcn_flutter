import '../../../shadcn_flutter.dart';

class FadeScroll extends StatelessWidget {
  final double startOffset;
  final double endOffset;
  final double startCrossOffset;
  final double endCrossOffset;
  final Widget child;
  final ScrollController controller;
  final List<Color> gradient;

  const FadeScroll({
    super.key,
    required this.startOffset,
    required this.endOffset,
    required this.child,
    required this.controller,
    required this.gradient,
    this.startCrossOffset = 0,
    this.endCrossOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      child: child,
      builder: (context, child) {
        if (!controller.hasClients) {
          return child!;
        }
        final position = controller.position.pixels;
        final max = controller.position.maxScrollExtent;
        final min = controller.position.minScrollExtent;
        final direction = controller.position.axis;
        final size = controller.position.viewportDimension;
        bool shouldFadeStart = position > min;
        bool shouldFadeEnd = position < max;
        if (!shouldFadeStart && !shouldFadeEnd) {
          return child!;
        }
        return ShaderMask(
          shaderCallback: (bounds) {
            Alignment start = direction == Axis.horizontal
                ? Alignment.centerLeft
                : Alignment.topCenter;
            Alignment end = direction == Axis.horizontal
                ? Alignment.centerRight
                : Alignment.bottomCenter;
            double relativeStart = startOffset / size;
            double relativeEnd = 1 - endOffset / size;
            List<double> stops = shouldFadeStart && shouldFadeEnd
                ? [
                    for (int i = 0; i < gradient.length; i++)
                      (i / gradient.length) * relativeStart,
                    relativeStart,
                    relativeEnd,
                    for (int i = 1; i < gradient.length + 1; i++)
                      relativeEnd + (i / gradient.length) * (1 - relativeEnd),
                  ]
                : shouldFadeStart
                    ? [
                        for (int i = 0; i < gradient.length; i++)
                          (i / gradient.length) * relativeStart,
                        relativeStart,
                        1
                      ]
                    : [
                        0,
                        relativeEnd,
                        for (int i = 1; i < gradient.length + 1; i++)
                          relativeEnd +
                              (i / gradient.length) * (1 - relativeEnd),
                      ];
            return LinearGradient(
                    colors: [
                  if (shouldFadeStart) ...gradient,
                  Colors.white,
                  Colors.white,
                  if (shouldFadeEnd) ...gradient.reversed,
                ],
                    stops: stops,
                    begin: start,
                    end: end,
                    transform: const _ScaleGradient(Offset(1, 1.5)))
                .createShader(bounds);
          },
          child: child!,
        );
      },
    );
  }
}

class _ScaleGradient extends GradientTransform {
  final Offset scale;

  const _ScaleGradient(this.scale);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final center = bounds.center;
    final dx = center.dx * (1 - scale.dx);
    final dy = center.dy * (1 - scale.dy);
    return Matrix4.identity()
      ..translate(dx, dy)
      ..scale(scale.dx, scale.dy)
      ..translate(-dx, -dy);
  }
}

