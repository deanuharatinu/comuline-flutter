part of 'home_bloc.dart';

enum HomeStatus { success, error, loading }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.stations = const <Station>[],
    this.error,
  });

  final HomeStatus status;
  final List<Station> stations;
  final dynamic error;

  HomeState copyWithError({
    dynamic error,
  }) {
    return HomeState(
      status: HomeStatus.error,
      error: error,
      stations: stations,
    );
  }

  @override
  List<Object?> get props => [status, stations, error];
}
