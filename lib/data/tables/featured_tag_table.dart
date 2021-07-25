import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/pojo/tag.dart';
import 'package:krokapp_multiplatform/data/tables/tag_features_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';

class FeaturedTagTable {
  late TagsTable tagTable;
  late TagFeaturesTable featureTable;

  FeaturedTagTable.fromJson(dynamic json) {
    tagTable = TagsTable.fromJson(json);
    featureTable = TagFeaturesTable.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map.addAll(tagTable.toJson());
    map.addAll(featureTable.toJson());
    return map;
  }

  Tag toTag() => tagTable.toTag(featureTable.isChecked == 1);
}

class FeaturedTagsJsonConverter extends JsonConverter<FeaturedTagTable> {
  @override
  FeaturedTagTable fromJson(Map<String, Object?> json) =>
      FeaturedTagTable.fromJson(json);

  @override
  Map<String, Object?> toJson(FeaturedTagTable pojo) => pojo.toJson();
}

extension FeaturedTagsStreamMaping on Stream<List<FeaturedTagTable>> {
  Stream<List<Tag>> asTags() =>
      this.map((event) => event.map((e) => e.toTag()).toList());
}
