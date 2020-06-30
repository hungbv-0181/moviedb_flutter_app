import 'package:http/http.dart' as http;
import 'package:moviedbflutterapp/models/models.dart';
import 'dart:convert';

class MovieApiClient {
  static const baseUrl = 'https://api.themoviedb.org';
  static const movieUrl = '3/movie/popular';
  static const genreUrl = '3/genre/movie/list';
  static const apiKey = 'd61431a2fb64b6e56c6f086952e63ab6';
  final http.Client httpClient;

  MovieApiClient({this.httpClient}) : assert(httpClient != null);

  Future<List<Movie>>getListMovie(int page) async {
    final listMovieUrl = '$baseUrl/$movieUrl?api_key=$apiKey&page=$page';
    final movieResponse = await this.httpClient.get(listMovieUrl);
    if (movieResponse.statusCode != 200) {
      throw Exception('error getting list movie');
    }

    final movieJson = jsonDecode(movieResponse.body) as Map;
    final data = movieJson['results'] as List<dynamic>;
    var movies = List<Movie>();
    for (var i in data) {
      movies.add(Movie.fromJson(i));
    }

    return movies;
  }

  Future<List<Genre>>getListGenre() async {
    final listGenreUrl = '$baseUrl/$genreUrl?api_key=$apiKey';
    final genreResponse = await this.httpClient.get(listGenreUrl);
    if (genreResponse.statusCode != 200) {
      throw Exception('error getting list genre');
    }

    final genreJson = jsonDecode(genreResponse.body) as Map;
    final genreList = genreJson['genres'] as List;
    final result = genreList.map((e) => Genre.fromJson(e)).toList();
    return result;
  }
}