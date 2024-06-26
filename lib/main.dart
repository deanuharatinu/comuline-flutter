import 'package:comuline/app.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/di/repository_injector.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart' as logging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setupLogging();

  final StationRepository repository =
      await RepositoryInjector.injectStationRepository();

  runApp(Comuline(
    stationRepository: repository,
  ));
}

void _setupLogging() {
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}
