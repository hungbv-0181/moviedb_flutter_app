import 'package:equatable/equatable.dart';
import 'package:moviedbflutterapp/models/models.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}
class MovieInProgress extends MovieState {}
class MovieFailure extends MovieState {}
class MovieSuccess extends MovieState {
  final List<GenreMovie> movies;
  final int page;
  final bool hasReachedMax;

  const MovieSuccess({
    this.movies,
    this.page = 1,
    this.hasReachedMax,
  });

  MovieSuccess copyWith({
    List<Movie> movies,
    int page,
    bool hasReachedMax,
  }) {
    return MovieSuccess(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [movies, page, hasReachedMax];

  @override
  String toString() => 'MovieLoaded { movies: ${movies.length}, page: ${page} hasReachedMax: $hasReachedMax }';
}