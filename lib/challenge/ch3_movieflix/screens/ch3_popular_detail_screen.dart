import 'package:flutter/material.dart';
import 'package:toonflix/challenge/ch3_movieflix/models/ch3_movie_model.dart';

class Ch3PopularDetailScreen extends StatelessWidget {
  final Ch3PopularMovieModel movie;

  const Ch3PopularDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Back to list",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500${movie.poster}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 그라데이션 레이어 여기다 놓으면 됨.
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star,
                      color: Colors.white24,
                    ),
                    Text(
                      "  |  Released: ${movie.date}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    /*
                    const SizedBox(width: 16),
                    Text(
                      rating,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      genre,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                      */
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Storyline',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 55),
                // 'Buy Ticket' 버튼
                Center(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                    child: const Text(
                      "Buy ticket",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
