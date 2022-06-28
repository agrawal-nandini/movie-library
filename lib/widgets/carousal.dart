import 'package:flutter/material.dart';
import 'package:movie_library/screens/desc_page.dart';
import 'package:movie_library/utilities/colors.dart';
import 'package:movie_library/utilities/text.dart';

class Carousal extends StatelessWidget {
  final List trending;
  final String title;
  final String heading;

  const Carousal(
      {Key? key,
      required this.trending,
      required this.heading,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingText(
            text: heading,
            color: Colors.black,
            size: 32.0,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescriptionPage(
                          name: trending[index][title] ?? 'Loading',
                          desc: trending[index]['overview'] ?? 'Loading',
                          banner:
                              "https://image.tmdb.org/t/p/w500${trending[index]["backdrop_path"]}",
                          rating: trending[index]['vote_average']
                              .toStringAsFixed(1),
                          launchDate:
                              trending[index]['release_date'] ?? '17/06/2010',
                          poster:
                              "https://image.tmdb.org/t/p/w500${trending[index]["poster_path"]}",
                          id: trending[index]['id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // color: kCarousalCard,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${trending[index]["poster_path"]}"),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          height: 70,
                          width: 140,
                          child: HeadingText(
                              text: trending[index][title] ?? 'Loading',
                              color: Colors.black,
                              size: 16),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
