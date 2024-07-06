import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

const kDefaultDuration = Duration(milliseconds: 150);

double wrapDouble(double value, double min, double max) {
  // loop around the min and max
  // for example, min is 0, and max is 10,
  // then the loop is 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, ...
  // the value then clamped between 0 and 10
  final range = max - min;
  if (range == 0) {
    return min;
  }
  // get the normalized value
  final normalized = (value - min) / range;
  // get the looped value
  final looped = normalized % 1.0;
  // get the clamped value
  return looped * range + min;
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

class ShadcnPopupRoute<T> extends PopupRoute<T> {
  final WidgetBuilder builder;
  final Offset position;
  final Alignment alignment;
  final CapturedThemes themes;
  final Key? key;
  final bool modal;
  final Size? anchorSize;
  final Alignment anchorAlignment;
  final PopupConstraint widthConstraint;
  final PopupConstraint heightConstraint;

  ShadcnPopupRoute({
    required this.builder,
    required this.position,
    required this.alignment,
    required this.themes,
    required this.anchorAlignment,
    this.modal = false,
    this.key,
    this.anchorSize,
    this.widthConstraint = PopupConstraint.flexible,
    this.heightConstraint = PopupConstraint.flexible,
    super.settings,
  }) : super(traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop);

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildModalBarrier() {
    if (modal) {
      return super.buildModalBarrier();
    }
    return Builder(builder: (context) {
      return Listener(
        onPointerDown: (event) {
          Navigator.of(context).pop();
        },
        behavior: HitTestBehavior.translucent,
      );
    });
  }

  void dispatchComplete(T? value) {
    didComplete(value);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return PopupAnchor(
      key: key,
      position: position,
      alignment: alignment,
      themes: themes,
      builder: builder,
      animation: animation,
      anchorSize: anchorSize,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      route: this,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  Duration get reverseTransitionDuration => kDefaultDuration;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0, 2 / 3));
  }
}

class PopupAnchor extends StatefulWidget {
  const PopupAnchor({
    super.key,
    required this.position,
    required this.alignment,
    required this.themes,
    required this.builder,
    required this.animation,
    required this.anchorAlignment,
    this.widthConstraint = PopupConstraint.flexible,
    this.heightConstraint = PopupConstraint.flexible,
    this.anchorSize,
    required this.route,
  });

  final Offset position;
  final Alignment alignment;
  final Alignment anchorAlignment;
  final CapturedThemes themes;
  final WidgetBuilder builder;
  final Size? anchorSize;
  final Animation<double> animation;
  final PopupConstraint widthConstraint;
  final PopupConstraint heightConstraint;
  final ShadcnPopupRoute route;

  @override
  State<PopupAnchor> createState() => PopupAnchorState();
}

enum PopupConstraint {
  flexible,
  anchorFixedSize,
  anchorMinSize,
  anchorMaxSize,
}

class PopupLayoutDelegate extends SingleChildLayoutDelegate {
  static const double _margin = 8;
  final Alignment alignment;
  final Alignment anchorAlignment;
  final Offset position;
  final Size? anchorSize;
  final PopupConstraint widthConstraint;
  final PopupConstraint heightConstraint;

  PopupLayoutDelegate({
    required this.alignment,
    required this.position,
    required this.anchorAlignment,
    required this.widthConstraint,
    required this.heightConstraint,
    this.anchorSize,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double minWidth = 0;
    double maxWidth = constraints.maxWidth;
    double minHeight = 0;
    double maxHeight = constraints.maxHeight;
    if (widthConstraint == PopupConstraint.anchorFixedSize) {
      minWidth = anchorSize!.width;
      maxWidth = anchorSize!.width;
    } else if (widthConstraint == PopupConstraint.anchorMinSize) {
      minWidth = anchorSize!.width;
    } else if (widthConstraint == PopupConstraint.anchorMaxSize) {
      maxWidth = anchorSize!.width;
    }
    if (heightConstraint == PopupConstraint.anchorFixedSize) {
      minHeight = anchorSize!.height;
      maxHeight = anchorSize!.height;
    } else if (heightConstraint == PopupConstraint.anchorMinSize) {
      minHeight = anchorSize!.height;
    } else if (heightConstraint == PopupConstraint.anchorMaxSize) {
      maxHeight = anchorSize!.height;
    }
    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // make sure the popup is within the size (with a margin of 8)
    double x =
        position.dx - childSize.width / 2 - (childSize.width / 2 * alignment.x);
    double y = position.dy -
        childSize.height / 2 -
        (childSize.height / 2 * alignment.y);
    double left = x - _margin;
    double top = y - _margin;
    double right = x + childSize.width + _margin;
    double bottom = y + childSize.height + _margin;
    if (left < 0 || right > size.width) {
      x = position.dx -
          childSize.width / 2 -
          (childSize.width / 2 * -alignment.x);
      if (anchorSize != null) {
        x -= anchorSize!.width * anchorAlignment.x;
      }
      left = x - _margin;
      right = x + childSize.width + _margin;
    }
    if (top < 0 || bottom > size.height) {
      y = position.dy -
          childSize.height / 2 -
          (childSize.height / 2 * -alignment.y);
      if (anchorSize != null) {
        y -= anchorSize!.height * anchorAlignment.y;
      }
      top = y - _margin;
      bottom = y + childSize.height + _margin;
    }
    final double dx = left < 0
        ? -left
        : right > size.width
            ? size.width - right
            : 0;
    final double dy = top < 0
        ? -top
        : bottom > size.height
            ? size.height - bottom
            : 0;
    return Offset(x + dx, y + dy);
  }

  @override
  bool shouldRelayout(covariant PopupLayoutDelegate oldDelegate) {
    return oldDelegate.alignment != alignment ||
        oldDelegate.position != position ||
        oldDelegate.anchorSize != anchorSize;
  }
}

class PopupAnchorState extends State<PopupAnchor> {
  // late ValueNotifier<Offset> _position;
  late Offset _position;
  late Alignment _alignment;
  late Alignment _anchorAlignment;
  late PopupConstraint _widthConstraint;
  late PopupConstraint _heightConstraint;
  Size? _anchorSize;

