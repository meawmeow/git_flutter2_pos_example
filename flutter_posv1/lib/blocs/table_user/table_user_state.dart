import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_posv1/models/food_model.dart';
import 'package:flutter_posv1/models/table_model.dart';

// abstract class TableUserState extends Equatable {
//   const TableUserState(this.tableList);
//
//   final List<TableModel> tableList;
//
//   @override
//   List<Object> get props => [tableList];
// }

abstract class TableState {
  final List<TableModel> tableList;

  const TableState(this.tableList);
}

class TableUserState extends TableState {
  final List<TableModel> tableList;
  TableUserState(this.tableList) : super(tableList);

  @override
  // TODO: implement props
  List<Object> get props => [tableList];
}

// class FoodMenuState extends TableState {
//   final List<FoodModel> foodList;
//
//   FoodMenuState(this.foodList) : super(foodList);
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [foodList];
// }
