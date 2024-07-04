import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/models/result.dart';
import 'package:comuline/models/station.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

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
        await _addBookmark(emitter, event.stationId, event.searchTerm);
      } else if (event is AddStationRemoveBookmarkPressed) {
        await _removeBookmark(emitter, event.stationId, event.searchTerm);
      } else if (event is AddStationSearchTermChanged) {
        await _searchStation(event, emitter);
      }
    }, transformer: (eventStream, eventHandler) {
      final nonDebounceEventStream = eventStream.where(
        (event) => event is! AddStationSearchTermChanged,
      );

      final debounceEventStream = eventStream
          .whereType<AddStationSearchTermChanged>()
          .debounceTime(const Duration(milliseconds: 500));

      final mergedEventStream = MergeStream([
        nonDebounceEventStream,
        debounceEventStream,
      ]);

      final restartableTransformer = restartable<AddStationEvent>();
      return restartableTransformer(mergedEventStream, eventHandler);
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

  Future<void> _addBookmark(
    Emitter<AddStationState> emitter,
    String stationId,
    String searchTerm,
  ) async {
    await _stationRepository.addBookmarkById(stationId);
    await _refreshDataWithSearchResult(emitter, searchTerm);
  }

  Future<void> _removeBookmark(
    Emitter<AddStationState> emitter,
    String stationId,
    String searchTerm,
  ) async {
    await _stationRepository.removeBookmarkById(stationId);
    await _refreshDataWithSearchResult(emitter, searchTerm);
  }

  Future<void> _refreshDataWithSearchResult(
    Emitter<AddStationState> emitter,
    String searchTerm,
  ) async {
    final result = await _stationRepository.getStationsFromLocal();

    final bookmarkedList = <Station>[];
    final notBookmarkedList = <Station>[];

    for (var station in (result as Success<List<Station>>).value) {
      final isBookmarked = station.isBookmarked ?? false;
      if (isBookmarked) {
        bookmarkedList.add(station);
      } else {
        notBookmarkedList.add(station);
      }
    }

    // return if search term is empty
    if (searchTerm.isEmpty) {
      final state = AddStationLoadSuccess(
        bookmarkedStationList: bookmarkedList,
        notBookmarkedStationList: notBookmarkedList,
      );
      emitter(state);
      return;
    }

    final newState = _getNewStateWithSearchTerm(
      searchTerm: searchTerm,
      bookmarkedList: bookmarkedList,
      notBookmarkedList: notBookmarkedList,
    );

    emitter(newState);
  }

  Future<void> _searchStation(
    AddStationSearchTermChanged event,
    Emitter<AddStationState> emitter,
  ) async {
    final searchTerm = event.searchTerm;

    List<Station> bookmarkedList = [];
    if (state is AddStationLoadSuccess) {
      bookmarkedList = (state as AddStationLoadSuccess).bookmarkedStationList;
    } else if (state is AddStationSearchSuccess) {
      bookmarkedList =
          (state as AddStationSearchSuccess).initialBookmarkedStationList;
    }

    List<Station> notBookmarkedList = [];
    if (state is AddStationLoadSuccess) {
      notBookmarkedList =
          (state as AddStationLoadSuccess).notBookmarkedStationList;
    } else if (state is AddStationSearchSuccess) {
      notBookmarkedList =
          (state as AddStationSearchSuccess).initialNotBookmarkedStationList;
    }

    // return if search term is empty
    if (searchTerm.isEmpty) {
      final state = AddStationLoadSuccess(
        bookmarkedStationList: bookmarkedList,
        notBookmarkedStationList: notBookmarkedList,
      );
      emitter(state);
      return;
    }

    final newState = _getNewStateWithSearchTerm(
      searchTerm: searchTerm,
      bookmarkedList: bookmarkedList,
      notBookmarkedList: notBookmarkedList,
    );

    emitter(newState);
  }

  AddStationSearchSuccess _getNewStateWithSearchTerm({
    required String searchTerm,
    required List<Station> bookmarkedList,
    required List<Station> notBookmarkedList,
  }) {
    final bookmarkedResult = bookmarkedList.where((station) {
      return station.name.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();

    final notBookmarkedResult = notBookmarkedList.where((station) {
      return station.name.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();

    return AddStationSearchSuccess(
      initialBookmarkedStationList: bookmarkedList,
      initialNotBookmarkedStationList: notBookmarkedList,
      searchResultBookmarkedStationList: bookmarkedResult,
      searchResultNotBookmarkedStationList: notBookmarkedResult,
    );
  }
}
