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
  final double starPointRounding;
  final double starValleyRounding;
  final double starSquash;
  final double starInnerRadiusRatio;
  final double starRotation;

  const StarRating({
    Key? key,
    required this.value,
    required this.onChanged,
    this.step = 0.5,
    this.direction = Axis.horizontal,
    this.max = 5.0,
    this.activeColor,
    this.backgroundColor,
    this.starPoints = 5,
    this.starSize = 10.0,
    this.starSpacing = 5.0,
    this.starPointRounding = 0.0,
    this.starValleyRounding = 0.0,
    this.starSquash = 0.0,
    this.starInnerRadiusRatio = 0.0,
    this.starRotation = 0.0,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> with FormValueSupplier {
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
    return Container(
      width: widget.starSize,
      height: widget.starSize,
      decoration: ShapeDecoration(
        shape: StarBorder(
          points: widget.starPoints,
          pointRounding: widget.starPointRounding,
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
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            widget.backgroundColor ?? Colors.gray,
            widget.activeColor ?? Colors.yellow,
          ],
          stops: [widget.value / widget.max, widget.value / widget.max],
        ).createShader(bounds);
      },
      child: SizedBox(
        width: containerWidth,
        height: containerHeight,
        child: ClipRect(
          child: OverflowBox(
            maxWidth: containerHeight,
            maxHeight: containerHeight,
            child: Flex(
              direction: widget.direction,
              children: [
                for (var i = 0; i < widget.max.ceil(); i++)
                  GestureDetector(
                    onTap: () {
                      widget.onChanged?.call(i + 1);
                    },
                    child: _buildStar(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
