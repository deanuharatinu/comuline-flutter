class StationDetail {
  StationDetail({
    required this.id,
    required this.stationId,
    required this.trainId,
    required this.line,
    required this.route,
    required this.color,
    required this.destination,
    required this.timeEstimated,
    required this.destinationTime,
    required this.updatedAt,
  });

  final String id;
  final String stationId;
  final String trainId;
  final String line;
  final String route;
  final String color;
  final String destination;
  final String timeEstimated;
  final String destinationTime;
  final String updatedAt;
}
