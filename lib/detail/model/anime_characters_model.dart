class AnimeCharactersModel {
  final int id;
  final String name;
  final String role;
  final String image;

  AnimeCharactersModel({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
  });

  factory AnimeCharactersModel.fromJson(Map<String, dynamic> json) {
    return AnimeCharactersModel(
      id: json['character']['mal_id'],
      name: json['character']['name'],
      role: json['role'],
      image: json['character']['images']['jpg']['image_url'],
    );
  }
}
