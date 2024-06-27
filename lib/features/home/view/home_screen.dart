import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/component_library/theme/styled_status_bar.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/features/home/bloc/home_bloc.dart';
import 'package:comuline/features/home/widget/custom_app_bar.dart';
import 'package:comuline/features/home/widget/custom_search_bar.dart';
import 'package:comuline/models/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.darkModePreference,
    this.onThemeToggleTap,
    super.key,
  });

  final VoidCallback? onThemeToggleTap;
  final DarkModePreference darkModePreference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: RepositoryProvider.of<StationRepository>(context),
      ),
      child: HomeView(
        darkModePreference: darkModePreference,
        onThemeToggleTap: onThemeToggleTap,
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({
    required this.darkModePreference,
    this.onThemeToggleTap,
    super.key,
  });

  final VoidCallback? onThemeToggleTap;
  final DarkModePreference darkModePreference;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc get _bloc => context.read<HomeBloc>();

  @override
  void initState() {
    _bloc.add(const HomeStarted());
    super.initState();
  }

  Future<void> _refreshData() async {
    _bloc.add(const HomeRefresh());
    await for (final _ in _bloc.stream) {
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle statusBarStyle;
    if (widget.darkModePreference == DarkModePreference.alwaysLight) {
      statusBarStyle = SystemUiOverlayStyle.dark;
    } else {
      statusBarStyle = SystemUiOverlayStyle.light;
    }

    return StyledStatusBar.dynamic(
      statusBarStyle: statusBarStyle,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              CustomAppBar(onThemeToggleTap: widget.onThemeToggleTap),
              SliverAppBar(
                pinned: true,
                floating: true,
                surfaceTintColor: Colors.grey.shade500,
                flexibleSpace: const FlexibleSpaceBar(
                  titlePadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: CustomSearchBar(),
                ),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: _refreshData,
              ),
              const StationList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _bloc.add(const HomeRefresh()),
          foregroundColor: Colors.grey.shade600,
          backgroundColor: Colors.grey.shade600,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class StationList extends StatelessWidget {
  const StationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final theme = ComulineTheme.of(context);

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.error is NoConnectionException) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Periksa koneksi internet Anda"),
              ),
            );
        } else if (state.error is Exception) {
          final errorMessage = (state.error as Exception).toString();

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(errorMessage),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          // TODO shimmer effect

          return SliverFillRemaining(
            fillOverscroll: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          );
        } else {
          if (state.stations.isEmpty) {
            return SliverFillRemaining(
              fillOverscroll: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_not_found.svg',
                    height: 100,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade500,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                    'Anda tidak memiliki daftar stasiun',
                  ),
                ],
              ),
            );
          } else {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.stations.length,
                (context, index) {
                  final station = state.stations[index];
                  return ExpansionTile(
                    key: PageStorageKey(station.id),
                    iconColor: theme.materialThemeData.listTileTheme.iconColor,
                    shape: const Border(),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stasiun',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          station.name.capitalize,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        bloc.add(
                          HomeStationDetailPressed(station.id),
                        );
                      }
                    },
                    children: [
                      if (station.stationDetails.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const CircularProgressIndicator(),
                        ),
                      if (station.stationDetails.isNotEmpty)
                        Text(station.stationDetails
                            .map((detail) => detail.destination)
                            .toList()
                            .toString()),
                    ],
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
