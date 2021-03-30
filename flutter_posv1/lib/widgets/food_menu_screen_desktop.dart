import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/data_generator.dart';
import 'package:flutter_posv1/models/food_model.dart';
import 'package:flutter_posv1/widgets/control_food_count.dart';

import '../models/table_model.dart';

class FoodMenuScreenDesktop extends StatefulWidget {
  const FoodMenuScreenDesktop({Key key, this.tableModel}) : super(key: key);
  final TableModel tableModel;

  @override
  _FoodMenuScreenDesktopState createState() => _FoodMenuScreenDesktopState();
}

class _FoodMenuScreenDesktopState extends State<FoodMenuScreenDesktop> {
  List<FoodModel> foodList = List();

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
    return Container(
      child: BlocBuilder<TableUserBloc, TableState>(
        builder: (context, tableState) {
          return Column(
            children: [
              Text(
                "โปรดเลือกรายการ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              buildTop(tableState),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        foodList.length.toString() + " รายการ",
                        style: TextStyle(fontSize: 18),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          var secondList = foodList
                              .map((item) => new FoodModel.clone(item))
                              .toList();
                          print("newLIst = " + secondList.length.toString());
                          context.read<TableUserBloc>().add(TableFoodOrderEvent(
                              foodList: secondList,
                              index: int.parse(widget.tableModel.tableNumber)));
                          //Navigator.pop(context);
                          //foodList.clear();
                          DataGennerator.resetFoodCount();
                          // setState(() {});
                        },
                        icon: Icon(Icons.add),
                        label: Text('ตกลง'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
                padding: const EdgeInsets.all(8.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (DataGennerator.foods[index].count > 0) {
                                DataGennerator.foods[index].count -= 1;
                                // DataGennerator.foods[index].count = -= 1;
                                addFood(DataGennerator.foods[index]);
                              }
                            });
                          },
                        ),
                        Text(
                          DataGennerator.foods[index].count.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              if (DataGennerator.foods[index].count >= 0) {
                                DataGennerator.foods[index].count += 1;
                                //DataGennerator.foods[index].count = count;
                                addFood(DataGennerator.foods[index]);
                              }
                            });
                          },
                        ),
                      ],
                    ),
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
