part of 'add_station_bloc.dart';

abstract class AddStationEvent extends Equatable {
  const AddStationEvent();

  @override
  List<Object> get props => [];
}

class AddStationStarted extends AddStationEvent {
  const AddStationStarted();
}

abstract class AddStationSearchTerm extends AddStationEvent {
  final String searchTerm;

  const AddStationSearchTerm({
    required this.searchTerm,
  });

  @override
  List<Object> get props => [searchTerm];
}

class AddStationSearchTermChanged extends AddStationSearchTerm {
  const AddStationSearchTermChanged({
    required super.searchTerm,
  });
}

class AddStationBookmarkPressed extends AddStationSearchTerm {
  final String stationId;

  const AddStationBookmarkPressed({
    required this.stationId,
    required super.searchTerm,
  });
}

class AddStationRemoveBookmarkPressed extends AddStationSearchTerm {
  final String stationId;

  const AddStationRemoveBookmarkPressed({
    required this.stationId,
    required super.searchTerm,
  });
}
