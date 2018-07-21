import 'package:flutter/foundation.dart';
import 'actions.dart';
import 'package:flutter_redux_app/app_state.dart';
import 'package:redux/redux.dart';
import 'dart:async';

List<Middleware<FRAAppState>> createStoreMiddleware() {
  return [
    TypedMiddleware<FRAAppState, SaveListAction>(_saveList)
  ];
}


Future _saveList(Store<FRAAppState> store, SaveListAction action, NextDispatcher next) async {
  await Future.sync(() => Duration(seconds: 3));
  next(action);
}