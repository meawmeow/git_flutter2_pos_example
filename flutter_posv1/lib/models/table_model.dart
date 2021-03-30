import 'food_model.dart';

class TableModel {
  String tableNumber;
  bool isOpen = false;
  final List<FoodModel> foodList;
  TableModel(this.tableNumber, this.isOpen, this.foodList);
}
