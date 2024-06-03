import 'package:comuline/features/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Comuline());
}

class Comuline extends StatelessWidget {
  const Comuline({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comuline',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
