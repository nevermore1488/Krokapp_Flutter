import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/excursion_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/tag.dart';
import 'package:rxdart/rxdart.dart';

class ExcursionSettingsViewModel {
  ExcursionUseCase _excursionUseCase;

  final _timeController = BehaviorSubject<TimeOfDay>();
  late Stream<TimeOfDay> time;

  ExcursionSettingsViewModel(
    this._excursionUseCase,
  ) {
    _timeController.add(
      _minutesToTime(_excursionUseCase.getExcursionTimeInMinutes()),
    );
    time = _timeController.stream;
  }

  TimeOfDay _minutesToTime(int minutes) => TimeOfDay(
        hour: minutes ~/ 60,
        minute: minutes % 60,
      );

  Stream<List<Tag>> getTags() => _excursionUseCase.getTags();

  void onTagCheckChanged(Tag tag) => _excursionUseCase.onTagCheckChanged(tag);

  void onSelectTimeTextClicked(BuildContext context) async {
    final time = _minutesToTime(
      _excursionUseCase.getExcursionTimeInMinutes(),
    );
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    pickedTime = pickedTime ?? time;

    _timeController.add(pickedTime);
    _excursionUseCase.setExcursionTime(
      pickedTime.hour * 60 + pickedTime.minute,
    );
  }
}
