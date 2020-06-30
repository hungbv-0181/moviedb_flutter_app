import 'package:flutter/material.dart';
import 'package:moviedbflutterapp/blocs/blocs.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moviedbflutterapp/repositories/repositories.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({@required this.movieRepository}) : assert(movieRepository != null);

  @override
  MovieState get initialState => MovieInitial();

  @override
  Stream<Transition<MovieEvent, MovieState>> transformEvents(
      Stream<MovieEvent> events,
      TransitionFunction<MovieEvent, MovieState> transitionFn,
      ) {

    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    final currentState = state;
    if (event is MovieLoaded && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MovieInitial) {
          final movies = await movieRepository.getListMovie(1);
          yield MovieSuccess(movies: movies, hasReachedMax: false);
          return;
        }
        if (currentState is MovieSuccess) {
          final movies = await movieRepository.getListMovie(currentState.page + 1);
          yield movies.isEmpty ? currentState.copyWith(hasReachedMax: true)
              : MovieSuccess(
            movies: currentState.movies + movies,
            page: currentState.page + 1,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield MovieFailure();
      }
    }
  }

  bool _hasReachedMax(MovieState state) =>
      state is MovieSuccess && state.hasReachedMax;
}