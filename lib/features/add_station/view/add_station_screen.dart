import 'package:auto_route/auto_route.dart';
import 'package:comuline/features/add_station/bloc/add_station_bloc.dart';
import 'package:comuline/features/add_station/view/add_station_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddStationScreen extends StatelessWidget {
  const AddStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStationBloc(),
      child: const AddStationView(),
    );
  }
}
