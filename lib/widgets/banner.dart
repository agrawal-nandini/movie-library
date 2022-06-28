import 'package:flutter/material.dart';
import 'package:movie_library/utilities/text.dart';

class BannerImage extends StatelessWidget {
  final String bannerUrl, rating;
  const BannerImage({super.key, required this.bannerUrl, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(bannerUrl),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey,
            offset: Offset.fromDirection(2.0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 4.0,
          bottom: 2.0,
          right: 4.0,
        ),
        child: HeadingText(
          text: '⭐$rating ',
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
