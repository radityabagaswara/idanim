class AnimeRelationsModel {
  String relation;
  List<RelationModel> entry;

  AnimeRelationsModel({required this.relation, required this.entry});

  factory AnimeRelationsModel.fromJson(Map<String, dynamic> json) {
    return AnimeRelationsModel(
      relation: json['relation'],
      entry: json['entry']
          .map<RelationModel>((e) => RelationModel.fromJson(e))
          .toList(),
    );
  }
}

class RelationModel {
  int id;
  String name;
  String type;
  String imageUrl;

  RelationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  factory RelationModel.fromJson(Map<String, dynamic> json) {
    return RelationModel(
      id: json['mal_id'],
      name: json['name'],
      type: json['type'],
      imageUrl: "",
    );
  }

  //tostring
  @override
  String toString() {
    return 'RelationModel{id: $id, name: $name, type: $type, imageUrl: $imageUrl}';
  }
}
