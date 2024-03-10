import 'package:favicon/favicon.dart';

class AnimeStreamingModel {
  String name;
  String icon;
  String url;

  AnimeStreamingModel({
    required this.name,
    required this.icon,
    required this.url,
  });

  factory AnimeStreamingModel.fromJson(Map<String, dynamic> json) {
    return AnimeStreamingModel(
      name: json['name'],
      icon: '',
      url: json['url'],
    );
  }
}
