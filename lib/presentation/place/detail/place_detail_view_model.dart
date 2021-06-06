import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';

class PlaceDetailViewModel {
  PlaceUseCase _placeUseCase;
  int placeId;

  PlaceDetailViewModel(
    this._placeUseCase,
    this.placeId,
  );

  Stream<PlaceDetail> getPlaceDetail() => _placeUseCase.getPlaceDetail(placeId);
}
