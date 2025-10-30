import 'dart:math';

import 'package:flutter/services.dart';

import '../../../shadcn_flutter.dart';

/// A container widget that displays a list of collapsible items with only one item expanded at a time.
///
/// [Accordion] implements the classic accordion UI pattern where clicking on one item
/// expands it while automatically collapsing any other expanded items. This ensures
/// only one section is visible at a time, making it ideal for organizing related
/// information in a compact, scannable format.
///
/// ## Key Features
/// - **Single Expansion**: Only one accordion item can be expanded at a time
/// - **Visual Separation**: Automatic dividers between accordion items
/// - **Smooth Animation**: Configurable expand/collapse animations
/// - **Accessibility**: Full keyboard navigation and screen reader support
/// - **Theming**: Comprehensive theming via [AccordionTheme]
///
/// ## Usage Pattern
/// An accordion consists of multiple [AccordionItem] widgets, each containing:
/// - [AccordionTrigger]: The clickable header that shows/hides content
/// - Content: The collapsible content area revealed when expanded
///
/// The accordion automatically manages state to ensure mutual exclusion of expanded items.
///
/// Example:
/// ```dart
/// Accordion(
///   items: [
///     AccordionItem(
///       trigger: AccordionTrigger(
///         child: Text('Section 1'),
///       ),
///       content: Text('Content for section 1...'),
///     ),
///     AccordionItem(
///       trigger: AccordionTrigger(
///         child: Text('Section 2'),
///       ),
///       content: Text('Content for section 2...'),
///       expanded: true, // Initially expanded
///     ),
///   ],
/// );
/// ```
class Accordion extends StatefulWidget {
  /// The list of accordion items to display.
  ///
  /// Each item should be an [AccordionItem] widget containing a trigger and content.
  /// The accordion automatically adds visual dividers between items and manages
  /// the expansion state to ensure only one item can be expanded at a time.
  final List<Widget> items;

  /// Creates an [Accordion] widget with the specified items.
  ///
  /// Parameters:
  /// - [items] (`List<Widget>`, required): List of [AccordionItem] widgets to display.
  ///
  /// The accordion automatically handles:
  /// - State management for mutual exclusion of expanded items
  /// - Visual dividers between items
  /// - Animation coordination between items
  /// - Proper accessibility semantics
  ///
  /// Example:
  /// ```dart
  /// Accordion(
  ///   items: [
  ///     AccordionItem(
  ///       trigger: AccordionTrigger(child: Text('FAQ 1')),
  ///       content: Text('Answer to first question...'),
  ///     ),
  ///     AccordionItem(
  ///       trigger: AccordionTrigger(child: Text('FAQ 2')),
  ///       content: Text('Answer to second question...'),
  ///     ),
  ///   ],
  /// );
  /// ```
  const Accordion({super.key, required this.items});

  @override
  AccordionState createState() => AccordionState();
}

/// State class for [Accordion] widget.
///
/// Manages the expansion state of accordion items, ensuring only one
/// item can be expanded at a time in single-expansion mode.
class AccordionState extends State<Accordion> {
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

/// Theme configuration for [Accordion], [AccordionItem], and [AccordionTrigger] widgets.
///
/// [AccordionTheme] provides comprehensive styling options for all accordion-related
/// widgets, including animation timing, spacing, colors, and iconography. It allows
/// for consistent accordion styling across an application while still permitting
/// per-instance customization.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<AccordionTheme>(
///   data: AccordionTheme(
///     duration: Duration(milliseconds: 300),
///     curve: Curves.easeInOut,
///     padding: 20.0,
///     arrowIcon: Icons.expand_more,
///     arrowIconColor: Colors.blue,
///   ),
///   child: MyAccordionWidget(),
/// );
/// ```
class AccordionTheme {
  /// Duration of the expand/collapse animation.
  ///
  /// Controls how long it takes for accordion items to animate between
  /// expanded and collapsed states. If null, defaults to 200 milliseconds.
  final Duration? duration;

  /// Animation curve used when expanding accordion items.
  ///
  /// Defines the easing function applied during expansion animations.
  /// If null, defaults to [Curves.easeIn].
  final Curve? curve;

  /// Animation curve used when collapsing accordion items.
  ///
  /// Defines the easing function applied during collapse animations.
  /// If null, defaults to [Curves.easeOut].
  final Curve? reverseCurve;

