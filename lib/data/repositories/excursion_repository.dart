import 'package:shared_preferences/shared_preferences.dart';

class ExcursionRepository {
  static const _EXCURSION_TIME_IN_MINUTES_KEY = "excursion_time_in_minutes";
  static const int _EXCURSION_DEFAULT_TIME_IN_MINUTES = 2 * 60 + 28;

  SharedPreferences _sharedPreferences;

  ExcursionRepository(
    this._sharedPreferences,
  );

  int getExcursionTimeInMinutes() {
    return _sharedPreferences.getInt(_EXCURSION_TIME_IN_MINUTES_KEY) ??
        _EXCURSION_DEFAULT_TIME_IN_MINUTES;
  }

  Future<bool> setExcursionTime(int timeInMinutes) {
    return _sharedPreferences.setInt(
        _EXCURSION_TIME_IN_MINUTES_KEY, timeInMinutes);
  }
}
