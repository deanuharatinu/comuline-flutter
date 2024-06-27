import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:flutter/material.dart';

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
