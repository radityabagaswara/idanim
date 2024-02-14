import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_f/home/model/home_anime_model.dart';
import 'package:project_f/home/model/home_filter_model.dart';
import 'package:project_f/home/services/home_anime_service.dart';
import 'package:project_f/home/widgets/home_carousel.dart';
import 'package:project_f/home/widgets/home_filter_chip.dart';
import 'package:project_f/home/widgets/home_poster.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HomeFilterModel> filterList = [
    HomeFilterModel(label: 'Airing Now', name: "airing"),
    HomeFilterModel(label: 'Popular', name: "bypopularity"),
    HomeFilterModel(label: 'Most Loved', name: "favorite"),
    HomeFilterModel(label: 'Upcoming', name: "upcoming"),
  ];

  late Future<List<HomeAnimeModel>> topAiringAnime;
  late Future<List<HomeAnimeModel>> homeAnimeList;

  int _selectedFilter = 0;

  final HomeAnimeService homeService = HomeAnimeService();

  void fetchTopAiring() {
    topAiringAnime = homeService.getTopAiring();
  }

  void fetchHomeAnimeList(String filter) {
    homeAnimeList = homeService.getAnimeList(filter);
  }

  @override
  void initState() {
    super.initState();
    fetchTopAiring();
    fetchHomeAnimeList(filterList[_selectedFilter].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: topAiringAnime,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Skeletonizer(
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 25,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return HomeCarousel(topAiringAnime: snapshot.data);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                    height: 50,
                    child: HomeFilterChip(
                      filterList: filterList,
                      selectedFilter: _selectedFilter,
                      onFilterSelected: (index) => setState(() {
                        _selectedFilter = index;
                        fetchHomeAnimeList(filterList[index].name);
                      }),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: homeAnimeList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                        ),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Skeletonizer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 2 / 3),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: HomePoster(
                                  width: constraints.maxWidth,
                                  title: snapshot.data[index].title,
                                  subtitle:
                                      '${snapshot.data[index].currentEpisode} Episodes',
                                  image: snapshot.data[index].image,
                                  id: snapshot.data[index].id.toString(),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
