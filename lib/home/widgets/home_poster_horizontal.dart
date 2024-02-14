import 'dart:developer';

import 'package:flutter/material.dart';

class HomePosterHorizontal extends StatelessWidget {
  final String title;
  final String image;
  final String eps;
  final String type;
  final String id;

  const HomePosterHorizontal(
      {super.key,
      required this.title,
      required this.image,
      required this.eps,
      required this.type,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (ctx) => DetailNavController(id: int.parse(id))));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ).createShader(rect);
              },
              blendMode: BlendMode.multiply,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              left: 15,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          "$eps Episodes",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            "•",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Text(
                          type,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
