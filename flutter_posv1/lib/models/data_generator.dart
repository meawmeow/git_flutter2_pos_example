import 'package:flutter_posv1/models/food_model.dart';
import 'package:flutter_posv1/models/table_model.dart';

class DataGennerator {
  List<TableModel> tableList = [
    TableModel("1", false, []),
    TableModel("2", false, []),
    TableModel("3", false, []),
    TableModel("4", false, []),
    TableModel("5", false, []),
    TableModel("6", false, []),
    TableModel("7", false, []),
  ];

  static List<FoodModel> foods = [
    FoodModel("ข้าวผัดทะเล", 100, 0),
    FoodModel("ข้าวผัดต้มยำ", 20, 0),
    FoodModel("ข้าวผัดมันกุ้ง", 30, 0),
    FoodModel("ข้าวผัดปู", 70, 0),
    FoodModel("ข้าวผัดหมา", 10, 0),
    FoodModel("ข้าวผัดแมว", 10, 0),
    FoodModel("ต้มแมว", 20, 0),
    FoodModel("แมวปิ้ง", 150, 0),
    FoodModel("เนื้อแมว", 40, 0),
    FoodModel("ลูกชิ้นเนื้อแมว", 5, 0),
    FoodModel("สุกี้แห้ง", 60, 0),
    FoodModel("ข้าวไข่เจียว", 200, 0),
  ];

  static resetFoodCount() {
    for (int i = 0; i < foods.length; i++) {
      foods[i].count = 0;
    }
  }
  // DataGennerator(){
  //   tableList = List<TableModel>();
  // }
}
