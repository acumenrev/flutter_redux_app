import 'package:flutter/foundation.dart';

class ToDoItem {
  final String title;

  ToDoItem({
    this.title
  });

  // bool operator ==(Object other) => identical(this, other) || other is ToDoItem && runtimeType == other.runtimeType && title == other.title;

  @override
  bool operator ==(other) {
    if (other is ToDoItem && runtimeType == other.runtimeType) {
      if (this.title == other.title) {
        return true;
      }
    }

    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => this.title.hashCode;
}