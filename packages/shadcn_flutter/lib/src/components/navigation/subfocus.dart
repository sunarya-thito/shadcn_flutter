import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Callback function type for building SubFocusScope widgets.
///
/// Receives the build context and the scope state for managing focus
/// within the scope's widget tree.
typedef SubFocusScopeBuilder = Widget Function(
  BuildContext context,
  SubFocusScopeState state,
);

/// Hierarchical focus management system for complex widget trees.
///
/// Creates a focus scope that manages keyboard navigation and focus traversal
/// for child widgets. Provides centralized control over which child widget
/// has focus and handles focus navigation between multiple focusable elements.
///
/// Key Features:
/// - **Focus Hierarchy**: Manages focus relationships between parent and child widgets
/// - **Keyboard Navigation**: Handles arrow key and tab navigation between elements
/// - **Action Delegation**: Routes keyboard actions to currently focused child
/// - **Auto-focus Support**: Automatically focuses first child when enabled
/// - **Focus State Management**: Tracks and updates focus state across widget rebuilds
/// - **Scroll Integration**: Ensures focused elements remain visible in scrollable areas
///
/// The scope maintains a list of attached [SubFocus] widgets and manages which
/// one currently has focus. It handles focus traversal, action routing, and
/// ensures focused widgets remain visible through scroll positioning.
///
/// Used commonly in:
/// - Lists with keyboard navigation
/// - Form field traversal
/// - Menu and dropdown navigation
/// - Tree view navigation
/// - Tab panel systems
///
/// Example:
/// ```dart
/// SubFocusScope(
///   autofocus: true,
///   builder: (context, state) => Column(
///     children: [
///       SubFocus(
///         builder: (context, focusState) => Container(
///           color: focusState.isFocused ? Colors.blue : Colors.grey,
///           child: Text('Item 1'),
///         ),
///       ),
///       SubFocus(
///         builder: (context, focusState) => Container(
///           color: focusState.isFocused ? Colors.blue : Colors.grey,
///           child: Text('Item 2'),
///         ),
///       ),
///     ],
///   ),
/// )
/// ```
class SubFocusScope extends StatefulWidget {
  /// Builder function that creates the widget tree for this scope.
  ///
  /// Called with the build context and the scope's state for managing
  /// focus within child widgets. If `null`, the scope acts as an invisible
  /// wrapper without building additional UI.
  final SubFocusScopeBuilder? builder;

  /// Whether the first child should automatically receive focus.
  ///
  /// When `true`, the first attached [SubFocus] widget will automatically
  /// gain focus when the scope is built. Defaults to `false`.
  final bool autofocus;

  /// Creates a sub-focus scope.
  ///
  /// Parameters:
  /// - [builder]: Widget builder with scope state (optional)
  /// - [autofocus]: Auto-focus first child (defaults to `false`)
  const SubFocusScope({super.key, this.builder, this.autofocus = false});

  @override
  State<SubFocusScope> createState() => _SubFocusScopeState();
}

