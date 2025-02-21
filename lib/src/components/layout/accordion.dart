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
    final accTheme = ComponentTheme.maybeOf<AccordionTheme>(context);
    return Data.inherit(
        data: this,
        child: IntrinsicWidth(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...join(
                    widget.items,
                    Container(
                      color: theme.colorScheme.muted,
                      height: accTheme?.dividerHeight ?? 1 * scaling,
                    )),
                const Divider(),
              ]),
        ));
  }
}

/// {@template accordion_theme}
/// Styling options for [AccordionItem], [AccordionTrigger] and [Accordion].
/// {@endtemplate}
class AccordionTheme {
  /// Duration of the collapse/expand animation.
  final Duration? duration;

  /// Curve of the animation (played when expanding).
  final Curve? curve;

  /// Reverse curve of the animation (played when collapsing).
  final Curve? reverseCurve;

  /// The gap between the trigger and the content (or other triggers if collapsed).
  ///
  /// The padding is applied to the top and bottom of the trigger.
  final double? padding;

  /// The gap between the trigger text and the icon.
  final double? iconGap;

  /// The height of the divider between each item.
  final double? dividerHeight;

  /// The color of the divider between each item.
  final Color? dividerColor;

  /// The icon to display at the end of the trigger.
  ///
  /// This icon is rotated 180 degrees when the item is expanded.
  final IconData? arrowIcon;

  /// The color of the arrow icon.
  final Color? arrowIconColor;

  /// {@macro accordion_theme}
  const AccordionTheme({
    this.duration,
    this.curve,
    this.reverseCurve,
    this.padding,
    this.iconGap,
    this.dividerHeight,
    this.dividerColor,
    this.arrowIcon,
    this.arrowIconColor,
  });

  /// Creates a copy of this theme and replaces the given properties.
  ///
  /// {@macro accordion_theme}
  AccordionTheme copyWith({
    Duration? duration,
    Curve? curve,
    Curve? reverseCurve,
    double? padding,
    double? iconGap,
    double? dividerHeight,
    Color? dividerColor,
    IconData? arrowIcon,
    Color? arrowIconColor,
  }) {
    return AccordionTheme(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      padding: padding ?? this.padding,
      iconGap: iconGap ?? this.iconGap,
      dividerHeight: dividerHeight ?? this.dividerHeight,
      dividerColor: dividerColor ?? this.dividerColor,
      arrowIcon: arrowIcon ?? this.arrowIcon,
      arrowIconColor: arrowIconColor ?? this.arrowIconColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AccordionTheme &&
      duration == other.duration &&
      curve == other.curve &&
      reverseCurve == other.reverseCurve &&
      padding == other.padding &&
      iconGap == other.iconGap &&
      dividerHeight == other.dividerHeight &&
      dividerColor == other.dividerColor &&
      arrowIcon == other.arrowIcon &&
      arrowIconColor == other.arrowIconColor;

  @override
  int get hashCode => Object.hash(
        duration,
        curve,
        reverseCurve,
        padding,
        iconGap,
        dividerHeight,
        dividerColor,
        arrowIcon,
        arrowIconColor,
      );

  @override
  String toString() {
    return 'AccordionTheme(duration: $duration, curve: $curve, reverseCurve: $reverseCurve, padding: $padding, iconGap: $iconGap, dividerHeight: $dividerHeight, dividerColor: $dividerColor, arrowIcon: $arrowIcon, arrorIconColor: $arrowIconColor)';
  }
}

class AccordionItem extends StatefulWidget {
  final Widget trigger;
  final Widget content;
  final bool expanded;

  const AccordionItem({
    super.key,
    required this.trigger,
    required this.content,
    this.expanded = false,
  });

  @override
  State<AccordionItem> createState() => _AccordionItemState();
}

class _AccordionItemState extends State<AccordionItem>
    with SingleTickerProviderStateMixin {
  _AccordionState? accordion;
  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  AnimationController? _controller;
  CurvedAnimation? _easeInAnimation;
  AccordionTheme? _theme;

  @override
  void initState() {
    super.initState();
    _expanded.value = widget.expanded;
    _updateAnimations();
  }

  void _updateAnimations() {
    _controller?.dispose();
    _controller = AnimationController(
      vsync: this,
      duration: _theme?.duration ?? const Duration(milliseconds: 200),
      value: _expanded.value ? 1 : 0,
    );
    _easeInAnimation = CurvedAnimation(
      parent: _controller!,
      curve: _theme?.curve ?? Curves.easeIn,
      reverseCurve: _theme?.reverseCurve ?? Curves.easeOut,
    );
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

    final theme = ComponentTheme.maybeOf<AccordionTheme>(context);

    if (_theme != theme) {
      _theme = theme;
      _updateAnimations();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    accordion?._expanded.removeListener(_onExpandedChanged);
    super.dispose();
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
    _controller?.forward();
    _expanded.value = true;
  }

  void _collapse() {
    _controller?.reverse();
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
            widget.trigger,
            SizeTransition(
              sizeFactor: _easeInAnimation!,
              axisAlignment: -1,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: _theme?.padding ?? 16 * scaling,
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
    final accTheme = ComponentTheme.maybeOf<AccordionTheme>(context);
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
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _focusing
                  ? theme.colorScheme.ring
                  : theme.colorScheme.ring.withValues(alpha: 0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(theme.radiusXs),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: accTheme?.padding ?? 16 * scaling,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: DefaultTextStyle.merge(
                      style: TextStyle(
                        decoration: _hovering
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                      child: widget.child,
                    ),
                  ),
                ),
                SizedBox(width: accTheme?.iconGap ?? 18 * scaling),
                TweenAnimationBuilder(
                    tween: _expanded
                        ? Tween(begin: 1.0, end: 0)
                        : Tween(begin: 0, end: 1.0),
                    duration: accTheme?.duration ?? kDefaultDuration,
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value * pi,
                        child: IconTheme(
                          data: IconThemeData(
                            color: accTheme?.arrowIconColor ??
                                theme.colorScheme.mutedForeground,
                          ),
                          child: Icon(accTheme?.arrowIcon ??
                                  Icons.keyboard_arrow_up)
                              .iconMedium(),
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
