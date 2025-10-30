---
title: "Class: BranchLine"
description: "Abstract base class for defining tree branch line styles."
---

```dart
/// Abstract base class for defining tree branch line styles.
///
/// BranchLine defines how visual connections are drawn between parent and child
/// nodes in tree views. Different implementations provide various visual styles
/// from no lines to complex path-based connections.
///
/// The class provides static instances for common branch line styles:
/// - [BranchLine.none] - No visual connections
/// - [BranchLine.line] - Simple vertical lines
/// - [BranchLine.path] - Connected path lines showing hierarchy
///
/// Custom implementations can be created by extending this class and implementing
/// the [build] method to return appropriate connection widgets.
///
/// Example:
/// ```dart
/// // Using built-in styles
/// TreeView(
///   branchLine: BranchLine.path, // Connected paths
///   // ... other properties
/// );
///
/// // Custom branch line implementation
/// class CustomBranchLine extends BranchLine {
///   @override
///   Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
///     return CustomPaint(painter: MyCustomLinePainter());
///   }
/// }
/// ```
abstract class BranchLine {
  /// Predefined branch line style with no visual connections.
  static const none = IndentGuideNone();
  /// Predefined branch line style with simple vertical lines.
  static const line = IndentGuideLine();
  /// Predefined branch line style with connected path lines.
  static const path = IndentGuidePath();
  /// Builds the visual representation of branch lines for a tree node.
  ///
  /// Creates a widget that shows the connection lines between tree nodes
  /// based on the node's position in the hierarchy and its depth information.
  ///
  /// Parameters:
  /// - [context] (BuildContext): Build context for theme access
  /// - [depth] (`List<TreeNodeDepth>`): Hierarchical depth information
  /// - [index] (int): Index within the current depth level
  ///
  /// Returns: A [Widget] representing the branch line visualization
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index);
}
```
