import 'package:alice/alice.dart';
import 'package:alice_chopper/alice_chopper_adapter.dart';
import 'package:comuline/app.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/di/repository_injector.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart' as logging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setupLogging();

  // Network inspector tool
  Alice alice = Alice(
    showInspectorOnShake: true,
    showNotification: true,
    showShareButton: true,
  );
  AliceChopperAdapter aliceChopperAdapter = AliceChopperAdapter();
  alice.addAdapter(aliceChopperAdapter);

  final StationRepository repository =
      await RepositoryInjector.injectStationRepository(
          aliceChopperAdapter: aliceChopperAdapter);

  runApp(Comuline(
    stationRepository: repository,
    alice: alice,
  ));
}

void _setupLogging() {
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}
