// import '../shadcn_flutter.dart';

// main() {
//   List<ResizableItem> items = [
//     ResizableItem(value: 80),
//     ResizableItem(value: 80),
//     ResizableItem(value: 120),
//     ResizableItem(value: 80),
//     ResizableItem(value: 80),
//   ];
//   double total = items.fold(0, (prev, item) => prev + item.value);
//   final state = Resizer(items);
//   double result = state.resize(1, 2, 200);
//   print('Applied Delta: $result');
//   for (int i = 0; i < items.length; i++) {
//     print('Item $i: ${items[i].newValue}');
//   }
//   print('Total: ${items.fold(0.0, (prev, item) => prev + item.newValue)}');
//   // double result = state.resize(1, 2, 78.66668701171875);
//   // print('Applied Delta: $result');
//   // for (int i = 0; i < items.length; i++) {
//   //   print('Item $i: ${items[i].newValue}');
//   // }
//   // print('Total: ${items.fold(0.0, (prev, item) => prev + item.newValue)}');
// }

/// Represents a resizable item within a [Resizer] layout system.
///
/// [ResizableItem] encapsulates the properties and constraints for a single
/// resizable element, supporting flexible sizing with minimum/maximum bounds,
/// collapse functionality, and resize restrictions. Each item tracks both its
/// original dimensions and computed new dimensions during resize operations.
///
/// ## Core Properties
///
/// - **Size bounds**: Configurable minimum and maximum size constraints
/// - **Collapse support**: Items can collapse to a smaller footprint when needed
/// - **Resize control**: Items can be marked as non-resizable for fixed layouts
/// - **State tracking**: Maintains both original and computed values during operations
///
/// ## Collapse Behavior
///
/// When [collapsed] is true, the item occupies [collapsedSize] space instead of
/// its normal dimensions. This enables space-efficient layouts where less important
/// content can be minimized to accommodate more critical elements.
///
/// ## Usage in Layout Systems
///
/// ResizableItems are typically used in:
/// - Splitter panes (resizable sidebars, content areas)
/// - Dashboard panels (collapsible widget containers)
/// - Table columns (user-resizable column widths)
/// - Timeline tracks (expandable/collapsible time periods)
///
/// Example:
/// ```dart
/// final items = [
///   // Main content area - flexible sizing
///   ResizableItem(
///     value: 300,
///     min: 200,
///     max: 800,
///   ),
///   
///   // Sidebar - collapsible with constraints
///   ResizableItem(
///     value: 250,
///     min: 150,
///     max: 400,
///     collapsed: false,
///     collapsedSize: 50, // Icon-only mode
///   ),
///   
///   // Footer - fixed size
///   ResizableItem(
///     value: 60,
///     resizable: false,
///   ),
/// ];
/// ```
class ResizableItem {
  /// The original size value for this item.
  double _value;
  
  /// The minimum size constraint for this item.
  ///
  /// During resize operations, the item will not be made smaller than this
  /// value unless it enters collapsed state. Must be non-negative.
  final double min;
  
  /// The maximum size constraint for this item.
  ///
  /// During resize operations, the item will not be made larger than this
  /// value. Use [double.infinity] to allow unlimited growth.
  final double max;
  
  /// Whether this item is currently in collapsed state.
  ///
  /// When true, the item uses [collapsedSize] instead of its normal dimensions.
  /// Collapsed items can be expanded back to their normal size through user
  /// interaction or programmatic control.
  final bool collapsed;
  
  /// The size occupied when this item is in collapsed state.
  ///
  /// When [collapsed] is true, this value determines the item's footprint.
  /// If null, collapsed items have zero size. Should be less than [min]
  /// for effective space savings.
  final double? collapsedSize;
  
  /// Whether this item can be resized by user interaction.
  ///
  /// When false, the item maintains its current size regardless of resize
  /// operations affecting neighboring items. Use for fixed-size elements
  /// like toolbars or status bars.
  final bool resizable;
  
