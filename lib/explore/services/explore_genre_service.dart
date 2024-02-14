import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_f/explore/model/explore_genre_model.dart';
import 'package:project_f/extra/constant.dart';

class ExploreGenreService {
  Future<List<ExploreGenreModel>> getGenres() async {
    final response = await http
        .get(Uri.parse("${ApiConstant.baseUrl}/genres/anime?filter=genres"));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<dynamic> list = result['data'];
      return list.map((genre) => ExploreGenreModel.fromJson(genre)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<ExploreGenreModel>> getThemes() async {
    final response = await http
        .get(Uri.parse("${ApiConstant.baseUrl}/genres/anime?filter=themes"));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<dynamic> list = result['data'];
      return list.map((genre) => ExploreGenreModel.fromJson(genre)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<ExploreGenreModel>> getDemographics() async {
    final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/genres/anime?filter=demographics"));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<dynamic> list = result['data'];
      return list.map((genre) => ExploreGenreModel.fromJson(genre)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }
}
