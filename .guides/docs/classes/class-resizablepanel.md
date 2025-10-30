---
title: "Class: ResizablePanel"
description: "A container widget that creates resizable panels separated by interactive dividers."
---

```dart
/// A container widget that creates resizable panels separated by interactive dividers.
///
/// This widget provides a flexible layout system where multiple child panes
/// can be resized by the user through draggable dividers. It supports both
/// horizontal and vertical orientations, allowing users to adjust the relative
/// sizes of the contained panels by dragging the separators between them.
///
/// Each [ResizablePane] child can have its own sizing constraints, minimum and
/// maximum sizes, and collapse behavior. The panel automatically manages the
/// distribution of available space and handles user interactions for resizing.
///
/// Example:
/// ```dart
/// ResizablePanel.horizontal(
///   children: [
///     ResizablePane(
///       child: Container(color: Colors.red),
///       minSize: 100,
///       defaultSize: 200,
///     ),
///     ResizablePane(
///       child: Container(color: Colors.blue),
///       flex: 1,
///     ),
///     ResizablePane(
///       child: Container(color: Colors.green),
///       defaultSize: 150,
///       maxSize: 300,
///     ),
///   ],
/// );
/// ```
class ResizablePanel extends StatefulWidget {
  /// Default builder for dividers between resizable panes.
  ///
  /// Creates appropriate divider widgets based on the panel orientation:
  /// - Horizontal panels get vertical dividers
  /// - Vertical panels get horizontal dividers
  ///
  /// This is the default value for [dividerBuilder] when none is specified.
  static Widget? defaultDividerBuilder(BuildContext context);
  /// Default builder for interactive drag handles between resizable panes.
  ///
  /// Creates appropriate dragger widgets based on the panel orientation:
  /// - Horizontal panels get vertical draggers
  /// - Vertical panels get horizontal draggers
  ///
  /// This is the default value for [draggerBuilder] when none is specified.
  static Widget? defaultDraggerBuilder(BuildContext context);
  /// The axis along which the panels are arranged and can be resized.
  ///
  /// When [Axis.horizontal], panels are arranged left-to-right with vertical
  /// dividers between them. When [Axis.vertical], panels are arranged
  /// top-to-bottom with horizontal dividers between them.
  final Axis direction;
  /// The list of resizable panes that make up this panel.
  ///
  /// Each pane can specify its own sizing constraints, default size, and
  /// collapse behavior. At least two panes are typically needed to create
  /// a meaningful resizable interface.
  final List<ResizablePane> children;
  /// Optional builder for creating divider widgets between panes.
  ///
  /// Called to create the visual separator between adjacent panes. If null,
  /// uses [defaultDividerBuilder] to create appropriate dividers based on
  /// the panel orientation.
  final OptionalWidgetBuilder? dividerBuilder;
  /// Optional builder for creating interactive drag handles between panes.
  ///
  /// Called to create draggable resize handles between adjacent panes. These
  /// handles allow users to adjust pane sizes. If null, no drag handles are
  /// displayed but dividers may still be present if [dividerBuilder] is set.
  final OptionalWidgetBuilder? draggerBuilder;
  /// The thickness of the draggable area between panes.
  ///
  /// Controls the size of the interactive region for resizing. A larger value
  /// makes it easier to grab and drag the resize handles, while a smaller
  /// value provides a more compact appearance.
  final double? draggerThickness;
  /// Hides the divider when not hovered or being dragged.
  final bool optionalDivider;
  /// Creates a horizontal resizable panel with panes arranged left-to-right.
  ///
  /// This is a convenience constructor that sets [direction] to [Axis.horizontal]
  /// and provides default builders for dividers and draggers appropriate for
  /// horizontal layouts.
  ///
  /// Parameters:
  /// - [children] (`List<ResizablePane>`, required): The panes to arrange horizontally
  /// - [dividerBuilder] (OptionalWidgetBuilder?, optional): Custom divider builder
  /// - [draggerBuilder] (OptionalWidgetBuilder?, optional): Custom dragger builder
  /// - [draggerThickness] (double?, optional): Size of the draggable resize area
  ///
  /// Example:
  /// ```dart
  /// ResizablePanel.horizontal(
  ///   children: [
  ///     ResizablePane(child: LeftSidebar(), defaultSize: 200),
  ///     ResizablePane(child: MainContent(), flex: 1),
  ///     ResizablePane(child: RightPanel(), defaultSize: 150),
  ///   ],
  /// );
  /// ```
  const ResizablePanel.horizontal({super.key, required this.children, this.dividerBuilder = defaultDividerBuilder, this.draggerBuilder, this.draggerThickness, this.optionalDivider = false});
  /// Creates a vertical resizable panel with panes arranged top-to-bottom.
  ///
  /// This is a convenience constructor that sets [direction] to [Axis.vertical]
  /// and provides default builders for dividers and draggers appropriate for
  /// vertical layouts.
  ///
  /// Parameters:
  /// - [children] (`List<ResizablePane>`, required): The panes to arrange vertically
  /// - [dividerBuilder] (OptionalWidgetBuilder?, optional): Custom divider builder
  /// - [draggerBuilder] (OptionalWidgetBuilder?, optional): Custom dragger builder
  /// - [draggerThickness] (double?, optional): Size of the draggable resize area
  ///
  /// Example:
  /// ```dart
  /// ResizablePanel.vertical(
  ///   children: [
  ///     ResizablePane(child: Header(), defaultSize: 60),
  ///     ResizablePane(child: Content(), flex: 1),
  ///     ResizablePane(child: Footer(), defaultSize: 40),
  ///   ],
  /// );
  /// ```
  const ResizablePanel.vertical({super.key, required this.children, this.dividerBuilder = defaultDividerBuilder, this.draggerBuilder, this.draggerThickness, this.optionalDivider = false});
  /// Creates a resizable panel with the specified direction and configuration.
  ///
  /// This is the general constructor that allows full customization of the
  /// panel orientation and behavior. Use the convenience constructors
  /// [ResizablePanel.horizontal] and [ResizablePanel.vertical] for typical use cases.
  ///
  /// Parameters:
  /// - [direction] (Axis, required): The axis along which panes are arranged
  /// - [children] (`List<ResizablePane>`, required): The panes to arrange
  /// - [dividerBuilder] (OptionalWidgetBuilder?, optional): Custom divider builder
  /// - [draggerBuilder] (OptionalWidgetBuilder?, optional): Custom dragger builder
  /// - [draggerThickness] (double?, optional): Size of the draggable resize area
  ///
  /// Example:
  /// ```dart
  /// ResizablePanel(
  ///   direction: Axis.horizontal,
  ///   draggerThickness: 8.0,
  ///   children: [...],
  ///   draggerBuilder: (context) => CustomDragger(),
  /// );
  /// ```
  const ResizablePanel({super.key, required this.direction, required this.children, this.dividerBuilder = defaultDividerBuilder, this.draggerBuilder, this.draggerThickness, this.optionalDivider = false});
  State<ResizablePanel> createState();
}
```
