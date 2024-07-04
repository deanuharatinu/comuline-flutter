part of 'add_station_bloc.dart';

abstract class AddStationState extends Equatable {
  const AddStationState();

  @override
  List<Object> get props => [];
}

final class AddStationInitial extends AddStationState {}

final class AddStationLoadSuccess extends AddStationState {
  const AddStationLoadSuccess({
    required this.bookmarkedStationList,
    required this.notBookmarkedStationList,
  });

  final List<Station> bookmarkedStationList;
  final List<Station> notBookmarkedStationList;

  @override
  List<Object> get props => [
        bookmarkedStationList.length,
        notBookmarkedStationList.length,
      ];
}

final class AddStationSearchSuccess extends AddStationState {
  const AddStationSearchSuccess({
    required this.initialBookmarkedStationList,
    required this.initialNotBookmarkedStationList,
    required this.searchResultBookmarkedStationList,
    required this.searchResultNotBookmarkedStationList,
  });

  final List<Station> initialBookmarkedStationList;
  final List<Station> initialNotBookmarkedStationList;
  final List<Station> searchResultBookmarkedStationList;
  final List<Station> searchResultNotBookmarkedStationList;

  @override
  List<Object> get props => [
        searchResultBookmarkedStationList.length,
        searchResultNotBookmarkedStationList.length,
      ];
}
