import 'package:flutter/foundation.dart';

class ListNotifier<T> extends ValueNotifier<List<T>> {
  ListNotifier(super.value);

  void add(T item) {
    value.add(item);
    notifyListeners();
  }

  void addAll(Iterable<T> items) {
    value.addAll(items);
    notifyListeners();
  }

  void remove(T item) {
    value.remove(item);
    notifyListeners();
  }
}