import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/component_library/theme/styled_status_bar.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/features/home/bloc/home_bloc.dart';
import 'package:comuline/models/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.darkModePreference,
    required this.repository,
    this.onThemeToggleTap,
    super.key,
  });

  final StationRepository repository;
  final VoidCallback? onThemeToggleTap;
  final DarkModePreference darkModePreference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: repository,
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
          child: GestureDetector(
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
                const StationList(),
              ],
            ),
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

  _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class StationList extends StatelessWidget {
  const StationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ComulineTheme.of(context);

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.error is NoConnectionException) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Connection Error"),
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
                children: const [
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              );
            },
          ),
        );
      },
    );
  }
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
