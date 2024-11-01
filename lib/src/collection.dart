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

class SeparatedIterable<T> extends Iterable<T> {
  final Iterable<T> _iterable;
  final T _separator;

  SeparatedIterable(this._iterable, this._separator);

  @override
  Iterator<T> get iterator => SeparatedIterator(_iterable.iterator, _separator);
}

class SeparatedIterator<T> implements Iterator<T> {
  final Iterator<T> _iterator;
  final T _separator;
  T? _current;
  bool _isSeparator = false;
  bool? _hasNextAfterSeparator;

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
