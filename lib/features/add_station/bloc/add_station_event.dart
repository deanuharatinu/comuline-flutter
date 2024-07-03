part of 'add_station_bloc.dart';

abstract class AddStationEvent extends Equatable {
  const AddStationEvent();

  @override
  List<Object> get props => [];
}

class AddStationStarted extends AddStationEvent {
  const AddStationStarted();
}

class AddStationBookmarkPressed extends AddStationEvent {
  final String stationId;

  const AddStationBookmarkPressed({
    required this.stationId,
  });
}

class AddStationRemoveBookmarkPressed extends AddStationEvent {
  final String stationId;

  const AddStationRemoveBookmarkPressed({
    required this.stationId,
  });
}
