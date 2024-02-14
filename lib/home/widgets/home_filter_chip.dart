import 'package:flutter/material.dart';
import 'package:project_f/home/model/home_filter_model.dart';

typedef void FilterCallback(int index);

class HomeFilterChip extends StatelessWidget {
  final int selectedFilter;
  final List<HomeFilterModel> filterList;
  final FilterCallback onFilterSelected;

  const HomeFilterChip(
      {super.key,
      required this.selectedFilter,
      required this.filterList,
      required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterList.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilterChip(
              backgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.transparent)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selectedColor: Colors.black,
              selected: selectedFilter == index,
              showCheckmark: false,
              label: Text(
                filterList[index].label,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color:
                        selectedFilter == index ? Colors.white : Colors.black),
              ),
              onSelected: (bool value) {
                onFilterSelected(index);
              },
            ),
          );
        });
  }
}
