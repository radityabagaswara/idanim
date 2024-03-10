import 'dart:convert';
import 'dart:developer';

import 'package:favicon/favicon.dart';
import 'package:project_f/detail/model/anime_characters_model.dart';
import 'package:project_f/detail/model/anime_detail_model.dart';
import "package:http/http.dart" as http;
import 'package:project_f/detail/model/anime_streaming_model.dart';
import 'package:project_f/extra/constant.dart';

class AnimeDetailService {
  Future<String> getIcon(String url) async {
    var iconUrl = await FaviconFinder.getBest(url);

    return iconUrl?.url ??
        "https://commons.wikimedia.org/wiki/File:No-Image-Placeholder.svg";
  }

  Future<AnimeDetailModel> getAnimeDetail(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final response =
        await http.get(Uri.parse('${ApiConstant.baseUrl}/anime/$id/full'));

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body)['data'];
      final AnimeDetailModel animeDetail = AnimeDetailModel.fromJson(data);

      return animeDetail;
    } else {
      throw Exception('Failed to load anime detail');
    }
  }

  Future<String> getAnimeRelationsPicture(int id) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final response =
        await http.get(Uri.parse('${ApiConstant.baseUrl}/anime/$id/pictures'));

    if (response.statusCode == 200) {
      log(response.body);
      final dynamic data = jsonDecode(response.body)['data'][0];
      final String imageUrl = data['jpg']['large_image_url'] ??
          data['jpg']['small_image_url'] ??
          data['jpg']['image_url'];
      return imageUrl;
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      return getAnimeRelationsPicture(id);
    }
  }

  Future<String> getMangaPictures(int id) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    log(id.toString());

    final response =
        await http.get(Uri.parse('${ApiConstant.baseUrl}/manga/$id/pictures'));

    if (response.statusCode == 200) {
      log(response.body);
      final dynamic data = jsonDecode(response.body)['data'][0];
      final String imageUrl = data['jpg']['large_image_url'] ??
          data['jpg']['small_image_url'] ??
          data['jpg']['image_url'];
      return imageUrl;
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      return getAnimeRelationsPicture(id);
    }
  }

  Future<List<AnimeCharactersModel>> getAnimeCharacters(int id) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final response = await http
        .get(Uri.parse('${ApiConstant.baseUrl}/anime/$id/characters?limit=10'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      final List<AnimeCharactersModel> animeCharacters =
          data.map((e) => AnimeCharactersModel.fromJson(e)).toList();
      return animeCharacters;
    } else {
      return [];
    }
  }
}
