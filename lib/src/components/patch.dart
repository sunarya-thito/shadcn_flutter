import 'package:shadcn_flutter/shadcn_flutter.dart';

class ClickDetails {
  final int clickCount;

  const ClickDetails({required this.clickCount});
}

typedef ClickCallback<T> = void Function(T details);

class ClickDetector extends StatefulWidget {
  final ClickCallback<ClickDetails>? onClick;
  final Widget child;
  final HitTestBehavior behavior;
  final Duration threshold;

  const ClickDetector({
    super.key,
    this.onClick,
    required this.child,
    this.behavior = HitTestBehavior.deferToChild,
    this.threshold = const Duration(milliseconds: 300),
  });

  @override
  State<ClickDetector> createState() => _ClickDetectorState();
}

class _ClickDetectorState extends State<ClickDetector> {
  DateTime? lastClick;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onClick == null
          ? null
          : () {
              var now = DateTime.now();
              if (lastClick == null ||
                  (now.difference(lastClick!) > widget.threshold)) {
                count = 1;
              } else {
                count++;
              }
              widget.onClick?.call(ClickDetails(clickCount: count));
              lastClick = now;
            },
      child: widget.child,
    );
  }
}
