import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_f/extra/constant.dart';
import 'package:project_f/home/model/home_anime_model.dart';

class HomeAnimeService {
  final http.Client _client = http.Client();

  Future<List<HomeAnimeModel>> getTopAiring() async {
    final response = await _client.get(
      Uri.parse(
          '${ApiConstant.baseUrl}/top/anime?filter=airing&limit=5&type=TV&sfw=true'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)["data"];

      final List<HomeAnimeModel> topAiringAnime =
          data.map((e) => HomeAnimeModel.fromJson(e)).toList();
      return topAiringAnime;
    } else {
      throw Exception('Failed to load top airing anime');
    }
  }

  Future<List<HomeAnimeModel>> getAnimeList(String filter) async {
    final response = await _client.get(
      Uri.parse(
          '${ApiConstant.baseUrl}/top/anime?filter=$filter&limit=10&type=TV&sfw=true'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)["data"];

      final List<HomeAnimeModel> animeList =
          data.map((e) => HomeAnimeModel.fromJson(e)).toList();
      return animeList;
    } else {
      throw Exception('Failed to load anime list');
    }
  }
}
