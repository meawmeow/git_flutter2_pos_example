import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_posv1/models/report_model.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class ReportTableEvent extends ReportEvent {
  final List<ReportModel> reeportList;
  const ReportTableEvent({@required this.reeportList})
      : assert(reeportList != null);

  @override
  // TODO: implement props
  List<Object> get props => [reeportList];
}

class ReportAddOrderEvent extends ReportEvent {
  final ReportModel report;
  const ReportAddOrderEvent({@required this.report}) : assert(report != null);

  @override
  // TODO: implement props
  List<Object> get props => [report];
}