/// Mixin providing focus scope state management capabilities.
///
/// Defines the interface for interacting with a [SubFocusScope], including
/// methods for focus management, child attachment/detachment, and action routing.
///
/// This mixin is implemented by internal scope state classes and provides
/// the public API for focus operations within a scope.
mixin SubFocusScopeState {
  /// Invokes an action on the currently focused child widget.
  ///
  /// Routes keyboard shortcuts or other intents to the focused child.
  /// Returns the result of the action, or `null` if no child is focused
  /// or the action is not handled.
  ///
  /// Parameters:
  /// - [intent]: The intent/action to invoke
  ///
  /// Returns the action result or `null`.
  Object? invokeActionOnFocused(Intent intent);

  /// Moves focus to the next child in the specified direction.
  ///
  /// Traverses the focus order in the given direction, wrapping around
  /// at the edges if needed. Returns `true` if focus was successfully
  /// moved, `false` otherwise (e.g., no children available).
  ///
  /// Parameters:
  /// - [direction]: Direction to traverse (defaults to [TraversalDirection.down])
  ///
  /// Returns `true` if focus moved successfully.
  bool nextFocus([TraversalDirection direction = TraversalDirection.down]);

  /// Retrieves the nearest [SubFocusScopeState] from the widget tree.
  ///
  /// Searches up the widget tree for an ancestor [SubFocusScope] and
  /// returns its state. Returns `null` if no scope is found.
  ///
  /// Parameters:
  /// - [context]: Build context to search from
  ///
  /// Returns the scope state or `null`.
  static SubFocusScopeState? maybeOf(BuildContext context) {
    return Data.maybeOf<SubFocusScopeState>(context);
  }

  /// Detaches a child focus state from this scope.
  ///
  /// Called when a [SubFocus] widget is disposed or removed from the tree.
  /// Removes the child from the scope's managed focus list.
  ///
  /// Parameters:
  /// - [child]: The child state to detach
  void detach(SubFocusState child);

  /// Attaches a child focus state to this scope.
  ///
  /// Called when a [SubFocus] widget is initialized. Adds the child to
  /// the scope's managed focus list and may auto-focus it if configured.
  ///
  /// Parameters:
  /// - [child]: The child state to attach
  ///
  /// Returns `true` if attachment succeeded.
  bool attach(SubFocusState child);

  /// Requests focus for a specific child.
  ///
  /// Transfers focus to the specified child, unfocusing the previously
  /// focused child if any. Updates visual state and ensures the focused
  /// widget is scrolled into view if needed.
  ///
  /// Parameters:
  /// - [child]: The child to receive focus
  ///
  /// Returns `true` if focus was granted successfully.
  bool requestFocus(SubFocusState child);

  /// Removes focus from a specific child.
  ///
  /// If the specified child currently has focus, clears the focus state.
  /// Otherwise, does nothing.
  ///
  /// Parameters:
  /// - [child]: The child to unfocus
  ///
  /// Returns `true` if the child was unfocused, `false` if it didn't have focus.
  bool unfocus(SubFocusState child);
}

class _SubFocusScopeState extends State<SubFocusScope> with SubFocusScopeState {
  final List<SubFocusState> _attachedStates = [];
  SubFocusState? _currentState;
  bool _active = true;

  @override
  bool unfocus(SubFocusState child) {
    if (_currentState == child) {
      _currentState?.markFocused(false);
      _currentState = null;
      return true;
    }
    return false;
  }

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
  Object? invokeActionOnFocused(Intent intent) {
    return _currentState?.invokeAction(intent);
  }

  @override
  bool attach(SubFocusState state) {
    assert(
      !_attachedStates.contains(state),
      'SubFocusState is already attached to this SubFocusScope.',
    );
    _attachedStates.add(state);
    if (widget.autofocus) {
      _currentState ??= state;
    }
    return _currentState == state;
  }

  @override
  void detach(SubFocusState state) {
    _attachedStates.remove(state);
    if (_currentState == state) {
      _currentState = null;
      if (widget.autofocus) findFirstFocus(); // Find new focus
    }
  }

  void _setCurrentItem(SubFocusState item, bool? forward) {
    if (!mounted || !_active) {
      return;
    }
    final currentItem = _currentState;
    if (!mounted || !_active) {
      return;
    }
    currentItem?.markFocused(false);
    item.markFocused(true);
    item.ensureVisible(
      alignmentPolicy: forward == null
          ? ScrollPositionAlignmentPolicy.explicit
          : forward
              ? ScrollPositionAlignmentPolicy.keepVisibleAtEnd
              : ScrollPositionAlignmentPolicy.keepVisibleAtStart,
    );
    _currentState = item;
  }

  RenderBox? findRenderObject() {
    if (!mounted || !_active) {
      return null;
    }
    return context.findRenderObject() as RenderBox?;
  }

