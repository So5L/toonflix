class Ch3PopularMovieModel {
  final String id, title, thumb, description, poster, date;
//  final String title, date;
//  final int id;

// int rating

  Ch3PopularMovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['original_title'],
        description = json['overview'],
        poster = json['poster_path'] ?? 'Untitled',
        date = json['release_date'] ?? 'Untitled',
        thumb = json['backdrop_path'];
//        date = json['release_date'];
//        backdrop = json['backdrop_path'],
//        id = json['id'];
}

class Ch3MovieModel {
  final String id, title, thumb;

  Ch3MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['original_title'],
        thumb = json['poster_path'];
}
