import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/table_model.dart';
import 'package:flutter_posv1/screens/food_menu_screen.dart';
import 'package:flutter_posv1/utils/constant.dart';

class FooterOrder extends StatefulWidget {
  const FooterOrder({Key key, this.tableModel}) : super(key: key);
  final TableModel tableModel;

  @override
  _FooterOrderState createState() => _FooterOrderState();
}

class _FooterOrderState extends State<FooterOrder> {
  int sumOrder = 0;

  @override
  Widget build(BuildContext context) {
    int indexTable = int.parse(widget.tableModel.tableNumber) - 1;
    var gradientColor = GradientTemplate.gradientTemplate[3].colors;
    return BlocConsumer<TableUserBloc, TableState>(
      listener: (context, tableState) {},
      builder: (context, tableState) {
        sumOrder = 0;
        for (int i = 0;
            i < tableState.tableList[indexTable].foodList.length;
            i++) {
          sumOrder += (tableState.tableList[indexTable].foodList[i].price *
              tableState.tableList[indexTable].foodList[i].count);
        }
        return Container(
          height: 100,
          color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.local_dining_sharp),
                label: Text(
                  "สั่งอาหาร",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodMenuScreen(
                                tableModel: widget.tableModel,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber.shade300,
                  onPrimary: Colors.black,
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              Text(
                "ยอดรวม " + sumOrder.toString() + " บาท",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
