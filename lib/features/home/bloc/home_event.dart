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
