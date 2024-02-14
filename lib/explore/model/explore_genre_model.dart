class ExploreGenreModel {
  final int id;
  final String name;

  ExploreGenreModel({
    required this.id,
    required this.name,
  });

  factory ExploreGenreModel.fromJson(Map<String, dynamic> json) {
    return ExploreGenreModel(
      id: json['mal_id'],
      name: json['name'],
    );
  }
}
