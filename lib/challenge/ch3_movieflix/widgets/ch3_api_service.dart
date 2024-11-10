import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toonflix/challenge/ch3_movieflix/models/ch3_movie_model.dart';

class Ch3ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String comingSoon = "coming-soon";

/*  
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";
*/

  static Future<List<Ch3PopularMovieModel>> getPopularMovies() async {
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

  static Future<List<Ch3MovieModel>> getNowMovies() async {
    List<Ch3MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$nowPlaying');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> movies = jsonResponse['results'];
      for (var movie in movies) {
        movieInstances.add(Ch3MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<Ch3MovieModel>> getComingMovies() async {
    List<Ch3MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$comingSoon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> movies = jsonResponse['results'];
      for (var movie in movies) {
        movieInstances.add(Ch3MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }
/*
  static Future<WebtoonDetailModel> getMovieById(String id) async {
    final url = Uri.parse('$detailUrl$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$detailUrl$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
*/
}
