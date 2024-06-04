import 'package:comuline/data/repository.dart';
import 'package:comuline/models/station.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required Repository repository,
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

  final Repository _repository;

  Future<void> _getStations(
    Emitter emitter,
  ) async {
    final streamOfStations = _repository.getStations().map((stations) {
      return HomeState(
        status: HomeStatus.success,
        stations: stations,
      );
    });

    return emitter.onEach<HomeState>(
      streamOfStations,
      onData: emitter,
    );
  }
}
