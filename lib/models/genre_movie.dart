import 'package:equatable/equatable.dart';
import 'movie.dart';
import 'genre.dart';

class GenreMovie extends Equatable {
  final String title;
  final String description;
  final String posterImage;
  final String backdropImage;
  final String releaseDate;
  final double rating;
  final List<String> genres;

  const GenreMovie({
    this.title,
    this.description,
    this.posterImage,
    this.backdropImage,
    this.releaseDate,
    this.rating,
    this.genres,
  });

  @override
  List<Object> get props => [title, description, posterImage, backdropImage, releaseDate, rating, genres];

  static GenreMovie fromMovie(Movie movie, List<Genre> genres) {
    final genresList = genres.where((element) => movie.genreIds.contains(element.id)).toList();

    return GenreMovie(
      title: movie.title,
      description: movie.description,
      posterImage: movie.posterImage,
      backdropImage: movie.backdropImage,
      releaseDate: movie.releaseDate,
      rating: movie.rating,
      genres: genresList.map((e) => e.name).toList(),
    );
  }

  String toGenresString() {
    String result = '';
    for (String genre in this.genres) {
      result = result + genre + " ";
    }

    return result;
  }
}