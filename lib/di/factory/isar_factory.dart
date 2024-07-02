import 'package:comuline/data/local/model/app_state_local.dart';
import 'package:comuline/data/local/model/station_local.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarFactory {
  static final IsarFactory _instance = IsarFactory._();
  factory IsarFactory() => _instance;

  IsarFactory._();

  static Isar? _isar;

  Future<Isar> get isar async {
    if (_isar != null) return _isar!;
    _isar = await _initIsar();
    return _isar!;
  }

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [StationLocalSchema, AppStateLocalSchema],
      directory: dir.path,
    );
  }
}