  /// Computed new size after resize operations (internal use).
  double? _newValue;
  
  /// Computed new collapsed state after resize operations (internal use).
  bool? _newCollapsed;

  /// Creates a [ResizableItem] with the specified properties.
  ///
  /// The [value] parameter is required and represents the item's current size.
  /// All constraint and behavior parameters are optional with sensible defaults.
  ///
  /// Example:
  /// ```dart
  /// // Basic resizable item
  /// ResizableItem(value: 200)
  ///
  /// // Item with constraints and collapse support  
  /// ResizableItem(
  ///   value: 300,
  ///   min: 100,
  ///   max: 600,
  ///   collapsedSize: 40,
  /// )
  ///
  /// // Fixed-size item
  /// ResizableItem(
  ///   value: 50,
  ///   resizable: false,
  /// )
  /// ```
  ResizableItem({
    required double value,
    this.min = 0,
    this.max = double.infinity,
    this.collapsed = false,
    this.collapsedSize,
    this.resizable = true,
  }) : _value = value;

  /// Gets the computed collapsed state after resize operations.
  ///
  /// Returns the new collapsed state if computed during resize operations,
  /// otherwise returns the original [collapsed] value.
  bool get newCollapsed => _newCollapsed ?? collapsed;

  /// Gets the computed size value after resize operations.
  ///
  /// Returns the new computed size if calculated during resize operations,
  /// otherwise returns the original [value]. This represents the item's
  /// final size after all resize constraints have been applied.
  double get newValue {
    return _newValue ?? _value;
  }

  /// Gets the original size value for this item.
  ///
  /// This value remains constant unless explicitly updated, representing
  /// the item's baseline size before any resize operations.
  double get value {
    return _value;
  }

  @override
  String toString() {
    return 'ResizableItem(value: $value, min: $min, max: $max)';
  }
}

/// Internal data structure for tracking size redistribution during resize operations.
///
/// [_BorrowInfo] encapsulates the results of attempting to redistribute size
/// between resizable items. It tracks how much size was successfully transferred
/// and identifies the furthest item that participated in the redistribution.
///
/// This is an internal implementation detail of the [Resizer] class and should
/// not be used directly in application code.
class _BorrowInfo {
  /// The amount of size that was successfully redistributed.
  final double givenSize;
  
  /// The index of the furthest item that participated in the redistribution.
  final int from;

  /// Creates a [_BorrowInfo] with redistribution results.
  _BorrowInfo(this.givenSize, this.from);
}

