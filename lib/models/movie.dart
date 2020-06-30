import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String description;
  final String posterImage;
  final String backdropImage;
  final String releaseDate;
  final double rating;
  final List<int> genreIds;

  const Movie({
    this.title,
    this.description,
    this.posterImage,
    this.backdropImage,
    this.releaseDate,
    this.rating,
    this.genreIds,
  });

  @override
  List<Object> get props => [title, description, posterImage, backdropImage, releaseDate, rating, genreIds];

  static Movie fromJson(dynamic json) {
    String baseUrl = 'https://image.tmdb.org/t/p';
    String sizePath = '/w500';

    return Movie(
      title: json['title'],
      description: json['overview'],
      posterImage: baseUrl + sizePath + json['poster_path'],
      backdropImage: baseUrl + sizePath + json['backdrop_path'],
      releaseDate: json['release_date'],
      rating: json['vote_average'].toDouble(),
      genreIds: List<int>.from(json['genre_ids']),
    );
  }
}