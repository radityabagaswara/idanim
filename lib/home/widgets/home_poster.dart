import 'package:flutter/material.dart';

class HomePoster extends StatelessWidget {
  final String title;
  final String image;
  final String id;
  final String subtitle;
  final double width;
  const HomePoster(
      {super.key,
      required this.title,
      required this.image,
      required this.id,
      required this.subtitle,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(rect);
            },
            blendMode: BlendMode.multiply,
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: width,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: SizedBox(
            width: width - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
