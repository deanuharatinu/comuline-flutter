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
      if (event is HomeLoadStations) {
        await _loadStations(emitter);
      }
    });
  }

  final Repository _repository;

  _loadStations(
    Emitter emitter,
  ) async {
    final stations = await _repository.loadStations();
    emitter(
      state.copyWith(
        status: HomeStatus.success,
        stations: stations,
      ),
    );
  }
}
