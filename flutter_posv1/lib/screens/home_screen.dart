import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_table.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_event.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/models/data_generator.dart';
import 'package:flutter_posv1/screens/report_screen.dart';
import 'package:flutter_posv1/screens/table_user_screen.dart';
import 'package:flutter_posv1/utils/constant.dart';
import 'package:flutter_posv1/widgets/table_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../models/table_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tableBloc = BlocProvider.of<TableUserBloc>(context);
    var gradientColor = GradientTemplate.gradientTemplate[5].colors;
    var gradientTtileReport = GradientTemplate.gradientTemplate[3].colors;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "ระบบร้านอาหาร",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ReportScreen()));
        },
        label: const Text(
          'รายงานประจำวัน',
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.article_outlined),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.grey.shade100.withOpacity(0.1),
        child: BlocBuilder(
          bloc: tableBloc,
          builder: (context, tableState) {
            if (tableState is TableUserState) {
              return ResponsiveBuilder(builder: (context, sizing) {
                if (sizing.deviceScreenType == DeviceScreenType.desktop) {
                  return Column(
                    children: [
                      buildAddTable(context),
                      buildUxDesktop(context, tableState, gradientColor,
                          gradientTtileReport),
                    ],
                  );
                }
                if (sizing.deviceScreenType == DeviceScreenType.mobile) {
                  return Column(
                    children: [
                      buildAddTable(context),
                      Expanded(
                        child: buildGridViewTable(
                            context, tableState.tableList, 3),
                      ),
                    ],
                  );
                }
                return Container();
              });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildUxDesktop(BuildContext context, TableUserState tableState,
      List<Color> gradientColor, List<Color> gradientTtileReport) {
    return Expanded(
      child: Row(
        children: [
          Expanded(child: buildGridViewTable(context, tableState.tableList, 5)),
          Flexible(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 5, right: 20, bottom: 20),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientTtileReport,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: gradientTtileReport.last.withOpacity(0.4),
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
                          "รายงานประจำวัน",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "วันที่",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "จำนวนรายการ".toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "รวมยอด".toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildReport(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReport() {
    var gradientColor = GradientTemplate.gradientTemplate[3].colors;
    return BlocBuilder<ReportTableBloc, ReportState>(
        builder: (context, reportState) {
      if (reportState is ReportTableState) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: reportState.reportList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 70,
                child: Card(
                  color: Colors.white,
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
                                reportState.reportList[index].name,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                reportState.reportList[index].count.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                reportState.reportList[index].sales.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
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
      return Container();
    });
  }

  Widget buildAddTable(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            context.read<TableUserBloc>().add(TableUserRemoveEvent());
          },
        ),
        Text(
          "โต๊ะ",
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            context.read<TableUserBloc>().add(TableUserAddEvent());
          },
        ),
      ],
    );
  }

  Widget buildGridViewTable(
      BuildContext context, List<TableModel> tableList, int col) {
    return GridView.count(
      crossAxisCount: col,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 8.0,
      children: List.generate(tableList.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TableUserScreen(
                          tableModel: tableList[index],
                        )));
          },
          child: TableCard(tableModel: tableList[index]),
        );
      }),
    );
  }
}
