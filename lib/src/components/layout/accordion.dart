import 'dart:math';

import 'package:flutter/services.dart';

import '../../../shadcn_flutter.dart';

class Accordion extends StatefulWidget {
  final List<Widget> items;

  const Accordion({super.key, required this.items});

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  final ValueNotifier<_AccordionItemState?> _expanded = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final accTheme = ComponentTheme.maybeOf<AccordionTheme>(context) ??
        const AccordionTheme();
    return Data.inherit(
        data: this,
        child: IntrinsicWidth(
          child: ComponentTheme(
            data: accTheme,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...join(widget.items.map((item) {
                    return item is AccordionItem
                        ? item._applyTheme(accTheme)
                        : item;
                  }),
                      ShadcnAnimatedContainer(
                        duration: kDefaultDuration,
                        color: theme.colorScheme.muted,
                        height: 1 * scaling,
                      )),
                  const Divider(),
                ]),
          ),
        ));
  }
}

/// Theme data for [AccordionItem].
class AccordionTheme {
  /// Duration of the collapse/expand animation.
  final Duration duration;

  /// Curve of the animation (played when expanding).
  final Curve curve;

  /// Reverse curve of the animation (played when collapsing).
  final Curve reverseCurve;

  /// The gap between the trigger and the content (or other triggers if collapsed).
  ///
  /// The padding is applied to the top and bottom of the trigger.
  final double padding;

  /// The gap between the trigger text and the icon.
  final double iconGap;

  /// Theme data for [AccordionItem].
  const AccordionTheme({
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeIn,
    this.reverseCurve = Curves.easeOut,
    this.padding = 16,
    this.iconGap = 18,
  });

  /// Creates a copy of this theme and replaces the given properties.
  AccordionTheme copyWith({
    Duration? duration,
    Curve? curve,
    Curve? reverseCurve,
    double? padding,
    double? iconGap,
  }) {
    return AccordionTheme(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      padding: padding ?? this.padding,
      iconGap: iconGap ?? this.iconGap,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AccordionTheme &&
      duration == other.duration &&
      curve == other.curve &&
      reverseCurve == other.reverseCurve &&
      padding == other.padding &&
      iconGap == other.iconGap;

  @override
  int get hashCode => Object.hash(
        duration,
        curve,
        reverseCurve,
        padding,
        iconGap,
      );

  @override
  String toString() {
    return 'AccordionTheme(duration: $duration, curve: $curve, reverseCurve: $reverseCurve, padding: $padding, iconGap: $iconGap)';
  }
}

class AccordionItem extends StatefulWidget {
  final Widget trigger;
  final Widget content;
  final bool expanded;
  final AccordionTheme theme;

  const AccordionItem({
    super.key,
    required this.trigger,
    required this.content,
    this.expanded = false,
  }) : theme = const AccordionTheme();

  const AccordionItem._({
    super.key,
    required this.trigger,
    required this.content,
    required this.expanded,
    required this.theme,
  });

  @override
  State<AccordionItem> createState() => _AccordionItemState();

  /// Creates a copy of this item and replaces the theme.
  AccordionItem _applyTheme(AccordionTheme theme) {
    return AccordionItem._(
      key: key,
      trigger: trigger,
      content: content,
      expanded: expanded,
      theme: theme,
    );
  }
}

class _AccordionItemState extends State<AccordionItem>
    with SingleTickerProviderStateMixin {
  _AccordionState? accordion;
  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  late AnimationController _controller;
  late CurvedAnimation _easeInAnimation;

  @override
  void initState() {
    super.initState();
    // _expanded = widget.expanded;
    _expanded.value = widget.expanded;
    _controller = AnimationController(
      vsync: this,
      duration: widget.theme.duration,
      value: _expanded.value ? 1 : 0,
    );
    _easeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.theme.curve,
      reverseCurve: widget.theme.reverseCurve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    accordion?._expanded.removeListener(_onExpandedChanged);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _AccordionState newAccordion = Data.of<_AccordionState>(context);
    if (newAccordion != accordion) {
      accordion?._expanded.removeListener(_onExpandedChanged);
      newAccordion._expanded.addListener(_onExpandedChanged);
      accordion = newAccordion;
    }
  }

  void _onExpandedChanged() {
    if (_expanded.value != (accordion?._expanded.value == this)) {
      _expanded.value = !_expanded.value;
      if (_expanded.value) {
        _expand();
      } else {
        _collapse();
      }
    }
  }

  void _expand() {
    _controller.forward();
    // _expanded = true;
    _expanded.value = true;
  }

  void _collapse() {
    _controller.reverse();
    // _expanded = false;
    _expanded.value = false;
  }

  void _dispatchToggle() {
    if (accordion?._expanded.value == this) {
      accordion?._expanded.value = null;
    } else {
      accordion?._expanded.value = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Data.inherit(
      data: this,
      child: GestureDetector(
        child: Column(
          children: [
            SizeTransition(
              sizeFactor: _easeInAnimation,
              axisAlignment: -1,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: widget.theme.padding * scaling,
                ),
                child: widget.content,
              ).small().normal(),
            ),
          ],
        ),
      ),
    );
  }
}

class AccordionTrigger extends StatefulWidget {
  final Widget child;

