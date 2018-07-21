import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_app/app_state.dart';
import 'package:flutter_redux_app/middlewares.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_app/reducer.dart';
import 'package:flutter_redux_app/home_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Store<FRAAppState> store = Store<FRAAppState>(
    appReducer,
    initialState: FRAAppState.init(),
    middleware: createStoreMiddleware(),
  );


  @override
  Widget build(BuildContext context) => StoreProvider(
    store: this.store,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomeScreen(),
    ),
  );

}

