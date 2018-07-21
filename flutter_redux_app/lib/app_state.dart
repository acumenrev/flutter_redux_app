import 'package:flutter/foundation.dart';
import 'to_do_item.dart';

enum ListState {
  listOnly,
  listWithNewItem
}

class FRAAppState {
  List<ToDoItem> toDos;
  final ListState currentState;

  FRAAppState({
    this.toDos,
    this.currentState
  });

  factory FRAAppState.init() {
    return FRAAppState(toDos: List.unmodifiable([]),
    currentState: ListState.listOnly);
  }
}