  /// Vertical padding applied to accordion triggers and content.
  ///
  /// Controls the space above and below trigger text and between triggers
  /// and content. If null, defaults to 16 logical pixels scaled by theme.
  final double? padding;

  /// Horizontal spacing between trigger text and the expand/collapse icon.
  ///
  /// Controls the gap between the trigger content and the arrow icon.
  /// If null, defaults to 18 logical pixels scaled by theme.
  final double? iconGap;

  /// Height of divider lines between accordion items.
  ///
  /// Controls the thickness of the visual separators between accordion items.
  /// If null, defaults to 1 logical pixel scaled by theme.
  final double? dividerHeight;

  /// Color of divider lines between accordion items.
  ///
  /// If null, uses the muted color from the theme color scheme.
  final Color? dividerColor;

  /// Icon displayed in the trigger to indicate expand/collapse state.
  ///
  /// This icon is rotated 180 degrees when transitioning between states.
  /// If null, defaults to [Icons.keyboard_arrow_up].
  final IconData? arrowIcon;

  /// Color of the expand/collapse arrow icon.
  ///
  /// If null, uses the muted foreground color from the theme color scheme.
  final Color? arrowIconColor;

  /// Creates an [AccordionTheme] with the specified styling options.
  ///
  /// All parameters are optional and will fall back to component defaults
  /// when not specified.
  ///
  /// Parameters:
  /// - [duration] (Duration?, optional): Animation duration for expand/collapse.
  /// - [curve] (Curve?, optional): Easing curve for expansion animation.
  /// - [reverseCurve] (Curve?, optional): Easing curve for collapse animation.
  /// - [padding] (double?, optional): Vertical padding for triggers and content.
  /// - [iconGap] (double?, optional): Space between trigger text and icon.
  /// - [dividerHeight] (double?, optional): Thickness of item dividers.
  /// - [dividerColor] (Color?, optional): Color of item dividers.
  /// - [arrowIcon] (IconData?, optional): Icon for expand/collapse indicator.
  /// - [arrowIconColor] (Color?, optional): Color of the arrow icon.
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

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   duration: () => Duration(milliseconds: 400),
  ///   curve: () => Curves.bounceOut,
  /// );
  /// ```
  AccordionTheme copyWith({
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<Curve?>? reverseCurve,
    ValueGetter<double?>? padding,
    ValueGetter<double?>? iconGap,
    ValueGetter<double?>? dividerHeight,
    ValueGetter<Color?>? dividerColor,
    ValueGetter<IconData?>? arrowIcon,
    ValueGetter<Color?>? arrowIconColor,
  }) {
    return AccordionTheme(
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      reverseCurve: reverseCurve == null ? this.reverseCurve : reverseCurve(),
      padding: padding == null ? this.padding : padding(),
      iconGap: iconGap == null ? this.iconGap : iconGap(),
      dividerHeight:
          dividerHeight == null ? this.dividerHeight : dividerHeight(),
      dividerColor: dividerColor == null ? this.dividerColor : dividerColor(),
      arrowIcon: arrowIcon == null ? this.arrowIcon : arrowIcon(),
      arrowIconColor:
          arrowIconColor == null ? this.arrowIconColor : arrowIconColor(),
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

/// An individual item within an [Accordion] that can be expanded or collapsed.
///
/// [AccordionItem] represents a single section within an accordion, containing
/// both a trigger (the clickable header) and the collapsible content area. It
/// manages its own animation state and coordinates with the parent [Accordion]
/// to implement the mutual exclusion behavior.
///
/// ## Key Features
/// - **Smooth Animation**: Configurable size transition animations
/// - **State Coordination**: Automatic integration with parent accordion state
/// - **Flexible Content**: Supports any widget as trigger or content
/// - **Initial State**: Can start expanded or collapsed
///
/// The item automatically handles expansion/collapse animations and coordinates
/// with its parent accordion to ensure only one item can be expanded at a time.
///
/// Example:
/// ```dart
/// AccordionItem(
///   expanded: true, // Start expanded
///   trigger: AccordionTrigger(
///     child: Row(
///       children: [
///         Icon(Icons.help_outline),
///         SizedBox(width: 8),
///         Text('Frequently Asked Question'),
///       ],
///     ),
///   ),
///   content: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('This is the detailed answer to the question...'),
///   ),
/// );
/// ```
class AccordionItem extends StatefulWidget {
  /// The clickable header widget that controls expansion.
  ///
  /// Typically an [AccordionTrigger] widget, but can be any widget that
  /// provides user interaction. The trigger is always visible and clicking
  /// it toggles the expansion state of the item.
  final Widget trigger;

  /// The collapsible content widget revealed when expanded.
  ///
  /// This content is hidden when the item is collapsed and smoothly animated
  /// into view when expanded. Can contain any widget content including text,
  /// images, forms, or other complex UI elements.
  final Widget content;

  /// Whether this item should start in the expanded state.
  ///
  /// When true, the item begins expanded and its content is immediately visible.
  /// Only one item in an accordion should typically start expanded.
  final bool expanded;

  /// Creates an [AccordionItem] with the specified trigger and content.
  ///
  /// Parameters:
  /// - [trigger] (Widget, required): The clickable header widget.
  /// - [content] (Widget, required): The collapsible content widget.
  /// - [expanded] (bool, default: false): Initial expansion state.
  ///
  /// The item automatically integrates with its parent [Accordion] to provide
  /// proper state management and mutual exclusion behavior.
  ///
  /// Example:
  /// ```dart
  /// AccordionItem(
  ///   trigger: AccordionTrigger(
  ///     child: Text('Item Title'),
  ///   ),
  ///   content: Container(
  ///     padding: EdgeInsets.all(16),
  ///     child: Text('Item content goes here...'),
  ///   ),
  ///   expanded: false,
  /// );
  /// ```
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
  AccordionState? accordion;
  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  late AnimationController _controller;
  late CurvedAnimation _easeInAnimation;
  AccordionTheme? _theme;

  @override
  void initState() {
    super.initState();
    _expanded.value = widget.expanded;
    _controller = AnimationController(
      vsync: this,
    );
    _updateAnimations();
  }

  void _updateAnimations() {
    _controller.duration =
        _theme?.duration ?? const Duration(milliseconds: 200);
    _controller.value = _expanded.value ? 1 : 0;
    _easeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: _theme?.curve ?? Curves.easeIn,
      reverseCurve: _theme?.reverseCurve ?? Curves.easeOut,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AccordionState newAccordion = Data.of<AccordionState>(context);
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
    _controller.dispose();
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
    _controller.forward();
    _expanded.value = true;
  }

  void _collapse() {
    _controller.reverse();
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
              sizeFactor: _easeInAnimation,
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

/// A specialized trigger widget designed for use within [AccordionItem].
///
/// [AccordionTrigger] provides a consistent, accessible interface for accordion
/// headers. It automatically includes:
/// - Hover effects with text underlining
/// - Focus management with keyboard navigation
/// - Animated expand/collapse icon
/// - Proper click and keyboard activation
/// - Accessibility semantics
///
/// The trigger automatically coordinates with its parent [AccordionItem] to
/// control the expansion state and provides visual feedback for user interactions.
///
/// ## Accessibility Features
/// - Full keyboard navigation support (Enter and Space keys)
/// - Focus indicators with theme-appropriate styling
/// - Screen reader compatibility
/// - Proper semantic roles and states
///
/// Example:
/// ```dart
/// AccordionTrigger(
///   child: Row(
///     children: [
///       Icon(Icons.info_outline),
///       SizedBox(width: 12),
///       Expanded(
///         child: Column(
///           crossAxisAlignment: CrossAxisAlignment.start,
///           children: [
///             Text('Primary Title', style: TextStyle(fontWeight: FontWeight.bold)),
///             Text('Subtitle', style: TextStyle(fontSize: 12)),
///           ],
///         ),
///       ),
///     ],
///   ),
/// );
/// ```
class AccordionTrigger extends StatefulWidget {
  /// The content widget displayed within the trigger.
  ///
  /// Typically contains text, icons, or other UI elements that describe the
  /// accordion section. The child receives automatic text styling and hover
  /// effects from the trigger.
  final Widget child;

  /// Creates an [AccordionTrigger] with the specified child content.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The content to display in the trigger.
  ///
  /// The trigger automatically provides:
  /// - Click and keyboard interaction handling
  /// - Hover effects with text underlining
  /// - Focus management with visual indicators
  /// - Animated expand/collapse icon
  /// - Integration with parent [AccordionItem] state
  ///
  /// Example:
  /// ```dart
  /// AccordionTrigger(
  ///   child: Text('Click to expand this section'),
  /// );
  /// ```
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