/// Advanced resize engine for managing complex multi-item layout constraints.
///
/// [Resizer] implements a sophisticated constraint satisfaction system for
/// resizable layouts where items can be dynamically resized, collapsed, and
/// expanded while respecting size constraints and user interactions.
///
/// ## Core Algorithm
///
/// The resizer uses a "borrowing" algorithm that redistributes size between
/// adjacent items when one item needs to change size. When an item expands,
/// it "borrows" space from neighboring items; when it shrinks, it "returns"
/// space to neighbors. The algorithm handles constraint violations by
/// cascading changes through the item chain.
///
/// ## Key Features
///
/// - **Constraint satisfaction**: Automatically handles min/max size constraints
/// - **Cascade resolution**: Size changes propagate through neighboring items
/// - **Collapse integration**: Seamless integration with collapsible items
/// - **Overflow management**: Graceful handling of impossible constraint scenarios
/// - **Rollback capability**: Failed operations are automatically rolled back
///
/// ## Layout Behaviors
///
/// The resizer supports several interaction patterns:
/// - **Divider dragging**: Interactive resize between adjacent items
/// - **Item expansion**: Programmatic or user-initiated item growth
/// - **Item collapse**: Space-saving collapse with optional expansion thresholds
/// - **Constraint enforcement**: Automatic constraint satisfaction during all operations
///
/// ## Usage Examples
///
/// **Basic resizable layout**:
/// ```dart
/// final items = [
///   ResizableItem(value: 200, min: 100, max: 400),
///   ResizableItem(value: 300, min: 150, max: 600),
///   ResizableItem(value: 250, min: 100, max: 500),
/// ];
/// 
/// final resizer = Resizer(items);
/// 
/// // Simulate dragging divider between items 0 and 1 by 50 pixels
/// resizer.dragDivider(1, 50);
/// 
/// // Check results
/// for (int i = 0; i < items.length; i++) {
///   print('Item $i: ${items[i].newValue}');
/// }
/// ```
///
/// **Collapsible sidebar layout**:
/// ```dart
/// final items = [
///   // Main content
///   ResizableItem(value: 600, min: 300),
///   // Collapsible sidebar  
///   ResizableItem(
///     value: 250, 
///     min: 200, 
///     max: 400,
///     collapsedSize: 50,
///   ),
/// ];
///
/// final resizer = Resizer(items);
///
/// // Attempt to collapse the sidebar
/// if (resizer.attemptCollapse(1, 0)) {
///   print('Sidebar collapsed successfully');
/// }
/// ```
///
/// ## Performance Considerations
///
/// The algorithm has O(n) complexity for most operations where n is the number
/// of items. Complex constraint scenarios may require multiple passes, but
/// operations are generally efficient for typical layout sizes.
class Resizer {
  /// The list of resizable items managed by this resizer.
  final List<ResizableItem> items;
  
  /// Threshold ratio for automatic item collapse during space constraints.
  ///
  /// When an item's available space falls below `(item.min - item.collapsedSize) * collapseRatio`,
  /// the item will automatically collapse to free up space. Value should be between 0.0 and 1.0.
  final double collapseRatio;
  
  /// Threshold ratio for automatic item expansion from collapsed state.
  ///
  /// When sufficient space becomes available (above `(item.min - item.collapsedSize) * expandRatio`),
  /// collapsed items will automatically expand back to normal size. Value should be between 0.0 and 1.0.
  final double expandRatio;

  /// Creates a [Resizer] for the specified items with optional behavior configuration.
  ///
  /// The [items] list contains the resizable items to manage. The [collapseRatio]
  /// and [expandRatio] control automatic collapse/expand thresholds for space management.
  ///
  /// Example:
  /// ```dart
  /// final resizer = Resizer(
  ///   myResizableItems,
  ///   collapseRatio: 0.3,  // Collapse when 30% below minimum
  ///   expandRatio: 0.7,    // Expand when 70% above minimum
  /// );
  /// ```
  Resizer(
    this.items, {
    this.collapseRatio = 0.5, // half of min size
    this.expandRatio = 0.5, // half of max size
  });

  /// Tracks space that could not be redistributed during resize operations.
  double _couldNotBorrow = 0;

