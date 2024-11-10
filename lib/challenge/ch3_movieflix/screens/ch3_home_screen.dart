import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:toonflix/challenge/ch3_movieflix/models/ch3_movie_model.dart';
import 'package:toonflix/challenge/ch3_movieflix/screens/ch3_popular_detail_screen.dart';
import 'package:toonflix/challenge/constants/gaps.dart';
import 'package:toonflix/challenge/constants/sizes.dart';

const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
const String popular = "popular";
const String nowPlaying = "now-playing";
const String comingSoon = "coming-soon";

Future<List<Ch3PopularMovieModel>> getPopularMovies() async {
  List<Ch3PopularMovieModel> movieInstances = [];
//  void getPopularMovies() async {
  final url = Uri.parse('$baseUrl/$popular');
  final response = await http.get(url);
  if (response.statusCode == 200) {
//      final List<dynamic> movies = jsonDecode(response.body);
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> movies = jsonResponse['results'];
    for (var movie in movies) {
      movieInstances.add(Ch3PopularMovieModel.fromJson(movie));
//        final test = Ch3MovieModel.fromJson(movie);
//        print(test.date);
    }
    return movieInstances;
//      return;
  }
  throw Error();
}

Future<List<Ch3PopularMovieModel>> getNowMovies() async {
  List<Ch3PopularMovieModel> movieInstances = [];
//  void getPopularMovies() async {
  final url = Uri.parse('$baseUrl/$nowPlaying');
  final response = await http.get(url);
  if (response.statusCode == 200) {
//      final List<dynamic> movies = jsonDecode(response.body);
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> movies = jsonResponse['results'];
    for (var movie in movies) {
      movieInstances.add(Ch3PopularMovieModel.fromJson(movie));
//        final test = Ch3MovieModel.fromJson(movie);
//        print(test.date);
    }
    return movieInstances;
//      return;
  }
  throw Error();
}

Future<List<Ch3PopularMovieModel>> getComingMovies() async {
  List<Ch3PopularMovieModel> movieInstances = [];
//  void getPopularMovies() async {
  final url = Uri.parse('$baseUrl/$comingSoon');
  final response = await http.get(url);
  if (response.statusCode == 200) {
//      final List<dynamic> movies = jsonDecode(response.body);
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> movies = jsonResponse['results'];
    for (var movie in movies) {
      movieInstances.add(Ch3PopularMovieModel.fromJson(movie));
//        final test = Ch3MovieModel.fromJson(movie);
//        print(test.date);
    }
    return movieInstances;
//      return;
  }
  throw Error();
}

class Ch3HomeScreen extends StatelessWidget {
  const Ch3HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      appBar: AppBar(
        shadowColor: Colors.black38,
        elevation: 2,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.4),
        actions: const [
          Icon(
            Icons.download_rounded,
            size: Sizes.size32,
          ),
          Gaps.h8,
          Icon(
            Icons.search_rounded,
            size: Sizes.size32,
          ),
          Gaps.h10,
        ],
        title: const Text(
          "Movieflix 🍿",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Popular Movies",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Gaps.v10,
              SizedBox(
                height: 215,
                child: FutureBuilder(
                  future: getPopularMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text(
                        'Error loading movies.',
                        selectionColor: Colors.white,
                      ));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'No movies found.',
                        selectionColor: Colors.white,
                      ));
                    }

                    final movies = snapshot.data!;

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Ch3PopularDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15,
                                      offset: const Offset(10, 10),
                                      color: Colors.black.withOpacity(1),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie.thumb}",
                                  fit: BoxFit.fill,
                                  scale: 1.5,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 30,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    movie.title,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 30,
                      ),
                    );
                  },
                ),
              ),
              const Text(
                "Top 10 Movies Today",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Gaps.v10,
              SizedBox(
                height: 250,
                child: FutureBuilder(
                  future: getNowMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading movies.'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    }

                    final movies = snapshot.data!;

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Ch3PopularDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 225,
                              ),
                              Positioned(
                                top: -12,
                                left: 0,
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 220,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 200,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                left: 70,
                                child: Container(
                                  width: 150,
                                  //height: 250,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 15,
                                        offset: const Offset(10, 10),
                                        color: Colors.black.withOpacity(1),
                                      ),
                                    ],
                                  ),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${movie.poster}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 25,
                                left: 85,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: const Text(
                                    "Recently Added",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 5,
                                left: 77,
                                child: Text(
                                  "M",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 30,
                      ),
                    );
                  },
                ),
              ),
              const Text(
                "Now in Cinemas",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Gaps.v10,
              SizedBox(
                height: 225,
                child: FutureBuilder(
                  future: getNowMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading movies.'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    }

                    final movies = snapshot.data!;

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Ch3PopularDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15,
                                      offset: const Offset(10, 10),
                                      color: Colors.black.withOpacity(1),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie.thumb}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 30,
                      ),
                    );
                  },
                ),
              ),
              const Text(
                "Coming soon",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Gaps.v10,
              SizedBox(
                height: 225,
                child: FutureBuilder(
                  future: getComingMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading movies.'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    }

                    final movies = snapshot.data!;

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Ch3PopularDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15,
                                      offset: const Offset(10, 10),
                                      color: Colors.black.withOpacity(1),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie.thumb}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 30,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.house,
                    color: Colors.white,
                    size: Sizes.size20,
                  ),
                  Gaps.v5,
                  Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.fire,
                    color: Colors.grey,
                    size: Sizes.size20,
                  ),
                  Gaps.v5,
                  Text(
                    "New & Hot",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Sizes.size10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.grey,
                    size: Sizes.size20,
                  ),
                  Gaps.v5,
                  Text(
                    "My Movieflix",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Sizes.size10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
