import 'package:auto_route/auto_route.dart';
import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/component_library/theme/styled_status_bar.dart';
import 'package:comuline/data/repository/app_state_repository.dart';
import 'package:comuline/features/home/bloc/home_bloc.dart';
import 'package:comuline/features/home/view/shimmer.dart';
import 'package:comuline/features/home/widget/custom_app_bar.dart';
import 'package:comuline/features/home/widget/custom_search_bar.dart';
import 'package:comuline/features/home/widget/station_detail.dart';
import 'package:comuline/models/destination_detail.dart';
import 'package:comuline/models/exceptions.dart';
import 'package:comuline/models/station.dart';
import 'package:comuline/router/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutoRouteAwareStateMixin {
  HomeBloc get _bloc => context.read<HomeBloc>();
  final TextEditingController _searchBarController = TextEditingController();

  @override
  void initState() {
    _bloc.add(const HomeStarted());

    _searchBarController.addListener(() {
      _bloc.add(
        HomeSearchTermChanged(searchTerm: _searchBarController.text),
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _refreshData();
  }

  Future<void> _refreshData() async {
    final isLoading = _bloc.state.status == HomeStatus.loading;
    if (isLoading) return;

    _bloc.add(const HomeRefresh());
    _searchBarController.text = '';
    await for (final _ in _bloc.stream) {
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStateRepository =
        RepositoryProvider.of<AppStateRepository>(context);

    return StreamBuilder<DarkModePreference>(
        stream: appStateRepository.getDarkModePreference(),
        builder: (context, snapshot) {
          final darkModePreference = snapshot.data;

          return StyledStatusBar.dynamic(
            statusBarStyle: darkModePreference.getStatusBarStyle(),
            child: Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    CustomAppBar(onThemeToggleTap: () {
                      appStateRepository.upsertDarkModePreference(
                        darkModePreference.toggleDarkMode(),
                      );
                    }),
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      surfaceTintColor: Colors.grey.shade500,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: CustomSearchBar(
                          controller: _searchBarController,
                        ),
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
                onPressed: () => context.pushRoute(const AddStationRoute()),
                foregroundColor: Colors.grey.shade600,
                backgroundColor: Colors.grey.shade600,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }
}

class StationList extends StatelessWidget {
  const StationList({super.key});

  @override
  Widget build(BuildContext context) {
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
        debugPrint(state.toString());

        if (state.status == HomeStatus.loading) {
          return const LoadingStationList();
        }

        final stations = state.searchResult ?? state.stations;
        if (stations.isEmpty) {
          return const EmptyStationList();
        } else {
          return ShowStationList(
            stationList: stations,
          );
        }
      },
    );
  }
}

class ShowStationList extends StatelessWidget {
  const ShowStationList({
    required stationList,
    super.key,
  }) : _stationList = stationList;

  final List<Station> _stationList;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final theme = ComulineTheme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 80.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: _stationList.length,
          (context, index) {
            final station = _stationList[index];
            final destinationDetail = station.destinationDetail;

            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
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
                showStationDetail(theme, destinationDetail),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget showStationDetail(
    ComulineThemeData theme,
    List<DestinationDetail>? destinationDetail,
  ) {
    if (destinationDetail == null) {
      return Shimmer(
        linearGradient: theme.shimmerGradient,
        child: ShimmerLoading(
          isLoading: true,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              width: double.infinity,
            ),
          ),
        ),
      );
    }

    if (destinationDetail.isEmpty) {
      return const Text(
        'Jadwal kereta api tidak tersedia. Cek lagi pada esok hari.',
      );
    } else {
      return StationDetail(
        destinationDetail: destinationDetail,
      );
    }
  }
}

class LoadingStationList extends StatelessWidget {
  const LoadingStationList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ComulineTheme.of(context);

    return SliverFillRemaining(
      fillOverscroll: true,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Shimmer(
            linearGradient: theme.shimmerGradient,
            child: ShimmerLoading(
              isLoading: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}

class EmptyStationList extends StatelessWidget {
  const EmptyStationList({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
