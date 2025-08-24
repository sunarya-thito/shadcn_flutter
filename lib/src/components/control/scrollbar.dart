// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';

import '../../../shadcn_flutter.dart';

/// Theme configuration for scrollbar appearance and behavior.
///
/// [ScrollbarTheme] provides styling options for scrollbar components including
/// thumb color, thickness, and corner radius. These settings control the visual
/// appearance of scrollbars across scrollable widgets in the application.
///
/// The theme integrates with the shadcn_flutter theming system and can be applied
/// globally through [ComponentTheme] or customized per-scrollbar as needed.
///
/// Example:
/// ```dart
/// ComponentTheme<ScrollbarTheme>(
///   data: ScrollbarTheme(
///     color: Colors.grey.shade600,
///     thickness: 12.0,
///     radius: Radius.circular(6.0),
///   ),
///   child: ScrollableWidget(),
/// )
/// ```
class ScrollbarTheme {
  /// Color of the scrollbar thumb (draggable portion).
  ///
  /// When null, uses the theme's default scrollbar color. The thumb color
  /// should provide sufficient contrast against the scrollable content and
  /// track background for good visibility.
  final Color? color;

  /// Thickness of the scrollbar thumb in pixels.
  ///
  /// Controls the width (for vertical scrollbars) or height (for horizontal
  /// scrollbars) of the draggable thumb. When null, uses the theme's default
  /// thickness. Consider touch target size when setting custom thickness.
  final double? thickness;

  /// Corner radius for the scrollbar thumb.
  ///
  /// Defines the rounding of the scrollbar thumb corners. When null, uses
  /// the theme's default radius. Use [Radius.zero] for square corners or
  /// larger values for more rounded scrollbars.
  final Radius? radius;

  /// Creates a [ScrollbarTheme] with optional styling properties.
  ///
  /// All parameters are optional and fall back to theme defaults when null.
  ///
  /// Parameters:
  /// - [color]: Color of the scrollbar thumb
  /// - [thickness]: Thickness of the scrollbar in pixels
  /// - [radius]: Corner radius for the scrollbar thumb
  const ScrollbarTheme({
    this.color,
    this.thickness,
    this.radius,
  });

  /// Creates a copy of this theme with the given values replaced.
  ScrollbarTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? thickness,
    ValueGetter<Radius?>? radius,
  }) {
    return ScrollbarTheme(
      color: color == null ? this.color : color(),
      thickness: thickness == null ? this.thickness : thickness(),
      radius: radius == null ? this.radius : radius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScrollbarTheme &&
        other.color == color &&
        other.thickness == thickness &&
        other.radius == radius;
  }

  @override
  int get hashCode => Object.hash(color, thickness, radius);
}

const double _kScrollbarMinLength = 48.0;
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

/// Custom scrollbar widget with enhanced theming and cross-platform support.
///
/// [Scrollbar] provides a themed scrollbar implementation that integrates with
/// the shadcn_flutter design system. It supports both mouse and touch interactions,
/// configurable appearance, and platform-appropriate behavior.
///
/// The scrollbar automatically appears when scrollable content extends beyond
/// the viewport and can be configured to always show or only appear during
/// scrolling. It supports both vertical and horizontal orientations.
///
/// Features:
/// - **Theme integration**: Uses [ScrollbarTheme] for consistent styling
/// - **Interactive scrolling**: Drag the thumb to scroll content  
/// - **Auto-hide behavior**: Fades in/out based on scroll activity
/// - **Cross-platform**: Adapts to desktop and mobile interaction patterns
/// - **Accessibility**: Screen reader compatible with proper semantics
///
/// Example:
/// ```dart
/// Scrollbar(
///   controller: scrollController,
///   thickness: 12.0,
///   radius: Radius.circular(6.0),
///   thumbVisibility: true,
///   interactive: true,
///   child: ListView.builder(
///     controller: scrollController,
///     itemCount: 100,
///     itemBuilder: (context, index) => ListTile(
///       title: Text('Item $index'),
///     ),
///   ),
/// )
/// ```
class Scrollbar extends StatelessWidget {
  /// Creates a [Scrollbar] with configurable appearance and behavior.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The scrollable widget to add scrollbar to
  /// - [controller] (ScrollController?, optional): Controller for scroll coordination
  /// - [thumbVisibility] (bool?, optional): Whether thumb is always visible
  /// - [trackVisibility] (bool?, optional): Whether track background is visible
  /// - [thickness] (double?, optional): Thickness of the scrollbar thumb
  /// - [radius] (Radius?, optional): Corner radius of the scrollbar thumb
  /// - [color] (Color?, optional): Color of the scrollbar thumb
  /// - [interactive] (bool?, optional): Whether scrollbar responds to drag gestures
  /// - [notificationPredicate] (ScrollNotificationPredicate?, optional): Filter for scroll notifications
  /// - [scrollbarOrientation] (ScrollbarOrientation?, optional): Orientation override
  const Scrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.color,
    this.notificationPredicate,
    this.interactive,
    this.scrollbarOrientation,
  });

  /// The scrollable widget to which the scrollbar will be applied.
  ///
  /// This should be a scrollable widget like [ListView], [GridView],
  /// [SingleChildScrollView], or [CustomScrollView]. The scrollbar will
  /// automatically detect scroll changes and update its appearance.
  final Widget child;

  /// Controller for coordinating scrollbar and scroll view interactions.
  ///
  /// When provided, the scrollbar will use this controller to monitor scroll
  /// position and handle interactive scrolling. If null, the scrollbar will
  /// automatically find the nearest [Scrollable] widget's controller.
  final ScrollController? controller;

  /// Whether the scrollbar thumb is always visible.
  ///
  /// When true, the thumb remains visible even when not scrolling. When false
  /// or null, the thumb fades in during scrolling and fades out after a delay.
  /// Useful for indicating scrollable content is available.
  final bool? thumbVisibility;

  /// Whether the scrollbar track (background) is visible.
  ///
  /// When true, shows a background track behind the thumb. When false or null,
  /// only the thumb is visible. Track visibility helps users understand the
  /// total scrollable area and current position.
  final bool? trackVisibility;

  /// Thickness of the scrollbar thumb in pixels.
  ///
  /// Overrides the theme's default thickness. Consider touch target guidelines
  /// when setting custom thickness values - mobile interfaces typically need
  /// thicker scrollbars for easier interaction.
  final double? thickness;

  /// Corner radius for the scrollbar thumb.
  ///
  /// Overrides the theme's default radius. Use [Radius.zero] for square corners
  /// or larger values for more rounded scrollbars that match your design system.
  final Radius? radius;

  /// Color of the scrollbar thumb.
  ///
  /// Overrides the theme's default color. Should provide sufficient contrast
  /// against the scrollable content for good visibility while remaining
  /// aesthetically pleasing.
  final Color? color;

  /// Whether the scrollbar responds to drag gestures for interactive scrolling.
  ///
  /// When true, users can drag the thumb to scroll content directly. When false,
  /// the scrollbar is purely visual. Interactive scrollbars improve accessibility
  /// and provide precise scroll control.
  final bool? interactive;

  /// Predicate to filter which scroll notifications the scrollbar responds to.
  ///
  /// Use this to control which scroll events affect scrollbar visibility and
  /// position. For example, you might filter out certain scroll notifications
  /// in complex nested scrolling scenarios.
  final ScrollNotificationPredicate? notificationPredicate;

  /// Override for the scrollbar's orientation.
  ///
  /// When null, the scrollbar automatically determines orientation based on
  /// the scroll view's scroll direction. Use this to force a specific
  /// orientation or support dual-axis scrolling scenarios.
  final ScrollbarOrientation? scrollbarOrientation;

  @override
  Widget build(BuildContext context) {
    return _ShadcnScrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      thickness: thickness,
      radius: radius,
      color: color,
      notificationPredicate: notificationPredicate,
      interactive: interactive,
      scrollbarOrientation: scrollbarOrientation,
      child: child,
    );
  }
}

