import 'package:auto_route/auto_route.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/features/home/bloc/home_bloc.dart';
import 'package:comuline/features/home/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: RepositoryProvider.of<StationRepository>(context),
      ),
      child: const HomeView(),
    );
  }
}
