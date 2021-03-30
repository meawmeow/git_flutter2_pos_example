import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/data_generator.dart';
import 'package:flutter_posv1/models/food_model.dart';
import 'package:flutter_posv1/utils/constant.dart';
import 'package:flutter_posv1/widgets/control_food_count.dart';

import '../models/table_model.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({Key key, this.tableModel}) : super(key: key);
  final TableModel tableModel;

  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  List<FoodModel> foodList = List();

  var gradientColor = GradientTemplate.gradientTemplate[5].colors;

  addFood(FoodModel item) {
    setState(() {
      if (foodList.contains(item)) {
        var index = foodList.indexOf(item);
        foodList[index].count = item.count;
      } else {
        foodList.add(item);
      }
      List<FoodModel> newFoodList =
          foodList.where((u) => u.count != 0).toList();

      foodList.clear();
      foodList.addAll(newFoodList);
      for (int i = 0; i < newFoodList.length; i++) {
        print("index:" +
            i.toString() +
            " name: " +
            newFoodList[i].foodname +
            " count: " +
            newFoodList[i].count.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "โต๊ะ " + widget.tableModel.tableNumber,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(child: BlocBuilder<TableUserBloc, TableState>(
        builder: (context, tableState) {
          return Column(
            children: [
              SizedBox(height: 10),
              Text(
                "โปรดเลือกรายการ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
              buildTop(tableState),
              Container(
                height: 100,
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        foodList.length.toString() + " รายการ",
                        style: TextStyle(fontSize: 18),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text(
                          "ตกลง",
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          context.read<TableUserBloc>().add(TableFoodOrderEvent(
                              foodList: foodList,
                              index: int.parse(widget.tableModel.tableNumber)));
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber.shade300,
                          onPrimary: Colors.black,
                          padding: EdgeInsets.only(
                              left: 25, right: 25, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                      // OutlinedButton.icon(
                      //   onPressed: () {
                      //     context.read<TableUserBloc>().add(
                      //         TableFoodOrderEvent(
                      //             foodList: foodList,
                      //             index: int.parse(
                      //                 widget.tableModel.tableNumber)));
                      //     Navigator.pop(context);
                      //   },
                      //   icon: Icon(Icons.add),
                      //   label: Text('ตกลง'),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }

  Widget buildTop(TableState tableState) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: DataGennerator.foods.length,
        itemBuilder: (context, index) {
          var indexFood = foodList.indexOf(DataGennerator.foods[index]);
          return Container(
            height: 70,
            child: Card(
              color: indexFood != -1
                  ? foodList[indexFood].count > 0
                      ? Colors.teal.shade100
                      : Colors.white
                  : Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DataGennerator.foods[index].foodname,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            DataGennerator.foods[index].price.toString() +
                                " บาท ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    ControlFoodCount(
                      food: DataGennerator.foods[index],
                      tableModel: widget.tableModel,
                      onSelectFood: addFood,
                    ),
                    //buildAddCount(context, DataGennerator.foods[index],tableState),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
