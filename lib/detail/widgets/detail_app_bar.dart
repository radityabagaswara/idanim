import 'package:flutter/material.dart';

class AnimeAppBar extends StatelessWidget {
  final String image;
  final String title;
  final String poster;
  final bool showBottom;
  const AnimeAppBar({
    Key? key,
    required this.image,
    required this.title,
    required this.poster,
    required this.showBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: showBottom ? Colors.white : Colors.black,
      ),
      title: !showBottom
          ? Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      pinned: true,
      bottom: !showBottom
          ? null
          : PreferredSize(
              preferredSize:
                  const Size.fromHeight(50), // Adjusted preferredSize
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    title, // Use the title text here for consistency
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
              ).createShader(rect);
            },
            blendMode: BlendMode.multiply,
            child: Image.network(
              poster,
              height: 300,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
    );
  }
}
