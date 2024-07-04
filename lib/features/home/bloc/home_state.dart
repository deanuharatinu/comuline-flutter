part of 'home_bloc.dart';

enum HomeStatus { success, error, loading }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.stations = const <Station>[],
    this.searchResult,
    this.error,
  });

  final HomeStatus status;
  final List<Station> stations;
  final List<Station>? searchResult;
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

  HomeState copyWithSearchResult({
    required List<Station> initialStations,  
    required List<Station> searchResult,
  }) {
    return HomeState(
      status: HomeStatus.success,
      stations: initialStations,
      searchResult: searchResult,
      error: null,
    );
  }

  HomeState copyWithInitialStations({required List<Station> initialStations}) {
    return HomeState(
      status: HomeStatus.success,
      stations: initialStations,
      searchResult: initialStations,
      error: null,
    );
  }

  @override
  List<Object?> get props => [status, stations, searchResult, error];
}
