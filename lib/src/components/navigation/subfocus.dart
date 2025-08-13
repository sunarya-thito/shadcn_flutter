import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef SubFocusScopeBuilder = Widget Function(
  BuildContext context,
  SubFocusScopeState state,
);

class SubFocusScope extends StatefulWidget {
  final SubFocusScopeBuilder? builder;
  const SubFocusScope({super.key, this.builder});

  @override
  State<SubFocusScope> createState() => _SubFocusScopeState();
}

mixin SubFocusScopeState {
  void dispatchFocusedCallback();
  void nextFocus([SubFocusDirection direction = SubFocusDirection.down]);
  static SubFocusScopeState? maybeOf(BuildContext context) {
    return Data.maybeOf<SubFocusScopeState>(context);
  }
}

enum SubFocusDirection {
  up,
  down,
  start,
  end,
  left,
  right,
}

class _SubFocusScopeState extends State<SubFocusScope> with SubFocusScopeState {
  final List<_SubFocusState> _attachedStates = [];
  _SubFocusState? _currentState;
  bool _active = true;

  @override
  void activate() {
    super.activate();
    _active = true;
  }

  @override
  void deactivate() {
    _active = false;
    super.deactivate();
  }

  @override
  void dispatchFocusedCallback() {
    _currentState?.dispatchCallback();
  }

  bool _attach(_SubFocusState state) {
    assert(
      !_attachedStates.contains(state),
      'SubFocusState is already attached to this SubFocusScope.',
    );
    _attachedStates.add(state);
    _currentState ??= state;
    return _currentState == state;
  }

  void _detach(SubFocusState state) {
    if (!_attachedStates.contains(state)) return;
    _attachedStates.remove(state);
    if (_currentState == state) {
      _currentState = null;
      findFirstFocus(); // Find new focus
    }
  }

