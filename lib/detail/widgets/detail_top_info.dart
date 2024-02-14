import 'package:flutter/material.dart';

class AnimeTopInfo extends StatelessWidget {
  final String rating;
  final String episodes;
  final int popularity;
  const AnimeTopInfo({
    super.key,
    required this.rating,
    required this.episodes,
    required this.popularity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(
                width: 3,
              ),
              Text(
                rating,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text("Rating"),
        ],
      )),
      Expanded(
          child: Column(
        children: [
          Text(
            episodes,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text("Episodes"),
        ],
      )),
      Expanded(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              popularity > 50
                  ? const Text(
                      "#",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      "🔥",
                      style: TextStyle(fontSize: 24),
                    ),
              const SizedBox(
                width: 3,
              ),
              Text(
                popularity.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text("Popularity"),
        ],
      ))
    ]);
  }
}
