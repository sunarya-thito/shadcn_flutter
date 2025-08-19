// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';

import '../../../shadcn_flutter.dart';

/// Theme configuration for [Scrollbar].
class ScrollbarTheme {
  /// Color of the scrollbar thumb.
  final Color? color;

  /// Thickness of the scrollbar thumb.
  final double? thickness;

  /// Radius of the scrollbar thumb.
  final Radius? radius;

  /// Creates a [ScrollbarTheme].
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

class Scrollbar extends StatelessWidget {
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
  final Widget child;
  final ScrollController? controller;
  final bool? thumbVisibility;
  final bool? trackVisibility;

  final double? thickness;

  final Radius? radius;
  final Color? color;

  final bool? interactive;
  final ScrollNotificationPredicate? notificationPredicate;
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
