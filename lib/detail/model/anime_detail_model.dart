import 'package:project_f/detail/model/anime_characters_model.dart';
import 'package:project_f/detail/model/anime_relations_model.dart';
import 'package:project_f/detail/model/anime_streaming_model.dart';
import 'package:project_f/explore/model/explore_genre_model.dart';

class AnimeDetailModel {
  String title;
  String image;
  String duration;
  String rating;
  int rank;
  String synopsis;
  int year;
  String season;
  int episodes;
  double score;
  String aired;
  String source;
  String broadcast;
  String status;
  String type;
  List<ExploreGenreModel> genres;
  List<AnimeRelationsModel> relations;
  List<AnimeCharactersModel> characters;
  List<AnimeStreamingModel> streaming;

  AnimeDetailModel({
    required this.title,
    required this.image,
    required this.duration,
    required this.rating,
    required this.rank,
    required this.synopsis,
    required this.year,
    required this.season,
    required this.episodes,
    required this.score,
    required this.aired,
    required this.source,
    required this.broadcast,
    required this.status,
    required this.type,
    required this.genres,
    required this.relations,
    required this.characters,
    required this.streaming,
  });

  factory AnimeDetailModel.fromJson(Map<String, dynamic> json) {
    return AnimeDetailModel(
        title: json['title'] ?? "",
        image: json['images']['jpg']['large_image_url'] ??
            json['images']['jpg']['image_url'],
        duration: json['duration'] ?? "",
        rating: json['rating'] ?? "",
        rank: json['rank'] ?? 0,
        synopsis: json['synopsis'] ?? "",
        year: json['year'] ?? 0,
        season: json['season'] ?? "",
        episodes: json['episodes'] ?? 0,
        score: json['score'] ?? 0,
        aired: json['aired']['string'] ?? "",
        source: json['source'] ?? "",
        broadcast: json['broadcast']['string'] ?? "",
        status: json['status'] ?? "",
        type: json['type'] ?? "",
        genres: json['genres'].map<ExploreGenreModel>((e) {
          return ExploreGenreModel.fromJson(e);
        }).toList(),
        relations: json['relations'].map<AnimeRelationsModel>((e) {
          return AnimeRelationsModel.fromJson(e);
        }).toList(),
        streaming: json['streaming'].map<AnimeStreamingModel>((e) {
          return AnimeStreamingModel.fromJson(e);
        }).toList(),
        characters: []);
  }
}
