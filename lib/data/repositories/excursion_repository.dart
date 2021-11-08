import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExcursionRepository {
  static const _EXCURSION_TIME_IN_MINUTES_KEY = "excursion_time_in_minutes";
  static const int _EXCURSION_DEFAULT_TIME_IN_MINUTES = 2 * 60 + 28;

  SharedPreferences _sharedPreferences;

  late BehaviorSubject<int> _onExcursionTimeChangedController;

  ExcursionRepository(
    this._sharedPreferences,
  ) {
    _onExcursionTimeChangedController =
        BehaviorSubject.seeded(getExcursionTimeInMinutes());
  }

  int getExcursionTimeInMinutes() {
    return _sharedPreferences.getInt(_EXCURSION_TIME_IN_MINUTES_KEY) ??
        _EXCURSION_DEFAULT_TIME_IN_MINUTES;
  }

  Stream<int> onExcursionTimeChanged() =>
      _onExcursionTimeChangedController.stream;

  Future<bool> setExcursionTime(int timeInMinutes) {
    _onExcursionTimeChangedController.add(timeInMinutes);
    return _sharedPreferences.setInt(
        _EXCURSION_TIME_IN_MINUTES_KEY, timeInMinutes);
  }
}
