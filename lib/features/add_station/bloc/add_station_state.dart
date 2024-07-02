part of 'add_station_bloc.dart';

sealed class AddStationState extends Equatable {
  const AddStationState();
  
  @override
  List<Object> get props => [];
}

final class AddStationInitial extends AddStationState {}
