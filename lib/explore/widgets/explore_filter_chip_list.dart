import 'package:flutter/material.dart';
import 'package:project_f/explore/model/explore_genre_model.dart';

class ExploreFilterChipList extends StatefulWidget {
  final List<ExploreGenreModel> genres;
  final List<ExploreGenreModel> themes;
  final List<ExploreGenreModel> demographics;
  final void Function(List<ExploreGenreModel>) onGenreSelected;

  const ExploreFilterChipList({
    super.key,
    required this.genres,
    required this.themes,
    required this.demographics,
    required this.onGenreSelected,
  });

  @override
  State<ExploreFilterChipList> createState() => _ExploreFilterChipListState();
}

class _ExploreFilterChipListState extends State<ExploreFilterChipList> {
  final List<ExploreGenreModel> _selectedGenres = [];

  void handleGenreSelection(ExploreGenreModel genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              useSafeArea: true,
              isScrollControlled: true,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final item in [
                            {'title': 'Genres', 'list': widget.genres},
                            {'title': 'Themes', 'list': widget.themes},
                            {
                              'title': 'Demographics',
                              'list': widget.demographics
                            },
                          ])
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item['title'] as String,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    for (final genre in item['list']
                                        as List<ExploreGenreModel>)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FilterChip(
                                          backgroundColor: Colors.grey[300],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: const BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          selectedColor: Colors.black,
                                          selected:
                                              _selectedGenres.contains(genre),
                                          checkmarkColor: Colors.white,
                                          label: Text(
                                            genre.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: _selectedGenres
                                                        .contains(genre)
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          onSelected: (bool value) {
                                            setState(() {
                                              handleGenreSelection(genre);
                                            });
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ).then((value) {
              if (_selectedGenres.isEmpty) return;
              widget.onGenreSelected(_selectedGenres);
            });
          },
          child: const Icon(Icons.filter_list),
        ),
        _selectedGenres.isEmpty
            ? const Text("Filter")
            : const SizedBox.shrink(),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedGenres.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    onSelected: (e) {
                      handleGenreSelection(_selectedGenres[index]);
                      widget.onGenreSelected(_selectedGenres);
                    },
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedGenres[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
