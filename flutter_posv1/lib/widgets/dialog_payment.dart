import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/report_model.dart';
import 'package:flutter_posv1/models/table_model.dart';
import 'package:flutter_posv1/utils/constant.dart';

class DialogPayment extends StatefulWidget {
  const DialogPayment({Key key, this.tableModel}) : super(key: key);
  final TableModel tableModel;

  @override
  _DialogPaymentState createState() => _DialogPaymentState();
}

class _DialogPaymentState extends State<DialogPayment> {
  int sumOrder = 0;
  int sumCount = 0;
  bool isSucceed = false;
  int change = 0;
  int pay = 0;

  @override
  Widget build(BuildContext context) {
    var gradientColor = GradientTemplate.gradientTemplate[3].colors;
    int indexTable = int.parse(widget.tableModel.tableNumber) - 1;
    final number = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        width: 500,
        height: 500,
        child: BlocBuilder<TableUserBloc, TableState>(
          builder: (context, tableState) {
            sumOrder = 0;
            sumCount = 0;
            for (int i = 0;
                i < tableState.tableList[indexTable].foodList.length;
                i++) {
              sumCount += 1;
              sumOrder += (tableState.tableList[indexTable].foodList[i].price *
                  tableState.tableList[indexTable].foodList[i].count);
            }
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ปิดโต๊ะ " + widget.tableModel.tableNumber,
                        style: TextStyle(fontSize: 20),
                      ),
                      FloatingActionButton(
                        child: Icon(
                          Icons.close,
                          color: Colors.black54,
                        ),
                        backgroundColor: gradientColor.last.withOpacity(0.9),
                        onPressed: () {
                          if (isSucceed) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 35,
                    top: 10,
                    right: 35,
                    bottom: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !isSucceed
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "รายการทั้งหมด",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200),
                                ),
                                Text(
                                  sumCount.toString() + " รายการ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            )
                          : Container(),
                      !isSucceed
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ยอดรวมทั้งหมด",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200),
                                ),
                                Text(
                                  sumOrder.toString() + " บาท",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            )
                          : Container(),
                      !isSucceed
                          ? Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: number,
                                    autocorrect: true,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: 'ป้อนจำนวนเงิน'),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    if (number.value.text.isNotEmpty) {
                                      if (int.parse(number.value.text) >=
                                          sumOrder) {
                                        setState(() {
                                          isSucceed = true;
                                          pay = int.parse(number.value.text);
                                          change = (pay - sumOrder);
                                        });
                                        context.read<TableUserBloc>().add(
                                            TableUserClearEvent(
                                                index: indexTable));

                                        context.read<ReportTableBloc>().add(
                                            ReportAddOrderEvent(
                                                report: ReportModel(
                                                    name: "10/30/2562",
                                                    sales: sumOrder,
                                                    count: sumCount)));
                                      }
                                      print("onPressed:" +
                                          number.value.text.toString());
                                    }
                                  },
                                  child: Text(
                                    'ชำระ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    elevation: 1,
                                    backgroundColor:
                                        gradientColor.last.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "รับชำระ ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "" + pay.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      change > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "เงินทอน ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "" + change.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          : Container(),
                      isSucceed
                          ? Column(
                              children: [
                                Text(
                                  "ชําระเสร็จเรียบร้อย",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300),
                                ),
                                ElevatedButton.icon(
                                  icon: Icon(Icons.print_rounded),
                                  label: Text("Print"),
                                  onPressed: () => print("it's pressed"),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