class _ShadcnScrollbar extends RawScrollbar {
  const _ShadcnScrollbar({
    required super.child,
    super.controller,
    super.thumbVisibility,
    super.trackVisibility,
    super.thickness,
    super.radius,
    this.color,
    ScrollNotificationPredicate? notificationPredicate,
    super.interactive,
    super.scrollbarOrientation,
  }) : super(
          fadeDuration: _kScrollbarFadeDuration,
          timeToFade: _kScrollbarTimeToFade,
          pressDuration: Duration.zero,
          notificationPredicate:
              notificationPredicate ?? defaultScrollNotificationPredicate,
        );

  final Color? color;

  @override
  _ShadcnScrollbarState createState() => _ShadcnScrollbarState();
}

class _ShadcnScrollbarState extends RawScrollbarState<_ShadcnScrollbar> {
  late AnimationController _hoverAnimationController;
  bool _hoverIsActive = false;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  @override
  bool get enableGestures => widget.interactive ?? true;

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hoverAnimationController.addListener(() {
      updateScrollbarPainter();
    });
  }

  @override
  void updateScrollbarPainter() {
    final compTheme = ComponentTheme.maybeOf<ScrollbarTheme>(context);
    scrollbarPainter
      ..color = styleValue(
          widgetValue: widget.color,
          themeValue: compTheme?.color,
          defaultValue: _theme.colorScheme.border)
      ..textDirection = Directionality.of(context)
      // Should this be affected by density?
      ..thickness = styleValue(
          widgetValue: widget.thickness,
          themeValue: compTheme?.thickness,
          defaultValue: 7.0 * _theme.scaling)
      ..radius = styleValue(
          widgetValue: widget.radius,
          themeValue: compTheme?.radius,
          defaultValue: Radius.circular(_theme.radiusSm))
      ..minLength = _kScrollbarMinLength
      ..padding =
          MediaQuery.paddingOf(context) + EdgeInsets.all(_theme.scaling)
      ..scrollbarOrientation = widget.scrollbarOrientation
      ..ignorePointer = !enableGestures;
  }

  @override
  void handleHover(PointerHoverEvent event) {
    // Check if the position of the pointer falls over the painted scrollbar
    if (isPointerOverScrollbar(event.position, event.kind, forHover: true)) {
      // Pointer is hovering over the scrollbar
      setState(() {
        _hoverIsActive = true;
      });
      _hoverAnimationController.forward();
    } else if (_hoverIsActive) {
      // Pointer was, but is no longer over painted scrollbar.
      setState(() {
        _hoverIsActive = false;
      });
      _hoverAnimationController.reverse();
    }
    super.handleHover(event);
  }

  @override
  void handleHoverExit(PointerExitEvent event) {
    super.handleHoverExit(event);
    setState(() {
      _hoverIsActive = false;
    });
    _hoverAnimationController.reverse();
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    super.dispose();
  }
}
