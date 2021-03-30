import 'package:flutter_posv1/models/food_model.dart';

import '../models/table_model.dart';

class TableUserRepository {
  List<TableModel> tableList;

  TableUserRepository();

  List<TableModel> fetchUpdate(
      List<TableModel> tableList, TableModel tableModel) {
    tableList.elementAt(int.parse(tableModel.tableNumber) - 1);
    return tableList;
  }

  List<TableModel> fetchAdd(List<TableModel> tableList) {
    int index = tableList.length + 1;
    tableList.add(TableModel(index.toString(), false, []));
    return tableList;
  }

  List<TableModel> fetchRemove(List<TableModel> tableList) {
    int index = tableList.length - 1;
    if (index >= 0) {
      tableList.removeAt(index);
    }
    return tableList;
  }

  List<FoodModel> fetchFoodOrder(
      List<FoodModel> foodList, List<FoodModel> newList) {
    // List<FoodModel> temlist = List.castFrom(newList);
    // for (int i = 0; i < temlist.length; i++) {
    //   print("foodname:" +
    //       temlist[i].foodname +
    //       " count:" +
    //       temlist[i].count.toString());
    // }
    foodList.addAll(newList);
    return foodList;
  }

  List<TableModel> fetchTableUserClear(List<TableModel> tableList, int index) {
    tableList[index].isOpen = false;
    tableList[index].foodList.clear();
    return tableList;
  }
}
