import 'package:flutter_posv1/models/report_model.dart';

abstract class ReportState {
  final List<ReportModel> reportList;

  const ReportState(this.reportList);
}

class ReportTableState extends ReportState {
  final List<ReportModel> reportList;
  ReportTableState(this.reportList) : super(reportList);

  @override
  // TODO: implement props
  List<Object> get props => [reportList];
}
