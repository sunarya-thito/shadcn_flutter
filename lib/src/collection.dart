/// Efficiently mutates a list to maintain separation between source elements.
///
/// [mutateSeparated] provides an in-place transformation that takes a source list
/// and maintains a separated list where each pair of consecutive source elements
/// is separated by a specified separator value. This is more memory-efficient
/// than creating new lists when the separated list needs frequent updates.
///
/// ## Algorithm Behavior
///
/// The function modifies [separatedList] to contain source elements interspersed
/// with separators, following the pattern: `[item1, separator, item2, separator, item3]`.
/// The algorithm reuses existing list capacity when possible and only allocates
/// new space when the separated list needs to grow.
///
/// ## Performance Characteristics
///
/// - **Time complexity**: O(n) where n is the length of the source list
/// - **Space complexity**: O(1) additional space (modifies existing list)
/// - **Memory efficiency**: Reuses existing list capacity, minimizing allocations
///
/// ## Parameters
///
/// - [source] - The source list whose elements will be separated
/// - [separatedList] - The target list to mutate (modified in place)
/// - [separator] - The value to insert between consecutive source elements
///
/// Example:
/// ```dart
/// final items = ['A', 'B', 'C'];
/// final result = <String>[];
/// 
/// mutateSeparated(items, result, '|');
/// print(result); // ['A', '|', 'B', '|', 'C']
/// 
/// // Efficient updates - reuses existing list capacity
/// items.add('D');
/// mutateSeparated(items, result, '|');
/// print(result); // ['A', '|', 'B', '|', 'C', '|', 'D']
/// ```
///
/// ## Use Cases
///
/// This function is particularly useful for:
/// - UI widget lists that need separators (dividers, spacers)
/// - Data formatting with consistent delimiters
/// - Real-time list updates where allocation overhead matters
/// - Building separated collections from dynamic data sources
void mutateSeparated<T>(List<T> source, List<T> separatedList, T separator) {
  int targetIndex = 0; // Position in separatedList we're modifying

  for (int i = 0; i < source.length; i++) {
    // Update or add source element
    if (targetIndex < separatedList.length) {
      separatedList[targetIndex] = source[i];
    } else {
      separatedList.add(source[i]);
    }
    targetIndex++;

    // Update or add separator if not the last element
    if (i < source.length - 1) {
      if (targetIndex < separatedList.length) {
        separatedList[targetIndex] = separator;
      } else {
        separatedList.add(separator);
      }
      targetIndex++;
    }
  }

  // Remove extra elements if separatedList is too long
  if (targetIndex < separatedList.length) {
    separatedList.removeRange(targetIndex, separatedList.length);
  }
}

/// A lazy iterable that intersperses a separator value between source elements.
///
/// [SeparatedIterable] provides a memory-efficient way to create separated
/// sequences without materializing the entire result list. It implements
/// the [Iterable] interface to enable lazy evaluation and integration with
/// standard Dart collection operations.
///
/// ## Lazy Evaluation Benefits
///
/// - **Memory efficiency**: No intermediate list creation
/// - **Performance optimization**: Only computes values as needed
/// - **Composable**: Works with standard Dart collection methods
/// - **Streaming friendly**: Suitable for large or infinite sequences
///
/// The separated sequence follows the pattern:
/// `[item1, separator, item2, separator, ..., itemN]`
/// where the separator appears between every pair of consecutive source elements.
///
/// ## Usage Patterns
///
/// **Basic separation**:
/// ```dart
/// final numbers = [1, 2, 3, 4];
/// final separated = SeparatedIterable(numbers, 0);
/// print(separated.toList()); // [1, 0, 2, 0, 3, 0, 4]
/// ```
///
/// **Chaining with collection methods**:
/// ```dart
/// final words = ['hello', 'world', 'flutter'];
/// final result = SeparatedIterable(words, '|')
///     .map((s) => s.toUpperCase())
///     .where((s) => s.length > 1)
///     .toList();
/// // ['HELLO', '|', 'WORLD', '|', 'FLUTTER']
/// ```
///
/// **Widget separation in Flutter**:
/// ```dart
/// final widgets = [Text('A'), Text('B'), Text('C')];
/// final separated = SeparatedIterable(widgets, Divider());
/// 
/// Column(
///   children: separated.toList(),
/// );
/// ```
///
/// ## Performance Notes
///
/// For small collections or when the full result is immediately needed,
/// consider using [mutateSeparated] for better performance. Use
/// [SeparatedIterable] when working with large datasets, streaming data,
/// or when lazy evaluation provides clear memory benefits.
class SeparatedIterable<T> extends Iterable<T> {
  /// The source iterable whose elements will be separated.
  final Iterable<T> _iterable;
  
  /// The separator value to insert between consecutive elements.
  final T _separator;

  /// Creates a [SeparatedIterable] with the given source and separator.
  ///
  /// The [separator] will be inserted between each pair of consecutive
  /// elements from the source [iterable]. The original elements maintain
  /// their order and values.
  ///
  /// Example:
  /// ```dart
  /// final separated = SeparatedIterable(['a', 'b', 'c'], '-');
  /// print(separated.join('')); // 'a-b-c'
  /// ```
  SeparatedIterable(this._iterable, this._separator);

  @override
  Iterator<T> get iterator => SeparatedIterator(_iterable.iterator, _separator);
}

/// Iterator implementation for [SeparatedIterable] that lazily generates separated sequences.
///
/// [SeparatedIterator] implements the stateful iteration logic required to
/// intersperse separator values between source elements. It maintains internal
/// state to track whether the next value should be a source element or separator,
/// ensuring correct sequence generation without materializing the full result.
///
/// ## State Management
///
/// The iterator maintains several pieces of state:
/// - Current position in the iteration sequence
/// - Whether the next value is a separator or source element
/// - Look-ahead information to determine sequence continuation
///
/// This state-based approach enables efficient lazy evaluation while maintaining
/// correct separator placement throughout the iteration process.
///
/// **Note**: This class is an implementation detail of [SeparatedIterable] and
/// should not be used directly. Use [SeparatedIterable] to create separated
/// sequences in application code.
class SeparatedIterator<T> implements Iterator<T> {
  /// The source iterator providing elements to be separated.
  final Iterator<T> _iterator;
  
  /// The separator value to insert between consecutive elements.
  final T _separator;
  
  /// The current value in the iteration sequence.
  T? _current;
  
  /// Whether the current iteration position represents a separator.
  bool _isSeparator = false;
  
  /// Cached look-ahead information for sequence continuation.
  bool? _hasNextAfterSeparator;

  /// Creates a [SeparatedIterator] for the given source iterator and separator.
  ///
  /// The iterator will produce elements from the source interspersed with
  /// the separator value, following the pattern defined by [SeparatedIterable].
  SeparatedIterator(this._iterator, this._separator);

  @override
  T get current => _current!;

  @override
  bool moveNext() {
    var hasNextAfterSeparator = _hasNextAfterSeparator;
    if (_isSeparator) {
      if (hasNextAfterSeparator != null) {
        _isSeparator = false;
        _hasNextAfterSeparator = null;
        if (hasNextAfterSeparator) {
          _current = _iterator.current;
          _isSeparator = true;
        }
        return hasNextAfterSeparator;
      }
      _hasNextAfterSeparator = _iterator.moveNext();
      if (_hasNextAfterSeparator!) {
        _current = _separator;
        return true;
      }
      return false;
    }
    var moveNext = _iterator.moveNext();
    if (moveNext) {
      _current = _iterator.current;
      _isSeparator = true;
    }
    return moveNext;
  }
}
