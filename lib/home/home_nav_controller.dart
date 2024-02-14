import 'package:flutter/material.dart';
import 'package:project_f/explore/explore.dart';
import 'package:project_f/home/home.dart';

class HomeNavController extends StatefulWidget {
  const HomeNavController({super.key});

  @override
  State<HomeNavController> createState() => _HomeNavControllerState();
}

class _HomeNavControllerState extends State<HomeNavController> {
  int _currentScreenIndex = 0;

  void changeScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  final List<Widget> _screens = <Widget>[HomeScreen(), ExploreScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
        currentIndex: _currentScreenIndex,
        onTap: changeScreen,
      ),
    );
  }
}
