import 'package:comuline/app.dart';
import 'package:comuline/app_bootstraper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppBootstraper.init(
    mainAppWidget: const Comuline(),
    runApp: runApp,
  );
}
