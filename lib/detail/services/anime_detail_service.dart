import 'dart:convert';
import 'dart:developer';

import 'package:project_f/detail/model/anime_detail_model.dart';
import "package:http/http.dart" as http;
import 'package:project_f/extra/constant.dart';

class AnimeDetailService {
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
}
