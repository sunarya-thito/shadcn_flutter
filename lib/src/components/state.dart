import 'package:shadcn_flutter/shadcn_flutter.dart';

enum WidgetLifecycleState {
  entry,
  exit,
}

typedef LifecycleBuilder = Widget Function(BuildContext context,
    WidgetLifecycleState state, Animation<double> animation);

typedef LifecycleBucketBuilder = Widget Function(
    BuildContext context, List<Widget> children);

class AnimatedLifecycleBucket extends StatefulWidget {
  final List<AnimatedLifecycleWidget> children;
  final LifecycleBucketBuilder builder;

  const AnimatedLifecycleBucket(
      {super.key, required this.children, required this.builder});

  @override
  State<AnimatedLifecycleBucket> createState() =>
      _AnimatedLifecycleBucketState();
}

class _AnimatedLifecycleBucketState extends State<AnimatedLifecycleBucket> {
  late List<_AnimatedLifecycleWidgetData> _children;

  @override
  void initState() {
    super.initState();
    _children = widget.children
        .map((child) => _AnimatedLifecycleWidgetData(widget: child))
        .toList();
  }

  @override
  void didUpdateWidget(covariant AnimatedLifecycleBucket oldWidget) {
    super.didUpdateWidget(oldWidget);
    _children = _updateChildren(_children, widget.children);
  }

  List<_AnimatedLifecycleWidgetData> _updateChildren(
      List<_AnimatedLifecycleWidgetData> oldChildren,
      List<AnimatedLifecycleWidget> newChildren) {
    final result = <_AnimatedLifecycleWidgetData>[];

    final oldChildrenMap = <Key, _AnimatedLifecycleWidgetData>{
      for (var child in oldChildren) child.widget.key: child
    };
    final newChildrenKeys = <Key>{for (var child in newChildren) child.key};

    for (final newChild in newChildren) {
      if (oldChildrenMap.containsKey(newChild.key)) {
        // This is an UPDATE widget.
        result.add(_AnimatedLifecycleWidgetData(
          widget: newChild,
          state: WidgetLifecycleState.entry,
        ));
      } else {
        // This is an ENTRY widget.
        result.add(_AnimatedLifecycleWidgetData(
          widget: newChild,
          state: WidgetLifecycleState.entry,
        ));
      }
    }

    for (int i = oldChildren.length - 1; i >= 0; i--) {
      var oldChildData = oldChildren[i];
      final oldKey = oldChildData.widget.key;

      // If the old child is not in the new list, it's an EXITING widget.
      if (!newChildrenKeys.contains(oldKey)) {
        // Find the widget that came before it in the old list. This is our "anchor".
        Key? anchorKey;
        if (i > 0) {
          anchorKey = oldChildren[i - 1].widget.key;
        }

        // Find the anchor's position in our new `result` list.
        int insertIndex = -1;
        if (anchorKey != null) {
          insertIndex =
              result.indexWhere((data) => data.widget.key == anchorKey);
        }

        // Prepare the exiting widget.
        oldChildData = _AnimatedLifecycleWidgetData(
          widget: oldChildData.widget,
          state: WidgetLifecycleState.exit,
        );

        if (insertIndex != -1) {
          // If we found the anchor, insert the exiting widget right after it.
          result.insert(insertIndex + 1, oldChildData);
        } else {
          // If there was no anchor (meaning the exiting widget was the very
          // first item in the old list), insert it at the beginning of the result.
          result.insert(0, oldChildData);
        }
      }
    }

    return result;
  }

  void _removeChild(Key key) {
    setState(() {
      _children.removeWhere((child) => child.widget.key == key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: this,
      child: widget.builder(
          context,
          _children.map((child) {
            return Data.inherit(
              key: child.widget.key,
              data: child.state,
              child: child.widget,
            );
          }).toList()),
    );
  }
}

class _AnimatedLifecycleWidgetData {
  final AnimatedLifecycleWidget widget;
  final WidgetLifecycleState state;

  _AnimatedLifecycleWidgetData({
    required this.widget,
    this.state = WidgetLifecycleState.entry,
  });
}

class AnimatedLifecycleWidget extends StatefulWidget {
  final LifecycleBuilder builder;
  final Duration duration;

  const AnimatedLifecycleWidget({
    required Key super.key,
    required this.builder,
    this.duration = kDefaultDuration,
  });

  @override
  Key get key => super.key as Key;

  @override
  State<AnimatedLifecycleWidget> createState() =>
      _AnimatedLifecycleWidgetState();
}

class _AnimatedLifecycleWidgetState extends State<AnimatedLifecycleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  WidgetLifecycleState _state = WidgetLifecycleState.exit;
  _AnimatedLifecycleBucketState? _bucketState;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedLifecycleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.duration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newState = Data.of<WidgetLifecycleState>(context);
    _bucketState = Data.of<_AnimatedLifecycleBucketState>(context);
    if (newState != _state) {
      _state = newState;
      if (_state == WidgetLifecycleState.entry) {
        _controller.forward();
      } else if (_state == WidgetLifecycleState.exit) {
        _controller.reverse().then((value) {
          if (mounted) {
            // Notify parent to remove this widget
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _bucketState?._removeChild(widget.key);
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state, _controller);
  }
}
