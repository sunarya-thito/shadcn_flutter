import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Accordion extends StatefulWidget {
  final List<Widget> items;

  const Accordion({Key? key, required this.items}) : super(key: key);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  final ValueNotifier<_AccordionItemState?> _expanded = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Data(
        data: this,
        child: IntrinsicWidth(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ...join(
                    widget.items,
                    AnimatedContainer(
                      duration: kDefaultDuration,
                      color: Theme.of(context).colorScheme.muted,
                      height: 1,
                    )).toList(),
                const Divider(),
              ]),
        ));
  }
}

class AccordionItem extends StatefulWidget {
  final Widget trigger;
  final Widget content;
  final bool expanded;

  const AccordionItem(
      {Key? key,
      required this.trigger,
      required this.content,
      this.expanded = false})
      : super(key: key);

  @override
  State<AccordionItem> createState() => _AccordionItemState();
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
      duration: Duration(milliseconds: 200),
      value: _expanded.value ? 1 : 0,
    );
    _easeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
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
    return Data(
      data: this,
      child: GestureDetector(
        child: Column(
          children: [
            widget.trigger,
            SizeTransition(
              sizeFactor: _easeInAnimation,
              axisAlignment: -1,
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: widget.content,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccordionTrigger extends StatefulWidget {
  final Widget child;

  const AccordionTrigger({Key? key, required this.child}) : super(key: key);

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
    var themeData = Theme.of(context);
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
        child: AnimatedContainer(
          duration: kDefaultDuration,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  _focusing ? themeData.colorScheme.ring : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(themeData.radiusXs),
          ),
          child: mergeAnimatedTextStyle(
            duration: kDefaultDuration,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: UnderlineText(
                              underline: _hovering, child: widget.child))),
                  const SizedBox(width: 18),
                  TweenAnimationBuilder(
                      tween: _expanded
                          ? Tween(begin: 1.0, end: 0)
                          : Tween(begin: 0, end: 1.0),
                      duration: kDefaultDuration,
                      builder: (context, value, child) {
                        return Transform.rotate(
                          angle: value * pi,
                          child: AnimatedIconTheme(
                            duration: kDefaultDuration,
                            data: IconThemeData(
                              color: themeData.colorScheme.mutedForeground,
                            ),
                            child: Icon(Icons.keyboard_arrow_up,
                                // color:
                                //     Theme.of(context).colorScheme.mutedForeground,
                                size: 18),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
