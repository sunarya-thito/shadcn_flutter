import 'dart:math' as math;

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';
import 'data.dart';
import 'item.dart';

/// A mixin for navigation containers that provides child wrapping functionality.
///
/// This mixin is used to enhance navigation containers with the ability to wrap
/// navigation items with necessary control data. It tracks item positions and
/// manages selectable state for proper navigation behavior.
mixin NavigationContainerMixin {
  /// Wraps navigation bar items with control data for selection tracking.
  ///
  /// Takes a list of [NavigationBarItem] children and wraps each with
  /// [NavigationChildControlData] that tracks the item's index and selection state.
  /// Only items with a selectable count of 1 receive a selection index, while
  /// non-selectable items have a null selection index.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context for inherited data.
  /// - [children] (`List<NavigationBarItem>`, required): Navigation items to wrap.
  ///
  /// Returns: `List<Widget>` — wrapped navigation items with control data.
  ///
  /// Example:
  /// ```dart
  /// final wrappedItems = wrapChildren(
  ///   context,
  ///   [
  ///     NavigationItem(child: Icon(Icons.home)),
  ///     NavigationItem(child: Icon(Icons.settings)),
  ///   ],
  /// );
  /// ```
  List<Widget> wrapChildren(
    BuildContext context,
    List<NavigationBarItem> children, {
    int baseIndex = 0,
  }) {
    int index = baseIndex;
    List<Widget> newChildren = List.of(children);
    for (var i = 0; i < children.length; i++) {
      final child = children[i];
      final selectableCount = child.selectableCount;
      if (selectableCount > 1) {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: null, actualIndex: i),
          child: Data.inherit(
            data: NavigationGroupControlData(
              baseIndex: index,
              selectableCount: selectableCount,
            ),
            child: child,
          ),
        );
        index += selectableCount;
        continue;
      }
      if (selectableCount == 1) {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: index, actualIndex: i),
          child: child,
        );
        index++;
      } else {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: null, actualIndex: i),
          child: child,
        );
      }
    }
    return newChildren;
  }
}

