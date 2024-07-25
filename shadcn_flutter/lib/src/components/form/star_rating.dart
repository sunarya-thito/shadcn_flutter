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
  final double starSize;
  final double starSpacing;
  final double? starPointRounding;
  final double starValleyRounding;
  final double starSquash;
  final double starInnerRadiusRatio;
  final double starRotation;

  const StarRating({
    Key? key,
    required this.value,
    this.onChanged,
    this.step = 0.5,
    this.direction = Axis.horizontal,
    this.max = 5.0,
    this.activeColor,
    this.backgroundColor,
    this.starPoints = 5,
    this.starSize = 24.0,
    this.starSpacing = 5.0,
    this.starPointRounding,
    this.starValleyRounding = 0.0,
    this.starSquash = 0.0,
    this.starInnerRadiusRatio = 0.4,
    this.starRotation = 0.0,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> with FormValueSupplier {
  double? _changingValue;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(widget.value, (value) {
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    });
  }

  @override
  void didUpdateWidget(covariant StarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      reportNewFormValue(widget.value, (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      });
    }
  }

  Widget _buildStar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: widget.starSize,
      height: widget.starSize,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: StarBorder(
          points: widget.starPoints,
          pointRounding: widget.starPointRounding ?? (theme.radius / 2),
          valleyRounding: widget.starValleyRounding,
          squash: widget.starSquash,
          innerRadiusRatio: widget.starInnerRadiusRatio,
          rotation: widget.starRotation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double roundedValue =
        ((_changingValue ?? widget.value) / widget.step).round() * widget.step;
    double containerWidth = 0;
    double containerHeight = 0;
    if (widget.direction == Axis.horizontal) {
      containerWidth = widget.max * widget.starSize +
          ((widget.max.ceil() - 1) * widget.starSpacing).max(0);
      containerHeight = widget.starSize;
    } else {
      containerWidth = widget.starSize;
      containerHeight = widget.max * widget.starSize +
          ((widget.max.ceil() - 1) * widget.starSpacing).max(0);
    }
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
        child: SizedBox(
          width: containerWidth,
          height: containerHeight,
          child: ClipRect(
            child: Flex(
              direction: widget.direction,
              children: [
                for (var i = 0; i < widget.max.ceil(); i++)
                  MouseRegion(
                    hitTestBehavior: HitTestBehavior.translucent,
                    onHover: (event) {
                      if (widget.onChanged == null) return;
                      double progress =
                          (event.localPosition.dx / widget.starSize)
                              .clamp(0.0, 1.0);
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
            ).gap(widget.starSpacing),
          ),
        ),
      ),
    );
  }
}
