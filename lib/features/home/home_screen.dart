import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/ic_comuline_logo.svg',
              width: 26,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade400,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Comuline',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
