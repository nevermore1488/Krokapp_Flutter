abstract class JsonConverter<T> {
  T fromJson(Map<String, Object?> json);

  Map<String, Object?> toJson(T pojo);
}
