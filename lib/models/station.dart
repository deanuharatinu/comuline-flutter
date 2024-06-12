import 'package:comuline/models/station_detail.dart';

class Station {
  Station({
    required this.id,
    required this.name,
    required this.daop,
    required this.fgEnable,
    required this.haveSchedule,
    required this.updatedAt,
    this.stationDetails,
  });

  final String id;
  final String name;
  final int daop;
  final int fgEnable;
  final bool haveSchedule;
  final String updatedAt;
  final List<StationDetail>? stationDetails;
}
