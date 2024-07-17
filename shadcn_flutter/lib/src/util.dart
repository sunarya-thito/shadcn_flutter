import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

const kDefaultDuration = Duration(milliseconds: 150);

typedef ContextedCallback = void Function(BuildContext context);
typedef ContextedValueChanged<T> = void Function(BuildContext context, T value);

double wrapDouble(double value, double min, double max) {
  final range = max - min;
  if (range == 0) {
    return min;
  }
  return (value - min) % range + min;
}

class WidgetTreeChangeDetector extends StatefulWidget {
  final Widget child;
  final void Function() onWidgetTreeChange;

  const WidgetTreeChangeDetector({
    Key? key,
    required this.child,
    required this.onWidgetTreeChange,
  }) : super(key: key);

  @override
  _WidgetTreeChangeDetectorState createState() =>
      _WidgetTreeChangeDetectorState();
}

class _WidgetTreeChangeDetectorState extends State<WidgetTreeChangeDetector> {
  @override
  void initState() {
    super.initState();
    widget.onWidgetTreeChange();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

Widget gap(double gap, {double? crossGap}) {
  return Gap(
    gap,
    crossAxisExtent: crossGap,
  );
}

extension Joinable on List<Widget> {
  List<Widget> joinSeparator(Widget separator) {
    List<Widget> result = [];
    for (int i = 0; i < length; i++) {
      if (i > 0) {
        result.add(separator);
      }
      result.add(this[i]);
    }
    return result;
  }
}

extension WidgetExtension on Widget {
  Widget sized({double? width, double? height}) {
    if (this is SizedBox) {
      return SizedBox(
        width: width ?? (this as SizedBox).width,
        height: height ?? (this as SizedBox).height,
        child: (this as SizedBox).child,
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  Widget constrained(
      {double? minWidth,
      double? maxWidth,
      double? minHeight,
      double? maxHeight}) {
    if (this is ConstrainedBox) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? (this as ConstrainedBox).constraints.minWidth,
          maxWidth: maxWidth ?? (this as ConstrainedBox).constraints.maxWidth,
          minHeight:
              minHeight ?? (this as ConstrainedBox).constraints.minHeight,
          maxHeight:
              maxHeight ?? (this as ConstrainedBox).constraints.maxHeight,
        ),
        child: (this as ConstrainedBox).child,
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: this,
    );
  }

  // Widget padding({EdgeInsetsGeometry padding = EdgeInsets.zero}) {
  //   return Padding(
  //     padding: padding,
  //     child: this,
  //   );
  // }

  Widget withPadding(
      {double? top,
      double? bottom,
      double? left,
      double? right,
      double? horizontal,
      double? vertical,
      double? all,
      EdgeInsetsGeometry? padding}) {
    assert(() {
      if (all != null) {
        if (top != null ||
            bottom != null ||
            left != null ||
            right != null ||
            horizontal != null ||
            vertical != null) {
          throw FlutterError(
              'All padding properties cannot be used with other padding properties.');
        }
      } else if (horizontal != null) {
        if (left != null || right != null) {
          throw FlutterError(
              'Horizontal padding cannot be used with left or right padding.');
        }
      } else if (vertical != null) {
        if (top != null || bottom != null) {
          throw FlutterError(
              'Vertical padding cannot be used with top or bottom padding.');
        }
      }
      return true;
    }());
    var edgeInsets = EdgeInsets.only(
      top: top ?? vertical ?? all ?? 0,
      bottom: bottom ?? vertical ?? all ?? 0,
      left: left ?? horizontal ?? all ?? 0,
      right: right ?? horizontal ?? all ?? 0,
    );
    return Padding(
      padding: padding ?? edgeInsets,
      child: this,
    );
  }

  Widget withMargin(
      {double? top,
      double? bottom,
      double? left,
      double? right,
      double? horizontal,
      double? vertical,
      double? all}) {
    assert(() {
      if (all != null) {
        if (top != null ||
            bottom != null ||
            left != null ||
            right != null ||
            horizontal != null ||
            vertical != null) {
          throw FlutterError(
              'All margin properties cannot be used with other margin properties.');
        }
      } else if (horizontal != null) {
        if (left != null || right != null) {
          throw FlutterError(
              'Horizontal margin cannot be used with left or right margin.');
        }
      } else if (vertical != null) {
        if (top != null || bottom != null) {
          throw FlutterError(
              'Vertical margin cannot be used with top or bottom margin.');
        }
      }
      return true;
    }());
    return Container(
      margin: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  Widget center({Key? key}) {
    return Center(
      key: key,
      child: this,
    );
  }

  Widget withAlign(AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget positioned(
      {Key? key, double? left, double? top, double? right, double? bottom}) {
    return Positioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget withOpacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  Widget clip({Clip clipBehavior = Clip.hardEdge}) {
    return ClipRect(
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Widget clipRRect(
      {BorderRadius borderRadius = BorderRadius.zero,
      Clip clipBehavior = Clip.antiAlias}) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Widget clipOval({Clip clipBehavior = Clip.antiAlias}) {
    return ClipOval(
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Widget clipPath(
      {Clip clipBehavior = Clip.antiAlias,
      required CustomClipper<Path> clipper}) {
    return ClipPath(
      clipBehavior: clipBehavior,
      clipper: clipper,
      child: this,
    );
  }

  Widget transform({Key? key, required Matrix4 transform}) {
    return Transform(
      key: key,
      transform: transform,
      child: this,
    );
  }

  Widget intrinsicWidth({double? stepWidth, double? stepHeight}) {
    return IntrinsicWidth(
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: this,
    );
  }

  Widget intrinsicHeight() {
    return IntrinsicHeight(
      child: this,
    );
  }

  Widget intrinsic({double? stepWidth, double? stepHeight}) {
    return IntrinsicWidth(
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: IntrinsicHeight(
        child: this,
      ),
    );
  }
}

extension ColumnExtension on Column {
  Widget gap(double gap) {
    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: join(
        children,
        SizedBox(height: gap),
      ).toList(growable: false),
    );
  }

  Widget separator(Widget separator) {
    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: join(
        children,
        separator,
      ).toList(growable: false),
    );
  }
}

extension RowExtension on Row {
  Widget gap(double gap) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: join(
        children,
        SizedBox(width: gap),
      ).toList(growable: false),
    );
  }

  Widget separator(Widget separator) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: join(
        children,
        separator,
      ).toList(growable: false),
    );
  }
}

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

extension DoubleExtension on double {
  double min(double other) => this < other ? this : other;
  double max(double other) => this > other ? this : other;
}

extension IntExtension on int {
  int min(int other) => this < other ? this : other;
  int max(int other) => this > other ? this : other;
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
