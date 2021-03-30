import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_table.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_bloc.dart';
import 'package:flutter_posv1/blocs/table_user/table_user_state.dart';
import 'package:flutter_posv1/screens/home_screen.dart';

import 'blocs/table_user/table_user_observer.dart';
import 'models/data_generator.dart';

void main() {
  //Bloc.observer = TableUserObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TableUserBloc>(
        create: (context) =>
            TableUserBloc(TableUserState(DataGennerator().tableList)),
      ),
      BlocProvider<ReportTableBloc>(
        create: (context) => ReportTableBloc(ReportTableState([])),
      ),
    ],
    child: MyApp(),
  ));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter v.ทำเล่นๆไม่เน้นโค้ดสะอาด',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
