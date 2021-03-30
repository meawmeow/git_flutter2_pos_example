import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posv1/blocs/report/report_event.dart';
import 'package:flutter_posv1/blocs/report/report_table.dart';

class ReportTableBloc extends Bloc<ReportEvent, ReportState> {
  ReportTableBloc(ReportState initialState) : super(initialState);

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is ReportTableEvent) {
      yield ReportTableState(state.reportList);
    }
    if (event is ReportAddOrderEvent) {
      state.reportList.add(event.report);
      print("ReportAddOrderEvent = " + state.reportList.length.toString());
      yield ReportTableState(state.reportList);
    }
  }
}
