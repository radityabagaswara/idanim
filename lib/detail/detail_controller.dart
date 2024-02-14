import 'package:flutter/material.dart';
import 'package:project_f/detail/detail.dart';

class DetailController extends StatefulWidget {
  final int id;
  const DetailController({super.key, required this.id});

  @override
  State<DetailController> createState() => DetailControllerState();
}

class DetailControllerState extends State<DetailController> {
  int _currentIndex = 0;

  void onTapChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> screens = [
    // const DetailScreen();
  ];

  @override
  Widget build(BuildContext context) {
    return DetailScreen(id: widget.id);
  }
}
