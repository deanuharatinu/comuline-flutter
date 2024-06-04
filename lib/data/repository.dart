import 'package:comuline/models/station.dart';

class Repository {
  Stream<List<Station>> getStations() async* {
    final stations = <Station>[];
    for (var i = 0; i < 3; i++) {
      stations.add(
        Station(
          id: "AC",
          name: "ANCOL",
          daop: 1,
          fgEnable: 1,
          haveSchedule: true,
          updatedAt: '2024-03-10T15:15:19.997Z',
        ),
      );
    }

    yield stations;
  }
}
