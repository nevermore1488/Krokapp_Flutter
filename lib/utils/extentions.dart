extension StreamExtentions<T> on Stream<List<T>> {
  Stream<T?> firstOrNull() => this.map((event) => event.firstOrNull());
}

extension ListExtentions<T> on List<T> {
  T? firstOrNull() => this.isNotEmpty ? this.first : null;
}
