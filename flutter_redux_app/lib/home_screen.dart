import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'actions.dart';
import 'package:flutter_redux_app/app_state.dart';
import 'reducer.dart';
import 'to_do_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<FRAAppState, _ViewModel>(
      converter: (Store<FRAAppState> store) => _ViewModel.init(store),
      builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(viewModel.pageTitle),
        ),
        body: ListView(
          children: viewModel.items.map((_ItemViewModel item) => _createWidget(item)).toList(),
        ),
        floatingActionButton: FloatingActionButton(onPressed: viewModel.onAddItem,
        tooltip: viewModel.newItemToolTip,
        child: Icon(
          viewModel.newItemIcon
        ),),
      ),
    );
  }




  Widget _createWidget(_ItemViewModel item) {
    if (item is _EmptyItemViewModel) {
      return _createEmptyItemWidget(item);
    } else {
      return _createToDoItemWidget(item);
    }
  }

  Widget _createEmptyItemWidget(_EmptyItemViewModel item) {
    return Column(
      children: <Widget>[
        TextField(
          onSubmitted: item.onCreateItem,
          autofocus: true,
          decoration: InputDecoration(
            hintText: item.createItemToolTip
          ),
        )
      ],
    );
  }

  Widget _createToDoItemWidget(_ToDoItemViewModel item) {
    return Row(
      children: <Widget>[
        Text(item.title),
        FlatButton(
          onPressed: item.onDeleteItem,
          child: Icon(
            item.deleteItemIcon,
            semanticLabel: item.deleteItemToolTip,
          ),
        )
      ],
    );
  }
}

class _ViewModel {
  final String pageTitle;
  final List<_ItemViewModel> items;
  final Function() onAddItem;
  final String newItemToolTip;
  final IconData newItemIcon;

  _ViewModel({
    this.pageTitle,
    this.items,
    this.onAddItem,
    this.newItemIcon,
    this.newItemToolTip
  });

  factory _ViewModel.init(Store<FRAAppState> store) {
    List<_ItemViewModel> items = store.state.toDos.map(
            (ToDoItem item) => _ToDoItemViewModel(
                title: item.title,
                onDeleteItem: () {
      store.dispatch(RemoveItemAction(item: item));
      store.dispatch(SaveListAction());
    },
    deleteItemToolTip: 'Delete',
    deleteItemIcon: Icons.delete) ).toList();

    if (store.state.currentState == ListState.listWithNewItem) {
      items.add(_EmptyItemViewModel(
          hint: 'Type the next task here',
      onCreateItem: (String title) {
            store.dispatch(DisplayListOnlyAction());
            store.dispatch(AddItemAction(item: ToDoItem(title: title)));
            store.dispatch(SaveListAction());
      },
      createItemToolTip: 'Add'));
    }

    return _ViewModel(
      pageTitle: 'To Do',
      onAddItem: () => store.dispatch(DisplayListWithNewItemAction()),
      newItemToolTip: 'Add new to-do item',
      newItemIcon: Icons.add,
      items: items
    );
  }


}

abstract class _ItemViewModel {}


@immutable
class _EmptyItemViewModel extends _ItemViewModel {
  final String hint;
  final Function(String) onCreateItem;
  final String createItemToolTip;

  _EmptyItemViewModel({
    this.hint,
    this.onCreateItem,
    this.createItemToolTip
  });
}

@immutable
class _ToDoItemViewModel extends _ItemViewModel {
  final String title;
  final Function() onDeleteItem;
  final String deleteItemToolTip;
  final IconData deleteItemIcon;

  _ToDoItemViewModel({
    this.title,
    this.onDeleteItem,
    this.deleteItemIcon,
    this.deleteItemToolTip
});
}