  @override
  void initState() {
    super.initState();
    _position = widget.position;
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
  }

  void close() {
    // Navigator.of(context).pop();
    // check if the widget is still mounted
    if (mounted) {
      // Navigator.of(context).removeRoute(widget.route);
      // use pop until
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).removeRoute(widget.route);
        widget.route.dispatchComplete(null);
      });
    }
  }

  @override
  void didUpdateWidget(covariant PopupAnchor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.position != widget.position) {
      _position = widget.position;
    }
    if (oldWidget.alignment != widget.alignment) {
      _alignment = widget.alignment;
    }
    if (oldWidget.anchorSize != widget.anchorSize) {
      _anchorSize = widget.anchorSize;
    }
    if (oldWidget.anchorAlignment != widget.anchorAlignment) {
      _anchorAlignment = widget.anchorAlignment;
    }
    if (oldWidget.widthConstraint != widget.widthConstraint) {
      _widthConstraint = widget.widthConstraint;
    }
    if (oldWidget.heightConstraint != widget.heightConstraint) {
      _heightConstraint = widget.heightConstraint;
    }
  }

  Size? get anchorSize => _anchorSize;
  Alignment get anchorAlignment => _anchorAlignment;
  Offset get position => _position;
  Alignment get alignment => _alignment;
  PopupConstraint get widthConstraint => _widthConstraint;
  PopupConstraint get heightConstraint => _heightConstraint;

  set position(Offset value) {
    if (_position != value) {
      setState(() {
        _position = value;
      });
    }
  }

  set alignment(Alignment value) {
    if (_alignment != value) {
      setState(() {
        _alignment = value;
      });
    }
  }

  set anchorSize(Size? value) {
    if (_anchorSize != value) {
      setState(() {
        _anchorSize = value;
      });
    }
  }

  set anchorAlignment(Alignment value) {
    if (_anchorAlignment != value) {
      setState(() {
        _anchorAlignment = value;
      });
    }
  }

  set widthConstraint(PopupConstraint value) {
    if (_widthConstraint != value) {
      setState(() {
        _widthConstraint = value;
      });
    }
  }

  set heightConstraint(PopupConstraint value) {
    if (_heightConstraint != value) {
      setState(() {
        _heightConstraint = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: PopupLayoutDelegate(
        alignment: _alignment,
        position: _position,
        anchorSize: _anchorSize,
        anchorAlignment: _anchorAlignment,
        widthConstraint: _widthConstraint,
        heightConstraint: _heightConstraint,
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        removeTop: true,
        child: Builder(builder: (context) {
          return FadeTransition(
            opacity: widget.animation,
            child: ScaleTransition(
              alignment: _anchorAlignment,
              scale:
                  Tween<double>(begin: 0.9, end: 1).animate(widget.animation),
              child: widget.themes.wrap(widget.builder(context)),
            ),
          );
        }),
      ),
    );
  }
}

Future<T?> showPopup<T>({
  required BuildContext context,
  required Offset position,
  required Alignment alignment,
  required WidgetBuilder builder,
  Alignment? anchorAlignment,
  PopupConstraint widthConstraint = PopupConstraint.flexible,
  PopupConstraint heightConstraint = PopupConstraint.flexible,
  Size? anchorSize,
  Key? key,
  bool useRootNavigator = true,
  bool modal = true,
  Clip clipBehavior = Clip.none,
  RouteSettings? routeSettings,
}) {
  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);
  final CapturedThemes themes =
      InheritedTheme.capture(from: context, to: navigator.context);
  return navigator.push(ShadcnPopupRoute(
    key: key,
    builder: builder,
    position: position,
    alignment: alignment,
    themes: themes,
    modal: modal,
    settings: routeSettings,
    anchorSize: anchorSize,
    anchorAlignment: anchorAlignment ?? alignment * -1,
    widthConstraint: widthConstraint,
    heightConstraint: heightConstraint,
  ));
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
