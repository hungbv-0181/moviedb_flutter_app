import 'package:meta/meta.dart';
import 'dart:async';
import 'movie_api_client.dart';
import 'package:moviedbflutterapp/models/models.dart';

class MovieRepository {
  final MovieApiClient movieApiClient;
  List<Genre> genres;

  MovieRepository({@required this.movieApiClient})
      : assert(movieApiClient != null);

  Future<List<GenreMovie>>getListMovie(int page) async {
    final movies = await movieApiClient.getListMovie(page);
    if (genres == null) {
      genres = await movieApiClient.getListGenre();
    }

    return movies.map((e) => GenreMovie.fromMovie(e, genres)).toList();
  }
}