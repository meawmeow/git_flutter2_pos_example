import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/data_generator.dart';
import 'package:flutter_posv1/screens/food_menu_screen.dart';
import 'package:flutter_posv1/utils/constant.dart';
import 'package:flutter_posv1/widgets/dialog_payment.dart';
import 'package:flutter_posv1/widgets/food_menu_screen_desktop.dart';
import 'package:flutter_posv1/widgets/footer_order.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../models/table_model.dart';

class TableUserScreen extends StatelessWidget {
  const TableUserScreen({Key key, this.tableModel}) : super(key: key);
  final TableModel tableModel;

  @override
  Widget build(BuildContext context) {
    var gradientColor = GradientTemplate.gradientTemplate[5].colors;
    int indexTable = int.parse(tableModel.tableNumber) - 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "โต๊ะ " + tableModel.tableNumber,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(child: BlocBuilder<TableUserBloc, TableState>(
        builder: (context, tableState) {
          return Column(
            children: [
              buildOpenCloseTable(context, tableState),
              Flexible(
                flex: 2,
                child: ResponsiveBuilder(
                  builder: (context, sizing) {
                    if (sizing.deviceScreenType == DeviceScreenType.desktop) {
                      return Row(
                        children: [
                          buildFoodItemDesktop(
                              gradientColor, context, tableState, indexTable),
                          tableModel.isOpen
                              ? Expanded(
                                  child: FoodMenuScreenDesktop(
                                  tableModel: tableModel,
                                ))
                              : Container(),
                        ],
                      );
                    }
                    if (sizing.deviceScreenType == DeviceScreenType.mobile) {
                      return buildFoodItemMobile(
                          gradientColor, context, tableState, indexTable);
                    }
                    return Container();
                  },
                ),
              ),
              FooterOrder(tableModel: tableModel),
              //buildFooter(context, tableState, indexTable),
            ],
          );
        },
      )),
    );
  }

  Widget buildFoodItemDesktop(List<Color> gradientColor, BuildContext context,
      TableState tableState, int indexTable) {
    return Container(
      width: tableModel.isOpen
          ? (MediaQuery.of(context).size.width / 2) + 300
          : MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColor.last.withOpacity(0.4),
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Column(
        children: [
          Text(
            "รายการที่สั่ง",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w100),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: tableState.tableList[indexTable].foodList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 70,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tableState
                                .tableList[indexTable].foodList[index].foodname,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "x" +
                                tableState
                                    .tableList[indexTable].foodList[index].count
                                    .toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            tableState
                                .tableList[indexTable].foodList[index].price
                                .toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFoodItemMobile(List<Color> gradientColor, BuildContext context,
      TableState tableState, int indexTable) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColor.last.withOpacity(0.4),
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Column(
        children: [
          Text(
            "รายการที่สั่ง",
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w100),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: tableState.tableList[indexTable].foodList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 70,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tableState
                                .tableList[indexTable].foodList[index].foodname,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "x" +
                                tableState
                                    .tableList[indexTable].foodList[index].count
                                    .toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            tableState
                                .tableList[indexTable].foodList[index].price
                                .toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOpenCloseTable(BuildContext context, TableUserState tableState) {
    var gradientColor = GradientTemplate.gradientTemplate[5].colors;
    // bool isSwitched = tableModel.isOpen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColor.last.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fact_check_outlined,
            color: tableModel.isOpen ? Colors.yellow : Colors.white,
            size: 50,
          ),
          SizedBox(width: 10),
          Text(
            tableModel.isOpen ? "ปิดโต็ะ" : "เปิดโต๊ะ",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w100),
          ),
          Switch(
            activeTrackColor: Colors.orangeAccent,
            activeColor: Colors.yellow,
            value: tableModel.isOpen,
            onChanged: (_) {
              if (tableModel.isOpen) {
                tableModel.isOpen = false;
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return DialogPayment(tableModel: tableModel);
                    });
              } else {
                tableModel.isOpen = true;
              }
              context
                  .read<TableUserBloc>()
                  .add(TableUserUpdateEvent(tableModel: tableModel));
            },
          ),
        ],
      ),
    );
  }
}
