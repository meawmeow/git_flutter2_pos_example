import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_posv1/models/food_model.dart';
import 'package:flutter_posv1/models/table_model.dart';

abstract class TableUserEvent extends Equatable {
  const TableUserEvent();
}

class TableUserBeginList extends TableUserEvent {
  final List<TableModel> tableList;
  const TableUserBeginList({@required this.tableList})
      : assert(tableList != null);

  @override
  // TODO: implement props
  List<Object> get props => [tableList];
}

class TableUserAddEvent extends TableUserEvent {
  const TableUserAddEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TableUserRemoveEvent extends TableUserEvent {
  const TableUserRemoveEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TableUserUpdateEvent extends TableUserEvent {
  final TableModel tableModel;

  const TableUserUpdateEvent({@required this.tableModel})
      : assert(tableModel != null);

  @override
  // TODO: implement props
  List<Object> get props => [tableModel];
}

class TableUserClearEvent extends TableUserEvent {
  final int index;
  const TableUserClearEvent({@required this.index}) : assert(index != null);
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class TableFoodOrderEvent extends TableUserEvent {
  final List<FoodModel> foodList;
  final int index;

  const TableFoodOrderEvent({@required this.foodList, this.index})
      : assert(foodList != null);

  @override
  // TODO: implement props
  List<Object> get props => [foodList];
}
