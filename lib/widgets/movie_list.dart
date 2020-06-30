import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviedbflutterapp/blocs/blocs.dart';
import 'package:moviedbflutterapp/widgets/movie_cell.dart';
import 'package:moviedbflutterapp/widgets/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _movieBloc = BlocProvider.of<MovieBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieFailure) {
          return Center(
            child: Text('failed to fetch movie'),
          );
        }
        if (state is MovieSuccess) {
          if (state.movies.isEmpty) {
            return Center(
              child: Text('no movie'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.movies.length
                  ? BottomLoader()
                  : MovieCell(movie: state.movies[index]);
            },
            itemCount: state.hasReachedMax
                ? state.movies.length
                : state.movies.length + 1,
            controller: _scrollController,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _movieBloc.add(MovieLoaded());
    }
  }
}


class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}