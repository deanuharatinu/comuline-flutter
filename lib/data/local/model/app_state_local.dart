import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:isar/isar.dart';

part 'app_state_local.g.dart';

@collection
class AppStateLocal {
  Id? id;
  @enumerated
  late DarkModePreference darkModePreference;
}
