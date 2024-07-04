part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class HomeRefresh extends HomeEvent {
  const HomeRefresh();
}

class HomeStationDetailPressed extends HomeEvent {
  const HomeStationDetailPressed(this.stationId);

  final String stationId;
}

abstract class HomeWithSearchTerm extends HomeEvent {
  const HomeWithSearchTerm({
    required this.searchTerm,
  });

  final String searchTerm;
}

final class HomeSearchTermChanged extends HomeWithSearchTerm {
  const HomeSearchTermChanged({
    required super.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}
