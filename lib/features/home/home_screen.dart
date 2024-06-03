import 'package:comuline/comuline_theme.dart';
import 'package:comuline/data/repository.dart';
import 'package:comuline/features/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.repository,
    this.onThemeToggleTap,
    super.key,
  });

  final Repository repository;
  final VoidCallback? onThemeToggleTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: repository,
      ),
      child: HomeView(
        onThemeToggleTap: onThemeToggleTap,
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({
    this.onThemeToggleTap,
    super.key,
  });

  final VoidCallback? onThemeToggleTap;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc get _bloc => context.read<HomeBloc>();

  @override
  void initState() {
    _bloc.add(const HomeLoadStations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ComulineTheme.of(context);

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () => _releaseFocus(context),
            child: CustomScrollView(
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.stations.length,
                    (context, index) {
                      final station = state.stations[index];

                      return ExpansionTile(
                        iconColor:
                            theme.materialThemeData.listTileTheme.iconColor,
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
                              station.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        children: const [
                          Text('data'),
                          Text('data'),
                          Text('data'),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () {
              // TODO
            },
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

  _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onThemeToggleTap,
    this.onSortTap,
  });

  final VoidCallback? onThemeToggleTap;
  final VoidCallback? onSortTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/ic_comuline_logo.svg',
            width: 26,
            colorFilter: ColorFilter.mode(
              Colors.grey.shade600,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Comuline',
            style: TextStyle(
              fontFamily: 'GeistMono',
              color: Colors.grey.shade600,
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            debugPrint('pencet');
            onThemeToggleTap?.call();
          },
          icon: Icon(
            Icons.dark_mode_outlined,
            color: Colors.grey.shade600,
          ),
        ),
        IconButton(
          onPressed: onSortTap,
          icon: Icon(
            Icons.swap_vert,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomSearchBar();
  }
}

class _CustomSearchBar extends State<CustomSearchBar> {
  final _searchBarFocusNode = FocusNode();

  @override
  void dispose() {
    _searchBarFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ComulineTheme.of(context);

    return SearchBar(
      focusNode: _searchBarFocusNode,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: theme.materialThemeData.colorScheme.onSurface,
              width: 1,
            )),
      ),
      backgroundColor: WidgetStatePropertyAll(
        Colors.grey.shade400.withAlpha(20),
      ),
      elevation: const WidgetStatePropertyAll(0),
      hintText: 'Cari stasiun keberangkatan',
      leading: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Icon(
          Icons.search,
        ),
      ),
    );
  }
}
