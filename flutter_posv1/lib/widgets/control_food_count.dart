import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/food_model.dart';
import 'package:flutter_posv1/models/table_model.dart';

class ControlFoodCount extends StatefulWidget {
  final FoodModel food;
  final TableModel tableModel;
  final Function onSelectFood;

  const ControlFoodCount(
      {Key key, this.food, this.tableModel, this.onSelectFood})
      : super(key: key);

  @override
  _ControlFoodCountState createState() => _ControlFoodCountState();
}

class _ControlFoodCountState extends State<ControlFoodCount> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (count > 0) {
                count -= 1;
                widget.food.count = count;
                widget.onSelectFood(widget.food);
              }
            });
          },
        ),
        Text(
          count.toString(),
          style: TextStyle(fontSize: 15),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              if (count >= 0) {
                count += 1;
                widget.food.count = count;
                widget.onSelectFood(widget.food);
              }
            });
          },
        ),
      ],
    );
    //return buildAddCount(context, widget.food);
  }

  Widget buildAddCount(BuildContext context, FoodModel food) {
    int count = 0;
    return BlocBuilder<TableUserBloc, TableState>(
      builder: (context, tableState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  count -= 1;
                });
                // food.count = count;
                // context.read<TableUserBloc>().add(TableFoodOrderEvent(
                //     foodModel: food,
                //     index: int.parse(widget.tableModel.tableNumber)));
              },
            ),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 15),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  count += 1;
                });
                // food.count = count;
                // context.read<TableUserBloc>().add(TableFoodOrderEvent(
                //     foodModel: food,
                //     index: int.parse(widget.tableModel.tableNumber)));
              },
            ),
          ],
        );
      },
    );
  }
}
