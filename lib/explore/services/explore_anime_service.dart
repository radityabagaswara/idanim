import 'dart:convert';

import 'package:project_f/explore/model/explore_anime_model.dart';
import 'package:project_f/explore/model/explore_genre_model.dart';
import "package:http/http.dart" as http;
import 'package:project_f/extra/constant.dart';
import 'package:project_f/home/services/home_anime_service.dart';

class ExploreAnimeService {
  Future<List<ExploreAnimeModel>> getAnimeList(
      List<ExploreGenreModel> genres, String q) async {
    String url = '${ApiConstant.baseUrl}/anime?';

    if (genres.isNotEmpty || q.isNotEmpty) {
      if (genres.isNotEmpty) {
        url += 'genres=${genres.map((e) => e.id).join(',')}';
      }
      url += '&q=$q';

      url += '&order_by=favorites&sort=desc&limit=20&sfw=true';
    } else {
      url =
          '${ApiConstant.baseUrl}/top/anime?filter=airing&limit=20&type=TV&sfw=true';
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      final List<ExploreAnimeModel> animeList =
          data.map((e) => ExploreAnimeModel.fromJson(e)).toList();
      return animeList;
    } else {
      throw Exception('Failed to load anime list');
    }
  }
}