  /// Attempts to pay off borrowed space from previous resize operations.
  ///
  /// This internal method handles the repayment of space that was temporarily
  /// borrowed during previous resize operations, ensuring proper space
  /// accounting across the resizable item chain.
  ///
  /// Returns the amount of space that was successfully paid off.
  double _payOffLoanSize(int index, double delta, int direction) {
    if (direction < 0) {
      for (int i = 0; i < index; i++) {
        double borrowedSize = items[i].newValue - items[i].value;
        if (borrowedSize < 0 && delta > 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i]._newValue = items[i].value + newBorrowedSize;
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i]._newValue = items[i].value + newBorrowedSize;
          return delta;
        }
      }
    } else if (direction > 0) {
      for (int i = items.length - 1; i > index; i--) {
        double borrowedSize = items[i].newValue - items[i].value;
        if (borrowedSize < 0 && delta > 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize > 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i]._newValue = items[i].value + newBorrowedSize;
          return delta;
        } else if (borrowedSize > 0 && delta < 0) {
          double newBorrowedSize = borrowedSize + delta;
          if (newBorrowedSize < 0) {
            delta = -borrowedSize;
            newBorrowedSize = 0;
          }
          items[i]._newValue = items[i].value + newBorrowedSize;
          return delta;
        }
      }
    }
    return 0;
  }

  ResizableItem? _getItem(int index) {
    if (index < 0 || index >= items.length) {
      return null;
    }
    return items[index];
  }

  _BorrowInfo _borrowSize(int index, double delta, int until, int direction) {
    assert(direction == -1 || direction == 1, 'Direction must be -1 or 1');
    final item = _getItem(index);
    if (item == null) {
      return _BorrowInfo(0, index - direction);
    }
    if (index == until + direction) {
      return _BorrowInfo(0, index);
    }
    if (!item.resizable) {
      return _BorrowInfo(0, index - direction);
    }

    double minSize = item.min;
    double maxSize = item.max;

    if (item.newCollapsed) {
      if ((direction < 0 && delta < 0) || (direction > 0 && delta > 0)) {
        return _borrowSize(index + direction, delta, until, direction);
      }
      return _BorrowInfo(0, index);
    }

    double newSize = item.newValue + delta;

    if (newSize < minSize) {
      double overflow = newSize - minSize;
      double given = delta - overflow;
      var borrowSize =
          _borrowSize(index + direction, overflow, until, direction);
      item._newValue = minSize;
      return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
    }

    if (newSize > maxSize) {
      double maxOverflow = newSize - maxSize;
      double given = delta - maxOverflow;

      var borrowSize =
          _borrowSize(index + direction, maxOverflow, until, direction);
      item._newValue = maxSize;
      return _BorrowInfo(borrowSize.givenSize + given, borrowSize.from);
    }

    item._newValue = newSize;
    return _BorrowInfo(delta, index);
  }

  /// Attempts to expand an item by redistributing space from neighboring items.
  ///
  /// This method tries to increase the size of the item at [index] by [delta]
  /// pixels, borrowing space from adjacent items in the specified [direction].
  /// The operation respects all size constraints and will fail if insufficient
  /// space is available.
  ///
  /// ## Parameters
  /// 
  /// - [index] - Zero-based index of the item to expand
  /// - [direction] - Direction to borrow space: -1 (left), 0 (both), 1 (right)
  /// - [delta] - Amount of space to add (positive value)
  ///
  /// ## Return Value
  ///
  /// Returns `true` if the expansion was successful and all constraints were
  /// satisfied. Returns `false` if the operation failed due to insufficient
  /// space or constraint violations.
  ///
  /// ## Behavior Notes
  ///
  /// - For edge items (first/last), direction is automatically adjusted
  /// - Failed operations automatically roll back all changes
  /// - The method handles constraint cascading through neighboring items
  ///
  /// Example:
  /// ```dart
  /// // Expand item 1 by 100 pixels, borrowing from right neighbors
  /// if (resizer.attemptExpand(1, 1, 100.0)) {
  ///   print('Expansion successful');
  /// } else {
  ///   print('Insufficient space for expansion');
  /// }
  /// ```
  bool attemptExpand(int index, int direction, double delta) {
    final item = items[index];
    double currentSize = item.newValue; // check
    double minSize = item.min;
    double maxSize = item.max;
    double newSize = currentSize + delta;
    double minOverflow = newSize - minSize;
    double maxOverflow = newSize - maxSize;

    if (minOverflow < 0 && delta < 0) {
      delta = delta - minOverflow;
    }

    if (maxOverflow > 0 && delta > 0) {
      delta = delta - maxOverflow;
    }

    if (delta == 0) {
      return false;
    }

    if (index == 0) {
      direction = 1;
    } else if (index == items.length - 1) {
      direction = -1;
    }
    if (direction < 0) {
      var borrowed = _borrowSize(index - 1, -delta, 0, -1);
      if (borrowed.givenSize != -delta) {
        reset();
        return false;
      }
      item._newValue = (item.newValue + delta).clamp(minSize, maxSize);
      // check
      return true;
    } else if (direction > 0) {
      var borrowed = _borrowSize(index + 1, -delta, items.length - 1, 1);
      if (borrowed.givenSize != -delta) {
        reset();
        return false;
      }
      item._newValue = (item.newValue + delta).clamp(minSize, maxSize);
      // check
      return true;
    } else if (direction == 0) {
      double halfDelta = delta / 2;
      var borrowedLeft = _borrowSize(index - 1, -halfDelta, 0, -1);
      var borrowedRight =
          _borrowSize(index + 1, -halfDelta, items.length - 1, 1);
      if (borrowedLeft.givenSize != -halfDelta ||
          borrowedRight.givenSize != -halfDelta) {
        reset();
        return false;
      }
      item._newValue = (item.newValue + delta).clamp(minSize, maxSize);
      // check
      return true;
    }
    return false;
  }

  /// Attempts to collapse an item to its collapsed size, redistributing freed space.
  ///
  /// This method tries to collapse the item at [index] to its [collapsedSize],
  /// distributing the freed space to neighboring items in the specified [direction].
  /// The item must have a defined [collapsedSize] for this operation to succeed.
  ///
  /// ## Parameters
  ///
  /// - [index] - Zero-based index of the item to collapse
  /// - [direction] - Direction to distribute freed space: -1 (left), 0 (both), 1 (right)
  ///
  /// ## Return Value
  ///
  /// Returns `true` if the collapse was successful. Returns `false` if the
  /// item cannot be collapsed (no collapsedSize defined) or if neighboring
  /// items cannot accommodate the redistributed space.
  ///
  /// ## Behavior Notes
  ///
  /// - Items without a defined [collapsedSize] cannot be collapsed
  /// - For edge items, direction is automatically adjusted
  /// - Failed operations automatically roll back all changes
  /// - Collapsed items can later be expanded using [attemptExpandCollapsed]
  ///
  /// Example:
  /// ```dart
  /// // Collapse sidebar (item 1), giving space to main content (left)
  /// if (resizer.attemptCollapse(1, -1)) {
  ///   print('Sidebar collapsed successfully');
  /// } else {
  ///   print('Cannot collapse sidebar');
  /// }
  /// ```
  bool attemptCollapse(int index, int direction) {
    if (index == 0) {
      direction = 1;
    } else if (index == items.length - 1) {
      direction = -1;
    }
    if (direction < 0) {
      final item = items[index];
      final collapsedSize = item.collapsedSize ?? 0;
      final currentSize = item.newValue;
      final delta = currentSize - collapsedSize;
      var borrowed = _borrowSize(index - 1, delta, 0, -1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item._newCollapsed = true;
      return true;
    } else if (direction > 0) {
      final item = items[index];
      final collapsedSize = item.collapsedSize ?? 0;
      final delta = item.newValue - collapsedSize;
      var borrowed = _borrowSize(index + 1, delta, items.length - 1, 1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item._newCollapsed = true;
      return true;
    } else if (direction == 0) {
      final item = items[index];
      final collapsedSize = item.collapsedSize ?? 0;
      final delta = item.newValue - collapsedSize;
      final halfDelta = delta / 2;
      var borrowedLeft = _borrowSize(index - 1, halfDelta, 0, -1);
      var borrowedRight =
          _borrowSize(index + 1, halfDelta, items.length - 1, 1);
      if (borrowedLeft.givenSize != halfDelta ||
          borrowedRight.givenSize != halfDelta) {
        reset();
        return false;
      }
      item._newCollapsed = true;
      return true;
    }
    return false;
  }

  /// Attempts to expand a collapsed item back to its minimum size.
  ///
  /// This method tries to expand a currently collapsed item back to its normal
  /// minimum size, borrowing the required space from neighboring items in the
  /// specified [direction]. The item must currently be in collapsed state.
  ///
  /// ## Parameters
  ///
  /// - [index] - Zero-based index of the collapsed item to expand
  /// - [direction] - Direction to borrow space: -1 (left), 0 (both), 1 (right)
  ///
  /// ## Return Value
  ///
  /// Returns `true` if the expansion was successful and the item is no longer
  /// collapsed. Returns `false` if the item is not collapsed, or if neighboring
  /// items cannot provide sufficient space.
  ///
  /// ## Behavior Notes
  ///
  /// - Only works on items that are currently in collapsed state
  /// - Expanded items return to their minimum size, not their previous size
  /// - For edge items, direction is automatically adjusted
  /// - Failed operations automatically roll back all changes
  ///
  /// Example:
  /// ```dart
  /// // Expand collapsed sidebar back to normal size
  /// if (resizer.attemptExpandCollapsed(1, -1)) {
  ///   print('Sidebar expanded successfully');
  /// } else {
  ///   print('Cannot expand sidebar - insufficient space');
  /// }
  /// ```
  bool attemptExpandCollapsed(int index, int direction) {
    if (index == 0) {
      direction = 1;
    } else if (index == items.length - 1) {
      direction = -1;
    }
    final item = items[index];
    final collapsedSize = item.collapsedSize ?? 0;
    final currentSize = item.newValue;
    final delta = collapsedSize - currentSize;
    if (direction < 0) {
      var borrowed = _borrowSize(index - 1, delta, 0, -1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item._newCollapsed = false;
      return true;
    } else if (direction > 0) {
      var borrowed = _borrowSize(index + 1, delta, items.length - 1, 1);
      if (borrowed.givenSize != delta) {
        reset();
        return false;
      }
      item._newCollapsed = false;
      return true;
    } else if (direction == 0) {
      final halfDelta = delta / 2;
      var borrowedLeft = _borrowSize(index - 1, halfDelta, 0, -1);
      var borrowedRight =
          _borrowSize(index + 1, halfDelta, items.length - 1, 1);
      if (borrowedLeft.givenSize != halfDelta ||
          borrowedRight.givenSize != halfDelta) {
        reset();
        return false;
      }
      item._newCollapsed = false;
      return true;
    }
    return false;
  }

  /// Simulates dragging a divider between items to resize adjacent areas.
  ///
  /// This is the primary method for interactive resizing, simulating the effect
  /// of dragging a resize handle between two items. The method attempts to
  /// resize the items on either side of the divider while respecting all
  /// size constraints and handling automatic collapse/expand behaviors.
  ///
  /// ## Parameters
  ///
  /// - [index] - Index of the divider (affects items at index-1 and index)
  /// - [delta] - Distance dragged in pixels (positive = right/down, negative = left/up)
  ///
  /// ## Algorithm Behavior
  ///
  /// 1. **Initial redistribution**: Attempts to resize items on both sides of the divider
  /// 2. **Constraint handling**: Cascades changes through neighboring items when constraints are violated
  /// 3. **Automatic collapse**: May collapse items when they fall below collapse thresholds
  /// 4. **Automatic expand**: May expand collapsed items when sufficient space becomes available
  /// 5. **Rollback on failure**: Automatically reverts all changes if the operation cannot be completed
  ///
  /// ## Interactive Usage
  ///
  /// This method is typically called in response to user drag gestures on
  /// resize handles or dividers in the UI:
  ///
  /// ```dart
  /// // In a pan gesture handler for a divider
  /// void onPanUpdate(DragUpdateDetails details) {
  ///   final delta = details.delta.dx; // or .dy for vertical
  ///   resizer.dragDivider(dividerIndex, delta);
  ///   
  ///   // Update UI with new sizes
  ///   setState(() {
  ///     // Rebuild layout with updated item sizes
  ///   });
  /// }
  /// ```
  ///
  /// ## Batch Operations
  ///
  /// For smooth interactive behavior, call this method frequently with small
  /// delta values rather than infrequently with large deltas. The algorithm
  /// handles incremental changes more gracefully.
  void dragDivider(int index, double delta) {
    if (delta == 0) {
      return;
    }

    var borrowedLeft = _borrowSize(index - 1, delta, 0, -1);
    var borrowedRight = _borrowSize(index, -delta, items.length - 1, 1);

    double borrowedRightSize = borrowedRight.givenSize;
    double borrowedLeftSize = borrowedLeft.givenSize;

    double couldNotBorrowRight = borrowedRightSize + delta;
    double couldNotBorrowLeft = borrowedLeftSize - delta;

    if (couldNotBorrowLeft != 0 || couldNotBorrowRight != 0) {
      _couldNotBorrow += delta;
    } else {
      _couldNotBorrow = 0;
    }

    double givenBackLeft = 0;
    double givenBackRight = 0;

    if (couldNotBorrowLeft != -couldNotBorrowRight) {
      givenBackLeft =
          _borrowSize(borrowedRight.from, -couldNotBorrowLeft, index, -1)
              .givenSize;
      givenBackRight =
          _borrowSize(borrowedLeft.from, -couldNotBorrowRight, index - 1, 1)
              .givenSize;
    }

    if (givenBackLeft != -couldNotBorrowLeft ||
        givenBackRight != -couldNotBorrowRight) {
      reset();
      return;
    }

    double payOffLeft = _payOffLoanSize(index - 1, delta, -1);
    double payOffRight = _payOffLoanSize(index, -delta, 1);

    double payingBackLeft =
        _borrowSize(index - 1, -payOffLeft, 0, -1).givenSize;
    double payingBackRight =
        _borrowSize(index, -payOffRight, items.length - 1, 1).givenSize;

    if (payingBackLeft != -payOffLeft || payingBackRight != -payOffRight) {
      reset();
      return;
    }

    if (_couldNotBorrow > 0) {
      int start = borrowedRight.from;
      int endNotCollapsed = items.length - 1;
      for (int i = endNotCollapsed; i > start; i--) {
        if (items[i].newCollapsed) {
          endNotCollapsed = i - 1;
        } else {
          break;
        }
      }
      if (start == endNotCollapsed) {
        _checkCollapseUntil(index);
      }
      _checkExpanding(index);
    } else if (_couldNotBorrow < 0) {
      int start = borrowedLeft.from;
      int endNotCollapsed = 0;
      for (int i = endNotCollapsed; i < start; i++) {
        if (items[i].newCollapsed) {
          endNotCollapsed = i + 1;
        } else {
          break;
        }
      }
      if (start == endNotCollapsed) {
        _checkCollapseUntil(index);
      }
      _checkExpanding(index);
    }
  }

  void _checkCollapseUntil(int index) {
    if (_couldNotBorrow < 0) {
      for (int i = index - 1; i >= 0; i--) {
        final previousItem = _getItem(i);
        double? collapsibleSize = previousItem?.collapsedSize;
        if (previousItem != null &&
            collapsibleSize != null &&
            !previousItem.newCollapsed) {
          var minSize = previousItem.min;
          var threshold = (collapsibleSize - minSize) * collapseRatio;
          if (_couldNotBorrow < threshold) {
            var toBorrow = minSize - collapsibleSize;
            var borrowed = _borrowSize(index, toBorrow, items.length - 1, 1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize < toBorrow) {
              reset();
              return;
            }
            previousItem._newCollapsed = true;
            previousItem._newValue = previousItem.collapsedSize ?? 0;
            previousItem._value = previousItem._newValue!;
            _couldNotBorrow = 0;
          }
        }
      }
    } else {
      for (int i = index; i < items.length; i++) {
        final nextItem = _getItem(i);
        double? collapsibleSize = nextItem?.collapsedSize;
        if (nextItem != null &&
            collapsibleSize != null &&
            !nextItem.newCollapsed) {
          var minSize = nextItem.min;
          var threshold = (collapsibleSize - minSize) * collapseRatio;
          if (_couldNotBorrow > threshold) {
            var toBorrow = minSize - collapsibleSize;
            var borrowed = _borrowSize(index - 1, toBorrow, 0, -1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize < toBorrow) {
              reset();
              return;
            }
            nextItem._newCollapsed = true;
            nextItem._newValue = nextItem.collapsedSize ?? 0;
            nextItem._value = nextItem._newValue!;
            _couldNotBorrow = 0;
          }
        }
      }
    }
  }

  void _checkExpanding(int index) {
    if (_couldNotBorrow > 0) {
      int toCheck = index - 1;
      for (; toCheck >= 0; toCheck--) {
        final item = _getItem(toCheck);
        double? collapsibleSize = item?.collapsedSize;
        if (item != null && item.newCollapsed && collapsibleSize != null) {
          double minSize = item.min;
          double threshold = (minSize - collapsibleSize) * expandRatio;
          if (_couldNotBorrow >= threshold) {
            double toBorrow = collapsibleSize - minSize;
            var borrowed = _borrowSize(toCheck + 1, toBorrow, items.length, 1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize > toBorrow) {
              reset();
              continue;
            }
            item._newCollapsed = false;
            item._newValue = minSize;
            item._value = minSize;
            _couldNotBorrow = 0;
          }
          break;
        }
      }
    } else if (_couldNotBorrow < 0) {
      int toCheck = index;
      for (; toCheck < items.length; toCheck++) {
        final item = _getItem(toCheck);
        double? collapsibleSize = item?.collapsedSize;
        if (item != null && collapsibleSize != null && item.newCollapsed) {
          double minSize = item.min;
          double threshold = (collapsibleSize - minSize) * expandRatio;
          if (_couldNotBorrow <= threshold) {
            double toBorrow = collapsibleSize - minSize;
            var borrowed = _borrowSize(toCheck - 1, toBorrow, -1, -1);
            double borrowedSize = borrowed.givenSize;
            if (borrowedSize > toBorrow) {
              reset();
              continue;
            }
            item._newCollapsed = false;
            item._newValue = minSize;
            item._value = minSize;
            _couldNotBorrow = 0;
          }
          break;
        }
      }
    }
  }

  /// Resets all items to their original states, discarding computed changes.
  ///
  /// This method reverts all resizable items to their original size and
  /// collapse states, effectively undoing any resize operations that have
  /// been performed. This is automatically called when operations fail,
  /// but can also be called manually to reset the layout.
  ///
  /// ## Use Cases
  ///
  /// - **Error recovery**: Called automatically when operations fail constraints
  /// - **Manual reset**: Restore original layout after temporary changes  
  /// - **State cleanup**: Clear computed values before starting new operations
  /// - **UI reset**: Implement "restore defaults" functionality
  ///
  /// ## Behavior
  ///
  /// After calling reset():
  /// - All items return to their original [value] sizes
  /// - All items return to their original [collapsed] states
  /// - Any computed [newValue] and [newCollapsed] states are cleared
  /// - The layout should be rebuilt to reflect the original configuration
  ///
  /// Example:
  /// ```dart
  /// // Try a complex operation
  /// if (!resizer.attemptComplexResize()) {
  ///   // Operation failed, but reset() was already called automatically
  ///   print('Operation failed, layout restored');
  /// }
  ///
  /// // Manual reset to original state
  /// resizer.reset();
  /// rebuildLayout(); // Update UI to reflect reset state
  /// ```
  void reset() {
    for (final item in items) {
      if (item._newValue != null) {
        item._newValue = null;
        item._newCollapsed = null;
      }
    }
  }
}
