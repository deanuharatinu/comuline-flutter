import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/models/result.dart';
import 'package:comuline/models/station.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_station_event.dart';
part 'add_station_state.dart';

class AddStationBloc extends Bloc<AddStationEvent, AddStationState> {
  AddStationBloc({
    required StationRepository stationRepository,
  })  : _stationRepository = stationRepository,
        super(AddStationInitial()) {
    on<AddStationEvent>((event, emitter) async {
      if (event is AddStationStarted) {
        await _getStations(emitter);
      } else if (event is AddStationBookmarkPressed) {
        await _addBookmark(event.stationId);
        await _getStations(emitter);
      } else if (event is AddStationRemoveBookmarkPressed) {
        await _removeBookmark(event.stationId);
        await _getStations(emitter);
      }
    });
  }

  final StationRepository _stationRepository;

  Future<void> _getStations(Emitter emitter) async {
    final result = await _stationRepository.getStationsFromLocal();

    final bookmarkedStationList = <Station>[];
    final notBookmarkedStationList = <Station>[];

    for (var station in (result as Success<List<Station>>).value) {
      final isBookmarked = station.isBookmarked ?? false;
      if (isBookmarked) {
        bookmarkedStationList.add(station);
      } else {
        notBookmarkedStationList.add(station);
      }
    }

    final state = AddStationLoadSuccess(
      bookmarkedStationList: bookmarkedStationList,
      notBookmarkedStationList: notBookmarkedStationList,
    );

    emitter(state);
  }

  Future<void> _addBookmark(String stationId) async {
    await _stationRepository.addBookmarkById(stationId);
  }

  Future<void> _removeBookmark(String stationId) async {
    await _stationRepository.removeBookmarkById(stationId);
  }
}
