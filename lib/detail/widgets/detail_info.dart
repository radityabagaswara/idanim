import 'package:flutter/material.dart';
import 'package:project_f/explore/model/explore_genre_model.dart';

class DetailInfo extends StatelessWidget {
  final String type;
  final String status;
  final String aired;
  final String season;
  final String year;
  final String source;
  final String broadcast;
  final List<ExploreGenreModel> genreModel;
  final String rating;
  final String duration;

  const DetailInfo(
      {super.key,
      required this.type,
      required this.status,
      required this.aired,
      required this.season,
      required this.year,
      required this.source,
      required this.broadcast,
      required this.genreModel,
      required this.rating,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoRow("Type", type),
        infoRow("Status", status),
        infoRow("Aired", aired),
        infoRow("Premiered",
            "${season.split("")[0].toUpperCase()}${season.substring(1)} $year"),
        infoRow("Broadcast", broadcast),
        infoRow("Source", source),
        infoRow("Genres", genreModel.map((e) => e.name).join(", ")),
        infoRow("Duration", duration),
        infoRow("Rating", rating),
      ],
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
              width: 10), // Add some spacing between the title and value
          Expanded(
            flex: 8,
            child: Text(
              value,
              style: const TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
