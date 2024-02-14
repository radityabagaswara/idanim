class HomeAnimeModel {
  final int id;
  final String title;
  final String image;
  final int currentEpisode;
  final String type;

  HomeAnimeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.currentEpisode,
    required this.type,
  });

  factory HomeAnimeModel.fromJson(Map<String, dynamic> json) {
    return HomeAnimeModel(
      id: json['mal_id'],
      title: json['titles'][0]['title'] ?? '',
      image: json['images']['jpg']['large_image_url'] ??
          json['images']['jpg']['image_url'],
      currentEpisode: json['episodes'] ?? 0,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'currentEpisode': currentEpisode,
      'type': type,
    };
  }
}
