import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
