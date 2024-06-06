import 'package:comuline/models/result.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/models/exceptions.dart';
import 'package:comuline/models/station.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required StationRepository repository,
  })  : _repository = repository,
        super(const HomeState()) {
    on<HomeEvent>((event, emitter) async {
      if (event is HomeStarted) {
        await _getStations(emitter);
      } else if (event is HomeRefresh) {
        // TODO
        await _getStations(emitter);
      }
    });
  }

  final StationRepository _repository;

  Future<void> _getStations(
    Emitter emitter,
  ) async {
    final result = _repository.getStations();

    var streamOfHomeState = result.map((convert) {
      if (convert is Success<List<Station>>) {
        final value = convert.value;
        return HomeState(
          status: HomeStatus.success,
          stations: value,
        );
      } else if (convert is Error<List<Station>>) {
        return HomeState(
          status: HomeStatus.error,
          error: convert.exception,
          stations: state.stations,
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
}
