import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_f/detail/model/anime_detail_model.dart';
import 'package:project_f/detail/services/anime_detail_service.dart';
import 'package:project_f/detail/widgets/detail_app_bar.dart';
import 'package:project_f/detail/widgets/detail_info.dart';
import 'package:project_f/detail/widgets/detail_top_info.dart';
import 'package:project_f/home/widgets/home_poster.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  AnimeDetailModel? _animeDetail;
  final _scrollController = ScrollController();
  bool _showBottom = true;
  bool _infoExpanded = false;
  final _maxSynopsisLines = 5;
  AnimeDetailService animeDetailService = AnimeDetailService();

  void getAnimeDetail() async {
    AnimeDetailModel model = await animeDetailService.getAnimeDetail(widget.id);
    setState(() {
      _animeDetail = model;
    });

    //RATE LIMITING TO 5 ONLY
    int count = 0;
    for (var relation in _animeDetail!.relations) {
      for (var entry in relation.entry) {
        if (count < 5) {
          if (entry.type == "anime") {
            animeDetailService.getAnimeRelationsPicture(entry.id).then((value) {
              setState(() {
                entry.imageUrl = value;
              });
            });
          } else {
            animeDetailService.getMangaPictures(entry.id).then((value) {
              setState(() {
                entry.imageUrl = value;
              });
            });
          }
          count++; // Increment count
        } else {
          break; // Exit loop once 10 entries are processed
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAnimeDetail();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset < MediaQuery.of(context).size.height * 0.25) {
      setState(() {
        _showBottom = true;
      });
    } else {
      if (_showBottom) {
        setState(() {
          _showBottom = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _animeDetail == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : detailContent(),
    );
  }

  Stack detailContent() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            AnimeAppBar(
              showBottom: _showBottom,
              title: _animeDetail!.title,
              image: _animeDetail!.image,
              poster: _animeDetail!.image,
            ),
            SliverList.list(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: AnimeTopInfo(
                  rating: _animeDetail!.score.toString(),
                  episodes: _animeDetail!.episodes.toString(),
                  popularity: _animeDetail!.rank,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  _animeDetail!.synopsis,
                  maxLines: _infoExpanded ? 100 : _maxSynopsisLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // check if _maxSynopsisLines is less than the total lines
              if (_animeDetail!.synopsis.split('\n').length >=
                  _maxSynopsisLines)
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _infoExpanded = !_infoExpanded;
                          });
                        },
                        child: Text(_infoExpanded ? 'Read Less' : "Read More"),
                      ),
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: DetailInfo(
                    type: _animeDetail!.type,
                    status: _animeDetail!.status,
                    aired: _animeDetail!.aired,
                    season: _animeDetail!.season,
                    year: _animeDetail!.year.toString(),
                    source: _animeDetail!.source,
                    broadcast: _animeDetail!.broadcast,
                    genreModel: _animeDetail!.genres,
                    rating: _animeDetail!.rating,
                    duration: _animeDetail!.duration,
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 4),
                child: Text("Relations",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _animeDetail!.relations
                      .fold<int>(
                        0,
                        (previousValue, relation) =>
                            previousValue + relation.entry.length,
                      )
                      .clamp(0, 5),
                  itemBuilder: (context, index) {
                    int relationIndex = 0;
                    int entryIndex = index;
                    for (final relation in _animeDetail!.relations) {
                      if (entryIndex < relation.entry.length) {
                        break;
                      }
                      entryIndex -= relation.entry.length;
                      relationIndex++;
                    }
                    final entry = _animeDetail!
                        .relations[relationIndex].entry[entryIndex];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 250,
                        child: entry.imageUrl.isEmpty
                            ? AspectRatio(
                                aspectRatio: 2 / 3,
                                child: Skeletonizer(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ))
                            : AspectRatio(
                                aspectRatio: 2 / 3,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return HomePoster(
                                    subtitle:
                                        "${entry.type.split('')[0].toUpperCase()}${entry.type.substring(1)} • ${_animeDetail!.relations[relationIndex].relation}",
                                    id: entry.id.toString(),
                                    image: entry.imageUrl.isNotEmpty
                                        ? entry.imageUrl
                                        : _animeDetail!.image,
                                    title: entry.name,
                                    width: constraints.maxWidth,
                                  );
                                }),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ])
          ],
        ),
      ],
    );
  }
}