  void _setCurrentItem(_SubFocusState item, bool? forward) {
    if (!mounted) return;
    final currentItem = _currentState;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      currentItem?.markFocused(false);
      item.markFocused(true);
      item.ensureVisible(
        alignmentPolicy: forward == null
            ? ScrollPositionAlignmentPolicy.explicit
            : forward
                ? ScrollPositionAlignmentPolicy.keepVisibleAtEnd
                : ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      );
    });
    _currentState = item;
  }

  RenderBox? findRenderObject() {
    if (!mounted || !_active) {
      return null;
    }
    return context.findRenderObject() as RenderBox?;
  }

  @override
  void nextFocus([SubFocusDirection direction = SubFocusDirection.down]) {
    if (!mounted) return;
    if (_currentState != null) {
      final RenderBox? currentBox = _currentState!.findRenderObject();
      final RenderBox? parentBox = findRenderObject();
      if (currentBox == null || parentBox == null) return;
      final Offset currentOffset =
          currentBox.localToGlobal(Offset.zero, ancestor: parentBox);

      // Determine axis and forwardness from direction (start/end respect RTL)
      final textDirection = Directionality.of(context);
      late final bool horizontal;
      late final bool forward;
      switch (direction) {
        case SubFocusDirection.down:
          horizontal = false;
          forward = true;
          break;
        case SubFocusDirection.up:
          horizontal = false;
          forward = false;
          break;
        case SubFocusDirection.right:
          horizontal = true;
          forward = true;
          break;
        case SubFocusDirection.left:
          horizontal = true;
          forward = false;
          break;
        case SubFocusDirection.start:
          horizontal = true;
          forward = textDirection == TextDirection.rtl;
          break;
        case SubFocusDirection.end:
          horizontal = true;
          forward = textDirection == TextDirection.ltr;
          break;
      }

      (_SubFocusState, double)? nearestNextItem;
      for (final attached in _attachedStates) {
        if (attached == _currentState) continue;
        final RenderBox? box = attached.findRenderObject();
        if (box == null) continue;
        final Offset offset =
            box.localToGlobal(Offset.zero, ancestor: parentBox);
        final double delta = horizontal
            ? (forward
                ? (offset.dx - currentOffset.dx)
                : (currentOffset.dx - offset.dx))
            : (forward
                ? (offset.dy - currentOffset.dy)
                : (currentOffset.dy - offset.dy));
        if (delta <= 0) continue;
        if (nearestNextItem == null || delta < nearestNextItem.$2) {
          nearestNextItem = (attached, delta);
        }
      }
      if (nearestNextItem != null) {
        _setCurrentItem(nearestNextItem.$1, forward);
      }
    }
  }

  void findFirstFocus() {
    // // find the most top left attached render object as a fallback
    // if (!mounted) return;
    // RenderBox? parentBox = findRenderObject();
    // if (parentBox == null) return;
    // (SubFocusState, Offset)? nearestItem; // nearest item to Offset(0, 0)
    // for (final attached in _attachedStates) {
    //   RenderBox? box = attached.findRenderObject();
    //   if (box == null) continue;
    //   Offset offset = box.localToGlobal(Offset.zero, ancestor: parentBox);
    //   if (nearestItem == null || offset.distance < nearestItem.$2.distance) {
    //     nearestItem = (attached, offset);
    //   }
    // }
    // if (nearestItem != null) {
    //   _setCurrentItem(nearestItem.$1, null);
    // }

    // instead of top left, find the most focusCount
    (_SubFocusState, int)? mostItem;
    for (final attached in _attachedStates) {
      if (attached.focusCount > (mostItem?.$2 ?? 0)) {
        mostItem = (attached, attached.focusCount);
      }
    }
    if (mostItem != null) {
      _setCurrentItem(mostItem.$1, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<SubFocusScopeState>.inherit(
      data: this,
      child: widget.builder?.call(context, this),
    );
  }
}

typedef SubFocusBuilder = Widget Function(
  BuildContext context,
  SubFocusState state,
);

class SubFocus extends StatefulWidget {
  final SubFocusBuilder builder;
  final VoidCallback? onSelected;
  const SubFocus({super.key, required this.builder, this.onSelected});

  @override
  State<SubFocus> createState() => _SubFocusState();
}

mixin SubFocusState {
  RenderBox? findRenderObject();
  void ensureVisible({
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  });
  bool get isFocused;
  void requestFocus();
  void dispatchCallback();
  int get focusCount;
}

class _SubFocusState extends State<SubFocus> with SubFocusState {
  _SubFocusScopeState? _scope;
  bool _focused = false;
  bool _active = true;
  int _focusCount = 0;

  @override
  int get focusCount => _focusCount;

  @override
  void activate() {
    super.activate();
    _active = true;
  }

  @override
  void deactivate() {
    _active = false;
    super.deactivate();
  }

  @override
  void dispatchCallback() {
    if (!mounted || !_active) return;
    widget.onSelected?.call();
  }

  @override
  void ensureVisible(
      {ScrollPositionAlignmentPolicy alignmentPolicy =
          ScrollPositionAlignmentPolicy.explicit}) {
    if (!mounted || !_active) return;
    Scrollable.ensureVisible(
      context,
      alignmentPolicy: alignmentPolicy,
    );
  }

  @override
  void requestFocus() {
    if (!mounted || !_active) return;
    if (_scope != null) {
      _scope!._currentState?.markFocused(false);
      _scope!._currentState = this;
      setState(() {
        _focused = true;
      });
    }
  }

  @override
  bool get isFocused => _focused;

  @override
  RenderBox? findRenderObject() {
    if (!mounted || !_active) {
      return null;
    }
    return context.findRenderObject() as RenderBox?;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newScope = Data.maybeOf<SubFocusScopeState>(context);
    if (newScope != _scope) {
      _focusCount = 0;
      _scope?._detach(this);
      _scope = newScope as _SubFocusScopeState?;
      _focused = _scope?._attach(this) ?? false;
    }
  }

  @override
  void dispose() {
    _scope?._detach(this);
    super.dispose();
  }

  void markFocused(bool focus) {
    if (!mounted) return;
    setState(() {
      if (focus) {
        _focusCount++;
      }
      _focused = focus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, this);
  }
}
