abstract class JsonConverter<T> {
  T fromJson(Map<String, Object?> json);

  Map<String, Object?> toJson(T pojo);

  List<T> fromJsonList(dynamic jsonList) => jsonList.map<T>((e) => fromJson(e)).toList();

  List<Map<String, Object?>> toJsonList(List<T> pojo) => pojo.map((e) => toJson(e)).toList();
}
