import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_f/detail/detail_controller.dart';
import 'package:project_f/explore/model/explore_anime_model.dart';
import 'package:project_f/explore/model/explore_genre_model.dart';
import 'package:project_f/explore/services/explore_anime_service.dart';
import 'package:project_f/explore/widgets/explore_filter_chip_list.dart';
import 'package:project_f/explore/services/explore_genre_service.dart';
import 'package:project_f/home/widgets/home_poster.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreGenreService exploreService = ExploreGenreService();
  ExploreAnimeService exploreAnimeService = ExploreAnimeService();

  String _searchText = '';
  late List<ExploreGenreModel> _genreList = [];
  late List<ExploreGenreModel> _themeList = [];
  late List<ExploreGenreModel> _demographicList = [];
  late Future<List<ExploreAnimeModel>> _animeList;
  List<ExploreGenreModel> _selectedGenres = [];

  Timer? _debounce;

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final genreResult = await exploreService.getGenres();
      setState(() {
        _genreList = genreResult;
      });

      await Future.delayed(const Duration(milliseconds: 500));
      final themeResult = await exploreService.getThemes();
      setState(() {
        _themeList = themeResult;
      });

      await Future.delayed(const Duration(milliseconds: 500));
      final demographicResult = await exploreService.getDemographics();
      setState(() {
        _demographicList = demographicResult;
      });
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _fetchAnimeList() async {
    _animeList = exploreAnimeService.getAnimeList(_selectedGenres, _searchText);
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchAnimeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 1000), () {
                      setState(() {
                        _searchText = value;
                      });
                      if (value.length < 3 && value.isNotEmpty) return;
                      _fetchAnimeList();
                    });
                  },
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    fillColor: Colors.grey[300],
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    hintText: 'Search for anime...',
                    prefixIcon: const Icon(Icons.search),
                    iconColor: Colors.grey[500],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ExploreFilterChipList(
                  genres: _genreList,
                  themes: _themeList,
                  demographics: _demographicList,
                  onGenreSelected: (index) {
                    setState(() {
                      _selectedGenres = index;
                    });
                    _fetchAnimeList();
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: _animeList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
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
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: snapshot.data.length <= 0
                            ? const Center(
                                child: Text("Your search result none :("),
                              )
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                ),
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) => InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (ctx) {
                                          return DetailController(
                                              id: snapshot.data[index].id);
                                        }));
                                      },
                                      child: HomePoster(
                                          title: snapshot.data[index].title,
                                          image: snapshot.data[index].image,
                                          id: snapshot.data[index].id
                                              .toString(),
                                          subtitle:
                                              '${snapshot.data[index].currentEpisode} Episodes • ${snapshot.data[index].type}',
                                          width: constraints.maxWidth),
                                    ),
                                  );
                                },
                              ),
                      );
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