  @override
  bool nextFocus([TraversalDirection direction = TraversalDirection.down]) {
    if (!mounted || !_active) return false;
    if (_currentState != null) {
      final RenderBox? currentBox = _currentState!.findRenderObject();
      final RenderBox? parentBox = findRenderObject();
      if (currentBox == null || parentBox == null) {
        return false;
      }
      final Offset currentOffset =
          currentBox.localToGlobal(Offset.zero, ancestor: parentBox);

      late final bool horizontal;
      late final bool forward;
      switch (direction) {
        case TraversalDirection.down:
          horizontal = false;
          forward = true;
          break;
        case TraversalDirection.up:
          horizontal = false;
          forward = false;
          break;
        case TraversalDirection.right:
          horizontal = true;
          forward = true;
          break;
        case TraversalDirection.left:
          horizontal = true;
          forward = false;
          break;
      }

      (SubFocusState, double)? nearestNextItem;
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
        return true;
      }
    } else if (!widget.autofocus) {
      findFirstFocus();
      return true;
    }
    return false;
  }

  void findFirstFocus() {
    if (!mounted || !_active) return;
    (SubFocusState, int)? mostItem;
    for (final attached in _attachedStates) {
      if (attached.focusCount > 0 &&
          attached.focusCount > (mostItem?.$2 ?? 0)) {
        mostItem = (attached, attached.focusCount);
      }
    }
    if (mostItem != null) {
      _setCurrentItem(mostItem.$1, null);
    } else {
      // find very first focus based on top left or top right (based on directionality)
      (SubFocusState, double)? nearestItem;
      final direction = Directionality.of(context);
      RenderBox? parentBox = findRenderObject();
      if (parentBox == null) return;
      Offset anchor = direction == TextDirection.ltr
          ? Offset.zero
          : Offset(parentBox.size.width, 0);
      for (final attached in _attachedStates) {
        if (attached == mostItem?.$1) continue;
        final box = attached.findRenderObject();
        if (box == null) continue;
        final offset = box.localToGlobal(Offset.zero);
        final distance = (offset - anchor).distance;
        if (nearestItem == null || distance < nearestItem.$2) {
          nearestItem = (attached, distance);
        }
      }
      if (nearestItem != null) {
        _setCurrentItem(nearestItem.$1, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<SubFocusScopeState>.inherit(
      data: this,
      child: widget.builder?.call(context, this),
    );
  }

  @override
  bool requestFocus(SubFocusState child) {
    if (!mounted || !_active) return false;
    _currentState?.markFocused(false);
    _currentState = child;
    _currentState!.markFocused(true);
    return true;
  }
}

/// Callback function type for building SubFocus widgets.
///
/// Receives the build context and focus state for creating widgets that
/// respond to focus changes and user interactions.
/// Callback function type for building SubFocus widgets.
///
/// Receives the build context and the focus state for managing focus
/// presentation and behavior within the widget.
///
/// Parameters:
/// - [context]: The build context
/// - [state]: The focus state providing focus information and control methods
///
/// Returns the widget tree for this focusable element.
typedef SubFocusBuilder = Widget Function(
  BuildContext context,
  SubFocusState state,
);

/// Individual focusable widget within a SubFocusScope hierarchy.
///
/// Creates a single focusable element that can receive keyboard focus and respond
/// to user interactions within a [SubFocusScope]. Provides focus state information
/// and handles focus-related behaviors like visibility scrolling and action routing.
///
/// Key Features:
/// - **Focus State**: Tracks and reports whether this widget currently has focus
/// - **Focus Request**: Can programmatically request focus from its parent scope
/// - **Action Handling**: Receives and processes keyboard actions when focused
/// - **Scroll Integration**: Automatically scrolls to ensure visibility when focused
/// - **State Tracking**: Maintains focus count and state across widget lifecycle
/// - **Enable/Disable**: Can be temporarily disabled to prevent focus acquisition
///
/// The widget uses a builder pattern to provide focus state to child widgets,
/// allowing them to update their appearance and behavior based on focus status.
/// This enables rich visual feedback for focused states.
///
/// Common Use Cases:
/// - List items in navigable lists
/// - Form fields in keyboard-navigable forms
/// - Menu items in dropdown menus
/// - Tree nodes in tree views
/// - Tab headers in tab panels
///
/// Example:
/// ```dart
/// SubFocus(
///   enabled: true,
///   builder: (context, state) => GestureDetector(
///     onTap: () => state.requestFocus(),
///     child: Container(
///       padding: EdgeInsets.all(8),
///       decoration: BoxDecoration(
///         color: state.isFocused ? Colors.blue : Colors.transparent,
///         border: Border.all(
///           color: state.isFocused ? Colors.blue : Colors.grey,
///         ),
///       ),
///       child: Text(
///         'Focusable Item',
///         style: TextStyle(
///           color: state.isFocused ? Colors.white : Colors.black,
///         ),
///       ),
///     ),
///   ),
/// )
/// ```
class SubFocus extends StatefulWidget {
  /// Builder function that creates the widget tree with focus state.
  ///
  /// Called with the build context and focus state, allowing the widget
  /// to update its appearance and behavior based on the current focus status.
  final SubFocusBuilder builder;

  /// Whether this focusable element is enabled.
  ///
  /// When `false`, the element cannot receive focus and is excluded from
  /// the focus traversal order. Defaults to `true`.
  final bool enabled;

  /// Creates a focusable widget.
  ///
  /// Parameters:
  /// - [builder]: Widget builder with focus state (required)
  /// - [enabled]: Whether focus is enabled (defaults to `true`)
  const SubFocus({super.key, required this.builder, this.enabled = true});

  @override
  State<SubFocus> createState() => _SubFocusState();
}

/// Mixin providing focus state and control capabilities for focusable widgets.
///
/// Defines the interface for interacting with a [SubFocus] widget, including
/// methods for focus management, visibility control, and action handling.
///
/// This mixin is implemented by internal focus state classes and provides
/// the public API for focus operations on individual focusable elements.
mixin SubFocusState {
  /// Retrieves the render box for this focusable element.
  ///
  /// Used for positioning and scroll calculations. Returns `null` if
  /// the widget is not currently rendered.
  ///
  /// Returns the [RenderBox] or `null`.
  RenderBox? findRenderObject();

  /// Scrolls the widget into view within its scrollable ancestor.
  ///
  /// Ensures the focused widget is visible by scrolling its nearest
  /// [Scrollable] ancestor. Useful when focus moves to an off-screen element.
  ///
  /// Parameters:
  /// - [alignmentPolicy]: How to align the widget when scrolling
  void ensureVisible({
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  });

  /// Whether this element currently has focus.
  ///
  /// Returns `true` if this is the focused element in its parent scope.
  bool get isFocused;

  /// Requests focus for this element.
  ///
  /// Asks the parent scope to transfer focus to this element. Returns
  /// `true` if focus was successfully acquired, `false` otherwise.
  ///
  /// Returns `true` on success.
  bool requestFocus();

  /// Invokes an action/intent on this focused element.
  ///
  /// Routes keyboard shortcuts or other actions to this widget's
  /// action handlers. Returns the action result or `null` if not handled.
  ///
  /// Parameters:
  /// - [intent]: The intent/action to invoke
  ///
  /// Returns the action result or `null`.
  Object? invokeAction(Intent intent);

  /// The number of times this element has received focus.
  ///
  /// Increments each time [requestFocus] succeeds. Useful for analytics
  /// or behavior tracking.
  int get focusCount;

  /// Marks this element as focused or unfocused (internal method).
  ///
  /// Called by the parent scope to update focus state. Should not be
  /// called directly by application code.
  ///
  /// Parameters:
  /// - [focused]: Whether the element should be focused
  void markFocused(bool focused);

  /// Removes focus from this element.
  ///
  /// Asks the parent scope to clear focus from this element. Returns
  /// `true` if focus was successfully removed, `false` if it didn't have focus.
  ///
  /// Returns `true` on success.
  bool unfocus();
}

class _SubFocusState extends State<SubFocus> with SubFocusState {
  SubFocusScopeState? _scope;
  bool _focused = false;
  bool _active = true;
  int _focusCount = 0;

  @override
  int get focusCount => _focusCount;

  @override
  bool unfocus() {
    return _scope?.unfocus(this) ?? false;
  }

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
  void didUpdateWidget(covariant SubFocus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        _focused = _scope?.attach(this) ?? false;
      } else {
        _focused = false;
        _scope?.detach(this);
      }
    }
  }

  @override
  Object? invokeAction(Intent intent) {
    return Actions.invoke(context, intent);
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
  bool requestFocus() {
    if (!mounted || !_active) return false;
    if (_scope != null) {
      return _scope!.requestFocus(this);
    }
    return false;
  }

  @override
  bool get isFocused => _focused && widget.enabled;

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
      _scope?.detach(this);
      _scope = newScope;
      if (widget.enabled) {
        _focused = _scope?.attach(this) ?? false;
      }
    }
  }

  @override
  void dispose() {
    _scope?.detach(this);
    super.dispose();
  }

  @override
  void markFocused(bool focus) {
    if (!mounted || !_active) {
      return;
    }
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
