part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.stations = const <Station>[],
  });

  final HomeStatus status;
  final List<Station> stations;

  HomeState copyWith({
    HomeStatus? status,
    List<Station>? stations,
  }) {
    return HomeState(
      status: status ?? this.status,
      stations: stations ?? this.stations,
    );
  }

  @override
  List<Object?> get props => [status, stations];
}
