import 'package:flutter/foundation.dart';
import 'package:flutter_redux_app/to_do_item.dart';


class RemoveItemAction {
  final ToDoItem item;
  RemoveItemAction({
    this.item
  });
}

class AddItemAction {
  final ToDoItem item;
  AddItemAction({
    this.item
  });
}

class DisplayListOnlyAction {}

class DisplayListWithNewItemAction {}

class SaveListAction {}

