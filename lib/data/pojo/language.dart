class Language {
  int id;
  String key;
  String name;

  Language({
    required this.id,
    required this.key,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (other is Language) return this.id == other.id;

    return super == other;
  }

  @override
  int get hashCode => id;
}
