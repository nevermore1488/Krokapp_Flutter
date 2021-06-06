extension StreamExtentions<T> on Stream<T?> {
  Stream<T> whereNotNull() => this.where((event) => event != null).map((event) => event!);
}

extension ListStreamExtentions<T> on Stream<List<T?>> {
  Stream<T?> mapFirstOrNull() => this.map((event) => event.firstOrNull());
}

extension ListExtentions<T> on List<T> {
  T? firstOrNull() => this.isNotEmpty ? this.first : null;
}

extension NullableListExtentions<T> on List<T?> {
  List<T> whereNotNull() => this.where((e) => e != null).map((event) => event!).toList();
}
