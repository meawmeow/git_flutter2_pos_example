import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_table.dart';
import 'package:flutter_posv1/utils/constant.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "รายงานประจำวัน",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: buildReport(context),
    );
  }

  Widget buildReport(BuildContext context) {
    var gradientbg = GradientTemplate.gradientTemplate[5].colors;
    var gradientTtileReport = GradientTemplate.gradientTemplate[0].colors;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientbg,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientbg.last.withOpacity(0.5),
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(4, 4),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "วันที่",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                  Text(
                    "จำนวนรายการ".toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                  Text(
                    "รวมยอด".toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ReportTableBloc, ReportState>(
              builder: (context, reportState) {
            if (reportState is ReportTableState) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: reportState.reportList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    reportState.reportList[index].name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    reportState.reportList[index].count
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    reportState.reportList[index].sales
                                        .toString(),
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
              );
            }
            return Container();
          }),
        ),
      ],
    );
  }
}