  const AccordionTrigger({super.key, required this.child});

  @override
  State<AccordionTrigger> createState() => _AccordionTriggerState();
}

class _AccordionTriggerState extends State<AccordionTrigger> {
  bool _expanded = false;
  bool _hovering = false;
  bool _focusing = false;
  _AccordionItemState? _item;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _AccordionItemState newItem = Data.of<_AccordionItemState>(context);
    if (newItem != _item) {
      _item?._expanded.removeListener(_onExpandedChanged);
      newItem._expanded.addListener(_onExpandedChanged);
      _item = newItem;
    }
  }

  void _onExpandedChanged() {
    if (_expanded != _item?._expanded.value) {
      setState(() {
        _expanded = _item?._expanded.value ?? false;
      });
    }
  }

  @override
  void dispose() {
    _item?._expanded.removeListener(_onExpandedChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final accTheme = ComponentTheme.maybeOf<AccordionTheme>(context) ??
        const AccordionTheme();
    final scaling = theme.scaling;
    return GestureDetector(
      onTap: () {
        _item?._dispatchToggle();
      },
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowFocusHighlight: (value) {
          setState(() {
            _focusing = value;
          });
        },
        actions: {
          ActivateIntent: CallbackAction(
            onInvoke: (Intent intent) {
              _item?._dispatchToggle();
              return true;
            },
          ),
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        onShowHoverHighlight: (value) {
          setState(() {
            _hovering = value;
          });
        },
        child: ShadcnAnimatedContainer(
          duration: kDefaultDuration,
          decoration: BoxDecoration(
            border: Border.all(
              color: _focusing
                  ? theme.colorScheme.ring
                  : theme.colorScheme.ring.withOpacity(0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(theme.radiusXs),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: accTheme.padding * scaling),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: UnderlineText(
                        underline: _hovering, child: widget.child),
                  ),
                ),
                SizedBox(width: accTheme.iconGap * scaling),
                TweenAnimationBuilder(
                    tween: _expanded
                        ? Tween(begin: 1.0, end: 0)
                        : Tween(begin: 0, end: 1.0),
                    duration: accTheme.duration,
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value * pi,
                        child: AnimatedIconTheme(
                          duration: accTheme.duration,
                          data: IconThemeData(
                            color: theme.colorScheme.mutedForeground,
                          ),
                          child:
                              const Icon(Icons.keyboard_arrow_up).iconMedium(),
                        ),
                      );
                    }),
              ],
            ),
          ).medium().small(),
        ),
      ),
    );
  }
}
