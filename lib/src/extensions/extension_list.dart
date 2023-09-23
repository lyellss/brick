import 'dart:typed_data';

extension ExtensionListNullAble on List? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isEffective => this != null && this!.isNotEmpty;
}

extension ExtensionList<E> on List<E> {
  List<R> mapWithIndex<R>(R Function(int index, E e) toElement) {
    List<R> result = [];
    for (int i = 0, len = length; i < len; ++i) {
      result.add(toElement(i, this[i]));
    }
    return result;
  }

  E? firstWhereOrNull(bool Function(E e) block) {
    for (int i = 0, len = length; i < len; ++i) {
      E element = elementAt(i);
      if (block.call(element)) {
        return element;
      }
    }
    return null;
  }

  /// Takes an action for each element.
  ///
  /// Calls [action] for each element along with the index in the
  /// iteration order.
  void forEachIndexed(void Function(int index, E element) action) {
    for (var index = 0; index < length; index++) {
      action(index, this[index]);
    }
  }

  /// Takes an action for each element as long as desired.
  ///
  /// Calls [action] for each element.
  /// Stops iteration if [action] returns `false`.
  void forEachWhile(bool Function(E element) action) {
    for (var index = 0; index < length; index++) {
      if (!action(this[index])) break;
    }
  }

  /// Takes an action for each element and index as long as desired.
  ///
  /// Calls [action] for each element along with the index in the
  /// iteration order.
  /// Stops iteration if [action] returns `false`.
  void forEachIndexedWhile(bool Function(int index, E element) action) {
    for (var index = 0; index < length; index++) {
      if (!action(index, this[index])) break;
    }
  }
}

extension IntListExtension on List<int> {
  Uint8List get asUint8List {
    return Uint8List.fromList(this);
  }
}
