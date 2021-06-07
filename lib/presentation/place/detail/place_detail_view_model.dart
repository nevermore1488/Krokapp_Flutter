import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

class PlaceDetailViewModel {
  PlaceUseCase _placeUseCase;
  SelectArgs _selectionArgs;

  PlaceDetailViewModel(
    this._placeUseCase,
    this._selectionArgs,
  );

  Stream<PlaceDetail> getPlaceDetail() => _placeUseCase
      .getPlacesBySelectArgs(_selectionArgs)
      .map((event) => event.first as PlaceDetail)
      .first
      .asStream();
}
