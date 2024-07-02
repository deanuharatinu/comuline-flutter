import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_station_event.dart';
part 'add_station_state.dart';

class AddStationBloc extends Bloc<AddStationEvent, AddStationState> {
  AddStationBloc() : super(AddStationInitial()) {
    on<AddStationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
