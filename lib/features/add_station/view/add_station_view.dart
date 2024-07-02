import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/component_library/theme/styled_status_bar.dart';
import 'package:comuline/data/repository/app_state_repository.dart';
import 'package:comuline/features/add_station/bloc/add_station_bloc.dart';
import 'package:comuline/features/home/widget/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStationView extends StatefulWidget {
  const AddStationView({super.key});

  @override
  State<StatefulWidget> createState() => _AddStationViewState();
}

class _AddStationViewState extends State<AddStationView> {
  AddStationBloc get _bloc => context.read<AddStationBloc>();

  @override
  void initState() {
    _bloc.add(const AddStationStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ComulineTheme.of(context);

    return StreamBuilder<DarkModePreference>(
        stream: context.read<AppStateRepository>().getDarkModePreference(),
        builder: (context, snapshot) {
          final darkModePreference = snapshot.data;

          return StyledStatusBar.dynamic(
            statusBarStyle: darkModePreference.getStatusBarStyle(),
            child: Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      surfaceTintColor: Colors.grey.shade500,
                      flexibleSpace: const FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 16,
                          left: 58,
                        ),
                        title: CustomSearchBar(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
