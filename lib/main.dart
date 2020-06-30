import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedbflutterapp/blocs/blocs.dart';
import 'package:moviedbflutterapp/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:moviedbflutterapp/widgets/movie_list.dart';
import 'simple_bloc_delegate.dart';

void main() {
  final MovieRepository movieRepository = MovieRepository(
    movieApiClient: MovieApiClient(
      httpClient: http.Client(),
    ),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp(movieRepository: movieRepository));
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;

  MyApp({Key key, @required this.movieRepository}) : assert(movieRepository != null), super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Popular'
          ),
        ),
        body: BlocProvider(
          create: (context) => MovieBloc(
            movieRepository: movieRepository,
          )..add(MovieLoaded()),
          child: MovieList(),
        ),
      ),
    );
  }
}
