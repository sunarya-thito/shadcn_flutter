/// Mutates a list to contain source elements with separators between them.
///
/// This function efficiently updates [separatedList] in place to match the pattern
/// of [source] elements interleaved with [separator] values. It minimizes memory
/// allocations by reusing existing list elements where possible.
///
/// ## Parameters
///
/// * [source] - The source list of elements to separate.
/// * [separatedList] - The list to mutate. Will be modified in place.
/// * [separator] - The separator value to insert between source elements.
///
/// ## Side Effects
///
/// Modifies [separatedList] to contain elements from [source] with [separator]
/// inserted between each pair of adjacent elements. If [separatedList] is too
/// long, extra elements are removed. If too short, new elements are added.
///
/// ## Example
///
/// ```dart
/// final source = [1, 2, 3];
/// final separated = <int>[];
/// mutateSeparated(source, separated, 0);
/// // separated is now [1, 0, 2, 0, 3]
///
/// // Update with new source
/// mutateSeparated([4, 5], separated, 0);
/// // separated is now [4, 0, 5]
/// ```
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

/// An iterable that inserts a separator between elements of another iterable.
///
/// This class wraps an existing iterable and lazily produces elements with
/// a separator value inserted between each pair of adjacent elements.
///
/// ## Type Parameters
///
/// * [T] - The type of elements in the iterable.
///
/// ## Overview
///
/// Use [SeparatedIterable] when you need to iterate over a collection with
/// separators but don't want to allocate a new list. The separation happens
/// lazily during iteration.
///
/// ## Example
///
/// ```dart
/// final numbers = [1, 2, 3, 4];
/// final separated = SeparatedIterable(numbers, 0);
///
/// print(separated.toList()); // [1, 0, 2, 0, 3, 0, 4]
/// ```
///
/// See also:
///
/// * [mutateSeparated] for in-place list mutation with separators.
class SeparatedIterable<T> extends Iterable<T> {
  final Iterable<T> _iterable;
  final T _separator;

  /// Creates a separated iterable.
  ///
  /// ## Parameters
  ///
  /// * [_iterable] - The source iterable to separate.
  /// * [_separator] - The separator value to insert between elements.
  SeparatedIterable(this._iterable, this._separator);

  @override
  Iterator<T> get iterator => SeparatedIterator(_iterable.iterator, _separator);
}

/// An iterator that yields elements with separators between them.
///
/// This iterator wraps an existing iterator and produces elements from the
/// source with a separator value inserted between each pair of adjacent
/// elements.
///
/// ## Type Parameters
///
/// * [T] - The type of elements being iterated.
///
/// ## Overview
///
/// [SeparatedIterator] is used internally by [SeparatedIterable]. It maintains
/// state to alternate between source elements and separator values.
///
/// ## Example
///
/// ```dart
/// final iterator = SeparatedIterator([1, 2, 3].iterator, 0);
///
/// while (iterator.moveNext()) {
///   print(iterator.current); // Prints: 1, 0, 2, 0, 3
/// }
/// ```
class SeparatedIterator<T> implements Iterator<T> {
  final Iterator<T> _iterator;
  final T _separator;
  T? _current;
  bool _isSeparator = false;
  bool? _hasNextAfterSeparator;

  /// Creates a separated iterator.
  ///
  /// ## Parameters
  ///
  /// * [_iterator] - The source iterator to separate.
  /// * [_separator] - The separator value to insert between elements.
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
