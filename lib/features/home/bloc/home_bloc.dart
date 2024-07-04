import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:comuline/models/destination_detail.dart';
import 'package:comuline/models/result.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/models/exceptions.dart';
import 'package:comuline/models/station.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required StationRepository repository,
  })  : _repository = repository,
        super(const HomeState()) {
    on<HomeEvent>(
      (event, emitter) async {
        if (event is HomeStarted) {
          await _getStations(emitter);
        } else if (event is HomeRefresh) {
          await _getStations(emitter);
        } else if (event is HomeStationDetailPressed) {
          await _getStationDetailById(event.stationId, emitter);
        } else if (event is HomeSearchTermChanged) {
          await _searchStationByName(event.searchTerm, emitter);
        }
      },
      transformer: (events, mapper) {
        final nonDebounceEventStream = events.where(
          (event) {
            return event is! HomeSearchTermChanged &&
                event is! HomeStationDetailPressed;
          },
        );

        final debounceEventStream = events
            .whereType<HomeStationDetailPressed>()
            .debounceTime(const Duration(seconds: 1));

        final debounceSearchEvent = events
            .whereType<HomeSearchTermChanged>()
            .debounceTime(const Duration(milliseconds: 500));

        final mergedEventStream = MergeStream([
          nonDebounceEventStream,
          debounceEventStream,
          debounceSearchEvent,
        ]);

        final restartableTransformer = restartable<HomeEvent>();
        return restartableTransformer(mergedEventStream, mapper);
      },
    );
  }

  final StationRepository _repository;

  Future<void> _getStations(
    Emitter emitter,
  ) async {
    emitter(const HomeState(status: HomeStatus.loading));

    final result = _repository.getStations();

    var streamOfHomeState = result.map((convert) {
      if (convert is Success<List<Station>>) {
        final value = convert.value.where((station) {
          final isBookmarked = station.isBookmarked ?? false;
          return isBookmarked;
        }).toList();
        return HomeState(
          status: HomeStatus.success,
          stations: value,
          searchResult: value,
        );
      } else if (convert is Error<List<Station>>) {
        return HomeState(
          status: HomeStatus.error,
          error: convert.exception,
          stations: state.stations,
          searchResult: state.stations,
        );
      }

      // Unknown state
      return HomeState(
        status: HomeStatus.error,
        error: UnknownException(),
        stations: const [],
      );
    });

    return emitter.onEach<HomeState>(
      streamOfHomeState,
      onData: emitter.call,
    );
  }

  Future<void> _getStationDetailById(
    String stationId,
    Emitter emitter,
  ) async {
    final result = await _repository.getStationDetailById(stationId);

    if (result is Success<List<DestinationDetail>>) {
      final homeState = HomeState(
        status: HomeStatus.success,
        stations: state.stations.map((station) {
          if (station.id == stationId) {
            return station.copyWithdestinationDetail(result.value);
          }

          return station;
        }).toList(),
      );

      emitter(homeState);
    } else {
      final homeState = HomeState(
          status: HomeStatus.success,
          stations: state.stations.map((station) {
            if (station.id == stationId) {
              return station.copyWithdestinationDetail([]);
            }

            return station;
          }).toList());

      emitter(homeState);
    }
  }

  Future<void> _searchStationByName(
    String searchTerm,
    Emitter<HomeState> emitter,
  ) async {
    final searchResult = state.stations.where((station) {
      return station.name.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();

    if (searchTerm.isEmpty) {
      emitter(
        state.copyWithInitialStations(initialStations: state.stations),
      );
      return;
    }

    emitter(
      state.copyWithSearchResult(
        initialStations: state.stations,
        searchResult: searchResult,
      ),
    );
  }
}
