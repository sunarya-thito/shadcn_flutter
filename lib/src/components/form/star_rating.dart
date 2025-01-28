import 'package:shadcn_flutter/shadcn_flutter.dart';

class StarRating extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double step;
  final Axis direction;
  final double max;
  final Color? activeColor;
  final Color? backgroundColor;
  final double starPoints;
  final double? starSize;
  final double? starSpacing;
  final double? starPointRounding;
  final double? starValleyRounding;
  final double? starSquash;
  final double? starInnerRadiusRatio;
  final double? starRotation;

  const StarRating({
    super.key,
    required this.value,
    this.onChanged,
    this.step = 0.5,
    this.direction = Axis.horizontal,
    this.max = 5.0,
    this.activeColor,
    this.backgroundColor,
    this.starPoints = 5,
    this.starSize,
    this.starSpacing,
    this.starPointRounding,
    this.starValleyRounding,
    this.starSquash,
    this.starInnerRadiusRatio,
    this.starRotation,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating>
    with FormValueSupplier<double, StarRating> {
  double? _changingValue;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant StarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(double value) {
    widget.onChanged?.call(value);
  }

  Widget _buildStar(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var starValleyRounding = widget.starValleyRounding ?? 0.0;
    var starSquash = widget.starSquash ?? 0.0;
    var starInnerRadiusRatio = widget.starInnerRadiusRatio ?? 0.4;
    var starRotation = widget.starRotation ?? 0.0;
    var starSize = widget.starSize ?? 24.0;
    return Container(
      width: starSize * scaling,
      height: starSize * scaling,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: StarBorder(
          points: widget.starPoints,
          pointRounding: widget.starPointRounding ?? (theme.radius / 2),
          valleyRounding: starValleyRounding * theme.radius,
          squash: starSquash,
          innerRadiusRatio: starInnerRadiusRatio,
          rotation: starRotation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double roundedValue =
        ((_changingValue ?? widget.value) / widget.step).round() * widget.step;
    return AnimatedValueBuilder(
      value: roundedValue,
      duration: kDefaultDuration,
      builder: (context, roundedValue, child) {
        final theme = Theme.of(context);
        final scaling = theme.scaling;
        var starSize =
            widget.starSize != null ? widget.starSize! : 24.0 * scaling;
        var starSpacing =
            widget.starSpacing != null ? widget.starSpacing! : 5.0 * scaling;
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (widget.onChanged != null && roundedValue != widget.value) {
              widget.onChanged!(roundedValue);
            }
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onExit: (event) {
              setState(() {
                _changingValue = null;
              });
            },
            child: ClipRect(
              child: Flex(
                direction: widget.direction,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.max.ceil(); i++)
                    MouseRegion(
                      hitTestBehavior: HitTestBehavior.translucent,
                      onHover: (event) {
                        if (widget.onChanged == null) return;
                        double progress =
                            (event.localPosition.dx / starSize).clamp(0.0, 1.0);
                        setState(() {
                          _changingValue = (i + progress);
                        });
                      },
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [
                              widget.activeColor ??
                                  Theme.of(context).colorScheme.primary,
                              widget.backgroundColor ??
                                  Theme.of(context).colorScheme.muted,
                            ],
                            stops: [
                              (roundedValue - i).clamp(0.0, 1.0),
                              (roundedValue - i).clamp(0.0, 1.0),
                            ],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: _buildStar(context),
                      ),
                    ),
                ],
              ).gap(starSpacing),
            ),
          ),
        );
      },
    );
  }
}
