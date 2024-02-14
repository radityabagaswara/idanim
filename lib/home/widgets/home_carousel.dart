import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_f/home/model/home_anime_model.dart';
import 'package:project_f/home/widgets/home_poster_horizontal.dart';

class HomeCarousel extends StatelessWidget {
  final List<HomeAnimeModel> topAiringAnime;
  const HomeCarousel({super.key, required this.topAiringAnime});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: topAiringAnime.length,
        options: CarouselOptions(
          autoPlay: false,
          viewportFraction: 0.96,
          initialPage: 2,
        ),
        itemBuilder: (BuildContext ctx, int index, int realIndex) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: SizedBox(
                width: double.infinity,
                child: HomePosterHorizontal(
                  title: topAiringAnime[index].title,
                  image: topAiringAnime[index].image,
                  type: topAiringAnime[index].type,
                  eps: topAiringAnime[index].currentEpisode.toString(),
                  id: topAiringAnime[index].id.toString(),
                ),
              ),
            ),
          );
        });
  }
}
