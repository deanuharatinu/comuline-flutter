import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/data/local/local_source.dart';
import 'package:rxdart/rxdart.dart';

class AppStateRepository {
  AppStateRepository({
    required LocalSource localSource,
  }) : _localSource = localSource;

  final LocalSource _localSource;

  final BehaviorSubject<DarkModePreference> _darkModePreferenceSubject =
      BehaviorSubject();

  Future<void> upsertDarkModePreference(
    DarkModePreference darkModePreference,
  ) async {
    await _localSource.upsertDarkModePreference(darkModePreference);
    _darkModePreferenceSubject.add(darkModePreference);
  }

  Stream<DarkModePreference> getDarkModePreference() async* {
    if (!_darkModePreferenceSubject.hasValue) {
      final darkModePreference = await _localSource.getDarkModePreference();
      _darkModePreferenceSubject.add(darkModePreference);
    }

    yield* _darkModePreferenceSubject.stream;
  }
}
