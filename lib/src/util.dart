import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

const kDefaultDuration = Duration(milliseconds: 200);

Iterable<Widget> join(Iterable<Widget> widgets, Widget separator) sync* {
  final iterator = widgets.iterator;
  if (!iterator.moveNext()) {
    return;
  }
  yield iterator.current;
  while (iterator.moveNext()) {
    yield separator;
    yield iterator.current;
  }
}

class AnimatedIconTheme extends ImplicitlyAnimatedWidget {
  final IconThemeData data;
  final Widget child;

  const AnimatedIconTheme({
    Key? key,
    required this.data,
    required this.child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  static Widget merge({
    Key? key,
    required IconThemeData data,
    required Widget child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final iconTheme = IconTheme.of(context);
        return AnimatedIconTheme(
          key: key,
          data: iconTheme.merge(data),
          curve: curve,
          duration: duration,
          onEnd: onEnd,
          child: child,
        );
      },
    );
  }

  @override
  AnimatedWidgetBaseState<AnimatedIconTheme> createState() =>
      _AnimatedIconThemeState();
}

class _AnimatedIconThemeState
    extends AnimatedWidgetBaseState<AnimatedIconTheme> {
  IconThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
            _data,
            widget.data,
            (dynamic value) =>
                IconThemeDataTween(begin: value as IconThemeData))!
        as IconThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<IconThemeDataTween>('data', _data,
        showName: false, defaultValue: null));
  }
}

class IconThemeDataTween extends Tween<IconThemeData> {
  IconThemeDataTween({IconThemeData? begin, IconThemeData? end})
      : super(begin: begin, end: end);

  @override
  IconThemeData lerp(double t) => IconThemeData.lerp(begin, end, t);
}

Widget mergeAnimatedTextStyle({
  Key? key,
  TextStyle? style,
  required Widget child,
  Curve curve = Curves.linear,
  required Duration duration,
  VoidCallback? onEnd,
  TextAlign? textAlign,
  bool? softWrap,
  TextOverflow? overflow,
  int? maxLines,
  TextWidthBasis? textWidthBasis,
}) {
  return Builder(
    builder: (BuildContext context) {
      final defaultTextStyle = DefaultTextStyle.of(context);
      return AnimatedDefaultTextStyle(
        key: key,
        style: defaultTextStyle.style.merge(style),
        textAlign: textAlign ?? defaultTextStyle.textAlign,
        softWrap: softWrap ?? defaultTextStyle.softWrap,
        overflow: overflow ?? defaultTextStyle.overflow,
        maxLines: maxLines ?? defaultTextStyle.maxLines,
        textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
        curve: curve,
        duration: duration,
        onEnd: onEnd,
        child: child,
      );
    },
  );
}
