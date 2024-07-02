part of 'add_station_bloc.dart';

abstract class AddStationEvent extends Equatable {
  const AddStationEvent();

  @override
  List<Object> get props => [];
}

class AddStationStarted extends AddStationEvent {
  const AddStationStarted();
}
