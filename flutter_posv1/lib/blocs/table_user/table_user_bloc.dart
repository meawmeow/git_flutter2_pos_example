import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/data_generator.dart';
import 'package:flutter_posv1/models/food_model.dart';
import 'package:flutter_posv1/repositores/table_user_repository.dart';
import 'package:flutter_posv1/models/table_model.dart';

class TableUserBloc extends Bloc<TableUserEvent, TableState> {
  TableUserBloc(TableUserState initialState) : super(initialState);

  // @override
  // TableUserState get initialState => TableUserData(DataGennerator().tableList);

  @override
  Stream<TableUserState> mapEventToState(TableUserEvent event) async* {
    //add table
    if (event is TableUserAddEvent) {
      final List<TableModel> newList =
          TableUserRepository().fetchAdd(state.tableList);
      yield TableUserState(newList);
    }
    //remove table
    if (event is TableUserRemoveEvent) {
      final List<TableModel> newList =
          TableUserRepository().fetchRemove(state.tableList);
      yield TableUserState(newList);
    }

    if (event is TableUserUpdateEvent) {
      final List<TableModel> newList =
          TableUserRepository().fetchUpdate(state.tableList, event.tableModel);
      yield TableUserState(newList);
    }
    if (event is TableUserBeginList) {
      yield TableUserState(event.tableList);
    }

    if (event is TableFoodOrderEvent) {
      print("index table =" + event.index.toString());
      final List<FoodModel> newfoodlist = TableUserRepository().fetchFoodOrder(
          state.tableList[event.index - 1].foodList, event.foodList);
      yield TableUserState(state.tableList);
    }

    if (event is TableUserClearEvent) {
      final List<TableModel> tableList = TableUserRepository()
          .fetchTableUserClear(state.tableList, event.index);
      yield TableUserState(tableList);
    }
  }
}
