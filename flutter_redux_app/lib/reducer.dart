import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_app/app_state.dart';
import 'actions.dart';
import 'to_do_item.dart';


FRAAppState appReducer(FRAAppState newState, dynamic action) {
  return FRAAppState(toDos: toDoListReducer(newState.toDos, action), currentState: listStateReducers(newState.currentState, action));
}


final Reducer<List<ToDoItem>> toDoListReducer = combineReducers([
    TypedReducer<List<ToDoItem>, AddItemAction>(_addItem),
    TypedReducer<List<ToDoItem>, RemoveItemAction>(_removeItem)
]);

List<ToDoItem> _removeItem(List<ToDoItem> toDos, RemoveItemAction action) {
  return List.unmodifiable(List.from(toDos)..remove(action.item));
}

List<ToDoItem> _addItem(List<ToDoItem> toDos, AddItemAction action) {
  return List.unmodifiable(List.from(toDos)..add(action.item));
}


final Reducer<ListState> listStateReducers = combineReducers([
  TypedReducer<ListState, DisplayListOnlyAction>(_displayListOnly),
  TypedReducer<ListState, DisplayListWithNewItemAction>(_displayListWithNewItem)
]);

ListState _displayListOnly(ListState listState, DisplayListOnlyAction action) {
  return ListState.listOnly;
}

ListState _displayListWithNewItem(ListState listState, DisplayListWithNewItemAction action) {
  return ListState.listWithNewItem;
}