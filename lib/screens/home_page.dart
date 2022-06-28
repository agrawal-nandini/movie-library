import 'package:flutter/material.dart';
import 'package:movie_library/utilities/colors.dart';
import 'package:movie_library/utilities/text.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:movie_library/widgets/carousal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];
  List tvAir = [];
  List movieDiscover = [];
  List movieUpcoming = [];
  final String apiKey = '3b6715502c069651f4ed7730f2d9d9b5';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYjY3MTU1MDJjMDY5NjUxZjRlZDc3MzBmMmQ5ZDliNSIsInN1YiI6IjYyOWIwNGVmYTQ0ZDA5NTI3NmVjZDA4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2HYS4gkTpgn-R7S0GVqvRXWQl4lMaMYcQbo1EQ5DNYI';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  void loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();
    Map tvAirResult = await tmdbWithCustomLogs.v3.tv.getOnTheAir();
    Map movieDiscoverResult = await tmdbWithCustomLogs.v3.discover.getMovies();
    Map movieUpcomingResult = await tmdbWithCustomLogs.v3.movies.getUpcoming();

    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      tv = tvResult['results'];
      tvAir = tvAirResult['results'];
      movieDiscover = movieDiscoverResult['results'];
      movieUpcoming = movieUpcomingResult['results'];
    });

    print(tv);
    print(trendingMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kCarousalCard,
        title: const HeadingText(
          text: 'Movie Library',
          color: Colors.white,
          size: 30,
        ),
      ),
      body: ListView(
        children: [
          Carousal(
            trending: topRatedMovies,
            heading: 'Top Rated Movies',
            title: 'title',
          ),
          Carousal(
            trending: trendingMovies,
            heading: 'Trending Movies',
            title: 'title',
          ),
          Carousal(
            trending: movieUpcoming,
            heading: 'Upcoming Movies',
            title: 'title',
          ),
          Carousal(
            trending: tv,
            heading: 'Popular TV',
            title: 'original_name',
          ),
          Carousal(
            trending: tvAir,
            heading: 'TV On Air',
            title: 'original_name',
          ),
          // Carousal(
          //   trending: movieDiscover,
          //   heading: 'Discover',
          //   title: 'title',
          // ),
        ],
      ),
    );
  }
}
