class Station {
  Station({
    required this.id,
    required this.name,
    required this.daop,
    required this.fgEnable,
    required this.haveSchedule,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final int daop;
  final int fgEnable;
  final bool haveSchedule;
  final String updatedAt;
}
