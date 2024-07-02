import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:comuline/component_library/theme/styled_status_bar.dart';
import 'package:comuline/features/add_station/bloc/add_station_bloc.dart';
import 'package:comuline/features/home/widget/custom_search_bar.dart';
import 'package:comuline/models/station.dart';
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

    return BlocBuilder<AddStationBloc, AddStationState>(
      builder: (context, state) {
        // TODO harus diextract terpisah untuk bisa pisahin dari state yang lain
        var bookmarkedStationList = <Station>[];
        var notBookmarkedStationList = <Station>[];
        if (state is AddStationLoadSuccess) {
          bookmarkedStationList = state.bookmarkedStationList;
          notBookmarkedStationList = state.notBookmarkedStationList;
        }

        return StyledStatusBar.dynamic(
          statusBarStyle: theme.darkModePreference.getStatusBarStyle(),
          child: Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverAppBar(
                    pinned: false,
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        'Tersimpan',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  _BookmarkedStationList(
                    bookmarkedStationList: bookmarkedStationList,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(
                            'Belum Tersimpan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _NotBookmarkedStationList(
                    notBookmarkedStationList: notBookmarkedStationList,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BookmarkedStationList extends StatelessWidget {
  const _BookmarkedStationList({
    required this.bookmarkedStationList,
  });

  final List<Station> bookmarkedStationList;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: bookmarkedStationList.length,
        (context, index) {
          final station = bookmarkedStationList[index];

          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station.name.capitalize,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NotBookmarkedStationList extends StatelessWidget {
  const _NotBookmarkedStationList({
    required this.notBookmarkedStationList,
  });

  final List<Station> notBookmarkedStationList;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: notBookmarkedStationList.length,
        (context, index) {
          final station = notBookmarkedStationList[index];

          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station.name.capitalize,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
